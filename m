From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] arm/futex: disable preemption during futex_atomic_cmpxchg_inatomic()
Date: Wed, 18 Feb 2015 14:48:11 +0100
Message-ID: <1424267291-10495-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/include/asm/futex.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -93,6 +93,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	preempt_disable_rt();
+
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
 	"1:	" TUSER(ldr) "	%1, [%4]\n"
 	"	teq	%1, %2\n"
@@ -104,6 +106,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 	: "cc", "memory");
 
 	*uval = val;
+
+	preempt_enable_rt();
 	return ret;
 }
 
