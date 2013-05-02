From: Mike Galbraith <bitbucket@online.de>
Subject: 3.8.10-rt6: suspend/resume irqs enabled splat
Date: Thu, 02 May 2013 07:43:53 +0200
Message-ID: <1367473433.5808.8.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49650 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3EBFoD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 May 2013 01:44:03 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Suspend/resume works fine on laptop, but, suspend, let it sit there a
bit, then resume produces the gripe below.  Seems to be -rt specific,
3.8.10 with only voluntary preempt/autogroup config delta doesn't gripe.

[  301.005804] ------------[ cut here ]------------
[  301.005813] WARNING: at kernel/sched/clock.c:245 sched_clock_cpu+0x108/0x120()
[  301.005815] Hardware name: SATELLITE T130
[  301.005884] Modules linked in: fuse nfsd lockd rfcomm nfs_acl auth_rpcgss bnep sunrpc cpufreq_conservative cpufreq_ondemand cpufreq_userspace cpufreq_powersave arc4 rtl8192se rtlwifi mac80211 snd_hda_codec_hdmi snd_hda_codec_conexant btusb bluetooth snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss cfg80211 snd_pcm snd_seq snd_timer snd_seq_device snd_mixer_oss snd soundcore iTCO_wdt acpi_cpufreq iTCO_vendor_support lpc_ich snd_page_alloc sg mperf toshiba_acpi sparse_keymap ehci_pci coretemp joydev serio_raw i2c_i801 atl1c mfd_core wmi toshiba_bluetooth battery ac rfkill edd microcode ipv6 autofs4 ext4 mbcache jbd2 crc16 hid_generic usbhid hid sd_mod crc_t10dif uhci_hcd ehci_hcd rtc_cmos i915 drm_kms_helper drm i2c_algo_bit usbcore button usb_common video ahci libahci libata scsi_mod fa
 n processor thermal
[  301.005889] Pid: 0, comm: swapper/0 Not tainted 3.8.10-rt6-smp #25
[  301.005891] Call Trace:
[  301.005899]  [<ffffffff8103dd2f>] warn_slowpath_common+0x7f/0xc0
[  301.005905]  [<ffffffff8103dd8a>] warn_slowpath_null+0x1a/0x20
[  301.005909]  [<ffffffff81079a48>] sched_clock_cpu+0x108/0x120
[  301.005912]  [<ffffffff81079b31>] sched_clock_idle_sleep_event+0x11/0x20
[  301.005922]  [<ffffffffa000d190>] acpi_idle_enter_simple+0x78/0xbe [processor]
[  301.005931]  [<ffffffffa000d307>] acpi_idle_enter_bm+0xdf/0x21c [processor]
[  301.005937]  [<ffffffff8134ce70>] ? cpufreq_frequency_table_cpuinfo+0x120/0x120
[  301.005942]  [<ffffffff8134ce89>] cpuidle_enter+0x19/0x20
[  301.005945]  [<ffffffff8134da71>] cpuidle_wrap_enter+0x41/0xa0
[  301.005951]  [<ffffffff8134dae0>] cpuidle_enter_tk+0x10/0x20
[  301.005954]  [<ffffffff8134d571>] cpuidle_idle_call+0xe1/0x410
[  301.005959]  [<ffffffff8100bfea>] cpu_idle+0xca/0x130
[  301.005963]  [<ffffffff8142027b>] ? rest_init+0x7b/0x90
[  301.005965]  [<ffffffff81420280>] rest_init+0x80/0x90
[  301.005970]  [<ffffffff818d4b91>] start_kernel+0x357/0x364
[  301.005973]  [<ffffffff818d46cc>] ? repair_env_string+0x5a/0x5a
[  301.005976]  [<ffffffff818d432d>] x86_64_start_reservations+0x131/0x135
[  301.005979]  [<ffffffff818d4421>] x86_64_start_kernel+0xf0/0xf7
[  301.005981] ---[ end trace 0000000000000002 ]---


