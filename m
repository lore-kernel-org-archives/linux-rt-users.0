From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/6] Revert "slub: delay ctor until the object is requested"
Date: Thu, 06 Aug 2015 18:17:37 -0400
Message-ID: <20150806221814.310379886@goodmis.org>
References: <20150806221736.555188732@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-Revert-slub-delay-ctor-until-the-object-is-requested.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.48-rt49-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This approach is broken with SLAB_DESTROY_BY_RCU allocations.
Reported by Steven Rostedt and Koehrer Mathias.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 mm/slub.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 93eeaca6cb53..5b0e9ee52f79 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1403,10 +1403,8 @@ static void setup_object(struct kmem_cache *s, struct page *page,
 				void *object)
 {
 	setup_object_debug(s, page, object);
-#ifndef CONFIG_PREEMPT_RT_FULL
 	if (unlikely(s->ctor))
 		s->ctor(object);
-#endif
 }
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
@@ -2519,10 +2517,6 @@ redo:
 
 	if (unlikely(gfpflags & __GFP_ZERO) && object)
 		memset(object, 0, s->object_size);
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (unlikely(s->ctor) && object)
-		s->ctor(object);
-#endif
 
 	slab_post_alloc_hook(s, gfpflags, object);
 
-- 
2.1.4
