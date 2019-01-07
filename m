From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 11/13] x86/mm/pat: disable preemption __split_large_page() after spin_lock()
Date: Mon, 07 Jan 2019 14:53:03 -0500
Message-ID: <20190107195333.842328119@goodmis.org>
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
        tom.zanussi@linux.intel.com
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 45c6ff4811878e5c1c2ae31303cd95cdc6ae2ab4 ]

Commit "x86/mm/pat: Disable preemption around __flush_tlb_all()" added a
warning if __flush_tlb_all() is invoked in preemptible context. On !RT
the warning does not trigger because a spin lock is acquired which
disables preemption. On RT the spin lock does not disable preemption and
so the warning is seen.

Disable preemption to avoid the warning __flush_tlb_all().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/mm/pageattr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 835620ab435f..57a04ef6fe47 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -661,12 +661,18 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	pgprot_t ref_prot;
 
 	spin_lock(&pgd_lock);
+	/*
+	 * Keep preemption disabled after __flush_tlb_all() which expects not be
+	 * preempted during the flush of the local TLB.
+	 */
+	preempt_disable();
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up for us already:
 	 */
 	tmp = _lookup_address_cpa(cpa, address, &level);
 	if (tmp != kpte) {
+		preempt_enable();
 		spin_unlock(&pgd_lock);
 		return 1;
 	}
@@ -696,6 +702,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		break;
 
 	default:
+		preempt_enable();
 		spin_unlock(&pgd_lock);
 		return 1;
 	}
@@ -743,6 +750,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 * going on.
 	 */
 	__flush_tlb_all();
+	preempt_enable();
 	spin_unlock(&pgd_lock);
 
 	return 0;
-- 
2.19.2
