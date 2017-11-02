From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Thu, 2 Nov 2017 15:55:46 -0500
Message-ID: <7665923c-1c6f-eaa1-5069-9eedc81a93fa@ti.com>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: <linux-rt-users@vger.kernel.org>, <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Pavel V. Panteleev" <panteleevp@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:57366 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934407AbdKBU4d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Nov 2017 16:56:33 -0400
In-Reply-To: <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 11/02/2017 11:50 AM, Sebastian Andrzej Siewior wrote:
> On 2017-11-01 12:41:33 [+0300], Pavel V. Panteleev wrote:
>> Hello! I have a problem on kernel 3.14.79-rt85 and I don't know, if it's
>> solved on current kernel or, may be, it's our additions problem. Could you
>> help me, please?
> 
> will do my best.
> 
>> Kernel is broken in migrate_enable():
>>          WARN_ON_ONCE(p->migrate_disable <= 0);
>>
>> I have a trace, where I see, that it happened, because few
>> migrate_disable() were called under irqs_disabled (migrate_disable counter
>> wasn't changed). But after schedule() call irqs were enabled and the
>> following migrate_disable() and migrate_enable() changed migrate_disable
>> counter. I suppose, that problem is schedule() call under irqs_disabled.
> 
> that is basically what happens if the counter goes negative.
> 
> …
>> As I see, in allocate_slab() kernel could be under irqs_disabled. And irqs
>> would be enabled in case of SYSTEM_RUNNING (why only in case of
>> SYSTEM_RUNNING?). But in our case system isn't running yet (it's always
>> before /sbin/init), so irqs wouldn't be enabled:
> 
> ideally the interrupts would be always enabled because they have to on
> -RT but we can't do so early in the boot process.
> 
>>          enableirqs = (flags & __GFP_WAIT) != 0;
>>          #ifdef CONFIG_PREEMPT_RT_FULL
>>          enableirqs |= system_state == SYSTEM_RUNNING;
>>          #endif
>>          if (enableirqs)
>>                  local_irq_enable();
> …
>> P. S.
>> Today I reproduced this on 4.9.47-rt37. Try to reproduce on x86.
> 
> In newer -RT we have
> 	if (system_state > SYSTEM_BOOTING)
> instead but this won't work even in v4.9 because it does not have
> SYSTEM_SCHEDULING yet. So v4.11/v4.13 should not be affected.
> 
> If that is true, then something like
> 
> diff --git a/init/main.c b/init/main.c
> index 6470deef01c9..362761effeac 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -379,6 +379,7 @@ static void __init setup_command_line(char *command_line)
>    */
>   
>   static __initdata DECLARE_COMPLETION(kthreadd_done);
> +extern bool slab_do_irq_on;
>   
>   static noinline void __ref rest_init(void)
>   {
> @@ -396,6 +397,7 @@ static noinline void __ref rest_init(void)
>   	rcu_read_lock();
>   	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
>   	rcu_read_unlock();
> +	slab_do_irq_on = true;
>   	complete(&kthreadd_done);
>   
>   	/*
> diff --git a/mm/slub.c b/mm/slub.c
> index 67eb368b9314..22ec805130e5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1527,6 +1527,7 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct page *page)
>   	return false;
>   }
>   #endif /* CONFIG_SLAB_FREELIST_RANDOM */
> +bool slab_do_irq_on;
>   
>   static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>   {
> @@ -1543,7 +1544,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>   	if (gfpflags_allow_blocking(flags))
>   		enableirqs = true;
>   #ifdef CONFIG_PREEMPT_RT_FULL
> -	if (system_state == SYSTEM_RUNNING)
> +	if (slab_do_irq_on)
>   		enableirqs = true;
>   #endif
>   	if (enableirqs)
> 
> might just work. Can you test this please?

I've used to see the same and created patch for 4.9 (should work for 4.1)
which does mostly the same things, but it also enables __might_sleep() during boot.
Of course, it's possible that I've selected wrong place to set SYSTEM_BOOTING_LATE
and it's more correct to do it in rest_init().

NOTE: As Sebastian mentioned below patch is not relevant for newer Kernel versions.


>From a9600a6a18ffe285bccd299985ad57450e4aa1b4 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 9 Oct 2015 08:52:16 -0500
Subject: [DEBUG PATCH] core: introduce SYSTEM_BOOTING_LATE state

This patch introduces new SYSTEM_BOOTING_LATE system state
which will be set right after scheduler is fully operational
during the boot.

And reuse this state in update ___might_sleep() to allow catching
"BUG: sleeping function called from invalid context" early during
the boot which is very helping for debugging.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 include/linux/kernel.h | 1 +
 init/main.c            | 1 +
 kernel/sched/core.c    | 4 +++-
 mm/slub.c              | 3 +--
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 7894d55..5dfed24 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -488,6 +488,7 @@ extern bool early_boot_irqs_disabled;
 /* Values used for system_state */
 extern enum system_states {
 	SYSTEM_BOOTING,
+	SYSTEM_BOOTING_LATE,
 	SYSTEM_RUNNING,
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
diff --git a/init/main.c b/init/main.c
index a4a61e7..e5e5906 100644
--- a/init/main.c
+++ b/init/main.c
@@ -989,6 +989,7 @@ static noinline void __init kernel_init_freeable(void)
 
 	/* Now the scheduler is fully set up and can do blocking allocations */
 	gfp_allowed_mask = __GFP_BITS_MASK;
+	system_state = SYSTEM_BOOTING_LATE;
 
 	/*
 	 * init can allocate pages on any node
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 127aaf4..04c1805 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7977,7 +7977,9 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 	rcu_sleep_check(); /* WARN_ON_ONCE() by default, no rate limit reqd. */
 	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
 	     !is_idle_task(current)) ||
-		 (system_state != SYSTEM_RUNNING && system_state != SYSTEM_SUSPEND) || oops_in_progress)
+		 (system_state != SYSTEM_RUNNING &&
+		  system_state != SYSTEM_SUSPEND &&
+		  system_state != SYSTEM_BOOTING_LATE) || oops_in_progress)
 		return;
 	if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 		return;
diff --git a/mm/slub.c b/mm/slub.c
index 6d72b7f..993c89b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1540,8 +1540,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (gfpflags_allow_blocking(flags))
 		enableirqs = true;
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (system_state == SYSTEM_RUNNING)
-		enableirqs = true;
+	enableirqs = system_state == SYSTEM_RUNNING || system_state == SYSTEM_BOOTING_LATE;
 #endif
 	if (enableirqs)
 		local_irq_enable();
-- 
2.10.5



-- 
regards,
-grygorii
