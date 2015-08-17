From: eg Engleder Gerhard <eg@keba.com>
Subject: AW: [PATCH] rtmutex.c: Fix incorrect waiter check
Date: Mon, 17 Aug 2015 12:41:47 +0200
Message-ID: <12C1B74BDFD05D40B2356A9B12DFA3396C2A5F752B@KEBMXSPMB01.keba.co.at>
References: <548F7E4C.90805@hp.com>
	<1421269898-30591-1-git-send-email-brad.mouring@ni.com>
	<1421269898-30591-2-git-send-email-brad.mouring@ni.com>
 <20150121151352.7e4ef150@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xlspam03.mdcs.at ([217.13.183.27]:24725 "EHLO xlspam03.mdcs.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbbHQKlw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Aug 2015 06:41:52 -0400
In-Reply-To: <20150121151352.7e4ef150@gandalf.local.home>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Steven,

I had the following problem with 3.2.68-rt99:
<1>[ 1615.388250] BUG: unable to handle kernel NULL pointer dereference at 0000002d
<1>[ 1615.388261] IP: [<c106d006>] task_blocks_on_rt_mutex+0x126/0x240

We could reproduce it rather good, 2 times BUG out of 4 tries. Sebastian pointed
me to the patch below. 8 times no BUG out of 8 tries with the patch now. As Sebastian
is not available currently, I thought I should let you know. Could you add this patch
to 3.2.69-rt102?

Regards, Gerhard

> On Wed, 14 Jan 2015 15:11:38 -0600
> "Brad Mouring" <bmouring@ni.com> wrote:
> 
> > In task_blocks_on_lock, there's a null check on pi_blocked_on of the
> > task_struct. This pointer can encode the fact that the task that
> > contains the pointer is waking (preventing requeuing) and therefore is
> > non-null. Use the inline function to avoid dereferencing an invalid
> > "pointer"
> 
> Yep, this looks legit. I can apply it to the series I maintain.
> 
> -- Steve
> 
> >
> > Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> > Reported-by: Ben Shelton <ben.shelton@ni.com>
> > Reviewed-by: T Makphaibulchoke <tmac@hp.com>
> > Tested-by: T Makphaibulchoke <tmac@hp.com>
> > ---
> >  kernel/locking/rtmutex.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c index
> > 6c40660..535321e 100644
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -335,7 +335,8 @@ int max_lock_depth = 1024;
> >
> >  static inline struct rt_mutex *task_blocked_on_lock(struct
> > task_struct *p)  {
> > -	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
> > +	return rt_mutex_real_waiter(p->pi_blocked_on) ?
> > +		p->pi_blocked_on->lock : NULL;
> >  }
> >
> >  /*
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
