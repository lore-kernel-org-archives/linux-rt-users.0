From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH] list_bl: fixup bogus lockdep warning
Date: Fri, 1 Apr 2016 12:02:42 -0500
Message-ID: <20160401170241.GB6907@jcartwri.amer.corp.natinst.com>
References: <56FB8B5A.8@linutronix.de>
 <1459400665-12546-1-git-send-email-joshc@ni.com>
 <20160401104946.GD29603@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:45598 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752480AbcDARCw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Apr 2016 13:02:52 -0400
In-Reply-To: <20160401104946.GD29603@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 01, 2016 at 12:49:46PM +0200, Sebastian Andrzej Siewior wrote:
> * Josh Cartwright | 2016-03-31 00:04:25 [-0500]:
> 
> >diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> >index 44f0b55..a1bfb3b 100644
> >--- a/include/linux/list_bl.h
> >+++ b/include/linux/list_bl.h
> >@@ -42,13 +42,16 @@ struct hlist_bl_node {
> > 	struct hlist_bl_node *next, **pprev;
> > };
> > 
> >-static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
> >-{
> >-	h->first = NULL;
> > #ifdef CONFIG_PREEMPT_RT_BASE
> >-	raw_spin_lock_init(&h->lock);
> >+#define INIT_HLIST_BL_HEAD(h)		\
> >+do {					\
> >+	(h)->first = NULL;		\
> >+	raw_spin_lock_init(&(h)->lock);	\
> >+} while (0)
> >+#else
> >+#define INIT_HLIST_BL_HEAD(h)		\
> >+	(h)->first = NULL;		\
> 
> I switched the else part to
> 
>  #define INIT_HLIST_BL_HEAD(h) (h)->first = NULL

That works, thanks.  I had it wrapped it in do { } while(0);, but
checkpatch complained.

Anyway, I decided to do some grepping, and this particular case isn't
the only one where there might be unintentional lockdep class sharing.
I hope to follow up on this when I'm not traveling.

  Josh
