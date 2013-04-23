From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING +
 CONFIG_DEBUG_FORCE_WEAK_PER_CPU = boot time swap_lock deadlock
Date: Mon, 22 Apr 2013 22:44:56 -0400
Message-ID: <1366685096.9609.145.camel@gandalf.local.home>
References: <1365937652.4717.25.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:17566 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab3DWCo7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Apr 2013 22:44:59 -0400
In-Reply-To: <1365937652.4717.25.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2013-04-14 at 13:07 +0200, Mike Galbraith wrote:
> Greetings,
> 
> Turn off CONFIG_DEBUG_FORCE_WEAK_PER_CPU, all is well, with it enabled,
> I get a boot time deadlock on swap_lock when the box tries to load
> initramfs, seemingly because with CONFIG_DEBUG_FORCE_WEAK_PER_CPU,
> percpu locallocks are not zeroed, so only initializing the spinlock
> isn't enough.  With lockdep enabled, I see warning on owner and nestcnt,
> followed by init being permanently stuck.
> 
> Do the below, it'll boot and run, but lockdep will eventually gripe
> about MAX_LOCKDEP_ENTRIES, MAX_STACK_TRACE_ENTRIES, or adding a
> non-static key, and box explodes violently shortly thereafter on
> softlock or memory corruption.. so below wasn't exactly a great idea :)
> 
> 3.4-rt boots and runs just fine with the same config.  Turn off
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU, and these kernels boot and run fine
> with lockdep, though I do still need to double entries/bits for it to
> not shut itself off.  Anyway, seems CONFIG_DEBUG_FORCE_WEAK_PER_CPU
> became a very bad idea.  Probably always was, no idea how that ended up
> in my config.
> 

When I built with CONFIG_DEBUG_FORCE_WEAK_PER_CPU it had issues with the
swap lock. Can you try this patch? What you showed looks different, but
did that happen with the updates you made?

-- Steve

diff --git a/mm/swap.c b/mm/swap.c
index 63f42b8..fab8f97 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -42,7 +42,7 @@ static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
 static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
 
 static DEFINE_LOCAL_IRQ_LOCK(rotate_lock);
-static DEFINE_LOCAL_IRQ_LOCK(swap_lock);
+static DEFINE_LOCAL_IRQ_LOCK(swapvar_lock);
 
 /*
  * This path almost never happens for VM activity - pages are normally
@@ -407,13 +407,13 @@ static void activate_page_drain(int cpu)
 void activate_page(struct page *page)
 {
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec = &get_locked_var(swap_lock,
+		struct pagevec *pvec = &get_locked_var(swapvar_lock,
 						       activate_page_pvecs);
 
 		page_cache_get(page);
 		if (!pagevec_add(pvec, page))
 			pagevec_lru_move_fn(pvec, __activate_page, NULL);
-		put_locked_var(swap_lock, activate_page_pvecs);
+		put_locked_var(swapvar_lock, activate_page_pvecs);
 	}
 }
 
@@ -461,13 +461,13 @@ EXPORT_SYMBOL(mark_page_accessed);
  */
 void __lru_cache_add(struct page *page, enum lru_list lru)
 {
-	struct pagevec *pvec = &get_locked_var(swap_lock, lru_add_pvecs)[lru];
+	struct pagevec *pvec = &get_locked_var(swapvar_lock, lru_add_pvecs)[lru];
 
 	page_cache_get(page);
 	if (!pagevec_space(pvec))
 		__pagevec_lru_add(pvec, lru);
 	pagevec_add(pvec, page);
-	put_locked_var(swap_lock, lru_add_pvecs);
+	put_locked_var(swapvar_lock, lru_add_pvecs);
 }
 EXPORT_SYMBOL(__lru_cache_add);
 
@@ -632,19 +632,19 @@ void deactivate_page(struct page *page)
 		return;
 
 	if (likely(get_page_unless_zero(page))) {
-		struct pagevec *pvec = &get_locked_var(swap_lock,
+		struct pagevec *pvec = &get_locked_var(swapvar_lock,
 						       lru_deactivate_pvecs);
 
 		if (!pagevec_add(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
-		put_locked_var(swap_lock, lru_deactivate_pvecs);
+		put_locked_var(swapvar_lock, lru_deactivate_pvecs);
 	}
 }
 
 void lru_add_drain(void)
 {
-	lru_add_drain_cpu(local_lock_cpu(swap_lock));
-	local_unlock_cpu(swap_lock);
+	lru_add_drain_cpu(local_lock_cpu(swapvar_lock));
+	local_unlock_cpu(swapvar_lock);
 }
 
 static void lru_add_drain_per_cpu(struct work_struct *dummy)


