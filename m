From: Mike Galbraith <bitbucket@online.de>
Subject: Re: CONFIG_NO_HZ_FULL + CONFIG_PREEMPT_RT_FULL = nogo
Date: Sun, 22 Dec 2013 06:37:11 +0100
Message-ID: <1387690631.5412.58.camel@marge.simpson.net>
References: <1383228427.5272.36.camel@marge.simpson.net>
	 <alpine.DEB.2.02.1311061842160.23353@ionos.tec.linutronix.de>
	 <1383794799.5441.16.camel@marge.simpson.net>
	 <1383798668.5441.25.camel@marge.simpson.net>
	 <alpine.DEB.2.02.1311071158350.23353@ionos.tec.linutronix.de>
	 <20131220154146.GA18672@breakpoint.cc>
	 <1387617104.30230.7.camel@marge.simpson.net> <52B5CE09.5030908@gmail.com>
	 <1387685830.5412.37.camel@marge.simpson.net>
	 <1387689024.5412.49.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: muli.baron@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60002 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab3LVFhO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 Dec 2013 00:37:14 -0500
In-Reply-To: <1387689024.5412.49.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2013-12-22 at 06:10 +0100, Mike Galbraith wrote:

> DL980 with same rt7 patchset/config, but with nohz_full=55-63 can take a
> while to make up its mind, but does kick in (this boot anyway).

While rebuilding with distro config (lard=max, but nohz_full=off)...

[ 2230.960596] ------------[ cut here ]------------
[ 2231.008947] WARNING: CPU: 24 PID: 372 at kernel/time/tick-sched.c:161 can_stop_full_tick+0x1b3/0x1c0()
[ 2231.136916] Modules linked in: nfsv3 nfs_acl nfs fscache lockd sunrpc autofs4 edd af_packet bridge stp llc cpufreq_conservative cpufreq_userspace cpufreq_powersave pcc_cpufreq fuse loop ipmi_si iTCO_wdt iTCO_vendor_support gpio_ich sg sr_mod cdrom joydev ipmi_msghandler netxen_nic bnx2 i7core_edac lpc_ich mfd_core edac_core acpi_power_meter pcspkr button ext3 jbd radeon ttm drm_kms_helper drm i2c_algo_bit thermal processor thermal_sys scsi_dh_rdac scsi_dh_alua scsi_dh_emc scsi_dh_hp_sw scsi_dh ata_generic ata_piix hpsa cciss
[ 2231.633825] CPU: 24 PID: 372 Comm: ksoftirqd/24 Not tainted 3.12.6-rt7 #189
[ 2231.633827] Hardware name: Hewlett-Packard ProLiant DL980 G7, BIOS P66 07/07/2010
[ 2231.633831]  00000000ffffffff ffff88027459bbf8 ffffffff81573a2d ffffffff810b8583
[ 2231.633833]  00000000000000a1 ffff88027459bc38 ffffffff8104fe1c ffff88027459bc28
[ 2231.633834]  ffff88027710be40 ffff880277100000 0000000000000002 0000000000000000
[ 2231.633835] Call Trace:
[ 2231.633854]  [<ffffffff81573a2d>] dump_stack+0x4d/0xa8
[ 2231.633863]  [<ffffffff810b8583>] ? can_stop_full_tick+0x1b3/0x1c0
[ 2231.633872]  [<ffffffff8104fe1c>] warn_slowpath_common+0x8c/0xc0
[ 2231.633928]  [<ffffffff8104fe6a>] warn_slowpath_null+0x1a/0x20
[ 2231.633929]  [<ffffffff810b8583>] can_stop_full_tick+0x1b3/0x1c0
[ 2231.633931]  [<ffffffff810b8625>] __tick_nohz_full_check+0x95/0xb0
[ 2231.633933]  [<ffffffff810b864e>] nohz_full_kick_work_func+0xe/0x10
[ 2231.633941]  [<ffffffff8110a0a9>] __irq_work_run+0x69/0x80
[ 2231.633943]  [<ffffffff8110a0c9>] irq_work_run+0x9/0x10
[ 2231.633946]  [<ffffffff8105e1f4>] run_timer_softirq+0x24/0x2d0
[ 2231.633955]  [<ffffffff8108a2a5>] ? sched_clock_cpu+0xc5/0x110
[ 2231.633958]  [<ffffffff8108afc5>] ? account_system_time+0x175/0x1a0
[ 2231.633964]  [<ffffffff810560c6>] handle_softirq+0xa6/0x180
[ 2231.633966]  [<ffffffff810562f8>] do_current_softirqs+0x158/0x230
[ 2231.633968]  [<ffffffff81056403>] run_ksoftirqd+0x33/0x50
[ 2231.633971]  [<ffffffff8107ee82>] smpboot_thread_fn+0x232/0x360
[ 2231.633973]  [<ffffffff8107ec50>] ? smpboot_create_threads+0x80/0x80
[ 2231.633977]  [<ffffffff8107571e>] kthread+0xbe/0xd0
[ 2231.633978]  [<ffffffff81075660>] ? kthreadd+0x1d0/0x1d0
[ 2231.633988]  [<ffffffff8157fb2c>] ret_from_fork+0x7c/0xb0
[ 2231.633990]  [<ffffffff81075660>] ? kthreadd+0x1d0/0x1d0
[ 2231.633992] ---[ end trace 0000000000000002 ]---


