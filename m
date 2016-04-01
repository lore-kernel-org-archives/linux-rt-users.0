From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] list_bl: fixup bogus lockdep warning
Date: Fri, 1 Apr 2016 12:49:46 +0200
Message-ID: <20160401104946.GD29603@linutronix.de>
References: <56FB8B5A.8@linutronix.de>
 <1459400665-12546-1-git-send-email-joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53042 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbcDAKts (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Apr 2016 06:49:48 -0400
Content-Disposition: inline
In-Reply-To: <1459400665-12546-1-git-send-email-joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Josh Cartwright | 2016-03-31 00:04:25 [-0500]:

>diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
>index 44f0b55..a1bfb3b 100644
>--- a/include/linux/list_bl.h
>+++ b/include/linux/list_bl.h
>@@ -42,13 +42,16 @@ struct hlist_bl_node {
> 	struct hlist_bl_node *next, **pprev;
> };
> 
>-static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
>-{
>-	h->first = NULL;
> #ifdef CONFIG_PREEMPT_RT_BASE
>-	raw_spin_lock_init(&h->lock);
>+#define INIT_HLIST_BL_HEAD(h)		\
>+do {					\
>+	(h)->first = NULL;		\
>+	raw_spin_lock_init(&(h)->lock);	\
>+} while (0)
>+#else
>+#define INIT_HLIST_BL_HEAD(h)		\
>+	(h)->first = NULL;		\

I switched the else part to

 #define INIT_HLIST_BL_HEAD(h) (h)->first = NULL

> #endif
>-}

Sebastian
