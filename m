From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched: migrate_disable() and del_timer_sync() issues
 with !CONFIG_SMP
Date: Fri, 15 Jan 2016 17:23:10 +0100
Message-ID: <20160115162310.GC3781@linutronix.de>
References: <1451954450-29298-1-git-send-email-henrik@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	uriahheep@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38902 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbcAOQXM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 11:23:12 -0500
Content-Disposition: inline
In-Reply-To: <1451954450-29298-1-git-send-email-henrik@austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Henrik Austad | 2016-01-05 01:40:50 [+0100]:

>diff --git a/include/linux/timer.h b/include/linux/timer.h
>index 299d2b78591f..79889be97b3b 100644
>--- a/include/linux/timer.h
>+++ b/include/linux/timer.h
>@@ -225,7 +225,7 @@ extern void add_timer(struct timer_list *timer);
> 
> extern int try_to_del_timer_sync(struct timer_list *timer);
> 
>-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
>+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_FULL)

I think I fixed this in the meantime (-rt3 once it is out) but this
needs to be || here.

>   extern int del_timer_sync(struct timer_list *timer);
> #else
> # define del_timer_sync(t)		del_timer(t)

Sebastian
