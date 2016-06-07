From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch rfc] locking/rwsem: Add down_write_killable/killable_nested()
Date: Tue, 07 Jun 2016 06:19:19 +0200
Message-ID: <1465273159.3931.24.camel@gmail.com>
References: <20160603104424.GA18975@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603104424.GA18975@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

v4.7 added down_write_killable/killable_nested(), add them to -rt.

Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
---
 include/linux/rwsem_rt.h |   12 ++++++++++++
 kernel/locking/rt.c      |   24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

--- a/include/linux/rwsem_rt.h
+++ b/include/linux/rwsem_rt.h
@@ -52,8 +52,10 @@ do {							\
 } while (0)
 
 extern void rt_down_write(struct rw_semaphore *rwsem);
+extern int __must_check rt_down_write_killable(struct rw_semaphore *rwsem);
 extern void rt_down_read_nested(struct rw_semaphore *rwsem, int subclass);
 extern void rt_down_write_nested(struct rw_semaphore *rwsem, int subclass);
+extern int __must_check rt_down_write_killable_nested(struct rw_semaphore *rwsem, int subclass);
 extern void rt_down_write_nested_lock(struct rw_semaphore *rwsem,
 				      struct lockdep_map *nest);
 extern void rt__down_read(struct rw_semaphore *rwsem);
@@ -100,6 +102,11 @@ static inline void down_write(struct rw_
 	rt_down_write(sem);
 }
 
+static inline int down_write_killable(struct rw_semaphore *sem)
+{
+	return rt_down_write_killable(sem);
+}
+
 static inline int down_write_trylock(struct rw_semaphore *sem)
 {
 	return rt_down_write_trylock(sem);
@@ -134,6 +141,11 @@ static inline void down_write_nested(str
 {
 	rt_down_write_nested(sem, subclass);
 }
+
+static inline int down_write_killable_nested(struct rw_semaphore *sem, int subclass)
+{
+	return rt_down_write_killable_nested(sem, subclass);
+}
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static inline void down_write_nest_lock(struct rw_semaphore *sem,
 		struct rw_semaphore *nest_lock)
--- a/kernel/locking/rt.c
+++ b/kernel/locking/rt.c
@@ -358,6 +358,18 @@ void  rt_down_write(struct rw_semaphore
 }
 EXPORT_SYMBOL(rt_down_write);
 
+int  rt_down_write_killable(struct rw_semaphore *rwsem)
+{
+	int ret;
+
+	rwsem_acquire(&rwsem->dep_map, 0, 0, _RET_IP_);
+	ret = rt_mutex_lock_killable(&rwsem->lock);
+	if (ret)
+		rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
+	return ret;
+}
+EXPORT_SYMBOL(rt_down_write_killable);
+
 void  rt_down_write_nested(struct rw_semaphore *rwsem, int subclass)
 {
 	rwsem_acquire(&rwsem->dep_map, subclass, 0, _RET_IP_);
@@ -365,6 +377,18 @@ void  rt_down_write_nested(struct rw_sem
 }
 EXPORT_SYMBOL(rt_down_write_nested);
 
+int  rt_down_write_killable_nested(struct rw_semaphore *rwsem, int subclass)
+{
+	int ret;
+
+	rwsem_acquire(&rwsem->dep_map, subclass, 0, _RET_IP_);
+	ret = rt_mutex_lock_killable(&rwsem->lock);
+	if (ret)
+		rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
+	return ret;
+}
+EXPORT_SYMBOL(rt_down_write_killable_nested);
+
 void rt_down_write_nested_lock(struct rw_semaphore *rwsem,
 			       struct lockdep_map *nest)
 {
