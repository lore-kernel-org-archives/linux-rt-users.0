From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT v2] x86/mm/pat: disable preemption __split_large_page()
 after spin_lock()
Date: Thu, 13 Dec 2018 21:37:46 +0100
Message-ID: <20181213203746.m7oq3erumlyqckwi@linutronix.de>
References: <20181213164430.mggilzfjgr5retz6@linutronix.de>
 <20181213125907.48e75b89@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181213125907.48e75b89@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Commit "x86/mm/pat: Disable preemption around __flush_tlb_all()" added a
warning if __flush_tlb_all() is invoked in preemptible context. On !RT
the warning does not trigger because a spin lock is acquired which
disables preemption. On RT the spin lock does not disable preemption and
so the warning is seen.

Disable preemption to avoid the warning __flush_tlb_all().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2:
	- add comment
	- enable preemption before dropping the spinlock

 arch/x86/mm/pageattr.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -688,11 +688,17 @@ static int
 
 	spin_lock(&pgd_lock);
 	/*
+	 * Keep preemption disabled after __flush_tlb_all() which expects not be
+	 * preempted during the flush of the local TLB.
+	 */
+	preempt_disable();
+	/*
 	 * Check for races, another CPU might have split this page
 	 * up for us already:
 	 */
 	tmp = _lookup_address_cpa(cpa, address, &level);
 	if (tmp != kpte) {
+		preempt_enable();
 		spin_unlock(&pgd_lock);
 		return 1;
 	}
@@ -726,6 +732,7 @@ static int
 		break;
 
 	default:
+		preempt_enable();
 		spin_unlock(&pgd_lock);
 		return 1;
 	}
@@ -764,6 +771,7 @@ static int
 	 * going on.
 	 */
 	__flush_tlb_all();
+	preempt_enable();
 	spin_unlock(&pgd_lock);
 
 	return 0;
