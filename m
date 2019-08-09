Return-Path: <SRS0=ngSI=WF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C295AC433FF
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Aug 2019 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFC3208C4
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Aug 2019 15:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436647AbfHIPpY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:45:24 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:47084 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436626AbfHIPpX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Aug 2019 11:45:23 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:244:b080:7446:96cf:df6:1525])
        by smtp6-g21.free.fr (Postfix) with ESMTP id D4F2178031A
        for <linux-rt-users@vger.kernel.org>; Fri,  9 Aug 2019 17:45:13 +0200 (CEST)
To:     linux-rt-users@vger.kernel.org
From:   Yann COLLETTE <ycollette.nospam@free.fr>
Subject: Kernel 5.0.21rt16 hangs
Message-ID: <f410b429-db86-f81c-7c67-f563fa808b62@free.fr>
Date:   Fri, 9 Aug 2019 17:45:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr-classic
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,


I am using kernel-rt 5.0.21rt16 on fedora 30.

I use this kernel for audio.

After a while, this kernel hangs.

Here the related messge I found in /var/log/messages:


Aug  9 17:16:35 localhost kernel: BUG: scheduling while atomic: 
Xorg/1087/0x00000003
Aug  9 17:16:35 localhost kernel: Modules linked in: snd_hrtimer 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc ccm nf_conntrack_netbios_ns 
nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat 
nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat 
nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink 
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter 
ip_tables sunrpc vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops 
videobuf2_v4l2 videobuf2_common snd_usb_audio videodev snd_usbmidi_lib 
joydev media snd_rawmidi snd_hda_codec_realtek snd_hda_codec_generic 
edac_mce_amd ledtrig_audio pktcdvd snd_hda_codec_hdmi kvm_amd arc4 kvm 
irqbypass rtl8188ee snd_hda_intel snd_hda_codec rtl_pci crct10dif_pclmul 
rtlwifi snd_hda_core crc32_pclmul snd_hwdep ghash_clmulni_intel mac80211
Aug  9 17:16:35 localhost kernel: snd_seq hp_wmi snd_seq_device 
sp5100_tco sparse_keymap cfg80211 snd_pcm rfkill snd_timer wmi_bmof 
i2c_piix4 snd pcc_cpufreq soundcore ccp k10temp fam15h_power 
acpi_cpufreq pcspkr amdgpu chash amd_iommu_v2 gpu_sched crc32c_intel 
radeon i2c_algo_bit drm_kms_helper ttm drm r8169 wmi uas usb_storage
Aug  9 17:16:35 localhost kernel: Preemption disabled at:
Aug  9 17:16:35 localhost kernel: [<ffffffff8c67239e>] 
reservation_object_add_shared_fence+0x3e/0x1b0
Aug  9 17:16:35 localhost kernel: CPU: 3 PID: 1087 Comm: Xorg Not 
tainted 5.0.21-rt16.fc30.x86_64 #1
Aug  9 17:16:35 localhost kernel: Hardware name: HP 450-a121nf/2B29, 
BIOS A0.11 01/15/2016
Aug  9 17:16:35 localhost kernel: Call Trace:
Aug  9 17:16:35 localhost kernel: dump_stack+0x5c/0x80
Aug  9 17:16:35 localhost kernel: ? 
reservation_object_add_shared_fence+0x3e/0x1b0
Aug  9 17:16:35 localhost kernel: __schedule_bug.cold+0x44/0x51
Aug  9 17:16:35 localhost kernel: __schedule+0x5c6/0x6f0
Aug  9 17:16:35 localhost kernel: schedule+0x43/0xd0
Aug  9 17:16:35 localhost kernel: rt_spin_lock_slowlock_locked+0x114/0x2b0
Aug  9 17:16:35 localhost kernel: rt_spin_lock_slowlock+0x51/0x80
Aug  9 17:16:35 localhost kernel: __wake_up_common_lock+0x61/0xb0
Aug  9 17:16:35 localhost kernel: radeon_fence_is_signaled+0x74/0x90 
[radeon]
Aug  9 17:16:35 localhost kernel: 
reservation_object_add_shared_fence+0x97/0x1b0
Aug  9 17:16:35 localhost kernel: radeon_vm_bo_update+0x409/0x640 [radeon]
Aug  9 17:16:35 localhost kernel: radeon_gem_va_ioctl+0x41c/0x500 [radeon]
Aug  9 17:16:35 localhost kernel: ? 
radeon_gem_get_tiling_ioctl+0x120/0x120 [radeon]
Aug  9 17:16:35 localhost kernel: drm_ioctl_kernel+0xa7/0xf0 [drm]
Aug  9 17:16:35 localhost kernel: drm_ioctl+0x208/0x390 [drm]
Aug  9 17:16:35 localhost kernel: ? 
radeon_gem_get_tiling_ioctl+0x120/0x120 [radeon]
Aug  9 17:16:35 localhost kernel: ? unpin_current_cpu+0x3a/0x80
Aug  9 17:16:35 localhost kernel: ? migrate_enable+0x235/0x400
Aug  9 17:16:35 localhost kernel: ? _raw_spin_unlock_irqrestore+0x1f/0x60
Aug  9 17:16:35 localhost kernel: radeon_drm_ioctl+0x49/0x80 [radeon]
Aug  9 17:16:35 localhost kernel: do_vfs_ioctl+0x40c/0x670
Aug  9 17:16:35 localhost kernel: ksys_ioctl+0x5e/0x90
Aug  9 17:16:35 localhost kernel: ? switch_fpu_return+0x2d/0x160
Aug  9 17:16:35 localhost kernel: __x64_sys_ioctl+0x16/0x20
Aug  9 17:16:35 localhost kernel: do_syscall_64+0x5b/0x180
Aug  9 17:16:35 localhost kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug  9 17:16:35 localhost kernel: RIP: 0033:0x7f987e69e1fb
Aug  9 17:16:35 localhost kernel: Code: 0f 1e fa 48 8b 05 8d dc 0c 00 64 
c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 
b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d dc 0c 00 
f7 d8 64 89 01 48
Aug  9 17:16:35 localhost kernel: RSP: 002b:00007ffdef71c448 EFLAGS: 
00003246 ORIG_RAX: 0000000000000010
Aug  9 17:16:35 localhost kernel: RAX: ffffffffffffffda RBX: 
00007ffdef71c4a0 RCX: 00007f987e69e1fb
Aug  9 17:16:35 localhost kernel: RDX: 00007ffdef71c4a0 RSI: 
00000000c018646b RDI: 0000000000000012
Aug  9 17:16:35 localhost kernel: RBP: 00000000c018646b R08: 
000055b81a8a09e0 R09: 0000000000000000
Aug  9 17:16:35 localhost kernel: R10: 000055b81b4e14a0 R11: 
0000000000003246 R12: 0000000000004000
Aug  9 17:16:35 localhost kernel: R13: 0000000000000012 R14: 
00000000000f0000 R15: 000055b81b93a4f0
Aug  9 17:16:35 localhost kernel: WARNING: CPU: 0 PID: 1087 at 
kernel/sched/core.c:7303 migrate_enable+0x2e7/0x400
Aug  9 17:16:35 localhost kernel: Modules linked in: snd_hrtimer 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc ccm nf_conntrack_netbios_ns 
nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat 
nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat 
nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink 
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter 
ip_tables sunrpc vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops 
videobuf2_v4l2 videobuf2_common snd_usb_audio videodev snd_usbmidi_lib 
joydev media snd_rawmidi snd_hda_codec_realtek snd_hda_codec_generic 
edac_mce_amd ledtrig_audio pktcdvd snd_hda_codec_hdmi kvm_amd arc4 kvm 
irqbypass rtl8188ee snd_hda_intel snd_hda_codec rtl_pci crct10dif_pclmul 
rtlwifi snd_hda_core crc32_pclmul snd_hwdep ghash_clmulni_intel mac80211
Aug  9 17:16:35 localhost kernel: snd_seq hp_wmi snd_seq_device 
sp5100_tco sparse_keymap cfg80211 snd_pcm rfkill snd_timer wmi_bmof 
i2c_piix4 snd pcc_cpufreq soundcore ccp k10temp fam15h_power 
acpi_cpufreq pcspkr amdgpu chash amd_iommu_v2 gpu_sched crc32c_intel 
radeon i2c_algo_bit drm_kms_helper ttm drm r8169 wmi uas usb_storage
Aug  9 17:16:35 localhost kernel: CPU: 0 PID: 1087 Comm: Xorg Tainted: 
G        W         5.0.21-rt16.fc30.x86_64 #1
Aug  9 17:16:35 localhost kernel: Hardware name: HP 450-a121nf/2B29, 
BIOS A0.11 01/15/2016
Aug  9 17:16:35 localhost kernel: RIP: 0010:migrate_enable+0x2e7/0x400
Aug  9 17:16:35 localhost kernel: Code: fe ff ff e8 df 16 ef ff e9 7b fe 
ff ff 48 8b 00 a9 00 00 04 00 0f 84 53 ff ff ff e8 c7 16 ef ff e9 49 ff 
ff ff e8 69 aa 0b 00 <0f> 0b e9 64 fd ff ff f6 43 2e 20 48 c7 c0 a8 fe 
35 8d 4c 89 e2 bf
Aug  9 17:16:35 localhost kernel: RSP: 0018:ffffb71f026bfa10 EFLAGS: 
00010246
Aug  9 17:16:35 localhost kernel: RAX: 0000000000000000 RBX: 
ffff940011860000 RCX: ffff94003680ae08
Aug  9 17:16:35 localhost kernel: RDX: 0000000000000000 RSI: 
0000000000100000 RDI: ffff94003680ae00
Aug  9 17:16:35 localhost kernel: RBP: 0000000000000003 R08: 
ffffffff8ce11380 R09: 0000000000000001
Aug  9 17:16:35 localhost kernel: R10: 0000000000000000 R11: 
0000000000000001 R12: 0000000000000000
Aug  9 17:16:35 localhost kernel: R13: 0000000000000000 R14: 
0000000000000000 R15: ffff93ff054c8e40
Aug  9 17:16:35 localhost kernel: FS:  00007f987e233a80(0000) 
GS:ffff940036e00000(0000) knlGS:0000000000000000
Aug  9 17:16:35 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Aug  9 17:16:35 localhost kernel: CR2: 00007f9d912c3578 CR3: 
000000021e77a000 CR4: 00000000000406f0
Aug  9 17:16:35 localhost kernel: Call Trace:
Aug  9 17:16:35 localhost kernel: ? rt_mutex_futex_unlock+0xa3/0xb0
Aug  9 17:16:35 localhost kernel: rt_spin_unlock+0x23/0x40
Aug  9 17:16:35 localhost kernel: __wake_up_common_lock+0x82/0xb0
Aug  9 17:16:35 localhost kernel: radeon_fence_is_signaled+0x74/0x90 
[radeon]
Aug  9 17:16:35 localhost kernel: 
reservation_object_add_shared_fence+0x97/0x1b0
Aug  9 17:16:35 localhost kernel: radeon_vm_bo_update+0x409/0x640 [radeon]
Aug  9 17:16:35 localhost kernel: radeon_gem_va_ioctl+0x41c/0x500 [radeon]
Aug  9 17:16:35 localhost kernel: ? 
radeon_gem_get_tiling_ioctl+0x120/0x120 [radeon]
Aug  9 17:16:35 localhost kernel: drm_ioctl_kernel+0xa7/0xf0 [drm]
Aug  9 17:16:35 localhost kernel: drm_ioctl+0x208/0x390 [drm]
Aug  9 17:16:35 localhost kernel: ? 
radeon_gem_get_tiling_ioctl+0x120/0x120 [radeon]
Aug  9 17:16:35 localhost kernel: ? unpin_current_cpu+0x3a/0x80
Aug  9 17:16:35 localhost kernel: ? migrate_enable+0x235/0x400
Aug  9 17:16:35 localhost kernel: ? _raw_spin_unlock_irqrestore+0x1f/0x60
Aug  9 17:16:35 localhost kernel: radeon_drm_ioctl+0x49/0x80 [radeon]
Aug  9 17:16:35 localhost kernel: do_vfs_ioctl+0x40c/0x670
Aug  9 17:16:35 localhost kernel: ksys_ioctl+0x5e/0x90
Aug  9 17:16:35 localhost kernel: ? switch_fpu_return+0x2d/0x160
Aug  9 17:16:35 localhost kernel: __x64_sys_ioctl+0x16/0x20
Aug  9 17:16:35 localhost kernel: do_syscall_64+0x5b/0x180
Aug  9 17:16:35 localhost kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug  9 17:16:35 localhost kernel: RIP: 0033:0x7f987e69e1fb
Aug  9 17:16:35 localhost kernel: Code: 0f 1e fa 48 8b 05 8d dc 0c 00 64 
c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 
b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d dc 0c 00 
f7 d8 64 89 01 48
Aug  9 17:16:35 localhost kernel: RSP: 002b:00007ffdef71c448 EFLAGS: 
00003246 ORIG_RAX: 0000000000000010
Aug  9 17:16:35 localhost kernel: RAX: ffffffffffffffda RBX: 
00007ffdef71c4a0 RCX: 00007f987e69e1fb
Aug  9 17:16:35 localhost kernel: RDX: 00007ffdef71c4a0 RSI: 
00000000c018646b RDI: 0000000000000012
Aug  9 17:16:35 localhost kernel: RBP: 00000000c018646b R08: 
000055b81a8a09e0 R09: 0000000000000000
Aug  9 17:16:35 localhost kernel: R10: 000055b81b4e14a0 R11: 
0000000000003246 R12: 0000000000004000
Aug  9 17:16:35 localhost kernel: R13: 0000000000000012 R14: 
00000000000f0000 R15: 000055b81b93a4f0
Aug  9 17:16:35 localhost kernel: ---[ end trace 0000000000000002 ]---
Aug  9 17:16:35 localhost kernel: WARNING: CPU: 0 PID: 1087 at 
kernel/sched/core.c:7307 migrate_enable+0x92/0x400
Aug  9 17:16:35 localhost kernel: Modules linked in: snd_hrtimer 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc ccm nf_conntrack_netbios_ns 
nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat 
nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat 
nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink 
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter 
ip_tables sunrpc vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops 
videobuf2_v4l2 videobuf2_common snd_usb_audio videodev snd_usbmidi_lib 
joydev media snd_rawmidi snd_hda_codec_realtek snd_hda_codec_generic 
edac_mce_amd ledtrig_audio pktcdvd snd_hda_codec_hdmi kvm_amd arc4 kvm 
irqbypass rtl8188ee snd_hda_intel snd_hda_codec rtl_pci crct10dif_pclmul 
rtlwifi snd_hda_core crc32_pclmul snd_hwdep ghash_clmulni_intel mac80211
Aug  9 17:16:35 localhost kernel: snd_seq hp_wmi snd_seq_device 
sp5100_tco sparse_keymap cfg80211 snd_pcm rfkill snd_timer wmi_bmof 
i2c_piix4 snd pcc_cpufreq soundcore ccp k10temp fam15h_power 
acpi_cpufreq pcspkr amdgpu chash amd_iommu_v2 gpu_sched crc32c_intel 
radeon i2c_algo_bit drm_kms_helper ttm drm r8169 wmi uas usb_storage
Aug  9 17:16:35 localhost kernel: CPU: 0 PID: 1087 Comm: Xorg Tainted: 
G        W         5.0.21-rt16.fc30.x86_64 #1
Aug  9 17:16:35 localhost kernel: Hardware name: HP 450-a121nf/2B29, 
BIOS A0.11 01/15/2016
Aug  9 17:16:35 localhost kernel: RIP: 0010:migrate_enable+0x92/0x400
Aug  9 17:16:35 localhost kernel: Code: 00 00 eb 07 83 ab c4 03 00 00 01 
48 8b 44 24 20 65 48 33 04 25 28 00 00 00 0f 85 72 03 00 00 48 83 c4 28 
5b 5d 41 5c 41 5d c3 <0f> 0b bf 01 00 00 00 e8 02 d9 ff ff 4c 8d a3 b0 
03 00 00 48 8d 74
Aug  9 17:16:35 localhost kernel: RSP: 0018:ffffb71f026bfa10 EFLAGS: 
00010246
Aug  9 17:16:35 localhost kernel: RAX: 0000000000000000 RBX: 
ffff940011860000 RCX: ffff94003680ae08
Aug  9 17:16:35 localhost kernel: RDX: 0000000000000000 RSI: 
0000000000100000 RDI: ffff94003680ae00
Aug  9 17:16:35 localhost kernel: RBP: 0000000000000003 R08: 
ffffffff8ce11380 R09: 0000000000000001
Aug  9 17:16:35 localhost kernel: R10: 0000000000000000 R11: 
0000000000000001 R12: 0000000000000000
Aug  9 17:16:35 localhost kernel: R13: 0000000000000000 R14: 
0000000000000000 R15: ffff93ff054c8e40
Aug  9 17:16:35 localhost kernel: FS:  00007f987e233a80(0000) 
GS:ffff940036e00000(0000) knlGS:0000000000000000
Aug  9 17:16:35 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Aug  9 17:16:35 localhost kernel: CR2: 00007f9d912c3578 CR3: 
000000021e77a000 CR4: 00000000000406f0
Aug  9 17:16:35 localhost kernel: Call Trace:
Aug  9 17:16:35 localhost kernel: ? rt_mutex_futex_unlock+0xa3/0xb0
Aug  9 17:16:35 localhost kernel: rt_spin_unlock+0x23/0x40
Aug  9 17:16:35 localhost kernel: __wake_up_common_lock+0x82/0xb0
Aug  9 17:16:35 localhost kernel: radeon_fence_is_signaled+0x74/0x90 
[radeon]
Aug  9 17:16:35 localhost kernel: 
reservation_object_add_shared_fence+0x97/0x1b0
Aug  9 17:16:35 localhost kernel: radeon_vm_bo_update+0x409/0x640 [radeon]
Aug  9 17:16:35 localhost kernel: radeon_gem_va_ioctl+0x41c/0x500 [radeon]
Aug  9 17:16:35 localhost kernel: ? 
radeon_gem_get_tiling_ioctl+0x120/0x120 [radeon]
Aug  9 17:16:35 localhost kernel: drm_ioctl_kernel+0xa7/0xf0 [drm]
Aug  9 17:16:35 localhost kernel: drm_ioctl+0x208/0x390 [drm]
Aug  9 17:16:35 localhost kernel: ? 
radeon_gem_get_tiling_ioctl+0x120/0x120 [radeon]
Aug  9 17:16:35 localhost kernel: ? unpin_current_cpu+0x3a/0x80
Aug  9 17:16:35 localhost kernel: ? migrate_enable+0x235/0x400
Aug  9 17:16:35 localhost kernel: ? _raw_spin_unlock_irqrestore+0x1f/0x60
Aug  9 17:16:35 localhost kernel: radeon_drm_ioctl+0x49/0x80 [radeon]
Aug  9 17:16:35 localhost kernel: do_vfs_ioctl+0x40c/0x670
Aug  9 17:16:35 localhost kernel: ksys_ioctl+0x5e/0x90
Aug  9 17:16:35 localhost kernel: ? switch_fpu_return+0x2d/0x160
Aug  9 17:16:35 localhost kernel: __x64_sys_ioctl+0x16/0x20
Aug  9 17:16:35 localhost kernel: do_syscall_64+0x5b/0x180
Aug  9 17:16:35 localhost kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug  9 17:16:35 localhost kernel: RIP: 0033:0x7f987e69e1fb
Aug  9 17:16:35 localhost kernel: Code: 0f 1e fa 48 8b 05 8d dc 0c 00 64 
c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 
b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d dc 0c 00 
f7 d8 64 89 01 48
Aug  9 17:16:35 localhost kernel: RSP: 002b:00007ffdef71c448 EFLAGS: 
00003246 ORIG_RAX: 0000000000000010
Aug  9 17:16:35 localhost kernel: RAX: ffffffffffffffda RBX: 
00007ffdef71c4a0 RCX: 00007f987e69e1fb
Aug  9 17:16:35 localhost kernel: RDX: 00007ffdef71c4a0 RSI: 
00000000c018646b RDI: 0000000000000012
Aug  9 17:16:35 localhost kernel: RBP: 00000000c018646b R08: 
000055b81a8a09e0 R09: 0000000000000000
Aug  9 17:16:35 localhost kernel: R10: 000055b81b4e14a0 R11: 
0000000000003246 R12: 0000000000004000
Aug  9 17:16:35 localhost kernel: R13: 0000000000000012 R14: 
00000000000f0000 R15: 000055b81b93a4f0
Aug  9 17:16:35 localhost kernel: ---[ end trace 0000000000000003 ]---
Aug  9 17:16:35 localhost kernel: WARNING: CPU: 0 PID: 1087 at 
kernel/cpu.c:330 unpin_current_cpu+0x60/0x80
Aug  9 17:16:35 localhost kernel: Modules linked in: snd_hrtimer 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc ccm nf_conntrack_netbios_ns 
nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat 
nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat 
nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink 
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter 
ip_tables sunrpc vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops 
videobuf2_v4l2 videobuf2_common snd_usb_audio videodev snd_usbmidi_lib 
joydev media snd_rawmidi snd_hda_codec_realtek snd_hda_codec_generic 
edac_mce_amd ledtrig_audio pktcdvd snd_hda_codec_hdmi kvm_amd arc4 kvm 
irqbypass rtl8188ee snd_hda_intel snd_hda_codec rtl_pci crct10dif_pclmul 
rtlwifi snd_hda_core crc32_pclmul snd_hwdep ghash_clmulni_intel mac80211
Aug  9 17:16:35 localhost kernel: snd_seq hp_wmi snd_seq_device 
sp5100_tco sparse_keymap cfg80211 snd_pcm rfkill snd_timer wmi_bmof 
i2c_piix4 snd pcc_cpufreq soundcore ccp k10temp fam15h_power 
acpi_cpufreq pcspkr amdgpu chash amd_iommu_v2 gpu_sched crc32c_intel 
radeon i2c_algo_bit drm_kms_helper ttm drm r8169 wmi uas usb_storage
Aug  9 17:16:35 localhost kernel: CPU: 0 PID: 1087 Comm: Xorg Tainted: 
G        W         5.0.21-rt16.fc30.x86_64 #1
Aug  9 17:16:35 localhost kernel: Hardware name: HP 450-a121nf/2B29, 
BIOS A0.11 01/15/2016
Aug  9 17:16:35 localhost kernel: RIP: 0010:unpin_current_cpu+0x60/0x80
Aug  9 17:16:35 localhost kernel: Code: 56 c6 3e 00 41 39 c5 75 21 65 48 
8b 04 25 c0 5c 01 00 c7 80 c0 03 00 00 ff ff ff ff 48 89 ef 5b 5d 41 5c 
41 5d e9 50 9a 05 00 <0f> 0b 49 63 84 24 c0 03 00 00 48 03 1c c5 20 d8 
17 8d 48 89 dd eb
Aug  9 17:16:35 localhost kernel: RSP: 0018:ffffb71f026bf9e8 EFLAGS: 
00010286
Aug  9 17:16:35 localhost kernel: RAX: 0000000000000000 RBX: 
0000000000016720 RCX: 0000000000000000
Aug  9 17:16:35 localhost kernel: RDX: ffffffff8ce11380 RSI: 
ffffffff8d0ea19d RDI: ffffffff8d0c4c14
Aug  9 17:16:35 localhost kernel: RBP: ffff940036e16720 R08: 
ffffffff8ce11380 R09: 0000000000000000
Aug  9 17:16:35 localhost kernel: R10: 0000000000000000 R11: 
0000000000000001 R12: ffff940011860000
Aug  9 17:16:35 localhost kernel: R13: 00000000ffffffff R14: 
0000000000000000 R15: ffff93ff054c8e40
Aug  9 17:16:35 localhost kernel: FS:  00007f987e233a80(0000) 
GS:ffff940036e00000(0000) knlGS:0000000000000000
Aug  9 17:16:35 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Aug  9 17:16:35 localhost kernel: CR2: 00007f9d912c3578 CR3: 
000000021e77a000 CR4: 00000000000406f0
Aug  9 17:16:35 localhost kernel: Call Trace:
Aug  9 17:16:35 localhost kernel: migrate_enable+0x1fc/0x400
Aug  9 17:16:35 localhost kernel: ? rt_mutex_futex_unlock+0xa3/0xb0
Aug  9 17:16:35 localhost kernel: rt_spin_unlock+0x23/0x40
Aug  9 17:16:35 localhost kernel: __wake_up_common_lock+0x82/0xb0
Aug  9 17:16:35 localhost kernel: radeon_fence_is_signaled+0x74/0x90 
[radeon]
Aug  9 17:16:35 localhost kernel: 
reservation_object_add_shared_fence+0x97/0x1b0
Aug  9 17:16:35 localhost kernel: radeon_vm_bo_update+0x409/0x640 [radeon]
Aug  9 17:16:35 localhost kernel: radeon_gem_va_ioctl+0x41c/0x500 [radeon]
Aug  9 17:16:35 localhost kernel: ? 
radeon_gem_get_tiling_ioctl+0x120/0x120 [radeon]
Aug  9 17:16:35 localhost kernel: drm_ioctl_kernel+0xa7/0xf0 [drm]
Aug  9 17:16:35 localhost kernel: drm_ioctl+0x208/0x390 [drm]
Aug  9 17:16:35 localhost kernel: ? 
radeon_gem_get_tiling_ioctl+0x120/0x120 [radeon]
Aug  9 17:16:35 localhost kernel: ? unpin_current_cpu+0x3a/0x80
Aug  9 17:16:35 localhost kernel: ? migrate_enable+0x235/0x400
Aug  9 17:16:35 localhost kernel: ? _raw_spin_unlock_irqrestore+0x1f/0x60
Aug  9 17:16:35 localhost kernel: radeon_drm_ioctl+0x49/0x80 [radeon]
Aug  9 17:16:35 localhost kernel: do_vfs_ioctl+0x40c/0x670
Aug  9 17:16:35 localhost kernel: ksys_ioctl+0x5e/0x90
Aug  9 17:16:35 localhost kernel: ? switch_fpu_return+0x2d/0x160
Aug  9 17:16:35 localhost kernel: __x64_sys_ioctl+0x16/0x20
Aug  9 17:16:35 localhost kernel: do_syscall_64+0x5b/0x180
Aug  9 17:16:35 localhost kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug  9 17:16:35 localhost kernel: RIP: 0033:0x7f987e69e1fb
Aug  9 17:16:35 localhost kernel: Code: 0f 1e fa 48 8b 05 8d dc 0c 00 64 
c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 
b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d dc 0c 00 
f7 d8 64 89 01 48
Aug  9 17:16:35 localhost kernel: RSP: 002b:00007ffdef71c448 EFLAGS: 
00003246 ORIG_RAX: 0000000000000010
Aug  9 17:16:35 localhost kernel: RAX: ffffffffffffffda RBX: 
00007ffdef71c4a0 RCX: 00007f987e69e1fb
Aug  9 17:16:35 localhost kernel: RDX: 00007ffdef71c4a0 RSI: 
00000000c018646b RDI: 0000000000000012
Aug  9 17:16:35 localhost kernel: RBP: 00000000c018646b R08: 
000055b81a8a09e0 R09: 0000000000000000
Aug  9 17:16:35 localhost kernel: R10: 000055b81b4e14a0 R11: 
0000000000003246 R12: 0000000000004000
Aug  9 17:16:35 localhost kernel: R13: 0000000000000012 R14: 
00000000000f0000 R15: 000055b81b93a4f0
Aug  9 17:16:35 localhost kernel: ---[ end trace 0000000000000004 ]---
Aug  9 17:16:35 localhost kernel: BUG: unable to handle kernel paging 
request at 0000000000016748
Aug  9 17:16:35 localhost kernel: #PF error: [WRITE]
Aug  9 17:16:35 localhost kernel: PGD 0 P4D 0
Aug  9 17:16:35 localhost kernel: Oops: 0002 [#1] PREEMPT SMP NOPTI
Aug  9 17:16:35 localhost kernel: CPU: 0 PID: 1087 Comm: Xorg Tainted: 
G        W         5.0.21-rt16.fc30.x86_64 #1
Aug  9 17:16:35 localhost kernel: Hardware name: HP 450-a121nf/2B29, 
BIOS A0.11 01/15/2016
Aug  9 17:16:35 localhost kernel: RIP: 0010:__read_rt_unlock+0x5/0x40
Aug  9 17:16:35 localhost kernel: Code: 18 8d 4a 01 89 d0 f0 0f b1 4f 28 
39 c2 75 06 b8 01 00 00 00 c3 89 c2 eb e4 31 c0 c3 66 0f 1f 84 00 00 00 
00 00 0f 1f 44 00 00 <f0> ff 4f 28 74 01 c3 55 48 89 fd e8 4b c5 86 00 
48 8b 7d 18 48 83
Aug  9 17:16:35 localhost kernel: RSP: 0018:ffffb71f026bfa08 EFLAGS: 
00010202
Aug  9 17:16:35 localhost kernel: RAX: ffff940011860000 RBX: 
ffff940011860000 RCX: 0000000000000000
Aug  9 17:16:35 localhost kernel: RDX: ffffffff8ce11380 RSI: 
ffffffff8d0ea19d RDI: 0000000000016720
Aug  9 17:16:35 localhost kernel: RBP: ffff940036e1fbc0 R08: 
ffffffff8ce11380 R09: 0000000000000000
Aug  9 17:16:35 localhost kernel: R10: 0000000000000000 R11: 
0000000000000001 R12: ffff9400118603b0
Aug  9 17:16:35 localhost kernel: R13: ffff940011860850 R14: 
0000000000000000 R15: ffff93ff054c8e40
Aug  9 17:16:35 localhost kernel: FS:  00007f987e233a80(0000) 
GS:ffff940036e00000(0000) knlGS:0000000000000000
Aug  9 17:16:35 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Aug  9 17:16:35 localhost kernel: CR2: 0000000000016748 CR3: 
000000021e77a000 CR4: 00000000000406f0
Aug  9 17:16:35 localhost kernel: Call Trace:
Aug  9 17:16:35 localhost kernel: migrate_enable+0x1fc/0x400
Aug  9 17:16:35 localhost kernel: ? rt_mutex_futex_unlock+0xa3/0xb0
Aug  9 17:16:35 localhost kernel: rt_spin_unlock+0x23/0x40
Aug  9 17:16:35 localhost kernel: __wake_up_common_lock+0x82/0xb0
Aug  9 17:16:35 localhost kernel: radeon_fence_is_signaled+0x74/0x90 
[radeon]
Aug  9 17:16:35 localhost kernel: 
reservation_object_add_shared_fence+0x97/0x1b0
Aug  9 17:16:35 localhost kernel: radeon_vm_bo_update+0x409/0x640 [radeon]
Aug  9 17:16:35 localhost kernel: radeon_gem_va_ioctl+0x41c/0x500 [radeon]
Aug  9 17:16:35 localhost kernel: ? 
radeon_gem_get_tiling_ioctl+0x120/0x120 [radeon]
Aug  9 17:16:35 localhost kernel: drm_ioctl_kernel+0xa7/0xf0 [drm]
Aug  9 17:16:35 localhost kernel: drm_ioctl+0x208/0x390 [drm]
Aug  9 17:16:35 localhost kernel: ? 
radeon_gem_get_tiling_ioctl+0x120/0x120 [radeon]
Aug  9 17:16:35 localhost kernel: ? unpin_current_cpu+0x3a/0x80
Aug  9 17:16:35 localhost kernel: ? migrate_enable+0x235/0x400
Aug  9 17:16:35 localhost kernel: ? _raw_spin_unlock_irqrestore+0x1f/0x60
Aug  9 17:16:35 localhost kernel: radeon_drm_ioctl+0x49/0x80 [radeon]
Aug  9 17:16:35 localhost kernel: do_vfs_ioctl+0x40c/0x670
Aug  9 17:16:35 localhost kernel: ksys_ioctl+0x5e/0x90
Aug  9 17:16:35 localhost kernel: ? switch_fpu_return+0x2d/0x160
Aug  9 17:16:35 localhost kernel: __x64_sys_ioctl+0x16/0x20
Aug  9 17:16:35 localhost kernel: do_syscall_64+0x5b/0x180
Aug  9 17:16:35 localhost kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug  9 17:16:35 localhost kernel: RIP: 0033:0x7f987e69e1fb
Aug  9 17:16:35 localhost kernel: Code: 0f 1e fa 48 8b 05 8d dc 0c 00 64 
c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 
b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d dc 0c 00 
f7 d8 64 89 01 48
Aug  9 17:16:35 localhost kernel: RSP: 002b:00007ffdef71c448 EFLAGS: 
00003246 ORIG_RAX: 0000000000000010
Aug  9 17:16:35 localhost kernel: RAX: ffffffffffffffda RBX: 
00007ffdef71c4a0 RCX: 00007f987e69e1fb
Aug  9 17:16:35 localhost kernel: RDX: 00007ffdef71c4a0 RSI: 
00000000c018646b RDI: 0000000000000012
Aug  9 17:16:35 localhost kernel: RBP: 00000000c018646b R08: 
000055b81a8a09e0 R09: 0000000000000000
Aug  9 17:16:35 localhost kernel: R10: 000055b81b4e14a0 R11: 
0000000000003246 R12: 0000000000004000
Aug  9 17:16:35 localhost kernel: R13: 0000000000000012 R14: 
00000000000f0000 R15: 000055b81b93a4f0
Aug  9 17:16:35 localhost kernel: Modules linked in: snd_hrtimer 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc ccm nf_conntrack_netbios_ns 
nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat 
nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat 
nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink 
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter 
ip_tables sunrpc vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops 
videobuf2_v4l2 videobuf2_common snd_usb_audio videodev snd_usbmidi_lib 
joydev media snd_rawmidi snd_hda_codec_realtek snd_hda_codec_generic 
edac_mce_amd ledtrig_audio pktcdvd snd_hda_codec_hdmi kvm_amd arc4 kvm 
irqbypass rtl8188ee snd_hda_intel snd_hda_codec rtl_pci crct10dif_pclmul 
rtlwifi snd_hda_core crc32_pclmul snd_hwdep ghash_clmulni_intel mac80211
Aug  9 17:16:35 localhost kernel: snd_seq hp_wmi snd_seq_device 
sp5100_tco sparse_keymap cfg80211 snd_pcm rfkill snd_timer wmi_bmof 
i2c_piix4 snd pcc_cpufreq soundcore ccp k10temp fam15h_power 
acpi_cpufreq pcspkr amdgpu chash amd_iommu_v2 gpu_sched crc32c_intel 
radeon i2c_algo_bit drm_kms_helper ttm drm r8169 wmi uas usb_storage
Aug  9 17:16:35 localhost kernel: CR2: 0000000000016748
Aug  9 17:16:35 localhost kernel: ---[ end trace 0000000000000005 ]---
Aug  9 17:16:35 localhost kernel: RIP: 0010:__read_rt_unlock+0x5/0x40
Aug  9 17:16:35 localhost kernel: Code: 18 8d 4a 01 89 d0 f0 0f b1 4f 28 
39 c2 75 06 b8 01 00 00 00 c3 89 c2 eb e4 31 c0 c3 66 0f 1f 84 00 00 00 
00 00 0f 1f 44 00 00 <f0> ff 4f 28 74 01 c3 55 48 89 fd e8 4b c5 86 00 
48 8b 7d 18 48 83
Aug  9 17:16:35 localhost kernel: RSP: 0018:ffffb71f026bfa08 EFLAGS: 
00010202
Aug  9 17:16:35 localhost kernel: RAX: ffff940011860000 RBX: 
ffff940011860000 RCX: 0000000000000000
Aug  9 17:16:35 localhost kernel: RDX: ffffffff8ce11380 RSI: 
ffffffff8d0ea19d RDI: 0000000000016720
Aug  9 17:16:35 localhost kernel: RBP: ffff940036e1fbc0 R08: 
ffffffff8ce11380 R09: 0000000000000000
Aug  9 17:16:35 localhost kernel: R10: 0000000000000000 R11: 
0000000000000001 R12: ffff9400118603b0
Aug  9 17:16:35 localhost kernel: R13: ffff940011860850 R14: 
0000000000000000 R15: ffff93ff054c8e40
Aug  9 17:16:35 localhost kernel: FS:  00007f987e233a80(0000) 
GS:ffff940036e00000(0000) knlGS:0000000000000000
Aug  9 17:16:35 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Aug  9 17:16:35 localhost kernel: CR2: 0000000000016748 CR3: 
000000021e77a000 CR4: 00000000000406f0
Aug  9 17:16:35 localhost kernel: note: Xorg[1087] exited with 
preempt_count 1
Aug  9 17:16:35 localhost kernel: WARNING: CPU: 0 PID: 1087 at 
kernel/sched/core.c:7269 migrate_disable+0x1de/0x220
Aug  9 17:16:35 localhost kernel: Modules linked in: snd_hrtimer 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc ccm nf_conntrack_netbios_ns 
nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat 
nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat 
nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink 
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter 
ip_tables sunrpc vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops 
videobuf2_v4l2 videobuf2_common snd_usb_audio videodev snd_usbmidi_lib 
joydev media snd_rawmidi snd_hda_codec_realtek snd_hda_codec_generic 
edac_mce_amd ledtrig_audio pktcdvd snd_hda_codec_hdmi kvm_amd arc4 kvm 
irqbypass rtl8188ee snd_hda_intel snd_hda_codec rtl_pci crct10dif_pclmul 
rtlwifi snd_hda_core crc32_pclmul snd_hwdep ghash_clmulni_intel mac80211
Aug  9 17:16:35 localhost kernel: snd_seq hp_wmi snd_seq_device 
sp5100_tco sparse_keymap cfg80211 snd_pcm rfkill snd_timer wmi_bmof 
i2c_piix4 snd pcc_cpufreq soundcore ccp k10temp fam15h_power 
acpi_cpufreq pcspkr amdgpu chash amd_iommu_v2 gpu_sched crc32c_intel 
radeon i2c_algo_bit drm_kms_helper ttm drm r8169 wmi uas usb_storage
Aug  9 17:16:35 localhost kernel: CPU: 0 PID: 1087 Comm: Xorg Tainted: 
G      D W         5.0.21-rt16.fc30.x86_64 #1
Aug  9 17:16:35 localhost kernel: Hardware name: HP 450-a121nf/2B29, 
BIOS A0.11 01/15/2016
Aug  9 17:16:35 localhost kernel: RIP: 0010:migrate_disable+0x1de/0x220
Aug  9 17:16:35 localhost kernel: Code: 0f 8e 2e ff ff ff 8b 4b 44 48 c7 
c2 c0 fb 01 00 48 03 14 cd 20 d8 17 8d 48 83 aa a0 08 00 00 01 e9 0f ff 
ff ff e8 62 b2 0b 00 <0f> 0b e9 66 fe ff ff 83 bb a0 03 00 00 01 0f 8e 
f6 fe ff ff 8b 4b
Aug  9 17:16:35 localhost kernel: RSP: 0018:ffffb71f026bfe60 EFLAGS: 
00010246
Aug  9 17:16:35 localhost kernel: RAX: 0000000000100000 RBX: 
ffff940011860000 RCX: ffff94003680ae08
Aug  9 17:16:35 localhost kernel: RDX: 0000000000100000 RSI: 
0000000000100000 RDI: ffff94003680ae00
Aug  9 17:16:35 localhost kernel: RBP: ffff94001186a188 R08: 
ffff940012fbd0c0 R09: ffffffff8d25c140
Aug  9 17:16:35 localhost kernel: R10: ffffb71f026bfe28 R11: 
0000000000000001 R12: 0000000000000009
Aug  9 17:16:35 localhost kernel: R13: ffff940011860000 R14: 
ffff940011860000 R15: 0000000000000046
Aug  9 17:16:35 localhost kernel: FS:  00007f987e233a80(0000) 
GS:ffff940036e00000(0000) knlGS:0000000000000000
Aug  9 17:16:35 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Aug  9 17:16:35 localhost kernel: CR2: 0000000000016748 CR3: 
000000021e77a000 CR4: 00000000000406f0
Aug  9 17:16:35 localhost kernel: Call Trace:
Aug  9 17:16:35 localhost kernel: rt_spin_lock+0x1f/0x40
Aug  9 17:16:35 localhost kernel: acct_collect+0x1b3/0x1d0
Aug  9 17:16:35 localhost kernel: do_exit+0x126/0xc40
Aug  9 17:16:35 localhost kernel: ? ksys_ioctl+0x5e/0x90
Aug  9 17:16:35 localhost kernel: ? switch_fpu_return+0x2d/0x160
Aug  9 17:16:35 localhost kernel: rewind_stack_do_exit+0x17/0x20
Aug  9 17:16:35 localhost kernel: ---[ end trace 0000000000000006 ]---


I while ago, I sent a similar message.

I don't know if this bug is related to the kernel of if this is a mesa 
problem.

I've got a radeon graphic card.

The reference of the graphic card from lspci:

VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] 
Mullins [Radeon R4/R5 Graphics]

Best regards,


YC

