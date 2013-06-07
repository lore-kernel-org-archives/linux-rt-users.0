From: Mike Galbraith <bitbucket@online.de>
Subject: Re: 3.8.11-rt8 NFS triggered seizures
Date: Fri, 07 Jun 2013 14:34:41 +0200
Message-ID: <1370608481.5854.60.camel@marge.simpson.net>
References: <1368437465.11686.60.camel@marge.simpson.net>
	 <20130607090300.GC10280@linutronix.de>
	 <1370603848.5854.42.camel@marge.simpson.net>
	 <51B1C5CC.7010306@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56165 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3FGMet (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 08:34:49 -0400
In-Reply-To: <51B1C5CC.7010306@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-06-07 at 13:36 +0200, Sebastian Andrzej Siewior wrote: 
> On 06/07/2013 01:17 PM, Mike Galbraith wrote:
> > On Fri, 2013-06-07 at 11:03 +0200, Sebastian Andrzej Siewior wrote:
> > 
> >> The "panic" says "Oops" so your karnel most likely hit a NULL pointer.
> >> The completion you say is missing might run into the NULL pointer
> >> problem. Any way to get the backtrace from the oops?
> > 
> > The oops is just me poking sysrq-c to crash the box.
> 
> Ach. This does not make any easier then.

Yeah, it didn't repeat before DVD download finally finished (after mere
three _weeks_).  The below fired during the same boot as the last hang,
but far earlier fwiw.

[10288.045302] ------------[ cut here ]------------
[10288.045330] WARNING: at kernel/workqueue.c:1575 worker_enter_idle+0xea/0x130()
[10288.045345] Hardware name: SATELLITE T130
[10288.045357] Modules linked in: fuse nfsd lockd nfs_acl auth_rpcgss sunrpc rfcomm bnep edd ipv6 cpufreq_conservative cpufreq_ondemand cpufreq_userspace cpufreq_powersave dm_mod arc4 rtl8192se rtlwifi mac80211 snd_hda_codec_hdmi snd_hda_codec_conexant btusb bluetooth snd_hda_intel snd_hda_codec snd_hwdep cfg80211 snd_pcm_oss snd_pcm snd_seq acpi_cpufreq snd_timer mperf snd_seq_device snd_mixer_oss coretemp snd iTCO_wdt iTCO_vendor_support toshiba_acpi sparse_keymap sg microcode joydev soundcore lpc_ich rfkill toshiba_bluetooth serio_raw atl1c i2c_i801 snd_page_alloc mfd_core wmi ehci_pci ac battery ext4 mbcache jbd2 crc16 hid_generic usbhid hid sd_mod i915 crc_t10dif rtc_cmos uhci_hcd drm_kms_helper ehci_hcd drm i2c_algo_bit button usbcore usb_common video ahci libahci libata scsi_mod fan
  processor
[10288.045425]  thermal
[10288.045426]
[10288.045514] Pid: 5371, comm: kworker/0:0 Not tainted 3.8.11-rt8-smp #35
[10288.045528] Call Trace:
[10288.045546]  [<ffffffff8103dbef>] warn_slowpath_common+0x7f/0xc0
[10288.045550]  [<ffffffff8103dc4a>] warn_slowpath_null+0x1a/0x20
[10288.045552]  [<ffffffff8105b2da>] worker_enter_idle+0xea/0x130
[10288.045556]  [<ffffffff8105ec78>] worker_thread+0x268/0x3f0
[10288.045559]  [<ffffffff8105ea10>] ? rescuer_thread+0x2b0/0x2b0
[10288.045563]  [<ffffffff81064332>] kthread+0xb2/0xc0
[10288.045567]  [<ffffffff81040000>] ? console_unlock.part.11+0x170/0x320
[10288.045571]  [<ffffffff81064280>] ? flush_kthread_worker+0xb0/0xb0
[10288.045576]  [<ffffffff8144511c>] ret_from_fork+0x7c/0xb0
[10288.045579]  [<ffffffff81064280>] ? flush_kthread_worker+0xb0/0xb0
[10288.045582] ---[ end trace 0000000000000002 ]---

1567         /*
1568          * Sanity check nr_running.  Because gcwq_unbind_fn() releases
1569          * gcwq->lock between setting %WORKER_UNBOUND and zapping
1570          * nr_running, the warning may trigger spuriously.  Check iff
1571          * unbind is not in progress.
1572          */
1573         WARN_ON_ONCE(!(gcwq->flags & GCWQ_DISASSOCIATED) &&
1574                      pool->nr_workers == pool->nr_idle &&
1575                      atomic_read(get_pool_nr_running(pool)));
1576 }


