From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH tip v4 2/5] [s]wait: Add compile time type check assertion
Date: Thu, 26 Nov 2015 13:22:37 +0100
Message-ID: <5656F98D.70701@bmw-carit.de>
References: <1448370187-10075-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1448370187-10075-3-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448370187-10075-3-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas,

On 11/24/2015 02:03 PM, Daniel Wagner wrote:
> The API provided by wait.h and swait.h is very similiar. Most of the
> time your are only one character away from either of it:
> 
>      wake_up() vs swake_up()
> 
> This is on purpose so that we do not have two nearly identical bits of
> infrastructre code with dissimilar names.
> 
> A compile time type check assertion ensures that obvious wrong usage
> is caught at early stage.

Obviously, this didn't really work as one can see with patch #4. That
one just compiled. So I wrapped almost all functions to get a better
check coverage. woken_wake_function(), autoremove_wake_function() and
wake_bit_function() can't be wrapped easily because DEFINE_WAIT and 
friends. I just left them out. 

The result looks pretty bad in my opinion. Probably it would be
better do add -Werror=incompatible-pointer-types to the CFLAGS.

Is that what you had in mind?

cheers,
daniel

>From 3a84d2eed35e3acb76bf2f7557bb4c3763a3a433 Mon Sep 17 00:00:00 2001
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Date: Thu, 26 Nov 2015 07:53:03 +0100
Subject: [PATCH] wait: Add compile time type check assertion

The API provided by wait.h and swait.h is very similiar. Most of the
time your are only one character away from either of it:

     wake_up() vs swake_up()

This is on purpose so that we do not have two nearly identical bits of
infrastructre code with dissimilar names.

A compile time type check assertion ensures that obvious wrong usage
is caught at early stage. 
---
 include/linux/compiler.h |   4 +
 include/linux/swait.h    |  72 ++++++++++++++---
 include/linux/wait.h     | 200 ++++++++++++++++++++++++++++++++++++-----------
 kernel/sched/swait.c     |  42 +++++-----
 kernel/sched/wait.c      | 108 ++++++++++++-------------
 5 files changed, 294 insertions(+), 132 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index c836eb2..ac7afcb 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -455,6 +455,10 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")
 
+#define compiletime_assert_same_type(a, b)				\
+	compiletime_assert(__same_type(a, b),				\
+		"Need same type.");
+
 /*
  * Prevent the compiler from merging or refetching accesses.  The compiler
  * is also forbidden from reordering successive instances of ACCESS_ONCE(),
diff --git a/include/linux/swait.h b/include/linux/swait.h
index c1f9c62..ebc6f9a 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -44,6 +44,43 @@ struct swait_queue {
 	struct list_head	task_list;
 };
 
+
+/*
+ * Macros for type checks
+ */
+
+#define swait_tchk_q(fn, q, ...)					\
+	do {								\
+		compiletime_assert_same_type(struct swait_queue_head *, q); \
+		fn(q, ##__VA_ARGS__);					\
+	} while (0)
+
+#define swait_tchk_ret_q(fn, q, ...)					\
+	({								\
+		compiletime_assert_same_type(struct swait_queue_head *, q); \
+		fn(q, ##__VA_ARGS__);					\
+	})
+
+#define swait_tchk_w(fn, w, ...)					\
+	do {								\
+		compiletime_assert_same_type(struct swait_queue *, w);	\
+		fn(w, ...);						\
+	} while (0)
+
+#define swait_tchk_qw(fn, q, w, ...)					\
+	do {								\
+		compiletime_assert_same_type(struct swait_queue_head *, q); \
+		compiletime_assert_same_type(struct swait_queue *, w);	\
+		fn(q, w, ##__VA_ARGS__);				\
+	} while (0)
+
+#define swait_tchk_ret_qw(fn, q, w, ...)				\
+	({								\
+		compiletime_assert_same_type(struct swait_queue_head *, q); \
+		compiletime_assert_same_type(struct swait_queue *, w);	\
+		fn(q, w, ##__VA_ARGS__);				\
+	})
+
 #define __SWAITQUEUE_INITIALIZER(name) {				\
 	.task		= current,					\
 	.task_list	= LIST_HEAD_INIT((name).task_list),		\
@@ -60,8 +97,10 @@ struct swait_queue {
 #define DECLARE_SWAIT_QUEUE_HEAD(name)					\
 	struct swait_queue_head name = __SWAIT_QUEUE_HEAD_INITIALIZER(name)
 
-extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
+extern void ___init_swait_queue_head(struct swait_queue_head *q, const char *name,
 				    struct lock_class_key *key);
+#define __init_swait_queue_head(q, s, k)				\
+	swait_tchk_q(___init_swait_queue_head, q, s, k)
 
 #define init_swait_queue_head(q)				\
 	do {							\
@@ -79,21 +118,34 @@ extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name
 	DECLARE_SWAIT_QUEUE_HEAD(name)
 #endif
 
-static inline int swait_active(struct swait_queue_head *q)
+static inline int _swait_active(struct swait_queue_head *q)
 {
 	return !list_empty(&q->task_list);
 }
 
-extern void swake_up(struct swait_queue_head *q);
-extern void swake_up_all(struct swait_queue_head *q);
-extern void swake_up_locked(struct swait_queue_head *q);
+#define swait_active(q)		swait_tchk_ret_q(_swait_active, q)
 
-extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
-extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
-extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
+extern void _swake_up(struct swait_queue_head *q);
+extern void _swake_up_all(struct swait_queue_head *q);
+extern void _swake_up_locked(struct swait_queue_head *q);
 
+extern void ___prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
+extern long _prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
+
+extern void ___finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 extern void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
-extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+#define swake_up(q)		swait_tchk_q(_swake_up, q)
+#define swake_up_all(q)		swait_tchk_q(_swake_up_all, q)
+#define swake_up_locked(q)	swait_tchk_q(_swake_up_locked, q)
+
+#define _prepare_to_swait(q, w)		swait_tchk_qw(___prepare_to_swait, q, w)
+#define prepare_to_swait(q, w, s)	swait_tchk_qw(__prepare_to_swait, q, w, s)
+#define prepare_to_swait_event(q, w, s)	swait_tchk_ret_qw(_prepare_to_swait_event, q, w, s)
+
+#define _finish_swait(q, w)		swait_tchk_qw(___finish_swait, q, w)
+#define finish_swait(q, w)		swait_tchk_qw(__finish_swait, q, w)
 
 /* as per ___wait_event() but for swait, therefore "exclusive == 0" */
 #define ___swait_event(wq, condition, state, ret, cmd)			\
@@ -103,7 +155,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 									\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
-		long __int = prepare_to_swait_event(&wq, &__wait, state);\
+		long __int = _prepare_to_swait_event(&wq, &__wait, state);\
 									\
 		if (condition)						\
 			break;						\
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 1e1bf9f..9186497 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -45,6 +45,48 @@ typedef struct __wait_queue_head wait_queue_head_t;
 struct task_struct;
 
 /*
+ * Macros for type checks
+ */
+
+#define wait_tchk_q(fn, q, ...)						\
+	do {								\
+		compiletime_assert_same_type(wait_queue_head_t *, q);	\
+		fn(q, ##__VA_ARGS__);					\
+	} while (0)
+
+#define wait_tchk_ret_q(fn, q, ...)					\
+	({								\
+		compiletime_assert_same_type(wait_queue_head_t *, q);	\
+		fn(q, ##__VA_ARGS__);					\
+	})
+
+#define wait_tchk_w(fn, w, ...)						\
+	do {								\
+		compiletime_assert_same_type(wait_queue_t *, w);	\
+		fn(w, ##__VA_ARGS__);					\
+	} while (0)
+
+#define wait_tchk_ret_w(fn, w, ...)					\
+	({								\
+		compiletime_assert_same_type(wait_queue_t *, w);	\
+		fn(w, ##__VA_ARGS__);					\
+	})
+
+#define wait_tchk_qw(fn, q, w, ...)					\
+	do {								\
+		compiletime_assert_same_type(wait_queue_head_t *, q);	\
+		compiletime_assert_same_type(wait_queue_t *, w);	\
+		fn(q, w, ##__VA_ARGS__);				\
+	} while (0)
+
+#define wait_tchk_ret_qw(fn, q, w, ...)					\
+	({								\
+		compiletime_assert_same_type(wait_queue_head_t *, q);	\
+		compiletime_assert_same_type(wait_queue_t *, w);	\
+		fn(q, w, ##__VA_ARGS__);				\
+	})
+
+/*
  * Macros for declaration and initialisaton of the datatypes
  */
 
@@ -69,13 +111,15 @@ struct task_struct;
 #define __WAIT_ATOMIC_T_KEY_INITIALIZER(p)				\
 	{ .flags = p, .bit_nr = WAIT_ATOMIC_T_BIT_NR, }
 
-extern void __init_waitqueue_head(wait_queue_head_t *q, const char *name, struct lock_class_key *);
+extern void ___init_waitqueue_head(wait_queue_head_t *q, const char *name, struct lock_class_key *);
+#define __init_waitqueue_head(q, s, l)			\
+	wait_tchk_q(___init_waitqueue_head, q, s, l)
 
 #define init_waitqueue_head(q)				\
 	do {						\
 		static struct lock_class_key __key;	\
 							\
-		__init_waitqueue_head((q), #q, &__key);	\
+		__init_waitqueue_head((q), #q, &__key);	      \
 	} while (0)
 
 #ifdef CONFIG_LOCKDEP
@@ -87,7 +131,7 @@ extern void __init_waitqueue_head(wait_queue_head_t *q, const char *name, struct
 # define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) DECLARE_WAIT_QUEUE_HEAD(name)
 #endif
 
-static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
+static inline void _init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
 {
 	q->flags	= 0;
 	q->private	= p;
@@ -95,23 +139,37 @@ static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
 }
 
 static inline void
-init_waitqueue_func_entry(wait_queue_t *q, wait_queue_func_t func)
+_init_waitqueue_func_entry(wait_queue_t *q, wait_queue_func_t func)
 {
 	q->flags	= 0;
 	q->private	= NULL;
 	q->func		= func;
 }
 
-static inline int waitqueue_active(wait_queue_head_t *q)
+static inline int _waitqueue_active(wait_queue_head_t *q)
 {
 	return !list_empty(&q->task_list);
 }
 
-extern void add_wait_queue(wait_queue_head_t *q, wait_queue_t *wait);
-extern void add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t *wait);
-extern void remove_wait_queue(wait_queue_head_t *q, wait_queue_t *wait);
-
-static inline void __add_wait_queue(wait_queue_head_t *head, wait_queue_t *new)
+#define init_waitqueue_entry(w, p)					\
+	wait_tchk_w(_init_waitqueue_entry, w, p)
+#define init_waitqueue_func_entry(w, f)					\
+	wait_tchk_w(_init_waitqueue_func_entry, w, f)
+#define waitqueue_active(q)						\
+	wait_tchk_ret_q(_waitqueue_active, q)
+
+extern void _add_wait_queue(wait_queue_head_t *q, wait_queue_t *wait);
+extern void _add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t *wait);
+extern void _remove_wait_queue(wait_queue_head_t *q, wait_queue_t *wait);
+
+#define add_wait_queue(q, w)						\
+	wait_tchk_qw(_add_wait_queue, q, w)
+#define add_wait_queue_exclusive(q, w)					\
+	wait_tchk_qw(_add_wait_queue_exclusive, q, w)
+#define remove_wait_queue(q, w)						\
+	wait_tchk_qw(_remove_wait_queue, q, w)
+
+static inline void ___add_wait_queue(wait_queue_head_t *head, wait_queue_t *new)
 {
 	list_add(&new->task_list, &head->task_list);
 }
@@ -120,40 +178,51 @@ static inline void __add_wait_queue(wait_queue_head_t *head, wait_queue_t *new)
  * Used for wake-one threads:
  */
 static inline void
-__add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t *wait)
+___add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t *wait)
 {
 	wait->flags |= WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue(q, wait);
+	___add_wait_queue(q, wait);
 }
 
-static inline void __add_wait_queue_tail(wait_queue_head_t *head,
+static inline void ___add_wait_queue_tail(wait_queue_head_t *head,
 					 wait_queue_t *new)
 {
 	list_add_tail(&new->task_list, &head->task_list);
 }
 
 static inline void
-__add_wait_queue_tail_exclusive(wait_queue_head_t *q, wait_queue_t *wait)
+___add_wait_queue_tail_exclusive(wait_queue_head_t *q, wait_queue_t *wait)
 {
 	wait->flags |= WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue_tail(q, wait);
+	___add_wait_queue_tail(q, wait);
 }
 
 static inline void
-__remove_wait_queue(wait_queue_head_t *head, wait_queue_t *old)
+___remove_wait_queue(wait_queue_head_t *head, wait_queue_t *old)
 {
 	list_del(&old->task_list);
 }
 
+#define __add_wait_queue(q, w)						\
+	wait_tchk_qw(___add_wait_queue, q, w)
+#define __add_wait_queue_exclusive(q, w)				\
+	wait_tchk_qw(___add_wait_queue_exclusive, q, w)
+#define __add_wait_queue_tail(q, w)					\
+	wait_tchk_qw(___add_wait_queue_tail, q, w)
+#define __add_wait_queue_tail_exclusive(q, w)				\
+	wait_tchk_qw(___add_wait_queue_tail_exclusive, q, w)
+#define __remove_wait_queue(q, w)					\
+	wait_tchk_qw(___remove_wait_queue, q, w)
+
 typedef int wait_bit_action_f(struct wait_bit_key *);
-void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr, void *key);
-void __wake_up_locked_key(wait_queue_head_t *q, unsigned int mode, void *key);
-void __wake_up_sync_key(wait_queue_head_t *q, unsigned int mode, int nr, void *key);
-void __wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr);
-void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr);
-void __wake_up_bit(wait_queue_head_t *, void *, int);
-int __wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, wait_bit_action_f *, unsigned);
-int __wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, wait_bit_action_f *, unsigned);
+void ___wake_up(wait_queue_head_t *q, unsigned int mode, int nr, void *key);
+void ___wake_up_locked_key(wait_queue_head_t *q, unsigned int mode, void *key);
+void ___wake_up_sync_key(wait_queue_head_t *q, unsigned int mode, int nr, void *key);
+void ___wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr);
+void ___wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr);
+void ___wake_up_bit(wait_queue_head_t *, void *, int);
+int ___wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, wait_bit_action_f *, unsigned);
+int ___wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, wait_bit_action_f *, unsigned);
 void wake_up_bit(void *, int);
 void wake_up_atomic_t(atomic_t *);
 int out_of_line_wait_on_bit(void *, int, wait_bit_action_f *, unsigned);
@@ -162,16 +231,42 @@ int out_of_line_wait_on_bit_lock(void *, int, wait_bit_action_f *, unsigned);
 int out_of_line_wait_on_atomic_t(atomic_t *, int (*)(atomic_t *), unsigned);
 wait_queue_head_t *bit_waitqueue(void *, int);
 
-#define wake_up(x)			__wake_up(x, TASK_NORMAL, 1, NULL)
-#define wake_up_nr(x, nr)		__wake_up(x, TASK_NORMAL, nr, NULL)
-#define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
-#define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
-#define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
-
-#define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
-#define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
-#define wake_up_interruptible_all(x)	__wake_up(x, TASK_INTERRUPTIBLE, 0, NULL)
-#define wake_up_interruptible_sync(x)	__wake_up_sync((x), TASK_INTERRUPTIBLE, 1)
+#define __wake_up(q, m, n, k)						\
+	wait_tchk_q(___wake_up, q, m, n, k)
+#define __wake_up_locked_key(q, m, k)					\
+	wait_tchk_q(___wake_up_locked_key, q, m, k)
+#define __wake_up_sync_key(q, m, n, k)					\
+	wait_tchk_q(___wake_up_sync_key, q, m, n, k)
+#define __wake_up_locked(q, m, n)					\
+	wait_tchk_q(___wake_up_locked, q, m, n)
+#define __wake_up_sync(q, m, n)						\
+	wait_tchk_q(___wake_up_sync, q, m, n)
+#define __wake_up_bit(q, w, b)						\
+	wait_tchk_q(___wake_up_bit, q, w, b)
+#define __wait_on_bit(q, w, a, m)					\
+	wait_tchk_ret_q(___wait_on_bit, q, w, a, m)
+#define __wait_on_bit_lock(q, w, a, m)					\
+	wait_tchk_ret_q(___wait_on_bit_lock, q, w, a, m)
+
+#define wake_up(q)							\
+	wait_tchk_q(___wake_up, q, TASK_NORMAL, 1, NULL)
+#define wake_up_nr(q, n)						\
+	wait_tchk_q(___wake_up, q, TASK_NORMAL, n, NULL)
+#define wake_up_all(q)							\
+	wait_tchk_q(___wake_up, q, TASK_NORMAL, 0, NULL)
+#define wake_up_locked(q)						\
+	wait_tchk_q(___wake_up_locked, q, TASK_NORMAL, 1)
+#define wake_up_all_locked(q)						\
+	wait_tchk_q(___wake_up_locked, q, TASK_NORMAL, 0)
+
+#define wake_up_interruptible(q)					\
+	wait_tchk_q(___wake_up, q, TASK_INTERRUPTIBLE, 1, NULL)
+#define wake_up_interruptible_nr(q, n)					\
+	wait_tchk_q(___wake_up, q, TASK_INTERRUPTIBLE, n, NULL)
+#define wake_up_interruptible_all(q)					\
+	wait_tchk_q(___wake_up, q, TASK_INTERRUPTIBLE, 0, NULL)
+#define wake_up_interruptible_sync(q)					\
+	wait_tchk_q(___wake_up_sync, q, TASK_INTERRUPTIBLE, 1)
 
 /*
  * Wakeup macros to be used to report events to the targets.
@@ -198,6 +293,30 @@ wait_queue_head_t *bit_waitqueue(void *, int);
 		state == TASK_INTERRUPTIBLE || state == TASK_KILLABLE)	\
 
 /*
+ * Waitqueues which are removed from the waitqueue_head at wakeup time
+ */
+void _prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state);
+void _prepare_to_wait_exclusive(wait_queue_head_t *q, wait_queue_t *wait, int state);
+long _prepare_to_wait_event(wait_queue_head_t *q, wait_queue_t *wait, int state);
+void _finish_wait(wait_queue_head_t *q, wait_queue_t *wait);
+void _abort_exclusive_wait(wait_queue_head_t *q, wait_queue_t *wait, unsigned int mode, void *key);
+long wait_woken(wait_queue_t *wait, unsigned mode, long timeout);
+int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
+int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
+int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
+
+#define prepare_to_wait(q, w, s)					\
+	wait_tchk_qw(_prepare_to_wait, q, w, s)
+#define prepare_to_wait_exclusive(q, w, s)				\
+	wait_tchk_qw(_prepare_to_wait_exclusive, q, w, s)
+#define prepare_to_wait_event(q, w, s)					\
+	wait_tchk_ret_qw(_prepare_to_wait_event, q, w, s)
+#define finish_wait(q, w)						\
+	wait_tchk_qw(_finish_wait, q, w)
+#define abort_exclusive_wait(q, w, m, k)				\
+	wait_tchk_qw(_abort_exclusive_wait, q, w, m, k)
+
+/*
  * The below macro ___wait_event() has an explicit shadow of the __ret
  * variable when used from the wait_event_*() macros.
  *
@@ -918,19 +1037,6 @@ do {									\
 	__ret;								\
 })
 
-/*
- * Waitqueues which are removed from the waitqueue_head at wakeup time
- */
-void prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state);
-void prepare_to_wait_exclusive(wait_queue_head_t *q, wait_queue_t *wait, int state);
-long prepare_to_wait_event(wait_queue_head_t *q, wait_queue_t *wait, int state);
-void finish_wait(wait_queue_head_t *q, wait_queue_t *wait);
-void abort_exclusive_wait(wait_queue_head_t *q, wait_queue_t *wait, unsigned int mode, void *key);
-long wait_woken(wait_queue_t *wait, unsigned mode, long timeout);
-int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
-int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
-int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
-
 #define DEFINE_WAIT_FUNC(name, function)				\
 	wait_queue_t name = {						\
 		.private	= current,				\
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 82f0dff..ca91043 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -1,14 +1,14 @@
 #include <linux/sched.h>
 #include <linux/swait.h>
 
-void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
+void ___init_swait_queue_head(struct swait_queue_head *q, const char *name,
 			     struct lock_class_key *key)
 {
 	raw_spin_lock_init(&q->lock);
 	lockdep_set_class_and_name(&q->lock, key, name);
 	INIT_LIST_HEAD(&q->task_list);
 }
-EXPORT_SYMBOL(__init_swait_queue_head);
+EXPORT_SYMBOL(___init_swait_queue_head);
 
 /*
  * The thing about the wake_up_state() return value; I think we can ignore it.
@@ -16,7 +16,7 @@ EXPORT_SYMBOL(__init_swait_queue_head);
  * If for some reason it would return 0, that means the previously waiting
  * task is already running, so it will observe condition true (or has already).
  */
-void swake_up_locked(struct swait_queue_head *q)
+void _swake_up_locked(struct swait_queue_head *q)
 {
 	struct swait_queue *curr;
 
@@ -27,31 +27,31 @@ void swake_up_locked(struct swait_queue_head *q)
 	wake_up_process(curr->task);
 	list_del_init(&curr->task_list);
 }
-EXPORT_SYMBOL(swake_up_locked);
+EXPORT_SYMBOL(_swake_up_locked);
 
-void swake_up(struct swait_queue_head *q)
+void _swake_up(struct swait_queue_head *q)
 {
 	unsigned long flags;
 
-	if (!swait_active(q))
+	if (!_swait_active(q))
 		return;
 
 	raw_spin_lock_irqsave(&q->lock, flags);
-	swake_up_locked(q);
+	_swake_up_locked(q);
 	raw_spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(swake_up);
+EXPORT_SYMBOL(_swake_up);
 
 /*
  * Does not allow usage from IRQ disabled, since we must be able to
  * release IRQs to guarantee bounded hold time.
  */
-void swake_up_all(struct swait_queue_head *q)
+void _swake_up_all(struct swait_queue_head *q)
 {
 	struct swait_queue *curr;
 	LIST_HEAD(tmp);
 
-	if (!swait_active(q))
+	if (!_swait_active(q))
 		return;
 
 	raw_spin_lock_irq(&q->lock);
@@ -70,45 +70,45 @@ void swake_up_all(struct swait_queue_head *q)
 	}
 	raw_spin_unlock_irq(&q->lock);
 }
-EXPORT_SYMBOL(swake_up_all);
+EXPORT_SYMBOL(_swake_up_all);
 
-void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
+void ___prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	wait->task = current;
 	if (list_empty(&wait->task_list))
 		list_add(&wait->task_list, &q->task_list);
 }
 
-void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state)
+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&q->lock, flags);
-	__prepare_to_swait(q, wait);
+	___prepare_to_swait(q, wait);
 	set_current_state(state);
 	raw_spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(prepare_to_swait);
+EXPORT_SYMBOL(__prepare_to_swait);
 
-long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state)
+long _prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state)
 {
 	if (signal_pending_state(state, current))
 		return -ERESTARTSYS;
 
-	prepare_to_swait(q, wait, state);
+	__prepare_to_swait(q, wait, state);
 
 	return 0;
 }
-EXPORT_SYMBOL(prepare_to_swait_event);
+EXPORT_SYMBOL(_prepare_to_swait_event);
 
-void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
+void ___finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	__set_current_state(TASK_RUNNING);
 	if (!list_empty(&wait->task_list))
 		list_del_init(&wait->task_list);
 }
 
-void finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
+void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	unsigned long flags;
 
@@ -120,4 +120,4 @@ void finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
 		raw_spin_unlock_irqrestore(&q->lock, flags);
 	}
 }
-EXPORT_SYMBOL(finish_swait);
+EXPORT_SYMBOL(__finish_swait);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 052e026..02c69dc 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -11,46 +11,46 @@
 #include <linux/hash.h>
 #include <linux/kthread.h>
 
-void __init_waitqueue_head(wait_queue_head_t *q, const char *name, struct lock_class_key *key)
+void ___init_waitqueue_head(wait_queue_head_t *q, const char *name, struct lock_class_key *key)
 {
 	spin_lock_init(&q->lock);
 	lockdep_set_class_and_name(&q->lock, key, name);
 	INIT_LIST_HEAD(&q->task_list);
 }
 
-EXPORT_SYMBOL(__init_waitqueue_head);
+EXPORT_SYMBOL(___init_waitqueue_head);
 
-void add_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
+void _add_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
 {
 	unsigned long flags;
 
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&q->lock, flags);
-	__add_wait_queue(q, wait);
+	___add_wait_queue(q, wait);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(add_wait_queue);
+EXPORT_SYMBOL(_add_wait_queue);
 
-void add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t *wait)
+void _add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t *wait)
 {
 	unsigned long flags;
 
 	wait->flags |= WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&q->lock, flags);
-	__add_wait_queue_tail(q, wait);
+	___add_wait_queue_tail(q, wait);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(add_wait_queue_exclusive);
+EXPORT_SYMBOL(_add_wait_queue_exclusive);
 
-void remove_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
+void _remove_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&q->lock, flags);
-	__remove_wait_queue(q, wait);
+	___remove_wait_queue(q, wait);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(remove_wait_queue);
+EXPORT_SYMBOL(_remove_wait_queue);
 
 
 /*
@@ -86,7 +86,7 @@ static void __wake_up_common(wait_queue_head_t *q, unsigned int mode,
  * It may be assumed that this function implies a write memory barrier before
  * changing the task state if and only if any tasks are woken up.
  */
-void __wake_up(wait_queue_head_t *q, unsigned int mode,
+void ___wake_up(wait_queue_head_t *q, unsigned int mode,
 			int nr_exclusive, void *key)
 {
 	unsigned long flags;
@@ -95,22 +95,22 @@ void __wake_up(wait_queue_head_t *q, unsigned int mode,
 	__wake_up_common(q, mode, nr_exclusive, 0, key);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(__wake_up);
+EXPORT_SYMBOL(___wake_up);
 
 /*
  * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
  */
-void __wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr)
+void ___wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr)
 {
 	__wake_up_common(q, mode, nr, 0, NULL);
 }
-EXPORT_SYMBOL_GPL(__wake_up_locked);
+EXPORT_SYMBOL_GPL(___wake_up_locked);
 
-void __wake_up_locked_key(wait_queue_head_t *q, unsigned int mode, void *key)
+void ___wake_up_locked_key(wait_queue_head_t *q, unsigned int mode, void *key)
 {
 	__wake_up_common(q, mode, 1, 0, key);
 }
-EXPORT_SYMBOL_GPL(__wake_up_locked_key);
+EXPORT_SYMBOL_GPL(___wake_up_locked_key);
 
 /**
  * __wake_up_sync_key - wake up threads blocked on a waitqueue.
@@ -129,7 +129,7 @@ EXPORT_SYMBOL_GPL(__wake_up_locked_key);
  * It may be assumed that this function implies a write memory barrier before
  * changing the task state if and only if any tasks are woken up.
  */
-void __wake_up_sync_key(wait_queue_head_t *q, unsigned int mode,
+void ___wake_up_sync_key(wait_queue_head_t *q, unsigned int mode,
 			int nr_exclusive, void *key)
 {
 	unsigned long flags;
@@ -145,16 +145,16 @@ void __wake_up_sync_key(wait_queue_head_t *q, unsigned int mode,
 	__wake_up_common(q, mode, nr_exclusive, wake_flags, key);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL_GPL(__wake_up_sync_key);
+EXPORT_SYMBOL_GPL(___wake_up_sync_key);
 
 /*
- * __wake_up_sync - see __wake_up_sync_key()
+ * ___wake_up_sync - see __wake_up_sync_key()
  */
-void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+void ___wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
-	__wake_up_sync_key(q, mode, nr_exclusive, NULL);
+	___wake_up_sync_key(q, mode, nr_exclusive, NULL);
 }
-EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
+EXPORT_SYMBOL_GPL(___wake_up_sync);	/* For internal use only */
 
 /*
  * Note: we use "set_current_state()" _after_ the wait-queue add,
@@ -169,34 +169,34 @@ EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
  * loads to move into the critical region).
  */
 void
-prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state)
+_prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state)
 {
 	unsigned long flags;
 
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
-		__add_wait_queue(q, wait);
+		___add_wait_queue(q, wait);
 	set_current_state(state);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(prepare_to_wait);
+EXPORT_SYMBOL(_prepare_to_wait);
 
 void
-prepare_to_wait_exclusive(wait_queue_head_t *q, wait_queue_t *wait, int state)
+_prepare_to_wait_exclusive(wait_queue_head_t *q, wait_queue_t *wait, int state)
 {
 	unsigned long flags;
 
 	wait->flags |= WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
-		__add_wait_queue_tail(q, wait);
+		___add_wait_queue_tail(q, wait);
 	set_current_state(state);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(prepare_to_wait_exclusive);
+EXPORT_SYMBOL(_prepare_to_wait_exclusive);
 
-long prepare_to_wait_event(wait_queue_head_t *q, wait_queue_t *wait, int state)
+long _prepare_to_wait_event(wait_queue_head_t *q, wait_queue_t *wait, int state)
 {
 	unsigned long flags;
 
@@ -209,19 +209,19 @@ long prepare_to_wait_event(wait_queue_head_t *q, wait_queue_t *wait, int state)
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list)) {
 		if (wait->flags & WQ_FLAG_EXCLUSIVE)
-			__add_wait_queue_tail(q, wait);
+			___add_wait_queue_tail(q, wait);
 		else
-			__add_wait_queue(q, wait);
+			___add_wait_queue(q, wait);
 	}
 	set_current_state(state);
 	spin_unlock_irqrestore(&q->lock, flags);
 
 	return 0;
 }
-EXPORT_SYMBOL(prepare_to_wait_event);
+EXPORT_SYMBOL(_prepare_to_wait_event);
 
 /**
- * finish_wait - clean up after waiting in a queue
+ * _finish_wait - clean up after waiting in a queue
  * @q: waitqueue waited on
  * @wait: wait descriptor
  *
@@ -229,7 +229,7 @@ EXPORT_SYMBOL(prepare_to_wait_event);
  * the wait descriptor from the given waitqueue if still
  * queued.
  */
-void finish_wait(wait_queue_head_t *q, wait_queue_t *wait)
+void _finish_wait(wait_queue_head_t *q, wait_queue_t *wait)
 {
 	unsigned long flags;
 
@@ -253,10 +253,10 @@ void finish_wait(wait_queue_head_t *q, wait_queue_t *wait)
 		spin_unlock_irqrestore(&q->lock, flags);
 	}
 }
-EXPORT_SYMBOL(finish_wait);
+EXPORT_SYMBOL(_finish_wait);
 
 /**
- * abort_exclusive_wait - abort exclusive waiting in a queue
+ * _abort_exclusive_wait - abort exclusive waiting in a queue
  * @q: waitqueue waited on
  * @wait: wait descriptor
  * @mode: runstate of the waiter to be woken
@@ -273,7 +273,7 @@ EXPORT_SYMBOL(finish_wait);
  * aborts and is woken up concurrently and no one wakes up
  * the next waiter.
  */
-void abort_exclusive_wait(wait_queue_head_t *q, wait_queue_t *wait,
+void _abort_exclusive_wait(wait_queue_head_t *q, wait_queue_t *wait,
 			unsigned int mode, void *key)
 {
 	unsigned long flags;
@@ -286,7 +286,7 @@ void abort_exclusive_wait(wait_queue_head_t *q, wait_queue_t *wait,
 		__wake_up_locked_key(q, mode, key);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(abort_exclusive_wait);
+EXPORT_SYMBOL(_abort_exclusive_wait);
 
 int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
 {
@@ -384,7 +384,7 @@ EXPORT_SYMBOL(wake_bit_function);
  * permitted return codes. Nonzero return codes halt waiting and return.
  */
 int __sched
-__wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
+___wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
 	      wait_bit_action_f *action, unsigned mode)
 {
 	int ret = 0;
@@ -394,10 +394,10 @@ __wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
 		if (test_bit(q->key.bit_nr, q->key.flags))
 			ret = (*action)(&q->key);
 	} while (test_bit(q->key.bit_nr, q->key.flags) && !ret);
-	finish_wait(wq, &q->wait);
+	_finish_wait(wq, &q->wait);
 	return ret;
 }
-EXPORT_SYMBOL(__wait_on_bit);
+EXPORT_SYMBOL(___wait_on_bit);
 
 int __sched out_of_line_wait_on_bit(void *word, int bit,
 				    wait_bit_action_f *action, unsigned mode)
@@ -405,7 +405,7 @@ int __sched out_of_line_wait_on_bit(void *word, int bit,
 	wait_queue_head_t *wq = bit_waitqueue(word, bit);
 	DEFINE_WAIT_BIT(wait, word, bit);
 
-	return __wait_on_bit(wq, &wait, action, mode);
+	return ___wait_on_bit(wq, &wait, action, mode);
 }
 EXPORT_SYMBOL(out_of_line_wait_on_bit);
 
@@ -417,30 +417,30 @@ int __sched out_of_line_wait_on_bit_timeout(
 	DEFINE_WAIT_BIT(wait, word, bit);
 
 	wait.key.timeout = jiffies + timeout;
-	return __wait_on_bit(wq, &wait, action, mode);
+	return ___wait_on_bit(wq, &wait, action, mode);
 }
 EXPORT_SYMBOL_GPL(out_of_line_wait_on_bit_timeout);
 
 int __sched
-__wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
+___wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
 			wait_bit_action_f *action, unsigned mode)
 {
 	do {
 		int ret;
 
-		prepare_to_wait_exclusive(wq, &q->wait, mode);
+		_prepare_to_wait_exclusive(wq, &q->wait, mode);
 		if (!test_bit(q->key.bit_nr, q->key.flags))
 			continue;
 		ret = action(&q->key);
 		if (!ret)
 			continue;
-		abort_exclusive_wait(wq, &q->wait, mode, &q->key);
+		_abort_exclusive_wait(wq, &q->wait, mode, &q->key);
 		return ret;
 	} while (test_and_set_bit(q->key.bit_nr, q->key.flags));
-	finish_wait(wq, &q->wait);
+	_finish_wait(wq, &q->wait);
 	return 0;
 }
-EXPORT_SYMBOL(__wait_on_bit_lock);
+EXPORT_SYMBOL(___wait_on_bit_lock);
 
 int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
 					 wait_bit_action_f *action, unsigned mode)
@@ -452,13 +452,13 @@ int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
 }
 EXPORT_SYMBOL(out_of_line_wait_on_bit_lock);
 
-void __wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
+void ___wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
 {
 	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
 	if (waitqueue_active(wq))
 		__wake_up(wq, TASK_NORMAL, 1, &key);
 }
-EXPORT_SYMBOL(__wake_up_bit);
+EXPORT_SYMBOL(___wake_up_bit);
 
 /**
  * wake_up_bit - wake up a waiter on a bit
@@ -479,7 +479,7 @@ EXPORT_SYMBOL(__wake_up_bit);
  */
 void wake_up_bit(void *word, int bit)
 {
-	__wake_up_bit(bit_waitqueue(word, bit), word, bit);
+	___wake_up_bit(bit_waitqueue(word, bit), word, bit);
 }
 EXPORT_SYMBOL(wake_up_bit);
 
@@ -541,7 +541,7 @@ int __wait_on_atomic_t(wait_queue_head_t *wq, struct wait_bit_queue *q,
 			break;
 		ret = (*action)(val);
 	} while (!ret && atomic_read(val) != 0);
-	finish_wait(wq, &q->wait);
+	_finish_wait(wq, &q->wait);
 	return ret;
 }
 
@@ -577,7 +577,7 @@ EXPORT_SYMBOL(out_of_line_wait_on_atomic_t);
  */
 void wake_up_atomic_t(atomic_t *p)
 {
-	__wake_up_bit(atomic_t_waitqueue(p), p, WAIT_ATOMIC_T_BIT_NR);
+	___wake_up_bit(atomic_t_waitqueue(p), p, WAIT_ATOMIC_T_BIT_NR);
 }
 EXPORT_SYMBOL(wake_up_atomic_t);
 
-- 
2.4.3
