From: Yang Shi <yang.shi@linaro.org>
Subject: [PATCH v2] rt: x86: enable preemption in IST exception for x86-32
Date: Mon, 14 Dec 2015 15:06:44 -0800
Message-ID: <1450134404-16662-1-git-send-email-yang.shi@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org, yang.shi@linaro.org
To: tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34106 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbbLNX1A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2015 18:27:00 -0500
Received: by pfbo64 with SMTP id o64so34718965pfb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2015 15:27:00 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When running some ptrace single step tests on x86-32 machine, the below problem
is triggered:

BUG: sleeping function called from invalid context at linux-rt/kernel/locking/rtmutex.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 1041, name: dummy2
INFO: lockdep is turned off.
Preemption disabled at:[<c100326f>] do_debug+0x1f/0x1a0

CPU: 10 PID: 1041 Comm: dummy2 Tainted: G        W       4.1.13-rt13 #1
Hardware name: Intel Corporation S5520HC/S5520HC, BIOS S5500.86B.01.10.0025.030220091519 03/02/2009
 00000000 00000000 e1811e80 c1aa8306 00000000 e1811ea8 c1080517 c1d8b2e8
 c100326f c100326f 00000411 e5b7d5b4 e1d521c4 00000005 e1811f74 e1811ec4
 c1ab0eff e1d51cc0 e5b7d180 c1081403 e5b7d180 e5b7d180 e1811ee4 c1064b5a
Call Trace:
 [<c1aa8306>] dump_stack+0x46/0x5c
 [<c1080517>] ___might_sleep+0x137/0x220
 [<c100326f>] ? do_debug+0x1f/0x1a0
 [<c100326f>] ? do_debug+0x1f/0x1a0
 [<c1ab0eff>] rt_spin_lock+0x1f/0x80
 [<c1081403>] ? preempt_count_sub+0xb3/0x110
 [<c1064b5a>] do_force_sig_info+0x2a/0xc0
 [<c106567d>] force_sig_info+0xd/0x10
 [<c1010cff>] send_sigtrap+0x6f/0x80
 [<c10033b1>] do_debug+0x161/0x1a0
 [<c1ab2921>] debug_stack_correct+0x2e/0x35

Mainline kernel commit 959274753857efe9c5f1ba35fe727f51e9aa128d
("x86, traps: Track entry into and exit from IST context"), introduced
ist_enter which disables preemption uncondiontionally for both x86-64 and
x86-32. However, x86-32 does not have an IST and the stack still belongs to
the current task and there is no problem in scheduling out the task.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/x86/kernel/traps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ebae118..7139bc0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -90,7 +90,7 @@ static inline void conditional_sti(struct pt_regs *regs)
 
 static inline void conditional_sti_ist(struct pt_regs *regs)
 {
-#ifdef CONFIG_X86_64
+#if !defined(CONFIG_X86_64)
 	/*
 	 * X86_64 uses a per CPU stack on the IST for certain traps
 	 * like int3. The task can not be preempted when using one
@@ -101,7 +101,7 @@ static inline void conditional_sti_ist(struct pt_regs *regs)
 	 * On x86_32 the task keeps its own stack and it is OK if the
 	 * task schedules out.
 	 */
-	preempt_count_inc();
+	ist_begin_non_atomic(regs);
 #endif
 	if (regs->flags & X86_EFLAGS_IF)
 		local_irq_enable();
@@ -117,8 +117,8 @@ static inline void conditional_cli_ist(struct pt_regs *regs)
 {
 	if (regs->flags & X86_EFLAGS_IF)
 		local_irq_disable();
-#ifdef CONFIG_X86_64
-	preempt_count_dec();
+#if !defined(CONFIG_X86_64)
+	ist_end_non_atomic();
 #endif
 }
 
-- 
2.0.2

