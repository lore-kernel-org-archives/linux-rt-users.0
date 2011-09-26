From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: rt14 early console
Date: Mon, 26 Sep 2011 16:17:07 -0700
Message-ID: <4E8107F3.8030704@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4849 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab1IZXRJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Sep 2011 19:17:09 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Trying to debug why the printks from the early console are not seen early.

Inspecting console_trylock_for_printk it looks like during early boot 
the lock variable will be 0 due to early_boot_irqs_disabled being true.
* Looks like even the irqs_disabled_flags(flags) will be true.
* If lock is 0 then the this method returns 0  which I believe is bad. 
So how are the printks expected to be printed early?

static int console_trylock_for_printk(unsigned int cpu, unsigned long flags)
     __releases(&logbuf_lock)
{
#ifdef CONFIG_PREEMPT_RT_FULL
     int lock = !early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
         !preempt_count();
#else
.....
     if (lock && console_trylock()) {
         retval = 1;
}

I believe console_trylock_for_printk returning 0 is bad as it looks like 
the call to console_unlock() results in the
printk buffer being sent to the console . But console_unlock() will not 
be invoked in vprintk if console_trylock_for_printk
returns 0.

asmlinkage int vprintk(const char *fmt, va_list args)
{
......
......
......

     if (console_trylock_for_printk(this_cpu, flags)) {
#ifndef CONFIG_PREEMPT_RT_FULL
         console_unlock();
#else
         raw_local_irq_restore(flags);
         console_unlock();
         raw_local_irq_save(flags);
#endif
     }
.....
}

Thanks,
Venkat
