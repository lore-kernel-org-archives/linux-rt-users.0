From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 02/24] locallock: provide {get,put}_locked_ptr() variants
Date: Fri, 07 Sep 2018 16:58:59 -0400
Message-ID: <20180907205930.057848815@goodmis.org>
References: <20180907205857.262840394@goodmis.org>
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

4.14.63-rt41-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Julia Cartwright <julia@ni.com>

[ Upstream commit 3d45cf23db4f76cd356ebb0aa4cdaa7d92d1a64e ]

Provide a set of locallocked accessors for pointers to per-CPU data;
this is useful for dynamically-allocated per-CPU regions, for example.

These are symmetric with the {get,put}_cpu_ptr() per-CPU accessor
variants.

Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/locallock.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index d658c2552601..921eab83cd34 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -222,6 +222,14 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
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
@@ -262,6 +270,8 @@ static inline void local_irq_lock_init(int lvar) { }
 
 #define get_locked_var(lvar, var)		get_cpu_var(var)
 #define put_locked_var(lvar, var)		put_cpu_var(var)
+#define get_locked_ptr(lvar, var)		get_cpu_ptr(var)
+#define put_locked_ptr(lvar, var)		put_cpu_ptr(var)
 
 #define local_lock_cpu(lvar)			get_cpu()
 #define local_unlock_cpu(lvar)			put_cpu()
-- 
2.18.0
