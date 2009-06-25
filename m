From: Vivek Satpute <vivek@linsyssoft.com>
Subject: [PATCH-rt 1/1] Fix spinlock issue in net/core/sock.c
Date: Thu, 25 Jun 2009 17:37:25 +0530
Message-ID: <1245931645.6269.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: prtproj@linsyssoft.com, Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:63049 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZFYMHZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Jun 2009 08:07:25 -0400
Received: by pxi28 with SMTP id 28so992223pxi.33
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Jun 2009 05:07:27 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Kernel panic's and reboot while doing network operations such ifconfig
and ping on MIPS architecture after RT-patches applied.

In case of CONFIG_PREEMPT_RT, after releasing the lock with
"spin_unlock", context switch might occur before enabling the bottom
half with local_bh_enable and this causes the kernel to panic.
The issue is resolved by releasing the lock afer acquiring the mutex
using spin_unlock_bh.

Tested the fix on MIPS and X86 architecture.

Signed-off-by: Vivek Satpute <vivek@linsyssoft.com>
---
net/core/sock.c |    8 ++++++++
1 file changed, 8 insertions(+)

Index: linux-2.6.28.4/net/core/sock.c
===================================================================
--- linux-2.6.28.4.orig/net/core/sock.c
+++ linux-2.6.28.4/net/core/sock.c
@@ -1752,12 +1752,20 @@ void lock_sock_nested(struct sock *sk, i
 	if (sk->sk_lock.owned)
 		__lock_sock(sk);
 	sk->sk_lock.owned = 1;
+
+#ifndef CONFIG_PREEMPT_RT
 	spin_unlock(&sk->sk_lock.slock);
+#endif
 	/*
 	 * The sk_lock has mutex_lock() semantics here:
 	 */
 	mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
+
+#ifdef CONFIG_PREEMPT_RT
+	spin_unlock_bh(&sk->sk_lock.slock);
+#else
 	local_bh_enable();
+#endif
 }
 
 EXPORT_SYMBOL(lock_sock_nested);




Thanks and Regards,
Vivek Satpute
System Software Engineer
LinSysSoft Technologies, Pune

