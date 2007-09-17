From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Mon, 17 Sep 2007 11:28:32 -0700
Message-ID: <1190053712.3253.79.camel@imap.mvista.com>
References: <200709172012.21102.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:23135 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252AbXIQSaq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 14:30:46 -0400
In-Reply-To: <200709172012.21102.ak@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-09-17 at 20:12 +0200, Andi Kleen wrote:
> When the kernel is oopsing no realtime guarantees are needed anymore and sleeping
> here is unsafe; e.g. in case the crash site had interrupts disabled.
> 
> - Convert die_lock to a raw spinlock
> - Really disable interrupts
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux-2.6.23-rc4-rt1/arch/x86_64/kernel/traps.c
> ===================================================================
> --- linux-2.6.23-rc4-rt1.orig/arch/x86_64/kernel/traps.c
> +++ linux-2.6.23-rc4-rt1/arch/x86_64/kernel/traps.c
> @@ -467,7 +467,7 @@ void out_of_line_bug(void)
>  EXPORT_SYMBOL(out_of_line_bug);
>  #endif
>  
> -static DEFINE_SPINLOCK(die_lock);
> +static __raw_spinlock_t die_lock = __RAW_SPIN_LOCK_UNLOCKED;

You mean DEFINE_RAW_SPINLOCK() maybe? Unless I'm not following what your
doing here..

>  static int die_owner = -1;
>  static unsigned int die_nest_count;
>  
> @@ -479,13 +479,13 @@ unsigned __kprobes long oops_begin(void)
>  	oops_enter();
>  
>  	/* racy, but better than risking deadlock. */
> -	local_irq_save(flags);
> +	raw_local_irq_save(flags);

local_irq_save() should disable interrupts .. The difference between the
two is one does interrupt off trace accounting 

>  	cpu = smp_processor_id();
> -	if (!spin_trylock(&die_lock)) { 
> +	if (!__raw_spin_trylock(&die_lock)) {

If you use DEFINE_RAW_SPINLOCK() above you shouldn't need to mod these
individually .. A call to spin_trylock() will automatically change
depending on the lock type.

Daniel
