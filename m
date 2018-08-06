From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 19/22] locallock: provide {get,put}_locked_ptr() variants
Date: Mon,  6 Aug 2018 04:17:35 -0500
Message-ID: <2b33e3060bad998f3b93d170659ba05e4c50f4b1.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533540554.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
Provide a set of locallocked accessors for pointers to per-CPU data;
this is useful for dynamically-allocated per-CPU regions, for example.

These are symmetric with the {get,put}_cpu_ptr() per-CPU accessor
variants.

Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 3d45cf23db4f76cd356ebb0aa4cdaa7d92d1a64e)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/locallock.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 280f884a05a3..0c3ff5b23f6a 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -238,6 +238,14 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 #define put_locked_var(lvar, var)	local_unlock(lvar);
 
+#define get_locked_ptr(lvar, var)					\
+	({								\
+		local_lock(lvar);					\
+		this_cpu_ptr(var);					\
+	})
+
+#define put_locked_ptr(lvar, var)	local_unlock(lvar);
+
 #define local_lock_cpu(lvar)						\
 	({								\
 		local_lock(lvar);					\
@@ -278,6 +286,8 @@ static inline void local_irq_lock_init(int lvar) { }
 
 #define get_locked_var(lvar, var)		get_cpu_var(var)
 #define put_locked_var(lvar, var)		put_cpu_var(var)
+#define get_locked_ptr(lvar, var)		get_cpu_ptr(var)
+#define put_locked_ptr(lvar, var)		put_cpu_ptr(var)
 
 #define local_lock_cpu(lvar)			get_cpu()
 #define local_unlock_cpu(lvar)			put_cpu()
-- 
2.18.0
