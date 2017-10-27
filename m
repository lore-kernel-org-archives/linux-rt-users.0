From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.13.7-rt1
Date: Fri, 27 Oct 2017 18:39:12 +0200
Message-ID: <20171027163912.kpbbzkyepvfferik@linutronix.de>
References: <20171017152952.6ab7qsgeqgisqci4@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171017152952.6ab7qsgeqgisqci4@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-10-17 17:29:52 [+0200], To Thomas Gleixner wrote:
> I'm pleased to announce the v4.13.7-rt1 patch set. 

The SRCU_NOTIFIER_HEAD macro does not compile with SRCU-TINY and is only
used by the crypto code. It does not compile because the tiny
implementation does not define the "srcu_data" data type.

The following fixes it and I'm going to merge it into the original
patch (since it only affects rt1).

Reported by kbuild test robot.

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index e9515066250e..49bef3e96eb2 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -119,12 +119,20 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 	struct raw_notifier_head name =				\
 		RAW_NOTIFIER_INIT(name)
 
+#ifdef CONFIG_TREE_SRCU
 #define _SRCU_NOTIFIER_HEAD(name, mod)				\
 	static DEFINE_PER_CPU(struct srcu_data,			\
 			name##_head_srcu_data);			\
 	mod struct srcu_notifier_head name =			\
 			SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
 
+#else
+#define _SRCU_NOTIFIER_HEAD(name, mod)				\
+	mod struct srcu_notifier_head name =			\
+			SRCU_NOTIFIER_INIT(name, name)
+
+#endif
+
 #define SRCU_NOTIFIER_HEAD(name)				\
 	_SRCU_NOTIFIER_HEAD(name, )
 
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index cfbfc540cafc..1bdcbdd3317c 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -43,7 +43,7 @@ struct srcu_struct {
 
 void srcu_drive_gp(struct work_struct *wp);
 
-#define __SRCU_STRUCT_INIT(name)					\
+#define __SRCU_STRUCT_INIT(name, __ignored)				\
 {									\
 	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail = &name.srcu_cb_head,				\
@@ -56,9 +56,9 @@ void srcu_drive_gp(struct work_struct *wp);
  * Tree SRCU, which needs some per-CPU data.
  */
 #define DEFINE_SRCU(name) \
-	struct srcu_struct name = __SRCU_STRUCT_INIT(name)
+	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
 #define DEFINE_STATIC_SRCU(name) \
-	static struct srcu_struct name = __SRCU_STRUCT_INIT(name)
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
 
 void synchronize_srcu(struct srcu_struct *sp);
 

Sebastian
