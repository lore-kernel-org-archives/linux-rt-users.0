From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 20/27] arm/futex: disable preemption during futex_atomic_cmpxchg_inatomic()
Date: Fri, 13 Mar 2015 11:18:01 -0400
Message-ID: <20150313151758.366853155@goodmis.org>
References: <20150313151741.132137234@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0020-arm-futex-disable-preemption-during-futex_atomic_cmp.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.4.106-rt132-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The ARM UP implementation of futex_atomic_cmpxchg_inatomic() assumes that
pagefault_disable() inherits a preempt disabled section. This assumtion
is true for mainline but -RT reverts this and allows preemption in
pagefault disabled regions.
The code sequence of futex_atomic_cmpxchg_inatomic():

|   x = *futex;
|   if (x == oldval)
|           *futex = newval;

The problem occurs if the code is preempted after reading the futex value or
after comparing it with x. While preempted, the futex owner has to be
scheduled which then releases the lock (in userland because it has no waiter
yet). Once the code is back on the CPU, it overwrites the futex value
with with the old PID and the waiter bit set.

The workaround is to explicit disable code preemption to avoid the
described race window.

Debugged-by:  Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/include/asm/futex.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 7be54690aeec..3d1ae210c4b5 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -94,6 +94,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	preempt_disable_rt();
+
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
 	"1:	" TUSER(ldr) "	%1, [%4]\n"
 	"	teq	%1, %2\n"
@@ -105,6 +107,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	: "cc", "memory");
 
 	*uval = val;
+
+	preempt_enable_rt();
 	return ret;
 }
 
-- 
2.1.4
