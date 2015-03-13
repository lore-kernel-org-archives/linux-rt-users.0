From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 20/25] arm/futex: disable preemption during futex_atomic_cmpxchg_inatomic()
Date: Fri, 13 Mar 2015 11:18:45 -0400
Message-ID: <20150313151837.941137095@goodmis.org>
References: <20150313151825.583263173@goodmis.org>
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

3.2.68-rt99-rc1 stable review patch.
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
index aefd4594c9bf..48fc90c7db20 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -86,6 +86,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	int ret = 0;
 	u32 val;
 
+	preempt_disable_rt();
+
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
@@ -100,6 +102,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	: "cc", "memory");
 
 	*uval = val;
+
+	preempt_enable_rt();
 	return ret;
 }
 
-- 
2.1.4
