From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 8/9] lockdep: Fix compilation error for !CONFIG_MODULES and
Date: Tue, 7 Mar 2017 16:32:58 -0600
Message-ID: <02585c573c60d028365b49b158190d260b40553d.1488919535.git.julia@ni.com>
References: <cover.1488919535.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Murphy <dmurphy@ti.com>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1488919535.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.38-rt46-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
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
(cherry picked from commit a88182f3f1818407d738e832650085110cae1f29)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/module.h | 5 +++++
 kernel/module.c        | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index af9a771a9346..2fd71ecdd63a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -539,6 +539,11 @@ static inline bool is_module_percpu_address(unsigned long addr)
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
index b4ebb2fd4849..a7ac858fd1a1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -599,6 +599,11 @@ bool is_module_percpu_address(unsigned long addr)
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
2.11.1
