Return-Path: <SRS0=uopo=Z2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B17C43603
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Dec 2019 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604692073C
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Dec 2019 11:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfLDLzD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:55:03 -0500
Received: from mail.manjaro.org ([176.9.38.148]:38224 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfLDLzD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Dec 2019 06:55:03 -0500
X-Greylist: delayed 1042 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Dec 2019 06:55:02 EST
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id D5EF37E0BBC;
        Wed,  4 Dec 2019 12:37:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ftLbewQiqTYd; Wed,  4 Dec 2019 12:37:35 +0100 (CET)
Subject: Re: [ANNOUNCE] v5.2.21-rt14
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20191204095144.kvpbinxqptdszvqq@linutronix.de>
From:   Bernhard Landauer <bernhard@manjaro.org>
Message-ID: <902943c5-9fee-ef45-2b5d-8baa6fa00685@manjaro.org>
Date:   Wed, 4 Dec 2019 12:37:34 +0100
MIME-Version: 1.0
In-Reply-To: <20191204095144.kvpbinxqptdszvqq@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sorry if maybe I have missed any announcements here, but my I ask if you
are planning on releasing patches for kernels >5,2 in the near future?
Or is this project being faded out altogether?

kind regards
Bernhard

On 04.12.19 10:51, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v5.2.21-rt14 patch set. 
>
> Changes since v5.2.21-rt13:
>
>   - printk. The "emergency loglevel" was used to determine which
>     messages are printed directly on the console (if atomic write is
>     available (8250 only right now)). By default messages with the log
>     level KERN_WARNING (and less) were printed directly.
>     As part of the current printk rework it has been decided that only
>     messages which lead to system failure like BUG(), panic() should use
>     the direct interface. Patch by John Ogness.
>
>   - Cherry pick a X86-FPU patch from upstream to avoid a miss
>     compilation with gcc-9.
>
>   - Make the spin_lock() section also part of a rcu read section on RT.
>
>   - PowerPC on 32bit did not compile due to a missing function since the
>     softirq rework. It also did not boot due to a bug in the
>     lazy-preempt code. It compiles and it has been verified in qemu on a
>     book-E target (due to lack of real hardware) that it boots again.
>
>   - RT did not compile if CONFIG_HOTPLUG_CPU was not defined. Reported
>     by Dick Hollenbeck.
>
> Known issues
>      - None
>
> The delta patch against v5.2.21-rt13 is appended below and can be found here:
>  
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/incr/patch-5.2.21-rt13-rt14.patch.xz
>
> You can get this release via the git tree at:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.2.21-rt14
>
> The RT patch against v5.2.21 can be found here:
>
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2.21-rt14.patch.xz
>
> The split quilt queue is available at:
>
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patches-5.2.21-rt14.tar.xz
>
> Sebastian
>
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index d37b373104502..004944258387b 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -893,10 +893,10 @@ user_exc_return:		/* r10 contains MSR_KERNEL here */
>  	bne	restore_kuap
>  	andi.	r8,r8,_TIF_NEED_RESCHED
>  	bne+	1f
> -	lwz	r0,TI_PREEMPT_LAZY(r9)
> +	lwz	r0,TI_PREEMPT_LAZY(r2)
>  	cmpwi	0,r0,0          /* if non-zero, just restore regs and return */
>  	bne	restore_kuap
> -	lwz	r0,TI_FLAGS(r9)
> +	lwz	r0,TI_FLAGS(r2)
>  	andi.	r0,r0,_TIF_NEED_RESCHED_LAZY
>  	beq+	restore_kuap
>  1:
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 4c95c365058aa..44c48e34d7994 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -509,7 +509,7 @@ static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
>  
>  static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
>  {
> -	return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
> +	return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
>  }
>  
>  /*
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index d559e3a0379c2..7653dd58b4b21 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -100,9 +100,9 @@
>  				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
>  #ifdef CONFIG_PREEMPT_RT_FULL
>  
> -#define softirq_count()		((long)get_current()->softirq_count)
> +#define softirq_count()		(current->softirq_count)
>  #define in_softirq()		(softirq_count())
> -#define in_serving_softirq()	(get_current()->softirq_count & SOFTIRQ_OFFSET)
> +#define in_serving_softirq()	(current->softirq_count & SOFTIRQ_OFFSET)
>  
>  #else
>  
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index e1bf3c698a321..5bfd13a5cc49d 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -877,7 +877,9 @@ static int take_cpu_down(void *_param)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT_BASE
>  struct task_struct *takedown_cpu_task;
> +#endif
>  
>  static int takedown_cpu(unsigned int cpu)
>  {
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index bb5c09c49c504..ba4b151bf4517 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1143,6 +1143,7 @@ void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
>  void __lockfunc rt_spin_lock(spinlock_t *lock)
>  {
>  	sleeping_lock_inc();
> +	rcu_read_lock();
>  	migrate_disable();
>  	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
>  	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
> @@ -1158,6 +1159,7 @@ void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
>  void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
>  {
>  	sleeping_lock_inc();
> +	rcu_read_lock();
>  	migrate_disable();
>  	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
>  	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
> @@ -1171,6 +1173,7 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
>  	spin_release(&lock->dep_map, 1, _RET_IP_);
>  	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
>  	migrate_enable();
> +	rcu_read_unlock();
>  	sleeping_lock_dec();
>  }
>  EXPORT_SYMBOL(rt_spin_unlock);
> @@ -1202,6 +1205,7 @@ int __lockfunc rt_spin_trylock(spinlock_t *lock)
>  	ret = __rt_mutex_trylock(&lock->lock);
>  	if (ret) {
>  		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
> +		rcu_read_lock();
>  	} else {
>  		migrate_enable();
>  		sleeping_lock_dec();
> @@ -1218,6 +1222,7 @@ int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
>  	ret = __rt_mutex_trylock(&lock->lock);
>  	if (ret) {
>  		sleeping_lock_inc();
> +		rcu_read_lock();
>  		migrate_disable();
>  		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>  	} else
> @@ -1234,6 +1239,7 @@ int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
>  	ret = __rt_mutex_trylock(&lock->lock);
>  	if (ret) {
>  		sleeping_lock_inc();
> +		rcu_read_lock();
>  		migrate_disable();
>  		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>  	}
> diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
> index c3b91205161cc..0ae8c62ea8320 100644
> --- a/kernel/locking/rwlock-rt.c
> +++ b/kernel/locking/rwlock-rt.c
> @@ -310,6 +310,7 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
>  	ret = do_read_rt_trylock(rwlock);
>  	if (ret) {
>  		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
> +		rcu_read_lock();
>  	} else {
>  		migrate_enable();
>  		sleeping_lock_dec();
> @@ -327,6 +328,7 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
>  	ret = do_write_rt_trylock(rwlock);
>  	if (ret) {
>  		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
> +		rcu_read_lock();
>  	} else {
>  		migrate_enable();
>  		sleeping_lock_dec();
> @@ -338,6 +340,7 @@ EXPORT_SYMBOL(rt_write_trylock);
>  void __lockfunc rt_read_lock(rwlock_t *rwlock)
>  {
>  	sleeping_lock_inc();
> +	rcu_read_lock();
>  	migrate_disable();
>  	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
>  	do_read_rt_lock(rwlock);
> @@ -347,6 +350,7 @@ EXPORT_SYMBOL(rt_read_lock);
>  void __lockfunc rt_write_lock(rwlock_t *rwlock)
>  {
>  	sleeping_lock_inc();
> +	rcu_read_lock();
>  	migrate_disable();
>  	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
>  	do_write_rt_lock(rwlock);
> @@ -358,6 +362,7 @@ void __lockfunc rt_read_unlock(rwlock_t *rwlock)
>  	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
>  	do_read_rt_unlock(rwlock);
>  	migrate_enable();
> +	rcu_read_unlock();
>  	sleeping_lock_dec();
>  }
>  EXPORT_SYMBOL(rt_read_unlock);
> @@ -367,6 +372,7 @@ void __lockfunc rt_write_unlock(rwlock_t *rwlock)
>  	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
>  	do_write_rt_unlock(rwlock);
>  	migrate_enable();
> +	rcu_read_unlock();
>  	sleeping_lock_dec();
>  }
>  EXPORT_SYMBOL(rt_write_unlock);
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9d9523431178b..2b4616fd4fd4b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1767,15 +1767,8 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
>  			con->wrote_history = 1;
>  			con->printk_seq = seq - 1;
>  		}
> -		if (con->write_atomic && level < emergency_console_loglevel &&
> -		    facility == 0) {
> -			/* skip emergency messages, already printed */
> -			if (con->printk_seq < seq)
> -				con->printk_seq = seq;
> -			continue;
> -		}
>  		if (con->flags & CON_BOOT && facility == 0) {
> -			/* skip emergency messages, already printed */
> +			/* skip boot messages, already printed */
>  			if (con->printk_seq < seq)
>  				con->printk_seq = seq;
>  			continue;
> @@ -3161,7 +3154,7 @@ static bool console_can_emergency(int level)
>  	for_each_console(con) {
>  		if (!(con->flags & CON_ENABLED))
>  			continue;
> -		if (con->write_atomic && level < emergency_console_loglevel)
> +		if (con->write_atomic && oops_in_progress)
>  			return true;
>  		if (con->write && (con->flags & CON_BOOT))
>  			return true;
> @@ -3177,7 +3170,7 @@ static void call_emergency_console_drivers(int level, const char *text,
>  	for_each_console(con) {
>  		if (!(con->flags & CON_ENABLED))
>  			continue;
> -		if (con->write_atomic && level < emergency_console_loglevel) {
> +		if (con->write_atomic && oops_in_progress) {
>  			con->write_atomic(con, text, text_len);
>  			continue;
>  		}
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6383ade320f23..ef9621815f37e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7384,9 +7384,11 @@ void migrate_enable(void)
>  
>  	p->migrate_disable = 0;
>  	rq->nr_pinned--;
> +#ifdef CONFIG_HOTPLUG_CPU
>  	if (rq->nr_pinned == 0 && unlikely(!cpu_active(cpu)) &&
>  	    takedown_cpu_task)
>  		wake_up_process(takedown_cpu_task);
> +#endif
>  
>  	if (!p->migrate_disable_scheduled)
>  		goto out;
> diff --git a/localversion-rt b/localversion-rt
> index 9f7d0bdbffb18..08b3e75841adc 100644
> --- a/localversion-rt
> +++ b/localversion-rt
> @@ -1 +1 @@
> --rt13
> +-rt14
