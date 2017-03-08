From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 6/7] lockdep: Fix compilation error for !CONFIG_MODULES and !CONFIG_SMP
Date: Wed, 08 Mar 2017 15:22:33 -0500
Message-ID: <20170308202254.550618347@goodmis.org>
References: <20170308202227.841639815@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>, Dan Murphy <dmurphy@ti.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0006-lockdep-Fix-compilation-error-for-CONFIG_MODULES-and.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.70-rt95-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Dan Murphy <dmurphy@ti.com>

When CONFIG_MODULES is not set then it fails to compile in lockdep:

|kernel/locking/lockdep.c: In function 'look_up_lock_class':
|kernel/locking/lockdep.c:684:12: error: implicit declaration of function
| '__is_module_percpu_address' [-Werror=implicit-function-declaration]

If CONFIG_MODULES is set but CONFIG_SMP is not, then it compiles but
fails link at the end:

|kernel/locking/lockdep.c:684: undefined reference to `__is_module_percpu_address'
|kernel/built-in.o:(.debug_addr+0x1e674): undefined reference to `__is_module_percpu_address'

This patch adds the function for both cases.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
[bigeasy: merge the two patches from Dan into one, adapt changelog]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/module.h | 5 +++++
 kernel/module.c        | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7ae21ed9453d..874504dcc825 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -543,6 +543,11 @@ static inline bool is_module_percpu_address(unsigned long addr)
 	return false;
 }
 
+static inline bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
+{
+	return false;
+}
+
 static inline bool is_module_text_address(unsigned long addr)
 {
 	return false;
diff --git a/kernel/module.c b/kernel/module.c
index 4347aa243941..64135e935223 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -604,6 +604,11 @@ bool is_module_percpu_address(unsigned long addr)
 	return false;
 }
 
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
+{
+	return false;
+}
+
 #endif /* CONFIG_SMP */
 
 #define MODINFO_ATTR(field)	\
-- 
2.10.2
