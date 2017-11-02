From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Thu, 2 Nov 2017 17:50:10 +0100
Message-ID: <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: "Pavel V. Panteleev" <panteleevp@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55396 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933371AbdKBQuL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Nov 2017 12:50:11 -0400
Content-Disposition: inline
In-Reply-To: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-11-01 12:41:33 [+0300], Pavel V. Panteleev wrote:
> Hello! I have a problem on kernel 3.14.79-rt85 and I don't know, if it's
> solved on current kernel or, may be, it's our additions problem. Could you
> help me, please?

will do my best.

> Kernel is broken in migrate_enable():
>         WARN_ON_ONCE(p->migrate_disable <= 0);
> 
> I have a trace, where I see, that it happened, because few
> migrate_disable() were called under irqs_disabled (migrate_disable counter
> wasn't changed). But after schedule() call irqs were enabled and the
> following migrate_disable() and migrate_enable() changed migrate_disable
> counter. I suppose, that problem is schedule() call under irqs_disabled.

that is basically what happens if the counter goes negative.

…
> As I see, in allocate_slab() kernel could be under irqs_disabled. And irqs
> would be enabled in case of SYSTEM_RUNNING (why only in case of
> SYSTEM_RUNNING?). But in our case system isn't running yet (it's always
> before /sbin/init), so irqs wouldn't be enabled:

ideally the interrupts would be always enabled because they have to on
-RT but we can't do so early in the boot process.

>         enableirqs = (flags & __GFP_WAIT) != 0;
>         #ifdef CONFIG_PREEMPT_RT_FULL
>         enableirqs |= system_state == SYSTEM_RUNNING;
>         #endif
>         if (enableirqs)
>                 local_irq_enable();
…
> P. S.
> Today I reproduced this on 4.9.47-rt37. Try to reproduce on x86.

In newer -RT we have
	if (system_state > SYSTEM_BOOTING)
instead but this won't work even in v4.9 because it does not have
SYSTEM_SCHEDULING yet. So v4.11/v4.13 should not be affected.

If that is true, then something like

diff --git a/init/main.c b/init/main.c
index 6470deef01c9..362761effeac 100644
--- a/init/main.c
+++ b/init/main.c
@@ -379,6 +379,7 @@ static void __init setup_command_line(char *command_line)
  */
 
 static __initdata DECLARE_COMPLETION(kthreadd_done);
+extern bool slab_do_irq_on;
 
 static noinline void __ref rest_init(void)
 {
@@ -396,6 +397,7 @@ static noinline void __ref rest_init(void)
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
+	slab_do_irq_on = true;
 	complete(&kthreadd_done);
 
 	/*
diff --git a/mm/slub.c b/mm/slub.c
index 67eb368b9314..22ec805130e5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1527,6 +1527,7 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct page *page)
 	return false;
 }
 #endif /* CONFIG_SLAB_FREELIST_RANDOM */
+bool slab_do_irq_on;
 
 static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
@@ -1543,7 +1544,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (gfpflags_allow_blocking(flags))
 		enableirqs = true;
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (system_state == SYSTEM_RUNNING)
+	if (slab_do_irq_on)
 		enableirqs = true;
 #endif
 	if (enableirqs)

might just work. Can you test this please?

Sebastian
