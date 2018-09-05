From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 07/22] seqlock: provide the same ordering semantics as mainline
Date: Wed, 05 Sep 2018 08:28:01 -0400
Message-ID: <20180905122835.375399705@goodmis.org>
References: <20180905122754.443196118@goodmis.org>
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

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Julia Cartwright <julia@ni.com>

[ Upstream commit afa4c06b89a3c0fb7784ff900ccd707bef519cb7 ]

The mainline implementation of read_seqbegin() orders prior loads w.r.t.
the read-side critical section.  Fixup the RT writer-boosting
implementation to provide the same guarantee.

Also, while we're here, update the usage of ACCESS_ONCE() to use
READ_ONCE().

Fixes: e69f15cf77c23 ("seqlock: Prevent rt starvation")
Cc: stable-rt@vger.kernel.org
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/seqlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index a59751276b94..107079a2d7ed 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -462,6 +462,7 @@ static inline unsigned read_seqbegin(seqlock_t *sl)
 		spin_unlock_wait(&sl->lock);
 		goto repeat;
 	}
+	smp_rmb();
 	return ret;
 }
 #endif
-- 
2.18.0
