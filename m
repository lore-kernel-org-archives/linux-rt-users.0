From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH tip v4 2/5] [s]wait: Add compile time type check assertion
Date: Tue, 24 Nov 2015 14:03:04 +0100
Message-ID: <1448370187-10075-3-git-send-email-daniel.wagner@bmw-carit.de>
References: <1448370187-10075-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448370187-10075-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The API provided by wait.h and swait.h is very similiar. Most of the
time your are only one character away from either of it:

     wake_up() vs swake_up()

This is on purpose so that we do not have two nearly identical bits of
infrastructre code with dissimilar names.

A compile time type check assertion ensures that obvious wrong usage
is caught at early stage.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 include/linux/compiler.h | 4 ++++
 include/linux/swait.h    | 2 ++
 include/linux/wait.h     | 2 ++
 3 files changed, 8 insertions(+)

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
index c1f9c62..80e2eb8 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -66,6 +66,7 @@ extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name
 #define init_swait_queue_head(q)				\
 	do {							\
 		static struct lock_class_key __key;		\
+		compiletime_assert_same_type(struct swait_queue_head *, q); \
 		__init_swait_queue_head((q), #q, &__key);	\
 	} while (0)
 
@@ -101,6 +102,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
+	compiletime_assert_same_type(struct swait_queue_head, wq);	\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 1e1bf9f..bc4f829 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -75,6 +75,7 @@ extern void __init_waitqueue_head(wait_queue_head_t *q, const char *name, struct
 	do {						\
 		static struct lock_class_key __key;	\
 							\
+		compiletime_assert_same_type(wait_queue_head_t *, q); \
 		__init_waitqueue_head((q), #q, &__key);	\
 	} while (0)
 
@@ -215,6 +216,7 @@ wait_queue_head_t *bit_waitqueue(void *, int);
 	wait_queue_t __wait;						\
 	long __ret = ret;	/* explicit shadow */			\
 									\
+	compiletime_assert_same_type(wait_queue_head_t, wq);		\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	if (exclusive)							\
 		__wait.flags = WQ_FLAG_EXCLUSIVE;			\
-- 
2.4.3
