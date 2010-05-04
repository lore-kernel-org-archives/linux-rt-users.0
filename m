From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [RT] 2.6.33.3-rt19: WARNING: at fs/namespace.c:648
 commit_tree+0xf1/0x10b()
Date: Tue, 4 May 2010 11:04:44 -0300
Message-ID: <20100504140443.GF4309@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Nick Piggin <npiggin@suse.de>
To: john stultz <johnstul@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f202.google.com ([209.85.223.202]:64581 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab0EDOEx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 May 2010 10:04:53 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

John,

As the backtrace seems to be closely related to what has been discussed on
the thread "2.6.33.3-rt16: WARNING: at fs/namespace.c:1197", I copied the
same people on this message.

As a side note, this time I just see the warning, there is no system freeze
involved.


------------[ cut here ]------------
WARNING: at fs/namespace.c:648 commit_tree+0xf1/0x10b()
Hardware name: KQ260AA-AC4 a6540br
Modules linked in: nls_utf8 udf vfat fat usb_storage fuse i915 drm_kms_helper drm video output ipt_MASQUERADE iptable_nat nf_nat bridge stp llc sunrpc ipv6 xt_physdev ipt_REJECT xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_state iptable_filter ip_tables x_tables dm_mirror dm_region_hash dm_log dm_multipath scsi_dh dm_mod kvm_intel kvm uinput tuner_simple tuner_types wm8775 tda9887 tda8290 snd_hda_codec_realtek tuner snd_hda_intel cx25840 snd_hda_codec ivtv snd_hwdep snd_seq i2c_algo_bit cx2341x v4l2_common videodev snd_seq_device v4l1_compat snd_pcm v4l2_compat_ioctl32 snd_timer ir_common snd ir_core sg r8169 tveeprom soundcore sr_mod i2c_i801 mii iTCO_wdt snd_page_alloc intel_agp firewire_ohci serio_raw cdrom i2c_core iTCO_vendor_support firewire_core pcspkr crc_itu_t button ahci libata 
 sd_mod scsi_mod crc_t10dif ext3 jbd mbcache uhci_hcd ohci_hcd ehci_hcd [last unloaded: microcode]
Pid: 14002, comm: fusermount Not tainted 2.6.33.3-rt19 #32
Call Trace:
[<ffffffff81040e67>] warn_slowpath_common+0x7c/0x94
[<ffffffff81040e93>] warn_slowpath_null+0x14/0x16
[<ffffffff81115811>] commit_tree+0xf1/0x10b
[<ffffffff8111661d>] attach_recursive_mnt+0xf2/0x188
[<ffffffff811167b3>] graft_tree+0x100/0x102
[<ffffffff8111765b>] do_mount+0x386/0x7ae
[<ffffffff810d55f2>] ? strndup_user+0x5d/0x85
[<ffffffff81117b0b>] sys_mount+0x88/0xc2
[<ffffffff81002d32>] system_call_fastpath+0x16/0x1b


Regards,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

