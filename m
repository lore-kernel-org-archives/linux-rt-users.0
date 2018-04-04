From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 3/7] mm/slub: close possible memory-leak in kmem_cache_alloc_bulk()
Date: Wed,  4 Apr 2018 09:16:48 +0200
Message-ID: <20180404071652.24196-4-wagi@monom.org>
References: <20180404071652.24196-1-wagi@monom.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404071652.24196-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Under certain circumstances we could leak elements which were moved to
the local "to_free" list. The damage is limited since I can't find
any users here.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index b183c5271607..b3626ab324fe 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3026,6 +3026,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	return i;
 error:
 	local_irq_enable();
+	free_delayed(&to_free);
 	slab_post_alloc_hook(s, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
-- 
2.14.3
