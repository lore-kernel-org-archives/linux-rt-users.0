From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rc7-rt0
Date: Thu, 21 Jul 2011 19:43:28 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107211942420.2702@ionos>
References: <1311265361.2323.6.camel@box> <alpine.LFD.2.02.1107211932440.2702@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: hermann <brummer-@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60233 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab1GURna (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jul 2011 13:43:30 -0400
In-Reply-To: <alpine.LFD.2.02.1107211932440.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 21 Jul 2011, Thomas Gleixner wrote:
> On Thu, 21 Jul 2011, hermann wrote:
> > I try to build the 3.0-rc7-rt0 but fail with the following message:
> >  CC [M]  fs/ext3/balloc.o
> > In file included from include/linux/jbd.h:247:0,
> >                  from fs/ext3/balloc.c:18:
> 
> Find below a patch on top of rt0 which fixes this build failure and
> some other stuff.

Bah, that's when you trust other peoples patches. It needs the
following fix as well:

--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -109,7 +111,8 @@ static inline void buffer_head_init_lock
 {
 #ifdef CONFIG_PREEMPT_RT_BASE
 	spin_lock_init(&bh->b_uptodate_lock);
-#if defined(CONFIG_JBD) || defined(CONFIG_JBD2)
+#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE) || \
+    defined(CONFIG_JBD2) || defined(CONFIG_JBD2_MODULE)
 	spin_lock_init(&bh->b_state_lock);
 	spin_lock_init(&bh->b_journal_head_lock);
 #endif
