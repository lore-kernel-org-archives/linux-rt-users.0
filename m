From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] x86/fpu: Disable preemption around local_bh_disable()
Date: Tue, 11 Dec 2018 19:54:49 +0100
Message-ID: <20181211185448.4iainycyvrnwep6p@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

__fpu__restore_sig() restores the content of the FPU state in the CPUs
and in order to avoid concurrency it disables BH. On !RT this also
disables preemption but on RT we can get preempted in BH.

Add preempt_disable() while the FPU state is restored.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d99a8ee9e185e..5e0274a941333 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -344,10 +344,12 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
 		}
 
+		preempt_disable();
 		local_bh_disable();
 		fpu->initialized = 1;
 		fpu__restore(fpu);
 		local_bh_enable();
+		preempt_enable();
 
 		return err;
 	} else {
-- 
2.20.0
