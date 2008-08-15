From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH RT RFC v2 1/8] add generalized priority-inheritance interface
Date: Fri, 15 Aug 2008 08:08:15 -0400
Message-ID: <20080815120815.24722.80889.stgit@dev.haskins.net>
References: <20080815120722.24722.66516.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	gregory.haskins@gmail.com, David.Holmes@sun.com
To: mingo@elte.hu, paulmck@linux.vnet.ibm.com, peterz@infradead.org,
	tglx@linutronix.de, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-108-43.dhcp.oxfr.ma.charter.com ([75.130.108.43]:53184
	"EHLO dev.haskins.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751483AbYHOMSy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Aug 2008 08:18:54 -0400
In-Reply-To: <20080815120722.24722.66516.stgit@dev.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The kernel currently addresses priority-inversion through priority-
inheritence.  However, all of the priority-inheritence logic is
integrated into the Real-Time Mutex infrastructure.  This causes a few
problems:

 1) This tightly coupled relationship makes it difficult to extend to
    other areas of the kernel (for instance, pi-aware wait-queues may
    be desirable).
 2) Enhancing the rtmutex infrastructure becomes challenging because
    there is no seperation between the locking code, and the pi-code.

This patch aims to rectify these shortcomings by designing a stand-alon=
e
pi framework which can then be used to replace the rtmutex-specific
version.  The goal of this framework is to provide similar functionalit=
y
to the existing subsystem, but with sole focus on PI and the
relationships between objects that can boost priority, and the objects
that get boosted.

We introduce the concept of a "pi_source" and a "pi_sink", where, as th=
e
name suggests provides the basic relationship of a priority source, and
its boosted target.  A pi_source acts as a reference to some arbitrary
source of priority, and a pi_sink can be boosted (or deboosted) by
a pi_source.  For more details, please read the library documentation.

There are currently no users of this inteface.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 Documentation/libpi.txt |   59 +++++
 include/linux/pi.h      |  278 +++++++++++++++++++++++++
 lib/Makefile            |    3=20
 lib/pi.c                |  516 +++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 855 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/libpi.txt
 create mode 100644 include/linux/pi.h
 create mode 100644 lib/pi.c

diff --git a/Documentation/libpi.txt b/Documentation/libpi.txt
new file mode 100644
index 0000000..197b21a
--- /dev/null
+++ b/Documentation/libpi.txt
@@ -0,0 +1,59 @@
+=EF=BB=BFlib/pi.c - Priority Inheritance library
+
+Sources and sinks:
+------------
+
+This library introduces the basic concept of a "pi_source" and a "pi_s=
ink", where, as the name suggests provides the basic relationship of a =
priority source, and its boosted target.
+
+A pi_source is simply a reference to some arbitrary priority value tha=
t may range from 0 (highest prio), to MAX_PRIO (currently 140, lowest p=
rio).  A pi_source calls pi_sink.boost() whenever it wishes to boost th=
e sink to (at least minimally) the priority value that the source repre=
sents.  It uses pi_sink.boost() for both the initial boosting, or for a=
ny subsequent refreshes to the value (even if the value is decreasing i=
n logical priority).  The policy of the sink will dictate what happens =
as a result of that boost.  Likewise, a pi_source calls pi_sink.deboost=
() to stop contributing to the sink's minimum priority.
+
+It is important to note that a source is a reference to a priority val=
ue, not a value itself.  This is one of the concepts that allows the in=
terface to be idempotent, which is important for properly updating a ch=
ain of sources and sinks in the proper order.  If we passed the priorit=
y on the stack, the order in which the system executes could allow the =
actual value that is set to race.
+
+Nodes:
+
+A pi_node is a convenience object which is simultaneously a source and=
 a sink.  As its name suggests, it would typically be deployed as a nod=
e in a pi-chain.  Other pi_sources can boost a node via its pi_sink.boo=
st() interface.  Likewise, a node can boost a fixed number of sinks via=
 the node.add_sink() interface.
+
+Generally speaking, a node takes care of many common operations associ=
ated with being a =E2=80=9Clink in the chain=E2=80=9D, such as:
+
+	1) determining the current priority of the node based on the (logical=
ly) highest priority source that is boosting the node.
+	2) boosting/deboosting upstream sinks whenever the node locally chang=
es priority.
+	3) taking care to avoid deadlock during a chain update.
+
+Design details:
+
+Destruction:
+
+The pi-library objects are designed to be implicitly-destructable (mea=
ning they do not require an explicit =E2=80=9Cfree()=E2=80=9D operation=
 when they are not used anymore).  This is important considering their =
intended use (spinlock_t's which are also implicitly-destructable).  As=
 such, any allocations needed for operation must come from internal str=
ucture storage as there will be no opportunity to free it later.
+
+Multiple sinks per Node:
+
+We allow multiple sinks to be associated with a node.  This is a sligh=
t departure from the previous implementation which had the notion of on=
ly a single sink (i.e. =E2=80=9Ctask->pi_blocked_on=E2=80=9D).  The rea=
son why we added the ability to add more than one sink was not to chang=
e the default chaining model (I.e. multiple boost targets), but rather =
to add a flexible notification mechanism that is peripheral to the chai=
n, which are informally called =E2=80=9Cleaf sinks=E2=80=9D.
+
+Leaf-sinks are boostable objects that do not perpetuate a chain per se=
=2E  Rather, they act as endpoints to a priority boosting.  Ultimately,=
 every chain ends with a leaf-sink, which presumably will act on the ne=
w priority information.  However, there may be any number of leaf-sinks=
 along a chain as well.  Each one will act on its localized priority in=
 its own implementation specific way.  For instance, a task_struct pi-l=
eaf may change the priority of the task and reschedule it if necessary.=
  Whereas an rwlock leaf-sink may boost a list of reader-owners.
+
+The following diagram depicts an example relationship (warning: cheesy=
 ascii art)
+
+                   ---------       ---------
+                   | leaf  |       | leaf  |
+                   ---------       ---------
+                  /	          /	   =20
+     ---------   / ----------    / ---------     ---------
+  ->-| node  |->---| node   |-->---| node  |->---| leaf  |
+     ---------     ----------      ---------     ---------
+
+The reason why this was done was to unify the notion of a =E2=80=9Csin=
k=E2=80=9D to a single interface, rather than having something like tas=
k->pi_blocks_on and a separate callback for the leaf action.  Instead, =
any downstream object can be represented by a sink, and the implementat=
ion details are hidden (e.g. im a task, im a lock, im a node, im a work=
-item, im a wait-queue, etc).
+
+Sinkrefs:
+
+Each pi_sink.boost() operation is represented by a unique pi_source to=
 properly facilitate a one node to many source relationship.  Therefore=
, if a pi_node is to act as aggregator to multiple sinks, it implicitly=
 must have one internal pi_source object for every sink that is added (=
via node.add_sink().  This pi_source object has to be internally manage=
d for the lifetime of the sink reference.
+
+Recall that due to the implicit-destruction requirement above, and the=
 fact that we will typically be executing in a preempt-disabled region,=
 we have to be very careful about how we allocate references to those s=
inks.  More on that next.  But long story short we limit the number of =
sinks to MAX_PI_DEPENDENDICES (currently 5).
+
+Locking:
+
+(work in progress....)
+
+
+
+
+
diff --git a/include/linux/pi.h b/include/linux/pi.h
new file mode 100644
index 0000000..d839d4f
--- /dev/null
+++ b/include/linux/pi.h
@@ -0,0 +1,278 @@
+/*
+ * see Documentation/libpi.txt for details
+ */
+
+#ifndef _LINUX_PI_H
+#define _LINUX_PI_H
+
+#include <linux/list.h>
+#include <linux/plist.h>
+#include <asm/atomic.h>
+
+#define MAX_PI_DEPENDENCIES 5
+
+struct pi_source {
+	struct plist_node  list;
+	int               *prio;
+	int                boosted;
+};
+
+
+#define PI_FLAG_DEFER_UPDATE     (1 << 0)
+#define PI_FLAG_ALREADY_BOOSTED  (1 << 1)
+#define PI_FLAG_NO_DROPREF       (1 << 2)
+
+struct pi_sink {
+	atomic_t refs;
+	int (*boost)(struct pi_sink *snk, struct pi_source *src,
+		     unsigned int flags);
+	int (*deboost)(struct pi_sink *snk, struct pi_source *src,
+		       unsigned int flags);
+	int (*update)(struct pi_sink *snk,
+		      unsigned int flags);
+	int (*free)(struct pi_sink *snk,
+		      unsigned int flags);
+};
+
+enum pi_state {
+	pi_state_boost,
+	pi_state_boosted,
+	pi_state_deboost,
+	pi_state_free,
+};
+
+/*
+ * NOTE: PI must always use a true (e.g. raw) spinlock, since it is us=
ed by
+ * rtmutex infrastructure.
+ */
+
+struct pi_sinkref {
+	raw_spinlock_t         lock;
+	struct list_head       list;
+	enum pi_state          state;
+	struct pi_sink        *snk;
+	struct pi_source       src;
+	atomic_t               refs;
+	int                    prio;
+};
+
+struct pi_sinkref_pool {
+	struct list_head       free;
+	struct pi_sinkref      data[MAX_PI_DEPENDENCIES];
+	int                    count;
+};
+
+struct pi_node {
+	raw_spinlock_t         lock;
+	int                    prio;
+	struct pi_sink         snk;
+	struct pi_sinkref_pool sinkref_pool;
+	struct list_head       snks;
+	struct plist_head      srcs;
+};
+
+/**
+ * pi_node_init - initialize a pi_node before use
+ * @node: a node context
+ */
+extern void pi_node_init(struct pi_node *node);
+
+/**
+ * pi_add_sink - add a sink as an downstream object
+ * @node: the node context
+ * @snk: the sink context to add to the node
+ * @flags: optional flags to modify behavior
+ *   PI_FLAG_DEFER_UPDATE    - Do not perform sync update
+ *   PI_FLAG_ALREADY_BOOSTED - Do not perform initial boosting
+ *
+ * This function registers a sink to get notified whenever the
+ * node changes priority.
+ *
+ * Note: By default, this function will schedule the newly added sink
+ * to get an inital boost notification on the next update (even
+ * without the presence of a priority transition).  However, if the
+ * ALREADY_BOOSTED flag is specified, the sink is initially marked as
+ * BOOSTED and will only get notified if the node changes priority
+ * in the future.
+ *
+ * Note: By default, this function will synchronously update the
+ * chain unless the DEFER_UPDATE flag is specified.
+ *
+ * Returns: (int)
+ *   0 =3D success
+ *   any other value =3D failure
+ */
+extern int pi_add_sink(struct pi_node *node, struct pi_sink *snk,
+		       unsigned int flags);
+
+/**
+ * pi_del_sink - del a sink from the current downstream objects
+ * @node: the node context
+ * @snk: the sink context to delete from the node
+ * @flags: optional flags to modify behavior
+ *   PI_FLAG_DEFER_UPDATE    - Do not perform sync update
+ *
+ * This function unregisters a sink from the node.
+ *
+ * Note: The sink will not actually become fully deboosted until
+ * a call to node.update() successfully returns.
+ *
+ * Note: By default, this function will synchronously update the
+ * chain unless the DEFER_UPDATE flag is specified.
+ *
+ * Returns: (int)
+ *   0 =3D success
+ *   any other value =3D failure
+ */
+extern int pi_del_sink(struct pi_node *node, struct pi_sink *snk,
+		       unsigned int flags);
+
+/**
+ * pi_source_init - initialize a pi_source before use
+ * @src: a src context
+ * @prio: pointer to a priority value
+ *
+ * A pointer to a priority value is used so that boost and update
+ * are fully idempotent.
+ */
+static inline void
+pi_source_init(struct pi_source *src, int *prio)
+{
+	plist_node_init(&src->list, *prio);
+	src->prio =3D prio;
+	src->boosted =3D 0;
+}
+
+/**
+ * pi_boost - boost a node with a pi_source
+ * @node: the node context
+ * @src: the src context to boost the node with
+ * @flags: optional flags to modify behavior
+ *   PI_FLAG_DEFER_UPDATE    - Do not perform sync update
+ *
+ * This function registers a priority source with the node, possibly
+ * boosting its value if the new source is the highest registered sour=
ce.
+ *
+ * This function is used to both initially register a source, as well =
as
+ * to notify the node if the value changes in the future (even if the
+ * priority is decreasing).
+ *
+ * Note: By default, this function will synchronously update the
+ * chain unless the DEFER_UPDATE flag is specified.
+ *
+ * Returns: (int)
+ *   0 =3D success
+ *   any other value =3D failure
+ */
+static inline int
+pi_boost(struct pi_node *node, struct pi_source *src, unsigned int fla=
gs)
+{
+	struct pi_sink *snk =3D &node->snk;
+
+	if (snk->boost)
+		return snk->boost(snk, src, flags);
+
+	return 0;
+}
+
+/**
+ * pi_deboost - deboost a pi_source from a node
+ * @node: the node context
+ * @src: the src context to boost the node with
+ * @flags: optional flags to modify behavior
+ *   PI_FLAG_DEFER_UPDATE    - Do not perform sync update
+ *
+ * This function unregisters a priority source from the node, possibly
+ * deboosting its value if the departing source was the highest
+ * registered source.
+ *
+ * Note: By default, this function will synchronously update the
+ * chain unless the DEFER_UPDATE flag is specified.
+ *
+ * Returns: (int)
+ *   0 =3D success
+ *   any other value =3D failure
+ */
+static inline int
+pi_deboost(struct pi_node *node, struct pi_source *src, unsigned int f=
lags)
+{
+	struct pi_sink *snk =3D &node->snk;
+
+	if (snk->deboost)
+		return snk->deboost(snk, src, flags);
+
+	return 0;
+}
+
+/**
+ * pi_update - force a manual chain update
+ * @node: the node context
+ * @flags: optional flags to modify behavior.  Reserved, must be 0.
+ *
+ * This function will push any priority changes (as a result of
+ * boost/deboost or add_sink/del_sink) down through the chain.
+ * If no changes are necessary, this function is a no-op.
+ *
+ * Returns: (int)
+ *   0 =3D success
+ *   any other value =3D failure
+ */
+static inline int
+pi_update(struct pi_node *node, unsigned int flags)
+{
+	struct pi_sink *snk =3D &node->snk;
+
+	if (snk->update)
+		return snk->update(snk, flags);
+
+	return 0;
+}
+
+/**
+ * pi_sink_dropref - down the reference count, freeing the sink if 0
+ * @node: the node context
+ * @flags: optional flags to modify behavior.  Reserved, must be 0.
+ *
+ * Returns: none
+ */
+static inline void
+pi_sink_dropref(struct pi_sink *snk, unsigned int flags)
+{
+	if (atomic_dec_and_test(&snk->refs)) {
+		if (snk->free)
+			snk->free(snk, flags);
+	}
+}
+
+
+/**
+ * pi_addref - up the reference count
+ * @node: the node context
+ * @flags: optional flags to modify behavior.  Reserved, must be 0.
+ *
+ * Returns: none
+ */
+static inline void
+pi_addref(struct pi_node *node, unsigned int flags)
+{
+	struct pi_sink *snk =3D &node->snk;
+
+	atomic_inc(&snk->refs);
+}
+
+/**
+ * pi_dropref - down the reference count, freeing the node if 0
+ * @node: the node context
+ * @flags: optional flags to modify behavior.  Reserved, must be 0.
+ *
+ * Returns: none
+ */
+static inline void
+pi_dropref(struct pi_node *node, unsigned int flags)
+{
+	struct pi_sink *snk =3D &node->snk;
+
+	pi_sink_dropref(snk, flags);
+}
+
+#endif /* _LINUX_PI_H */
diff --git a/lib/Makefile b/lib/Makefile
index 5187924..df81ad7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -23,7 +23,8 @@ lib-$(CONFIG_SMP) +=3D cpumask.o
 lib-y	+=3D kobject.o kref.o klist.o
=20
 obj-y +=3D div64.o sort.o parser.o halfmd4.o debug_locks.o random32.o =
\
-	 bust_spinlocks.o hexdump.o kasprintf.o bitmap.o scatterlist.o
+	 bust_spinlocks.o hexdump.o kasprintf.o bitmap.o scatterlist.o \
+	 pi.o
=20
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o +=3D -DDEBUG
diff --git a/lib/pi.c b/lib/pi.c
new file mode 100644
index 0000000..46736e4
--- /dev/null
+++ b/lib/pi.c
@@ -0,0 +1,516 @@
+/*
+ *  lib/pi.c
+ *
+ *  Priority-Inheritance library
+ *
+ *  Copyright (C) 2008 Novell
+ *
+ *  Author: Gregory Haskins <ghaskins@novell.com>
+ *
+ *  This code provides a generic framework for preventing priority
+ *  inversion by means of priority-inheritance. (see Documentation/lib=
pi.txt
+ *  for details)
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; version 2
+ *  of the License.
+ */
+
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/pi.h>
+
+/*
+ *-----------------------------------------------------------
+ * pi_sinkref_pool
+ *-----------------------------------------------------------
+ */
+
+static void
+pi_sinkref_pool_init(struct pi_sinkref_pool *pool)
+{
+	int i;
+
+	INIT_LIST_HEAD(&pool->free);
+	pool->count =3D 0;
+
+	for (i =3D 0; i < MAX_PI_DEPENDENCIES; ++i) {
+		struct pi_sinkref *sinkref =3D &pool->data[i];
+
+		memset(sinkref, 0, sizeof(*sinkref));
+		INIT_LIST_HEAD(&sinkref->list);
+		list_add_tail(&sinkref->list, &pool->free);
+		pool->count++;
+	}
+}
+
+static struct pi_sinkref *
+pi_sinkref_alloc(struct pi_sinkref_pool *pool)
+{
+	struct pi_sinkref *sinkref;
+
+	BUG_ON(!pool->count);
+
+	if (list_empty(&pool->free))
+		return NULL;
+
+	sinkref =3D list_first_entry(&pool->free, struct pi_sinkref, list);
+	list_del(&sinkref->list);
+	memset(sinkref, 0, sizeof(*sinkref));
+	pool->count--;
+
+	return sinkref;
+}
+
+static void
+pi_sinkref_free(struct pi_sinkref_pool *pool,
+		  struct pi_sinkref *sinkref)
+{
+	list_add_tail(&sinkref->list, &pool->free);
+	pool->count++;
+}
+
+/*
+ *-----------------------------------------------------------
+ * pi_sinkref
+ *-----------------------------------------------------------
+ */
+
+static inline void
+_pi_sink_addref(struct pi_sinkref *sinkref)
+{
+	atomic_inc(&sinkref->snk->refs);
+	atomic_inc(&sinkref->refs);
+}
+
+static inline void
+_pi_sink_dropref_local(struct pi_node *node, struct pi_sinkref *sinkre=
f)
+{
+	if (atomic_dec_and_lock(&sinkref->refs, &node->lock)) {
+		list_del(&sinkref->list);
+		pi_sinkref_free(&node->sinkref_pool, sinkref);
+		spin_unlock(&node->lock);
+	}
+}
+
+static inline void
+_pi_sink_dropref_all(struct pi_node *node, struct pi_sinkref *sinkref)
+{
+	struct pi_sink *snk =3D sinkref->snk;
+
+	_pi_sink_dropref_local(node, sinkref);
+	pi_sink_dropref(snk, 0);
+}
+
+/*
+ *-----------------------------------------------------------
+ * pi_node
+ *-----------------------------------------------------------
+ */
+
+static struct pi_node *node_of(struct pi_sink *snk)
+{
+	return container_of(snk, struct pi_node, snk);
+}
+
+static inline void
+__pi_update_prio(struct pi_node *node)
+{
+	if (!plist_head_empty(&node->srcs))
+		node->prio =3D plist_first(&node->srcs)->prio;
+	else
+		node->prio =3D MAX_PRIO;
+}
+
+static inline void
+__pi_boost(struct pi_node *node, struct pi_source *src)
+{
+	BUG_ON(src->boosted);
+
+	plist_node_init(&src->list, *src->prio);
+	plist_add(&src->list, &node->srcs);
+	src->boosted =3D 1;
+
+	__pi_update_prio(node);
+}
+
+static inline void
+__pi_deboost(struct pi_node *node, struct pi_source *src)
+{
+	BUG_ON(!src->boosted);
+
+	plist_del(&src->list, &node->srcs);
+	src->boosted =3D 0;
+
+	__pi_update_prio(node);
+}
+
+/*
+ * _pi_node_update - update the chain
+ *
+ * We loop through up to MAX_PI_DEPENDENCIES times looking for stale e=
ntries
+ * that need to propagate up the chain.  This is a step-wise process w=
here we
+ * have to be careful about locking and preemption.  By trying MAX_PI_=
DEPs
+ * times, we guarantee that this update routine is an effective barrie=
r...
+ * all modifications made prior to the call to this barrier will have =
completed.
+ *
+ * Deadlock avoidance: This node may participate in a chain of nodes w=
hich
+ * form a graph of arbitrary structure.  While the graph should techni=
cally
+ * never close on itself barring any bugs, we still want to protect ag=
ainst
+ * a theoretical ABBA deadlock (if for nothing else, to prevent lockde=
p
+ * from detecting this potential).  To do this, we employ a dual-locki=
ng
+ * scheme where we can carefully control the order.  That is: node->lo=
ck
+ * protects most of the node's internal state, but it will never be he=
ld
+ * across a chain update.  sinkref->lock, on the other hand, can be he=
ld
+ * across a boost/deboost, and also guarantees proper execution order.=
 Also
+ * note that no locks are held across an snk->update.
+ */
+static int
+_pi_node_update(struct pi_sink *snk, unsigned int flags)
+{
+	struct pi_node    *node =3D node_of(snk);
+	struct pi_sinkref *sinkref;
+	unsigned long      iflags;
+	int                count =3D 0;
+	int                i;
+
+	struct updater {
+		int update;
+		struct pi_sinkref *sinkref;
+		struct pi_sink *snk;
+	} updaters[MAX_PI_DEPENDENCIES];
+
+	spin_lock_irqsave(&node->lock, iflags);
+
+	list_for_each_entry(sinkref, &node->snks, list) {
+		/*
+		 * If the priority is changing, or if this is a
+		 * BOOST/DEBOOST, we consider this sink "stale"
+		 */
+		if (sinkref->prio !=3D node->prio
+		    || sinkref->state !=3D pi_state_boosted) {
+			struct updater *iter =3D &updaters[count++];
+
+			BUG_ON(!atomic_read(&sinkref->snk->refs));
+			_pi_sink_addref(sinkref);
+			sinkref->prio =3D node->prio;
+
+			iter->update  =3D 1;
+			iter->sinkref =3D sinkref;
+			iter->snk     =3D sinkref->snk;
+		}
+	}
+
+	spin_unlock(&node->lock);
+
+	for (i =3D 0; i < count; ++i) {
+		struct updater    *iter =3D &updaters[i];
+		unsigned int       lflags =3D PI_FLAG_DEFER_UPDATE;
+		struct pi_sink    *snk;
+
+		sinkref =3D iter->sinkref;
+		snk =3D iter->snk;
+
+		spin_lock(&sinkref->lock);
+
+		switch (sinkref->state) {
+		case pi_state_boost:
+			sinkref->state =3D pi_state_boosted;
+			/* Fall through */
+		case pi_state_boosted:
+			snk->boost(snk, &sinkref->src, lflags);
+			break;
+		case pi_state_deboost:
+			snk->deboost(snk, &sinkref->src, lflags);
+			sinkref->state =3D pi_state_free;
+
+			/*
+			 * drop the ref that we took when the sinkref
+			 * was allocated.  We still hold a ref from
+			 * the above.
+			 */
+			_pi_sink_dropref_all(node, sinkref);
+			break;
+		case pi_state_free:
+			iter->update =3D 0;
+			break;
+		default:
+			panic("illegal sinkref type: %d", sinkref->state);
+		}
+
+		spin_unlock(&sinkref->lock);
+
+		/*
+		 * We will drop the sinkref reference while still holding the
+		 * preempt/irqs off so that the memory is returned synchronously
+		 * to the system.
+		 */
+		_pi_sink_dropref_local(node, sinkref);
+
+		/*
+		 * The sinkref is no longer valid since we dropped the reference
+		 * above, so symbolically drop it here too to make it more
+		 * obvious if we try to use it later
+		 */
+		iter->sinkref =3D NULL;
+	}
+
+	local_irq_restore(iflags);
+
+	/*
+	 * Note: At this point, sinkref is invalid since we dropref'd
+	 * it above, but snk is valid since we still hold the remote
+	 * reference.  This is key to the design because it allows us
+	 * to synchronously free the sinkref object, yet maintain a
+	 * reference to the sink across the update
+	 */
+	for (i =3D 0; i < count; ++i) {
+		struct updater *iter =3D &updaters[i];
+
+		if (iter->update)
+			iter->snk->update(iter->snk, 0);
+	}
+
+	/*
+	 * We perform all the free opertations together at the end, using
+	 * only automatic/stack variables since any one of these operations
+	 * could result in our node object being deallocated
+	 */
+	for (i =3D 0; i < count; ++i) {
+		struct updater *iter =3D &updaters[i];
+
+		pi_sink_dropref(iter->snk, 0);
+	}
+
+	return 0;
+}
+
+static void
+_pi_del_sinkref(struct pi_node *node, struct pi_sinkref *sinkref)
+{
+	struct pi_sink *snk =3D sinkref->snk;
+	int             remove =3D 0;
+	unsigned long   iflags;
+
+	local_irq_save(iflags);
+	spin_lock(&sinkref->lock);
+
+	switch (sinkref->state) {
+	case pi_state_boost:
+		/*
+		 * This state indicates the sink was never formally
+		 * boosted so we can just delete it immediately
+		 */
+		remove =3D 1;
+		break;
+	case pi_state_boosted:
+		if (snk->deboost)
+			/*
+			 * If the sink supports deboost notification,
+			 * schedule it for deboost at the next update
+			 */
+			sinkref->state =3D pi_state_deboost;
+		else
+			/*
+			 * ..otherwise schedule it for immediate
+			 * removal
+			 */
+			remove =3D 1;
+		break;
+	default:
+		break;
+	}
+
+	if (remove) {
+		/*
+		 * drop the ref that we took when the sinkref
+		 * was allocated.  We still hold a ref from
+		 * when the caller performed the lookup
+		 */
+		_pi_sink_dropref_all(node, sinkref);
+		sinkref->state =3D pi_state_free;
+	}
+
+	spin_unlock(&sinkref->lock);
+
+	_pi_sink_dropref_local(node, sinkref);
+	local_irq_restore(iflags);
+
+	pi_sink_dropref(snk, 0);
+}
+
+static int
+_pi_node_boost(struct pi_sink *snk, struct pi_source *src,
+	       unsigned int flags)
+{
+	struct pi_node *node =3D node_of(snk);
+	unsigned long   iflags;
+
+	spin_lock_irqsave(&node->lock, iflags);
+	if (src->boosted)
+		__pi_deboost(node, src);
+	__pi_boost(node, src);
+	spin_unlock_irqrestore(&node->lock, iflags);
+
+	if (!(flags & PI_FLAG_DEFER_UPDATE))
+		_pi_node_update(snk, 0);
+
+	return 0;
+}
+
+static int
+_pi_node_deboost(struct pi_sink *snk, struct pi_source *src,
+		 unsigned int flags)
+{
+	struct pi_node *node =3D node_of(snk);
+	unsigned long   iflags;
+
+	spin_lock_irqsave(&node->lock, iflags);
+	__pi_deboost(node, src);
+	spin_unlock_irqrestore(&node->lock, iflags);
+
+	if (!(flags & PI_FLAG_DEFER_UPDATE))
+		_pi_node_update(snk, 0);
+
+	return 0;
+}
+
+static int
+_pi_node_free(struct pi_sink *snk, unsigned int flags)
+{
+	struct pi_node    *node =3D node_of(snk);
+	struct pi_sinkref *sinkref;
+	struct pi_sinkref *sinkrefs[MAX_PI_DEPENDENCIES];
+	unsigned long      iflags;
+	int                count =3D 0;
+	int                i;
+
+	spin_lock_irqsave(&node->lock, iflags);
+
+	/*
+	 * When the node is freed, we should perform an implicit
+	 * del_sink on any remaining sinks we may have
+	 */
+	list_for_each_entry(sinkref, &node->snks, list) {
+		_pi_sink_addref(sinkref);
+		sinkrefs[count++] =3D sinkref;
+	}
+
+	spin_unlock_irqrestore(&node->lock, iflags);
+
+	for (i =3D 0; i < count; ++i)
+		_pi_del_sinkref(node, sinkrefs[i]);
+
+	if (!(flags & PI_FLAG_DEFER_UPDATE))
+		_pi_node_update(&node->snk, 0);
+
+	return 0;
+}
+
+static struct pi_sink pi_node_snk =3D {
+    .boost   =3D _pi_node_boost,
+    .deboost =3D _pi_node_deboost,
+    .update  =3D _pi_node_update,
+    .free    =3D _pi_node_free,
+};
+
+void pi_node_init(struct pi_node *node)
+{
+	spin_lock_init(&node->lock);
+	node->prio =3D MAX_PRIO;
+	node->snk =3D pi_node_snk;
+	pi_sinkref_pool_init(&node->sinkref_pool);
+	INIT_LIST_HEAD(&node->snks);
+	plist_head_init(&node->srcs, &node->lock);
+	atomic_set(&node->snk.refs, 1);
+}
+
+int pi_add_sink(struct pi_node *node, struct pi_sink *snk, unsigned in=
t flags)
+{
+	struct pi_sinkref *sinkref;
+	int                ret =3D 0;
+	unsigned long      iflags;
+
+	spin_lock_irqsave(&node->lock, iflags);
+
+	if (!atomic_read(&node->snk.refs)) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	sinkref =3D pi_sinkref_alloc(&node->sinkref_pool);
+	if (!sinkref) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	spin_lock_init(&sinkref->lock);
+	INIT_LIST_HEAD(&sinkref->list);
+
+	if (flags & PI_FLAG_ALREADY_BOOSTED)
+		sinkref->state =3D pi_state_boosted;
+	else
+		/*
+		 * Schedule it for addition at the next update
+		 */
+		sinkref->state =3D pi_state_boost;
+
+	sinkref->prio =3D node->prio;
+	pi_source_init(&sinkref->src, &sinkref->prio);
+	sinkref->snk =3D snk;
+
+	/* set one ref from ourselves.  It will be dropped on del_sink */
+	atomic_inc(&sinkref->snk->refs);
+	atomic_set(&sinkref->refs, 1);
+
+	list_add_tail(&sinkref->list, &node->snks);
+
+	spin_unlock_irqrestore(&node->lock, iflags);
+
+	if (!(flags & PI_FLAG_DEFER_UPDATE))
+		_pi_node_update(&node->snk, 0);
+
+	return 0;
+
+ out:
+	spin_unlock_irqrestore(&node->lock, iflags);
+
+	return ret;
+}
+
+int pi_del_sink(struct pi_node *node, struct pi_sink *snk, unsigned in=
t flags)
+{
+	struct pi_sinkref *sinkref;
+	struct pi_sinkref *sinkrefs[MAX_PI_DEPENDENCIES];
+	unsigned long      iflags;
+	int                count =3D 0;
+	int                i;
+
+	spin_lock_irqsave(&node->lock, iflags);
+
+	/*
+	 * There may be multiple matches to snk because sometimes a
+	 * deboost/free may still be pending an update when the same
+	 * node has been added.  So we want to process all instances
+	 */
+	list_for_each_entry(sinkref, &node->snks, list) {
+		if (sinkref->snk =3D=3D snk) {
+			_pi_sink_addref(sinkref);
+			sinkrefs[count++] =3D sinkref;
+		}
+	}
+
+	spin_unlock_irqrestore(&node->lock, iflags);
+
+	for (i =3D 0; i < count; ++i)
+		_pi_del_sinkref(node, sinkrefs[i]);
+
+	if (!(flags & PI_FLAG_DEFER_UPDATE))
+		_pi_node_update(&node->snk, 0);
+
+	return 0;
+}
+
+
+

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
