From: Yang Shi <yang.shi@linaro.org>
Subject: [PATCH] rt: x86: extend signal send delay to 32 bit
Date: Thu, 10 Dec 2015 10:58:51 -0800
Message-ID: <1449773931-7200-1-git-send-email-yang.shi@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org, yang.shi@linaro.org
To: tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

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

Signal send delay is just available for x86-64, x86-32 needs it too.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/x86/include/asm/signal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index b1b08a2..0e7bfe9 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -32,7 +32,7 @@ typedef struct {
  * TIF_NOTIFY_RESUME and set up the signal to be sent on exit of the
  * trap.
  */
-#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_X86_64)
+#if defined(CONFIG_PREEMPT_RT_FULL)
 #define ARCH_RT_DELAYS_SIGNAL_SEND
 #endif
 
-- 
2.0.2
