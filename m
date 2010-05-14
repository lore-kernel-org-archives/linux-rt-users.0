From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: WARNING: at fs/namespace.c:648 commit_tree+0xf1/0x10b()
Date: Fri, 14 May 2010 09:35:12 -0300
Message-ID: <20100514123512.GB31019@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Nick Piggin <npiggin@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:43521 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab0ENMm7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 08:42:59 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

John,

This morning I boooted 2.6.33.4-rt19 (from rt/2.6.33) and, though this
kernel has all of your fs/namespace.c patches, I saw the very same
backtrace you and Nick fixed a while ago:

------------[ cut here ]------------
WARNING: at fs/namespace.c:648 commit_tree+0xf1/0x10b()
Hardware name: KQ260AA-AC4 a6540br
Modules linked in: fuse i915 drm_kms_helper drm video output ipt_MASQUERADE iptable_nat nf_nat bridge stp llc sunrpc ipv6 xt_physdev ipt_REJECT xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_state iptable_filter ip_tables x_tables dm_mirror dm_region_hash dm_log dm_multipath scsi_dh dm_mod kvm_intel kvm uinput tuner_simple tuner_types wm8775 tda9887 tda8290 tuner snd_hda_codec_realtek cx25840 ivtv snd_hda_intel snd_hda_codec snd_hwdep i2c_algo_bit snd_seq cx2341x v4l2_common snd_seq_device videodev v4l1_compat snd_pcm v4l2_compat_ioctl32 ir_common snd_timer ir_core snd tveeprom i2c_i801 firewire_ohci firewire_core i2c_core soundcore r8169 sr_mod sg iTCO_wdt snd_page_alloc pcspkr serio_raw mii intel_agp cdrom crc_itu_t iTCO_vendor_support button ahci libata sd_mod scsi_mod crc_t10dif ext3 jb
 d mbcache uhci_hcd ohci_hcd ehci_hcd [last unloaded: microcode]
Pid: 5117, comm: fusermount Not tainted 2.6.33.4-rt19 #36
Call Trace:
[<ffffffff8103ff87>] warn_slowpath_common+0x7c/0x94
[<ffffffff8103ffb3>] warn_slowpath_null+0x14/0x16
[<ffffffff81114931>] commit_tree+0xf1/0x10b
[<ffffffff8111573d>] attach_recursive_mnt+0xf2/0x188
[<ffffffff811158d3>] graft_tree+0x100/0x102
[<ffffffff811167b7>] do_mount+0x386/0x7ae
[<ffffffff810d4712>] ? strndup_user+0x5d/0x85
[<ffffffff81116c67>] sys_mount+0x88/0xc2
[<ffffffff81002d32>] system_call_fastpath+0x16/0x1b


Regards,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

