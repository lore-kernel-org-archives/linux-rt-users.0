From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: BUG: scheduling while atomic on 4.0.4-rt
Date: Mon, 1 Jun 2015 18:05:29 +0200
Message-ID: <20150601180529.76806ca5@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:10497 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbbFAQFt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Jun 2015 12:05:49 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Just got this on 4.0.4-rt1.

[74169.672071] BUG: scheduling while atomic: chromium/1566/0x00000002
[74169.672099] Modules linked in: uas usb_storage hid_logitech snd_seq_dummy xt_tcpudp ipt_REJECT nf_reject_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack nf_conntrack iptable_filter ip6table_filter ip6_tables ip_tables x_tables nct6775 hwmon_vid bnep joydev xpad ff_memless intel_rapl iosf_mbi intel_powerclamp eeepc_wmi coretemp btusb asus_wmi sparse_keymap led_class kvm_intel bluetooth usblp rfkill kvm mousedev nls_iso8859_1 nls_cp437 iTCO_wdt crct10dif_pclmul iTCO_vendor_support crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel mxm_wmi vfat fat e1000e aes_x86_64 lrw gf128mul snd_hda_codec_hdmi glue_helper snd_hda_codec_realtek snd_hda_codec_generic snd_seq_midi ablk_helper snd_seq_midi_event snd_hda_intel snd_hdsp pt
 p snd_rawmidi
[74169.672126]  snd_hda_controller cryptd pps_core snd_hda_codec mei_me i2c_i801 mei evdev pcspkr psmouse serio_raw shpchp snd_hwdep thermal lpc_ich mac_hid battery wmi processor fan sch_fq_codel fuse tun snd_aloop snd_pcm snd_seq snd_seq_device snd_timer snd soundcore hid_logitech_hidpp ext4 crc16 mbcache jbd2 hid_generic hid_logitech_dj usbhid hid sr_mod cdrom sd_mod ahci libahci i915 intel_gtt libata xhci_pci firewire_ohci i2c_algo_bit ehci_pci firewire_core xhci_hcd ehci_hcd drm_kms_helper crc_itu_t scsi_mod drm usbcore usb_common i2c_core atkbd libps2 i8042 serio video button
[74169.672128] CPU: 2 PID: 1566 Comm: chromium Tainted: G        W       4.0.4-rt1-2-rt #1
[74169.672129] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[74169.672131]  0000000000000000 0000000098778511 ffff880092acf5c8 ffffffff8158ab39
[74169.672132]  0000000000000000 ffff88040f964c00 ffff880092acf5d8 ffffffff8109df2d
[74169.672134]  ffff880092acf628 ffffffff8158c50a ffff880092acf648 ffff880365499a30
[74169.672134] Call Trace:
[74169.672140]  [<ffffffff8158ab39>] dump_stack+0x4c/0x81
[74169.672142]  [<ffffffff8109df2d>] __schedule_bug+0x4d/0x60
[74169.672144]  [<ffffffff8158c50a>] __schedule+0x7fa/0x960
[74169.672146]  [<ffffffff8158c6af>] schedule+0x3f/0xd0
[74169.672148]  [<ffffffff8158dc1d>] rt_spin_lock_slowlock+0xdd/0x290
[74169.672151]  [<ffffffff8158f749>] rt_spin_lock+0x29/0x30
[74169.672154]  [<ffffffff81177bdd>] pagevec_lru_move_fn+0x9d/0x120
[74169.672156]  [<ffffffff81176fb0>] ? ftrace_raw_output_mm_lru_activate+0x70/0x70
[74169.672158]  [<ffffffff8117873e>] lru_add_drain_cpu+0x12e/0x170
[74169.672160]  [<ffffffff81192587>] compact_zone+0x537/0x8e0
[74169.672162]  [<ffffffff810b2531>] ? enqueue_task_fair+0x121/0x620
[74169.672164]  [<ffffffff8119299a>] compact_zone_order+0x6a/0x90
[74169.672166]  [<ffffffff81192c62>] try_to_compact_pages+0x102/0x290
[74169.672167]  [<ffffffff8117149a>] ? get_page_from_freelist+0x11a/0xbe0
[74169.672169]  [<ffffffff81171fa3>] __alloc_pages_direct_compact+0x43/0xf0
[74169.672171]  [<ffffffff81172590>] __alloc_pages_nodemask+0x540/0xa10
[74169.672174]  [<ffffffff811bae81>] alloc_pages_current+0x91/0x110
[74169.672177]  [<ffffffff81476fbc>] alloc_skb_with_frags+0xdc/0x1e0
[74169.672179]  [<ffffffff810a4bb0>] ? wake_up_process+0x50/0x50
[74169.672181]  [<ffffffff8146f44e>] sock_alloc_send_pskb+0x1fe/0x280
[74169.672183]  [<ffffffff810badd5>] ? __wake_up_sync_key+0x55/0x60
[74169.672186]  [<ffffffff81531cc0>] unix_stream_sendmsg+0x290/0x420
[74169.672188]  [<ffffffff81469f70>] ? sock_read_iter+0xf0/0xf0
[74169.672189]  [<ffffffff81469f70>] ? sock_read_iter+0xf0/0xf0
[74169.672190]  [<ffffffff81469ffd>] sock_write_iter+0x8d/0x100
[74169.672194]  [<ffffffff811df1e4>] do_iter_readv_writev+0x74/0xb0
[74169.672196]  [<ffffffff811e0a2a>] do_readv_writev+0xfa/0x300
[74169.672197]  [<ffffffff81469f70>] ? sock_read_iter+0xf0/0xf0
[74169.672199]  [<ffffffff811df131>] ? new_sync_write+0x91/0xd0
[74169.672200]  [<ffffffff811df0a0>] ? new_sync_read+0xd0/0xd0
[74169.672202]  [<ffffffff810aa558>] ? __enqueue_entity+0x78/0x80
[74169.672204]  [<ffffffff8101462a>] ? __switch_to+0x16a/0x630
[74169.672206]  [<ffffffff810b188f>] ? put_prev_task_fair+0x2f/0x50
[74169.672208]  [<ffffffff811fe842>] ? __fget+0x72/0xb0
[74169.672209]  [<ffffffff811e0cb9>] vfs_writev+0x39/0x50
[74169.672211]  [<ffffffff811e0e2c>] SyS_writev+0x5c/0x100
[74169.672213]  [<ffffffff811f5dcf>] ? SyS_poll+0xef/0x130
[74169.672215]  [<ffffffff8158fd89>] system_call_fastpath+0x12/0x17


-- 

   Joakim
