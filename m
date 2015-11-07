From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] v4.1.12-rt13
Date: Sat, 7 Nov 2015 19:29:31 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511071928341.4032@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35793 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbbKGSaQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Nov 2015 13:30:16 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.1.12-rt13 patch set. v4.1.12-rt12 is a
non-announced update to incorporate the linux-4.1.y stable tree.

Changes since v4.1.10-rt11:

  Yang Shi (1):
      bpf: Convert hashtab lock to raw lock

  Thomas Gleixner(2)
      rtmutex: Handle non enqueued waiters gracefully
      v4.1.12-rt13

Known issues:

  - bcache stays disabled

  - CPU hotplug is not better than before

  - The netlink_release() OOPS, reported by Clark, is still on the
    list, but unsolved due to lack of information

The delta patch against 4.1.12-rt12 is appended below and can be found here:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.12-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.1.12-rt13

The RT patch against 4.1.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.12-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/patches-4.1.12-rt13.tar.xz

Enjoy!

	tglx

--------------->

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 83c209d9b17a..972b76bf54b7 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -17,7 +17,7 @@
 struct bpf_htab {
 	struct bpf_map map;
 	struct hlist_head *buckets;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	u32 count;	/* number of elements in this hashtable */
 	u32 n_buckets;	/* number of hash buckets */
 	u32 elem_size;	/* size of each element in bytes */
@@ -82,7 +82,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	for (i = 0; i < htab->n_buckets; i++)
 		INIT_HLIST_HEAD(&htab->buckets[i]);
 
-	spin_lock_init(&htab->lock);
+	raw_spin_lock_init(&htab->lock);
 	htab->count = 0;
 
 	htab->elem_size = sizeof(struct htab_elem) +
@@ -230,7 +230,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	l_new->hash = htab_map_hash(l_new->key, key_size);
 
 	/* bpf_map_update_elem() can be called in_irq() */
-	spin_lock_irqsave(&htab->lock, flags);
+	raw_spin_lock_irqsave(&htab->lock, flags);
 
 	head = select_bucket(htab, l_new->hash);
 
@@ -266,11 +266,11 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	} else {
 		htab->count++;
 	}
-	spin_unlock_irqrestore(&htab->lock, flags);
+	raw_spin_unlock_irqrestore(&htab->lock, flags);
 
 	return 0;
 err:
-	spin_unlock_irqrestore(&htab->lock, flags);
+	raw_spin_unlock_irqrestore(&htab->lock, flags);
 	kfree(l_new);
 	return ret;
 }
@@ -291,7 +291,7 @@ static int htab_map_delete_elem(struct bpf_map *map, void *key)
 
 	hash = htab_map_hash(key, key_size);
 
-	spin_lock_irqsave(&htab->lock, flags);
+	raw_spin_lock_irqsave(&htab->lock, flags);
 
 	head = select_bucket(htab, hash);
 
@@ -304,7 +304,7 @@ static int htab_map_delete_elem(struct bpf_map *map, void *key)
 		ret = 0;
 	}
 
-	spin_unlock_irqrestore(&htab->lock, flags);
+	raw_spin_unlock_irqrestore(&htab->lock, flags);
 	return ret;
 }
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2822aceb8dfb..20267595df07 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2141,7 +2141,7 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
-	if (unlikely(ret))
+	if (ret && rt_mutex_has_waiters(lock))
 		remove_waiter(lock, waiter);
 
 	raw_spin_unlock(&lock->wait_lock);
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927..9f7d0bdbffb1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13

