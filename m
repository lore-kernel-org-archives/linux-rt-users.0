From: Jacek Konieczny <jajcus@jajcus.net>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Mon, 14 Aug 2017 20:03:26 +0200
Message-ID: <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tropek.jajcus.net ([31.179.132.94]:40890 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdHNSDd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Aug 2017 14:03:33 -0400
In-Reply-To: <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-08-07 15:19, Sebastian Andrzej Siewior wrote:
> One thing you could try, is to see if the latest v4.11 based RT kernel
> works more reliable.

I tried 4.11.12-rt9 (with your patch applied, just in case). It worked
find for a day and then failed like the older kernels:

Aug 13 21:26:34 lolek kernel: EDEADLK #2
Aug 13 21:26:34 lolek kernel: Crashing soon on -35 (ffff8f3f8674df40
ffff8f3f76a11fc0)
Aug 13 21:26:34 lolek kernel: ------------[ cut here ]------------
Aug 13 21:26:34 lolek kernel: kernel BUG at kernel/locking/rtmutex.c:1077!
Aug 13 21:26:34 lolek kernel: invalid opcode: 0000 [#1] PREEMPT SMP
Aug 13 21:26:34 lolek kernel: Modules linked in: snd_seq_dummy snd_seq
cts nfsv4 dns_resolver nfs lockd grace fscache fuse ip6t_REJECT
nf_reject_ipv6 ip6t_rpfilter xt_tcpudp ipt_REJECT nf_reject_ipv4
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc
ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6
ip6table_mangle ip6table_raw ip6table_security iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack
iptable_mangle iptable_raw iptable_security ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter msr bnep joydev acer_wmi
sparse_keymap coretemp hwmon intel_rapl intel_powerclamp intel_cstate
intel_uncore intel_rapl_perf efi_pstore psmouse pcspkr snd_soc_skl
uvcvideo efivars snd_soc_skl_ipc snd_hda_codec_hdmi videobuf2_vmalloc
snd_soc_sst_ipc videobuf2_memops
Aug 13 21:26:34 lolek kernel:  snd_soc_sst_dsp videobuf2_v4l2
snd_hda_ext_core snd_hda_codec_realtek videobuf2_core snd_soc_sst_match
snd_hda_codec_generic videodev input_leds snd_soc_core btusb btrtl media
btbcm snd_compress btintel ac97_bus snd_pcm_dmaengine snd_usb_audio
bluetooth snd_usbmidi_lib snd_hda_intel snd_rawmidi snd_hda_codec
snd_seq_device snd_hda_core snd_hwdep r8169 snd_pcm mii mei_me mei
shpchp dell_smo8800 thermal wmi pinctrl_sunrisepoint pinctrl_intel
intel_lpss_acpi idma64 battery tpm_crb evdev intel_lpss_pci acpi_pad ac
intel_lpss intel_pch_thermal sch_fq_codel ip_tables x_tables ext4 crc16
jbd2 fscrypto mbcache dm_crypt algif_skcipher af_alg hid_generic usbhid
sr_mod cdrom sd_mod rtsx_pci_sdmmc i915 mmc_core crct10dif_pclmul
crc32_pclmul intel_gtt ghash_clmulni_intel ahci i2c_algo_bit libahci
Aug 13 21:26:34 lolek kernel:  drm_kms_helper libata aesni_intel
syscopyarea sysfillrect aes_x86_64 sysimgblt crypto_simd xhci_pci
fb_sys_fops cryptd scsi_mod glue_helper xhci_hcd drm serio_raw rtsx_pci
i2c_hid usbcore hid i2c_core video button dm_mirror dm_region_hash
dm_log rpcsec_gss_krb5 auth_rpcgss sunrpc snd_hrtimer snd_timer snd
soundcore dm_cache_smq dm_cache dm_persistent_data libcrc32c
crc32c_generic crc32c_intel dm_bufio dm_bio_prison dm_mod efivarfs autofs4
Aug 13 21:26:34 lolek kernel: CPU: 3 PID: 1312 Comm: zabbix_agentd Not
tainted 4.11.12-rt9-1 #2
Aug 13 21:26:34 lolek kernel: Hardware name: Acer Aspire
E5-575/Ironman_SK  , BIOS V1.25 03/03/2017
Aug 13 21:26:34 lolek kernel: task: ffff8f3f76a11fc0 task.stack:
ffff90d7022dc000
Aug 13 21:26:34 lolek kernel: RIP:
0010:rt_spin_lock_slowlock_locked+0x2cf/0x300
Aug 13 21:26:34 lolek kernel: RSP: 0018:ffff90d7022dfbe8 EFLAGS: 00010082
Aug 13 21:26:34 lolek kernel: RAX: 0000000000000038 RBX:
ffff8f3f76a11fc0 RCX: 0000000000000000
Aug 13 21:26:34 lolek kernel: RDX: 0000000000000000 RSI:
0000000000000038 RDI: 0000000000000001
Aug 13 21:26:34 lolek kernel: RBP: ffff90d7022dfc28 R08:
0000000000000000 R09: 0000000000000038
Aug 13 21:26:34 lolek kernel: R10: 0000000000000008 R11:
000000000001ac04 R12: ffff8f3f76a11fc0
Aug 13 21:26:34 lolek kernel: R13: ffff90d7022dfc38 R14:
0000000000000246 R15: ffff8f3f9158ce18
Aug 13 21:26:34 lolek kernel: FS:  00007f4858271780(0000)
GS:ffff8f3f91580000(0000) knlGS:0000000000000000
Aug 13 21:26:34 lolek kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Aug 13 21:26:34 lolek kernel: CR2: 00007f4856eedf38 CR3:
0000000236a1a000 CR4: 00000000003406e0
Aug 13 21:26:34 lolek kernel: Call Trace:
Aug 13 21:26:34 lolek kernel:  rt_spin_lock_slowlock+0x67/0xa0
Aug 13 21:26:34 lolek kernel:  rt_spin_lock+0x1a/0x20
Aug 13 21:26:34 lolek kernel:  do_current_softirqs+0x116/0x390
Aug 13 21:26:34 lolek kernel:  __local_bh_enable+0x5b/0x80
Aug 13 21:26:34 lolek kernel:  tcp_v4_send_reset+0x412/0x590
Aug 13 21:26:34 lolek kernel:  ? tcp_rcv_state_process+0x28a/0xda0
Aug 13 21:26:34 lolek kernel:  ? preempt_count_sub+0xa1/0x100
Aug 13 21:26:34 lolek kernel:  tcp_v4_do_rcv+0x73/0x200
Aug 13 21:26:34 lolek kernel:  ? tcp_v4_do_rcv+0x73/0x200
Aug 13 21:26:34 lolek kernel:  __release_sock+0x6b/0x110
Aug 13 21:26:34 lolek kernel:  release_sock+0x35/0xa0
Aug 13 21:26:34 lolek kernel:  inet_shutdown+0x86/0x100
Aug 13 21:26:34 lolek kernel:  SyS_shutdown+0x84/0x90
Aug 13 21:26:34 lolek kernel:  do_syscall_64+0x7f/0x190
Aug 13 21:26:34 lolek kernel:  entry_SYSCALL64_slow_path+0x25/0x25
Aug 13 21:26:34 lolek kernel: RIP: 0033:0x7f4856c38b57
Aug 13 21:26:34 lolek kernel: RSP: 002b:00007fffe1110558 EFLAGS:
00000202 ORIG_RAX: 0000000000000030
Aug 13 21:26:34 lolek kernel: RAX: ffffffffffffffda RBX:
00007fffe11105e0 RCX: 00007f4856c38b57
Aug 13 21:26:34 lolek kernel: RDX: 00000000ffffffff RSI:
0000000000000002 RDI: 0000000000000007
Aug 13 21:26:34 lolek kernel: RBP: 00000000006671f8 R08:
000000000157edc0 R09: 0000000000000000
Aug 13 21:26:34 lolek kernel: R10: 000000000158e130 R11:
0000000000000202 R12: 000000000044afb0
Aug 13 21:26:34 lolek kernel: R13: 00000000006607dc R14:
00000000006615e0 R15: 00007fffe11105a0
Aug 13 21:26:34 lolek kernel: Code: 89 e6 e8 85 2b a3 ff 85 c0 75 bc e9
89 fd ff ff 0f 0b 49 8b 57 18 4c 89 e1 89 c6 48 c7 c7 00 1c 9c b8 48 83
e2 fe e8 69 cf af ff <0f> 0b 49 8b 47 10 4c 3b 78 38 75 16 49 39 c5 75
85 0f 0b 0f 0b
Aug 13 21:26:34 lolek kernel: RIP:
rt_spin_lock_slowlock_locked+0x2cf/0x300 RSP: ffff90d7022dfbe8
Aug 13 21:26:34 lolek kernel: ---[ end trace 0000000000000002 ]---

Jacek
