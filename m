From: joel silvestre <j.silvestre@wanadoo.fr>
Subject: 3.0.14-rt31 - irq 23: nobody cared
Date: Sun, 12 Feb 2012 22:05:46 +0100
Message-ID: <1329080746.4913.35.camel@zordi2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:21235 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab2BLVNo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 12 Feb 2012 16:13:44 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
ethernet interface stop working and :


Feb 12 19:10:47 zatelier kernel: [361833.358104] irq 23: nobody cared
(try booting with the "irqpoll" option)
Feb 12 19:10:47 zatelier kernel: [361833.358117] Pid: 618, comm:
irq/23-ohci_hcd Not tainted 3.0.14.moa-debug-rt31 #1
Feb 12 19:10:47 zatelier kernel: [361833.358124] Call Trace:
Feb 12 19:10:47 zatelier kernel: [361833.358158]  [<c1075f34>]
__report_bad_irq+0x24/0x9a
Feb 12 19:10:47 zatelier kernel: [361833.358170]  [<c10760e5>]
note_interrupt+0x13b/0x1ac
Feb 12 19:10:47 zatelier kernel: [361833.358180]  [<c1075036>]
irq_thread+0xe9/0x1a1
Feb 12 19:10:47 zatelier kernel: [361833.358189]  [<c1075189>] ?
exit_irq_thread+0x6f/0x6f
Feb 12 19:10:47 zatelier kernel: [361833.358198]  [<c1074f4d>] ?
irq_finalize_oneshot+0x8c/0x8c
Feb 12 19:10:47 zatelier kernel: [361833.358206]  [<c1074f4d>] ?
irq_finalize_oneshot+0x8c/0x8c
Feb 12 19:10:47 zatelier kernel: [361833.358217]  [<c104f07d>] kthread
+0x67/0x6c
Feb 12 19:10:47 zatelier kernel: [361833.358240]  [<c104f016>] ?
kthreadd+0x10a/0x10a
Feb 12 19:10:47 zatelier kernel: [361833.358252]  [<c12c1882>]
kernel_thread_helper+0x6/0x10
Feb 12 19:10:47 zatelier kernel: [361833.358257] handlers:
Feb 12 19:10:47 zatelier kernel: [361833.358264] [<c1074d55>]
irq_default_primary_handler threaded [<f803f8f6>] usb_hcd_irq
Feb 12 19:10:47 zatelier kernel: [361833.358328] [<c1074d55>]
irq_default_primary_handler threaded [<f81b579d>] nv_nic_irq_optimized
Feb 12 19:10:47 zatelier kernel: [361833.358374] Disabling IRQ #23
Feb 12 19:10:47 zatelier kernel: [362602.680819] [drm] nouveau
0000:00:05.0: Setting dpms mode 1 on vga encoder (output 0)
Feb 12 19:10:47 zatelier kernel: [362602.718819] [drm] nouveau
0000:00:05.0: Setting dpms mode 3 on vga encoder (output 0)
Feb 12 19:58:51 zatelier kernel: [362738.016043] ------------[ cut here
]------------
Feb 12 19:58:51 zatelier kernel: [362738.016063] WARNING: at
net/sched/sch_generic.c:255 dev_watchdog+0xb9/0x110()
Feb 12 19:58:51 zatelier kernel: [362738.016070] Hardware name: System
Product Name
Feb 12 19:58:51 zatelier kernel: [362738.016075] NETDEV WATCHDOG: eth0
(forcedeth): transmit queue 0 timed out
Feb 12 19:58:51 zatelier kernel: [362738.016079] Modules linked in:
powernow_k8 mperf cpufreq_conservative cpufreq_stats cpufreq_powersave
cpufreq_userspace ppdev lp rfcomm bridge stp bnep bluetooth rfkill
nouveau ttm drm_kms_helper drm i2c_algo_bit mxm_wmi wmi video
binfmt_misc fuse ext3 jbd loop firewire_sbp2 snd_hda_codec_analog
snd_ice1724 snd_ice17xx_ak4xxx snd_hda_intel snd_ac97_codec ac97_bus
snd_ak4xxx_adda snd_ak4114 snd_pt2258 snd_i2c snd_ak4113 snd_hda_codec
snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_midi snd_rawmidi
snd_seq_midi_event snd_seq snd_timer psmouse snd_seq_device serio_raw
snd evdev button processor soundcore k8temp parport_pc i2c_nforce2
i2c_core snd_page_alloc tpm_tis tpm tpm_bios parport asus_atk0110 ext4
mbcache jbd2 crc16 sg sr_mod cdrom sd_mod crc_t10dif ata_generic
ohci_hcd pata_amd firewire_ohci thermal firewire_core crc_itu_t floppy
fan sata_nv libata ehci_hcd forcedeth scsi_mod thermal_sys usbcore [last
unloaded: scsi_wait_scan]
Feb 12 19:58:51 zatelier kernel: [362738.016199] Pid: 3, comm:
ksoftirqd/0 Not tainted 3.0.14.moa-debug-rt31 #1
Feb 12 19:58:51 zatelier kernel: [362738.016204] Call Trace:
Feb 12 19:58:51 zatelier kernel: [362738.016220]  [<c1036aad>]
warn_slowpath_common+0x6a/0x7f
Feb 12 19:58:51 zatelier kernel: [362738.016228]  [<c12262e5>] ?
dev_watchdog+0xb9/0x110
Feb 12 19:58:51 zatelier kernel: [362738.016238]  [<c1036b35>]
warn_slowpath_fmt+0x2b/0x2f
Feb 12 19:58:51 zatelier kernel: [362738.016246]  [<c12262e5>]
dev_watchdog+0xb9/0x110
Feb 12 19:58:51 zatelier kernel: [362738.016264]  [<c1042b55>]
run_timer_softirq+0x15e/0x231
Feb 12 19:58:51 zatelier kernel: [362738.016273]  [<c122622c>] ?
netif_tx_unlock+0x4d/0x4d
Feb 12 19:58:51 zatelier kernel: [362738.016282]  [<c103c625>]
__do_softirq_common+0xbe/0x1a7
Feb 12 19:58:51 zatelier kernel: [362738.016291]  [<c103c7b3>]
__thread_do_softirq+0xa5/0xe3
Feb 12 19:58:51 zatelier kernel: [362738.016298]  [<c103c85f>]
run_ksoftirqd+0x6e/0x152
Feb 12 19:58:51 zatelier kernel: [362738.016306]  [<c103c7f1>] ?
__thread_do_softirq+0xe3/0xe3
Feb 12 19:58:51 zatelier kernel: [362738.016314]  [<c104f07d>] kthread
+0x67/0x6c
Feb 12 19:58:51 zatelier kernel: [362738.016324]  [<c104f016>] ?
kthreadd+0x10a/0x10a
Feb 12 19:58:51 zatelier kernel: [362738.016335]  [<c12c1882>]
kernel_thread_helper+0x6/0x10
Feb 12 19:58:51 zatelier kernel: [362738.016341] ---[ end trace
0000000000000002 ]---
Feb 12 19:58:51 zatelier kernel: [362738.016350] forcedeth 0000:00:14.0:
eth0: Got tx_timeout. irq: 00000032
Feb 12 19:58:51 zatelier kernel: [362738.016356] forcedeth 0000:00:14.0:
eth0: Ring at 2de8c000
Feb 12 19:58:51 zatelier kernel: [362738.016361] forcedeth 0000:00:14.0:
eth0: Dumping tx registers
Feb 12 19:58:51 zatelier kernel: [362738.016374] forcedeth 0000:00:14.0:
eth0:   0: 00000032 00000060 00000003 0007000d 00000000 00000000
00000000 00000000
Feb 12 19:58:51 zatelier kernel: [362738.016387] forcedeth 0000:00:14.0:
eth0:  20: 00000000 f0000000 00000000 00000000 00000000 00000000
00000000 00000000
Feb 12 19:58:51 zatelier kernel: [362738.016400] forcedeth 0000:00:14.0:
eth0:  40: 0420e20e 0000a455 00002e20 00000000 00000000 00000000
00000000 00000000
--- lot of dump after ---

