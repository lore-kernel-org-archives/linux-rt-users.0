From: Carsten Emde <C.Emde@osadl.org>
Subject: [OSADL QA 3.18.7-rt2 #1] WARNING at kernel/time/tick-sched.c:167
 can_stop_full_tick+0x2d/0xcd()
Date: Wed, 04 Mar 2015 22:24:31 +0100
Message-ID: <54F7780F.50109@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:32789 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbbCDVaL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Mar 2015 16:30:11 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Some x86-based systems with

CONFIG_NO_HZ_FULL=y

run into this WARN_ON_ONCE during boot

static bool can_stop_full_tick(void)
{
         WARN_ON_ONCE(!irqs_disabled());

Thanks,
Carsten.


[   22.706429] WARNING: CPU: 2 PID: 33 at kernel/time/tick-sched.c:167 
can_stop_full_tick+0x2d/0xcd()
[   22.706700] Modules linked in: ppdev parport_pc parport cpufreq_stats 
eeprom lockd 8021q garp w83627ehf stp grace llc hwmon_vid coretemp 
ip6table_filter ip6_tables snd_hda_codec_hdmi snd_hda_codec_realtek 
snd_hda_codec_generic snd_hda_intel snd_hda_controller snd_hda_codec 
snd_hwdep microcode snd_seq iTCO_wdt iTCO_vendor_support snd_seq_device 
snd_pcm serio_raw pcspkr snd_timer snd r8169 lpc_ich soundcore mfd_core 
mii i2c_i801 acpi_cpufreq uinput sunrpc ipv6 i915 drm_kms_helper drm 
video i2c_algo_bit i2c_core
[   22.708082] CPU: 2 PID: 33 Comm: ksoftirqd/2 Not tainted 3.18.7-rt2 #7
[   22.708083] Hardware name: System manufacturer System Product 
Name/P8H67-I DELUXE, BIOS 0502 02/11/2011
[   22.708085]  00000000000000a7 ffff8802353b7c78 ffffffff814f36db 
0000000000000001
[   22.708086]  0000000000000000 ffff8802353b7cb8 ffffffff8103b011 
ffff8802353b7cb8
[   22.708087]  ffffffff81098771 ffff880236e0d0f0 ffff880236e00000 
000000000000000a
[   22.708087] Call Trace:
[   22.708091]  [<ffffffff814f36db>] dump_stack+0x4f/0x7c
[   22.708092]  [<ffffffff8103b011>] warn_slowpath_common+0x81/0x9c
[   22.708094]  [<ffffffff81098771>] ? can_stop_full_tick+0x2d/0xcd
[   22.708095]  [<ffffffff8103b046>] warn_slowpath_null+0x1a/0x1c
[   22.708096]  [<ffffffff81098771>] can_stop_full_tick+0x2d/0xcd
[   22.708098]  [<ffffffff81098f2e>] __tick_nohz_full_check+0x52/0x93
[   22.708099]  [<ffffffff81098f8d>] nohz_full_kick_work_func+0xe/0x10
[   22.708101]  [<ffffffff810ded0c>] irq_work_run_list+0x36/0x57
[   22.708102]  [<ffffffff810df034>] irq_work_tick+0x42/0x66
[   22.708103]  [<ffffffff8108b142>] run_timer_softirq+0x35/0x223
[   22.708106]  [<ffffffff812779af>] ? check_preemption_disabled+0x9b/0x132
[   22.708108]  [<ffffffff810609a3>] ? 
vtime_common_account_irq_enter+0x5b/0x60
[   22.708110]  [<ffffffff8103e41f>] do_current_softirqs+0x18b/0x2d5
[   22.708111]  [<ffffffff8103e592>] run_ksoftirqd+0x29/0x3d
[   22.708113]  [<ffffffff810561d4>] smpboot_thread_fn+0x201/0x206
[   22.708114]  [<ffffffff81055fd3>] ? 
smpboot_unregister_percpu_thread+0x67/0x67
[   22.708116]  [<ffffffff81053169>] kthread+0xc4/0xcc
[   22.708118]  [<ffffffff810530a5>] ? __init_kthread_worker+0x50/0x50
[   22.708120]  [<ffffffff814f7bec>] ret_from_fork+0x7c/0xb0
[   22.708121]  [<ffffffff810530a5>] ? __init_kthread_worker+0x50/0x50
