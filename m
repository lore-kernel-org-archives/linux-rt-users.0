From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [4.4.4-rt11] Possiblie recursive locking detected in kswapd /
 mb_cache_shrink_scan()
Date: Mon, 21 Mar 2016 17:47:26 -0300
Message-ID: <20160321204726.GD29388@uudg.org>
References: <20160314210058.GE29798@uudg.org>
 <alpine.DEB.2.11.1603190933150.3978@nanos>
 <20160321144016.GA31276@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35948 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbcCUUra convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Mar 2016 16:47:30 -0400
Received: by mail-qg0-f42.google.com with SMTP id u110so162536120qge.3
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Mar 2016 13:47:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160321144016.GA31276@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 21, 2016 at 09:40:16AM -0500, Josh Cartwright wrote:
| On Sat, Mar 19, 2016 at 09:33:34AM +0100, Thomas Gleixner wrote:
| > On Mon, 14 Mar 2016, Luis Claudio R. Goncalves wrote:
| > 
| > > Hello,
| > > 
| > > I just started using 4.4.4-rt11 this afternoon and saw the lockdep splat below.
| > > Is this something new or did I miss a patch floating on the list?
| > 
| > That's new. Looking into it.
| 
| It looks like the way that INIT_HLIST_BL_HEAD() is authored, all
| instances of the contained raw spinlock will share the same lockdep
| class.  That, coupled with the following in mb_cache_shrink(), is
| triggering the lockdep violation:
| 
| 	void
| 	mb_cache_shrink(struct block_device *bdev)
| 	{
| 		[..]
| 				/*
| 				 * Prevent any find or get operation on the entry.
| 				 */
| 				hlist_bl_lock(ce->e_block_hash_p);
| 				hlist_bl_lock(ce->e_index_hash_p);
| 
|   Josh

Josh, I built a kernel with your patch and the lockdep complaint is gone. 
I was used to see the message within 30 minutes of normal usage. So far,
four hours with that kernel running and no complaints.

Tested-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>

Thanks!
Luis
 
| diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
| index 44f0b55..d13428a 100644
| --- a/include/linux/list_bl.h
| +++ b/include/linux/list_bl.h
| @@ -42,13 +42,18 @@ struct hlist_bl_node {
|  	struct hlist_bl_node *next, **pprev;
|  };
|  
| -static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
| -{
| -	h->first = NULL;
|  #ifdef CONFIG_PREEMPT_RT_BASE
| -	raw_spin_lock_init(&h->lock);
| +#define INIT_HLIST_BL_HEAD(h)		\
| +do {					\
| +	(h)->first = NULL;		\
| +	raw_spin_lock_init(&(h)->lock);	\
| +} while (0)
| +#else
| +#define INIT_HLIST_BL_HEAD(h)		\
| +do {					\
| +	(h)->first = NULL;		\
| +} while (0)
|  #endif
| -}
|  
|  static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
|  {


---end quoted text---

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

