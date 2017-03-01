From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.9.13-rt11
Date: Wed, 1 Mar 2017 12:51:54 +0100
Message-ID: <20170301115154.5hxhjw2wzo3we6ov@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.9.13-rt11 patch set. 

Changes since v4.9.13-rt10:

- The lockdep fix in last release failed to compile for UP and
  MODULE=n configs. Fixed by Dan Murphy.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against v4.9.13-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.13-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9.13-rt11

The RT patch against v4.9.13 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.13-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9.13-rt11.tar.xz

Sebastian
diff --git a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -664,6 +664,11 @@ static inline bool is_module_percpu_address(unsigned long addr)
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
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -734,6 +734,11 @@ bool is_module_percpu_address(unsigned long addr)
 	return false;
 }
 
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
+{
+	return false;
+}
+
 #endif /* CONFIG_SMP */
 
 #define MODINFO_ATTR(field)	\
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
