From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.2.9-rt15
Date: Mon, 05 Mar 2012 17:14:00 -0500
Message-ID: <1330985640.25686.342.camel@gandalf.stny.rr.com>
References: <alpine.LFD.2.02.1203021743040.2742@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:13822 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711Ab2CEWOD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Mar 2012 17:14:03 -0500
In-Reply-To: <alpine.LFD.2.02.1203021743040.2742@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

Please fold this change into

   cpu-rt-make-hotplug-lock-a-sleeping-spinlock-on-rt.patch


As the patch was never tested (nor even compiled) it introduced a nasty
bug into taking a CPU down instead of fixing one.

Thanks,

-- Steve

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c25b5ff..66dfb74 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -59,16 +59,20 @@ static struct {
 	int refcount;
 } cpu_hotplug = {
 	.active_writer = NULL,
+#ifdef CONFIG_PREEMPT_RT_FULL
+	.lock = __SPIN_LOCK_UNLOCKED(cpu_hotplug.lock),
+#else
 	.lock = __MUTEX_INITIALIZER(cpu_hotplug.lock),
+#endif
 	.refcount = 0,
 };
 
 #ifdef CONFIG_PREEMPT_RT_FULL
-# define hotplug_lock() spin_lock(&cpu_hotplug.lock)
-# define hotplug_unlock() spin_unlock(&cpu_hotplug.lock)
+# define hotplug_lock() rt_spin_lock(&cpu_hotplug.lock)
+# define hotplug_unlock() rt_spin_unlock(&cpu_hotplug.lock)
 #else
 # define hotplug_lock() mutex_lock(&cpu_hotplug.lock)
-# define hotplug_lock() mutex_unlock(&cpu_hotplug.lock)
+# define hotplug_unlock() mutex_unlock(&cpu_hotplug.lock)
 #endif
 
 struct hotplug_pcp {


