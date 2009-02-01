From: Luis Henriques <henrix@sapo.pt>
Subject: [BUG -rt] scheduling while atomic in -rt git tree
Date: Sun, 1 Feb 2009 19:52:59 +0000
Message-ID: <20090201195259.GB5383@hades.domain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:42657 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751571AbZBATyN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Feb 2009 14:54:13 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am using an x86_64 and getting the following log while executing the master in
the -rt git tree:

[   28.182621] BUG: scheduling while atomic: sirq-net-rx/0/8/0x00000101, CPU#0
[   28.182744] Modules linked in: parport_pc ppdev parport ipv6 powernow_k8
cpufreq_stats cpufreq_conservative cpufreq_ondemand freq_table cpufreq_powersave
cpufreq_userspace af_packet sbp2 loop joydev arc4 snd_hda_intel ecb snd_pcm
snd_page_alloc uvcvideo snd_hwdep ath5k snd_seq compat_ioctl32 mac80211 psmouse
snd_timer videodev snd_seq_device k8temp v4l1_compat led_class snd soundcore
cfg80211 rfkill input_polldev battery video output ac button evdev ext3 jbd
mbcache sg sr_mod cdrom ide_pci_generic ide_core ata_generic sd_mod pata_acpi
ohci1394 ahci ehci_hcd pata_atiixp ohci_hcd ieee1394 libata usbcore scsi_mod
r8169 mii thermal processor fan
[   28.186632] Pid: 8, comm: sirq-net-rx/0 Tainted: G        W
2.6.28-rt-00209-g82e0a07 #1
[   28.186747] Call Trace:
[   28.186831]  [<ffffffff80455cb4>] ? netif_receive_skb+0x2c4/0x590
[   28.186938]  [<ffffffff80242795>] __schedule_bug+0x85/0x90
[   28.187033]  [<ffffffff804ead38>] thread_return+0x142/0x70a
[   28.187127]  [<ffffffff8020c3c8>] ? ftrace_call+0x5/0x2b
[   28.187218]  [<ffffffff8024f42f>] ksoftirqd+0x1df/0x270
[   28.187306]  [<ffffffff8024f250>] ? ksoftirqd+0x0/0x270
[   28.187395]  [<ffffffff802621de>] kthread+0x4e/0x90
[   28.187481]  [<ffffffff8020d639>] child_rip+0xa/0x11
[   28.187569]  [<ffffffff802408d9>] ? finish_task_switch+0x59/0x130
[   28.187663]  [<ffffffff804ed1ab>] ? _spin_unlock_irq+0x1b/0x40
[   28.187753]  [<ffffffff8020cb25>] ? restore_args+0x0/0x30
[   28.187842]  [<ffffffff80262190>] ? kthread+0x0/0x90
[   28.187929]  [<ffffffff8020d62f>] ? child_rip+0x0/0x11
[   28.188034] ---------------------------
[   28.188111] | preempt count: 00000101 ]
[   28.188189] | 2-level deep critical section nesting:
[   28.188272] ----------------------------------------
[   28.188356] .. [<ffffffff804a9c16>] .... icmp_send+0xc6/0x6a0
[   28.188497] .....[<ffffffff804a9c16>] ..   ( <= icmp_send+0xc6/0x6a0)
[   28.188639] .. [<ffffffff804ea7ac>] .... schedule+0x2c/0x476
[   28.188777] .....[<ffffffff8024f42f>] ..   ( <= ksoftirqd+0x1df/0x270)
[   28.188918] 

Can also provide my config file if needed.

-- 
Luis Henriques
