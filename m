From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 3.2.57-rt: rcu_preempt detected stalls at boot
Date: Wed, 14 May 2014 12:21:56 -0400
Message-ID: <53739824.2080007@windriver.com>
References: <20140513074539.GJ12328@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <746232@bugs.debian.org>
To: "Alexandra N. Kossovsky" <Alexandra.Kossovsky@oktetlabs.ru>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36293 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaENQVd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 May 2014 12:21:33 -0400
In-Reply-To: <20140513074539.GJ12328@oktetlabs.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 14-05-13 03:45 AM, Alexandra N. Kossovsky wrote:
> Hello.
> 
> One of my computers fails to boot with 3.2.57-rt kernel, i686.
> The kernel is the Debian one: linux-image-3.2.0-4-rt-686-pae, version
> 3.2.57-3.  Same non-rt kernel boots fine.  All newer -rt kernels (I've
> tried kernels starting from 3.6) boot fine.
> You can find some details of the hardware in
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=746232,
> including lspci output and full kernel output.

One of the more recent additions was to ensure RCU_BOOST was
auto selected via Kconfig dependencies.  It might not have
been present in 3.2.57-rt; not sure w/o checking what debian
has in there.  But you might want to check the .config you
have to see whether it is on or off, and try enabling it.

Paul.
--

> 
> Here is the end of the serial log from the failed boot:
> [    2.868692] ERST: Failed to get Error Log Address Range.
> [    3.705427] Refined TSC clocksource calibration: 3599.999 MHz.
> [    3.711340] Switching to clocksource tsc
> [   62.804918] INFO: rcu_preempt detected stalls on CPUs/tasks: {} (detected by 3, t=15002 jiffies)
> [   62.804923] INFO: Stall ended before state dump start
> [  242.351898] INFO: task swapper/0:1 blocked for more than 120 seconds.
> [  242.372354] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  242.380260] swapper/0       D 00000001     0     1      0 0x00000000
> [  242.386812]  e8cd56f0 00000046 c12c30e0 00000001 e8cd6000 00000000 2c2abdd0 c14cb680
> [  242.400292]  e8cd58c0 c14cb680 00000001 c12c5c47 c154bfdc c12c2f02 00003520 c10283fb
> [  242.408607]  00000001 c12c5bb3 e8c18800 c12c3002 c118f8e7 c140007c c140007c e8c18800
> [  242.416931] Call Trace:
> [  242.419453]  [<c12c30e0>] ? need_resched+0x17/0x1b
> [  242.424296]  [<c12c5c47>] ? add_preempt_count+0x88/0x97
> [  242.429577]  [<c12c2f02>] ? _raw_spin_lock_irqsave+0x1b/0x37
> [  242.435308]  [<c10283fb>] ? get_parent_ip+0x8/0x19
> [  242.440158]  [<c12c5bb3>] ? sub_preempt_count+0x74/0x80
> [  242.445439]  [<c12c3002>] ? _raw_spin_unlock_irqrestore+0x21/0x2b
> [  242.451602]  [<c118f8e7>] ? vgacon_scroll+0x175/0x18f
> [  242.456703]  [<c12c5ccd>] ? __atomic_notifier_call_chain+0x33/0x3c
> [  242.462942]  [<c12c20ac>] ? schedule+0x64/0x7d
> [  242.467441]  [<c12c22d5>] ? schedule_timeout+0x1f/0xac
> [  242.472641]  [<c11d530a>] ? notify_update+0x1f/0x23
> [  242.477574]  [<c10283fb>] ? get_parent_ip+0x8/0x19
> [  242.482421]  [<c12c5bb3>] ? sub_preempt_count+0x74/0x80
> [  242.487700]  [<c10283fb>] ? get_parent_ip+0x8/0x19
> [  242.492543]  [<c12c5bb3>] ? sub_preempt_count+0x74/0x80
> [  242.497831]  [<c102b2de>] ? migrate_enable+0x120/0x132
> [  242.503024]  [<c12c1f7f>] ? wait_for_common+0x7f/0xe1
> [  242.508130]  [<c102b0d6>] ? try_to_wake_up+0x189/0x189
> [  242.513336]  [<c1077820>] ? __call_rcu+0xe6/0xe6
> [  242.518025]  [<c1044fcc>] ? wait_rcu_gp+0x2e/0x33
> [  242.522787]  [<c1044fd1>] ? wait_rcu_gp+0x33/0x33
> [  242.527553]  [<c1020000>] ? huge_pte_alloc+0x1cc/0x216
> [  242.532750]  [<c102b2de>] ? migrate_enable+0x120/0x132
> [  242.537953]  [<c119bbcb>] ? acpi_post_unmap_gar+0x78/0x91
> [  242.543424]  [<c11ba24a>] ? post_unmap_gar_callback+0x15/0x18
> [  242.549224]  [<c11b9c97>] ? apei_exec_for_each_entry+0x64/0x78
> [  242.555110]  [<c11ba235>] ? apei_resources_request+0x17f/0x17f
> [  242.561008]  [<c143aa36>] ? setup_erst_disable+0xd/0xd
> [  242.566203]  [<c11b9cc9>] ? apei_exec_post_unmap_gars+0xe/0x10
> [  242.572088]  [<c143ac67>] ? erst_init+0x231/0x288
> [  242.576851]  [<c11ef04a>] ? bus_add_driver+0x180/0x1b2
> [  242.582054]  [<c100115c>] ? do_one_initcall+0x66/0x10e
> [  242.587246]  [<c14177d8>] ? kernel_init+0xfc/0x173
> [  242.592093]  [<c14176dc>] ? start_kernel+0x31a/0x31a
> [  242.597110]  [<c12c76fe>] ? kernel_thread_helper+0x6/0xd
> 
> 
