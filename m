From: Joakim Hernberg <jbh@alchemy.lu>
Subject: 3.8.4-rt2: (x86_64): BUG: scheduling while atomic
Date: Wed, 27 Mar 2013 13:16:58 +0100
Message-ID: <20130327131658.22aef026@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skinbark.wpsintrax.se ([83.145.49.220]:54211 "EHLO
	skinbark.wpsintrax.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab3C0M0S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Mar 2013 08:26:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by skinbark.wpsintrax.se (Postfix) with ESMTP id 6DB02BC82A3
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Mar 2013 13:17:00 +0100 (CET)
Received: from skinbark.wpsintrax.se ([127.0.0.1])
	by localhost (skinbark.wpsintrax.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RaFVneWM6o5t for <linux-rt-users@vger.kernel.org>;
	Wed, 27 Mar 2013 13:17:00 +0100 (CET)
Received: from tor.valhalla.alchemy.lu (ppp-256.vo.lu [80.90.42.2])
	by skinbark.wpsintrax.se (Postfix) with ESMTPA id 1BA97BC8210
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Mar 2013 13:17:00 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[  618.783525] BUG: scheduling while atomic: X/630/0x00000003
[  618.783548] Modules linked in: snd_hrtimer snd_seq_midi
snd_seq_midi_event snd_seq_dummy ipt_REJECT xt_tcpudp nf_conntrack_ipv4
nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_tables
x_tables w83627ehf hwmon_vid nls_utf8 hfsplus sr_mod snd_usb_audio
cdrom snd_usbmidi_lib joydev snd_hda_codec_hdmi snd_hda_codec_realtek
coretemp kvm_intel snd_hdsp snd_hda_intel snd_hda_codec snd_hwdep
e1000e mei snd_rawmidi kvm iTCO_wdt iTCO_vendor_support i2c_i801
lpc_ich mxm_wmi eeepc_wmi asus_wmi sparse_keymap rfkill pci_hotplug
crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 wmi xts lrw
gf128mul ablk_helper psmouse cryptd pcspkr serio_raw evdev fan thermal
microcode nfs lockd sunrpc fscache fuse tun cpufreq_userspace
acpi_cpufreq mperf processor snd_aloop snd_pcm snd_page_alloc snd_seq
snd_seq_device [  618.783558]  snd_timer snd soundcore ext4 crc16 jbd2
mbcache hid_generic usbhid hid usb_storage sd_mod ahci libahci
firewire_ohci libata ehci_pci firewire_core crc_itu_t xhci_hcd ehci_hcd
scsi_mod usbcore usb_common i915 video button i2c_algo_bit intel_agp
intel_gtt drm_kms_helper drm i2c_core [  618.783560] Pid: 630, comm: X
Not tainted 3.8.4-rt2-1-rt #1 [  618.783560] Call Trace:
[  618.783564]  [<ffffffff814cc358>] __schedule_bug+0x4d/0x59
[  618.783566]  [<ffffffff814d24cc>] __schedule+0x88c/0x930
[  618.783568]  [<ffffffff814d3b90>] ?
_raw_spin_unlock_irqrestore+0x40/0x50 [  618.783570]
[<ffffffff814d3b95>] ? _raw_spin_unlock_irqrestore+0x45/0x50
[  618.783572]  [<ffffffff810b57b5>] ?
task_blocks_on_rt_mutex+0x1f5/0x250 [  618.783573]
[<ffffffff814d27d9>] schedule+0x29/0x70 [  618.783574]
[<ffffffff814d3423>] rt_spin_lock_slowlock+0x15b/0x278 [  618.783576]
[<ffffffff814d3786>] rt_spin_lock+0x26/0x30 [  618.783585]
[<ffffffffa00dced9>] gen6_gt_force_wake_get+0x29/0x60 [i915]
[  618.783591]  [<ffffffffa00e183f>] gen6_ring_get_irq+0x5f/0x100
[i915] [  618.783597]  [<ffffffffa00b2a33>]
ftrace_raw_event_i915_gem_ring_dispatch+0xe3/0x100 [i915]
[  618.783602]  [<ffffffffa00ac1b3>]
i915_gem_do_execbuffer.isra.13+0xbd3/0x1430 [i915] [  618.783604]
[<ffffffff810f8943>] ? trace_buffer_unlock_commit+0x43/0x60
[  618.783606]  [<ffffffff8113e8d2>] ?
ftrace_raw_event_kmem_alloc+0xd2/0x180 [  618.783609]
[<ffffffff8101d063>] ? native_sched_clock+0x13/0x80 [  618.783614]
[<ffffffffa00acf29>] i915_gem_execbuffer2+0x99/0x280 [i915]
[  618.783621]  [<ffffffffa00114a3>] drm_ioctl+0x4c3/0x570 [drm]
[  618.783622]  [<ffffffff8101d0d9>] ? sched_clock+0x9/0x10
[  618.783628]  [<ffffffffa00ace90>] ? i915_gem_execbuffer+0x480/0x480
[i915] [  618.783629]  [<ffffffff810f1c18>] ? rb_commit+0x68/0xa0
[  618.783634]  [<ffffffff810f1c6c>] ?
ring_buffer_unlock_commit+0x1c/0xa0 [  618.783636]
[<ffffffff81197467>] do_vfs_ioctl+0x97/0x540 [  618.783638]
[<ffffffff81021318>] ? ftrace_raw_event_sys_enter+0xd8/0x130
[  618.783639]  [<ffffffff811979a1>] sys_ioctl+0x91/0xb0
[  618.783640]  [<ffffffff814db931>] tracesys+0xe1/0xe6

-- 

   Joakim
