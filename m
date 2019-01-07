From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 08/13] x86/fpu: Disable preemption around local_bh_disable()
Date: Mon, 07 Jan 2019 14:53:00 -0500
Message-ID: <20190107195333.112062036@goodmis.org>
References: <20190107195252.599921907@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit f70ac4a5ca5df1d84dae809453464eca16b54f51 ]

__fpu__restore_sig() restores the content of the FPU state in the CPUs
and in order to avoid concurency it disbles BH. On !RT it also disables
preemption but on RT we can get preempted in BH.

Add preempt_disable() while the FPU state is restored.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/fpu/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d99a8ee9e185..5e0274a94133 100644
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
2.19.2
