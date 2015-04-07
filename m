From: Carsten Emde <C.Emde@osadl.org>
Subject: [OSADL QA 3.18.9-rt5 #1]
Date: Wed, 08 Apr 2015 00:52:56 +0200
Message-ID: <55245FC8.9090509@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:49411 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843AbbDGXBK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2015 19:01:10 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

an Intel Bay Trail board (Intel(R) Celeron(R) CPU  J1900  @ 1.99GHz) at 
the OSADL QA Farm rack #b/slot #6 (https://www.osadl.org/?id=1894) stops 
working every 12 to 36 hours. The only way to get the board back to work 
is to power cycle it. Such crashes did not happen with any of the 
previously tested 3.12-rt kernels. About eight crashes have been 
observed so far - the kernel message obtained at the serial console (see 
below) was similar in all cases.

Thanks,
Carsten.


------------[ cut here ]------------
WARNING: CPU: 3 PID: 16574 at kernel/watchdog.c:298 
watchdog_overflow_callback+0x10f/0x16c()
Watchdog detected hard LOCKUP on cpu 3
Modules linked in: rpcsec_gss_krb5 nfsv4 eeprom nfs cpufreq_stats 
fscache bnep bluetooth ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 
nf_defrag_ipv6 ip6table_filter ip6_tables cfg80211 rfkill it87 hwmon_vid 
pl2303 usbserial cdc_acm r8169 mii iTCO_wdt iTCO_vendor_support ppdev 
coretemp kvm_intel kvm crc32c_intel snd_hda_codec_hdmi 
ghash_clmulni_intel cryptd microcode snd_hda_codec_realtek 
snd_hda_codec_generic serio_raw snd_hda_intel snd_hda_controller pcspkr 
snd_hda_codec snd_hwdep lpc_ich i2c_i801 snd_seq mfd_core snd_seq_device 
snd_pcm snd_timer snd xhci_pci shpchp soundcore xhci_hcd parport_pc 
parport nfsd auth_rpcgss oid_registry exportfs nfs_acl lockd grace 
sunrpc i915 i2c_algo_bit drm_kms_helper drm i2c_core video ipv6 autofs4 
[last unloaded: hwlat_detector]
CPU: 3 PID: 16574 Comm: cyclictest Not tainted 3.18.9-rt5 #30
Hardware name: Gigabyte Technology Co., Ltd. To be filled by 
O.E.M./J1900N-D3V, BIOS F2 03/06/2014
  0000000000000009 ffff88013fd85ba8 ffffffff814f89a4 00000000000003f8
  ffff88013fd85bf8 ffff88013fd85be8 ffffffff8103a27b 0000000000000000
  ffffffff810b6e65 0000000000000003 0000000000000000 ffff88013fd85d38
Call Trace:
  <NMI>  [<ffffffff814f89a4>] dump_stack+0x4f/0x9e
  [<ffffffff8103a27b>] warn_slowpath_common+0x81/0x9b
  [<ffffffff810b6e65>] ? watchdog_overflow_callback+0x10f/0x16c
  [<ffffffff8103a2db>] warn_slowpath_fmt+0x46/0x48
  [<ffffffff810b6e65>] watchdog_overflow_callback+0x10f/0x16c
  [<ffffffff810dec3b>] __perf_event_overflow+0x15a/0x1e8
  [<ffffffff81013c48>] ? x86_perf_event_set_period+0xfa/0x10c
  [<ffffffff810df127>] perf_event_overflow+0x14/0x16
  [<ffffffff8101825a>] intel_pmu_handle_irq+0x2bc/0x341
  [<ffffffff81012de4>] perf_event_nmi_handler+0x25/0x3e
  [<ffffffff81006325>] nmi_handle+0x72/0x134
  [<ffffffff81028081>] ? cpumask_clear_cpu.constprop.4+0x11/0x11
  [<ffffffff814fc7c3>] ? _raw_spin_unlock_irqrestore+0xe/0x4d
  [<ffffffff81006649>] default_do_nmi+0x78/0x14e
  [<ffffffff81006782>] do_nmi+0x63/0xa4
  [<ffffffff814fec0a>] end_repeat_nmi+0x1e/0x2e
  [<ffffffff814fc7c3>] ? _raw_spin_unlock_irqrestore+0xe/0x4d
  [<ffffffff814fc7c3>] ? _raw_spin_unlock_irqrestore+0xe/0x4d
  [<ffffffff814fc7c3>] ? _raw_spin_unlock_irqrestore+0xe/0x4d
  <<EOE>>  <IRQ>  [<ffffffff81086b9b>] hrtimer_try_to_cancel+0x55/0x5f
  [<ffffffff81087017>] hrtimer_cancel+0x16/0x28
  [<ffffffff81092fdf>] tick_nohz_restart+0x17/0x72
  [<ffffffff810936fc>] __tick_nohz_full_check+0x8e/0x93
  [<ffffffff8109370f>] nohz_full_kick_work_func+0xe/0x10
  [<ffffffff810d6a37>] irq_work_run_list+0x39/0x57
  [<ffffffff810930ae>] ? tick_sched_do_timer+0x45/0x45
  [<ffffffff810d6d6d>] irq_work_tick+0x60/0x67
  [<ffffffff81086122>] update_process_times+0x57/0x67
  [<ffffffff81092df3>] tick_sched_handle+0x4a/0x59
  [<ffffffff810930e9>] tick_sched_timer+0x3b/0x64
  [<ffffffff81086a77>] __run_hrtimer+0x7a/0x149
  [<ffffffff81087435>] hrtimer_interrupt+0x1cc/0x2c5
  [<ffffffff81026e3d>] local_apic_timer_interrupt+0x54/0x58
  [<ffffffff81027193>] smp_apic_timer_interrupt+0x31/0x43
  [<ffffffff814fdd0a>] apic_timer_interrupt+0x6a/0x70
  <EOI>  [<ffffffff810e2419>] ? context_tracking_user_exit+0xa0/0xcd
  [<ffffffff8100ec59>] syscall_trace_leave+0xf9/0x134
  [<ffffffff814fd1a8>] int_check_syscall_exit_work+0x34/0x3d
---[ end trace 0000000000000002 ]---
