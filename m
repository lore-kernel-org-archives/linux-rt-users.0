From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RT] lockdep munching nr_list_entries like popcorn
Date: Thu, 16 Feb 2017 15:53:55 +0100
Message-ID: <20170216145354.unz44uocud4ybrfq@linutronix.de>
References: <1487224986.5258.45.camel@gmx.de>
 <alpine.DEB.2.20.1702160933420.3543@nanos>
 <1487235000.5258.48.camel@gmx.de>
 <alpine.DEB.2.20.1702161001100.3543@nanos>
 <20170216110618.GC6557@twins.programming.kicks-ass.net>
 <1487256179.28442.8.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487256179.28442.8.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-02-16 15:42:59 [+0100], Mike Galbraith wrote:
> 
> Weeell, I'm trying to cobble something kinda like that together using
> __RT_SPIN_INITIALIZER() instead, but seems mean ole Mr. Compiler NAKs
> the PER_CPU_DEP_MAP_INIT() thingy.
> 
>   CC      mm/swap.o
> mm/swap.c:54:689: error: braced-group within expression allowed only
> inside a function

so this is what I have now. I need to get the `static' symbol working
again and PER_CPU_DEP_MAP_INIT but aside from that it seems to do its
job.

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 845c77f1a5ca..36201b37012d 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -22,9 +22,27 @@ struct local_irq_lock {
 	unsigned long		flags;
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define PER_CPU_DEP_MAP_INIT(lockname)					\
+	.dep_map = {							\
+		.key = ({ static struct lock_class_key __key; &__key }),\
+		.name = #lockname,					\
+	}
+#else
+#define PER_CPU_DEP_MAP_INIT(lockname)
+#endif
+
 #define DEFINE_LOCAL_IRQ_LOCK(lvar)					\
+	struct lock_class_key lvar##__key;			\
 	DEFINE_PER_CPU(struct local_irq_lock, lvar) = {			\
-		.lock = __SPIN_LOCK_UNLOCKED((lvar).lock) }
+		.lock = {	\
+			.lock = __RT_SPIN_INITIALIZER(lvar.lock),	\
+			.dep_map = {				\
+				.key = &lvar##__key,		\
+				.name = #lvar,			\
+			}					\
+		}							\
+	}
 
 #define DECLARE_LOCAL_IRQ_LOCK(lvar)					\
 	DECLARE_PER_CPU(struct local_irq_lock, lvar)

> 	-Mike

Sebastian
