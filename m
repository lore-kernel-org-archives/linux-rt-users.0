From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 2/2] mce: don't try to wake thread before it exists.
Date: Fri, 6 Mar 2015 22:12:22 +0100
Message-ID: <20150306211222.GI10155@linutronix.de>
References: <1425046838-4868-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1425046838-4868-3-git-send-email-daniel.wagner@bmw-carit.de>
 <20150306210127.GH10155@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56846 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbbCFVMZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Mar 2015 16:12:25 -0500
Content-Disposition: inline
In-Reply-To: <20150306210127.GH10155@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sebastian Andrzej Siewior | 2015-03-06 22:01:27 [+0100]:

>We only miss a printk. The userland helper is not yet ready and we won't
>anyone one waiting on the wait queue. So it should be enough to simply
>check if the swait is ready.

So this should be enough and I fold this in you #1 patch. And now I see
that swork_queue() might be called from hardirq context so it needs irqs
off. I fix that one, too. But after that we should be good to go.

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1385,6 +1385,7 @@ static void __mce_notify_work(struct swo
 }
 
 #ifdef CONFIG_PREEMPT_RT_FULL
+static bool notify_work_ready __read_mostly;
 static struct swork_event notify_work;
 
 static int mce_notify_work_init(void)
@@ -1396,12 +1397,14 @@ static int mce_notify_work_init(void)
 		return err;
 
 	INIT_SWORK(&notify_work, __mce_notify_work);
+	notify_work_ready = true;
 	return 0;
 }
 
 static void mce_notify_work(void)
 {
-	swork_queue(&notify_work);
+	if (notify_work_ready)
+		swork_queue(&notify_work);
 }
 #else
 static void mce_notify_work(void)

Sebastian
