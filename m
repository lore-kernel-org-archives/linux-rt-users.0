From: Pratyush Patel <pratyushpatel.1995@gmail.com>
Subject: Re: kernel BUG at kernel/locking/rtmutex.c:1059
Date: Thu, 31 Aug 2017 16:29:54 +0530
Message-ID: <CAAnMKKa2LiYMCr0v32Wnd6TzdpnfZ0qKcecaFp6vpT8gR6+fvg@mail.gmail.com>
References: <86val4928u.fsf@gaheris.avalon.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-rt-users@vger.kernel.org
To: Mart van de Wege <mvdwege@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34622 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdHaK74 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 31 Aug 2017 06:59:56 -0400
Received: by mail-io0-f195.google.com with SMTP id k22so3609005iod.1
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Aug 2017 03:59:55 -0700 (PDT)
In-Reply-To: <86val4928u.fsf@gaheris.avalon.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I too faced a similar issue on startup when I ran v4.11.12-rt10 on a
virtual QEMU-KVM setup with Arch Linux. The kernel panics when the
Locking API test suite runs during the startup. I'm not sure if these
could be related.

Stacktrace:

[    0.000000]               recursive read-lock:             |
[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at kernel/locking/rtmutex.c:1059!
[    0.000000] invalid opcode: 0000 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.11.12-rt10 #2
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.9.1-0-gb3ef39f-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff82055500 task.stack: ffffffff82000000
[    0.000000] RIP: 0010:rt_spin_lock_slowlock_locked+0x28f/0x2c0
[    0.000000] RSP: 0000:ffffffff82003d50 EFLAGS: 00010046
[    0.000000] RAX: ffffffff82055500 RBX: ffffffff820f7d00 RCX: 0000000000000001
[    0.000000] RDX: 0000000000000000 RSI: ffffffff82055501 RDI: ffffffff820f7d18
[    0.000000] RBP: ffffffff82003d90 R08: 0000000000000000 R09: 0000000000000000
[    0.000000] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff82003da0
[    0.000000] R13: ffffffff82055500 R14: ffffffff813e5450 R15: 0000000000000286
[    0.000000] FS:  0000000000000000(0000) GS:ffff88003de00000(0000)
knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffff88000330f000 CR3: 0000000002050000 CR4: 00000000000006b0
[    0.000000] Call Trace:
[    0.000000]  ? AA_mutex+0x20/0x20
[    0.000000]  ? AA_mutex+0x20/0x20
[    0.000000]  rt_spin_lock_slowlock+0x58/0x80
[    0.000000]  __rt_spin_lock+0xe/0x10
[    0.000000]  rt_read_lock+0x3b/0x50
[    0.000000]  ? rlock_AA1+0x1c/0x20
[    0.000000]  rlock_AA1+0x1c/0x20
[    0.000000]  dotest+0x3c/0x694
[    0.000000]  locking_selftest+0x699/0xfd0
[    0.000000]  start_kernel+0x2d1/0x3ed
[    0.000000]  x86_64_start_reservations+0x2a/0x2c
[    0.000000]  x86_64_start_kernel+0x178/0x18b
[    0.000000]  start_cpu+0x14/0x14
[    0.000000]  ? start_cpu+0x14/0x14
[    0.000000] Code: 85 35 ff ff ff 48 c7 c2 78 b4 e5 81 be 5b 03 00
00 48 c7 c7 21 b0 e5 81 c6 05 c1 14 67 00 01 e8 48 f3 67 ff e9 11 ff
ff ff 0f 0b <0f> 0b 0f 0b 48 8b 43 50 48 3b 58 38 75 18 49 39 c4 0f 85
66 ff
[    0.000000] RIP: rt_spin_lock_slowlock_locked+0x28f/0x2c0 RSP:
ffffffff82003d50
[    0.000000] ---[ end trace 0000000000000001 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

- Pratyush

On Thu, Aug 31, 2017 at 2:55 AM, Mart van de Wege <mvdwege@gmail.com> wrote:
> Hi,
>
> As of v4.11.12-rt8 my laptop runs into trouble booting up, throwing a
> kernel BUG when starting up bluetooth. Bisecting *seems* to lead back to
> commit 6fb87cb1181786dc88432c6c6093a02a897e5789, 'Add the hotplug rework
> including all its side stories'.
>
> The issue persists up to v4.11.12-rt10
>
> Stacktrace:
>
> Aug 29 17:28:04 localhost kernel: [   46.483810] ------------[ cut here ]------------
> Aug 29 17:28:04 localhost kernel: [   46.483812] kernel BUG at kernel/locking/rtmutex.c:1059!
> Aug 29 17:28:04 localhost kernel: [   46.483816] invalid opcode: 0000 [#1] PREEMPT SMP
> Aug 29 17:28:04 localhost kernel: [   46.483817] Modules linked in: cmac bnep msr fuse intel_rapl intel_powerclamp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel uvcvideo videobuf2_vmalloc videobuf2_memops video
> buf2_v4l2 videobuf2_core videodev pcbc media aesni_intel btusb joydev evdev aes_x86_64 btrtl crypto_simd glue_helper serio_raw cryptd intel_cstate intel_uncore hci_uart intel_rapl_perf btbcm efi_pstore arc4 snd_hda_codec_hdmi snd_hda_code
> c_realtek snd_hda_codec_generic btqca btintel iwlmvm snd_hda_intel mac80211 snd_hda_codec pcspkr snd_hda_core iwlwifi i915 snd_hwdep snd_pcm_oss iTCO_wdt sg efivars iTCO_vendor_support rtsx_pci_ms memstick wmi bluetooth crc16 drm_kms_help
> er snd_mixer_oss snd_pcm snd_timer mei_me snd cfg80211 drm soundcore mei rfkill i2c_algo_bit intel_lpss_acpi intel_lpss video battery
> Aug 29 17:28:04 localhost kernel: [   46.483870]  ac acpi_pad button intel_pch_thermal tpm_crb shpchp binfmt_misc nls_ascii nls_cp437 vfat fat coretemp ecryptfs cbc encrypted_keys parport_pc ppdev lp parport loop dm_crypt dm_mod sunrpc ef
> ivarfs ip_tables x_tables autofs4 btrfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath linear md_mod sr_mod cdrom sd_mod mmc_block rtsx_pci_sdmmc mmc_c
> ore ahci libahci xhci_pci xhci_hcd libata rtsx_pci r8169 crc32c_intel psmouse mfd_core mii i2c_i801 scsi_mod usbcore thermal i2c_hid hid
> Aug 29 17:28:04 localhost kernel: [   46.483945] CPU: 3 PID: 227 Comm: kworker/u9:0 Not tainted 4.11.12-rt8+ #6
> Aug 29 17:28:04 localhost kernel: [   46.483947] Hardware name: Notebook                         W94_95_97JU/W94_95_97JU, BIOS 5.11 10/21/2015
> Aug 29 17:28:04 localhost kernel: [   46.483988] Workqueue: hci0 hci_rx_work [bluetooth]
> Aug 29 17:28:04 localhost kernel: [   46.483990] task: ffff935b9a506000 task.stack: ffff9edcc3398000
> Aug 29 17:28:04 localhost kernel: [   46.483996] RIP: 0010:rt_spin_lock_slowlock_locked+0x26e/0x2d0
> Aug 29 17:28:04 localhost kernel: [   46.483998] RSP: 0018:ffff9edcc339bb20 EFLAGS: 00010046
> Aug 29 17:28:04 localhost kernel: [   46.484000] RAX: ffff935b9a506000 RBX: ffffffffc0b13268 RCX: 0000000000000001
> Aug 29 17:28:04 localhost kernel: [   46.484002] RDX: 0000000000000000 RSI: ffff935b9a506000 RDI: ffffffffc0b13268
> Aug 29 17:28:04 localhost kernel: [   46.484003] RBP: 0000000000000246 R08: ffff935b9a506000 R09: ffffffffc0b13280
> Aug 29 17:28:04 localhost kernel: [   46.484004] R10: ffff935b9a506001 R11: 0000000000000001 R12: ffff935b9a506000
> Aug 29 17:28:04 localhost kernel: [   46.484005] R13: ffff9edcc339bb68 R14: 0000000000000246 R15: ffff935b8f0de800
> Aug 29 17:28:04 localhost kernel: [   46.484008] FS:  0000000000000000(0000) GS:ffff935bb3d80000(0000) knlGS:0000000000000000
> Aug 29 17:28:04 localhost kernel: [   46.484009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Aug 29 17:28:04 localhost kernel: [   46.484011] CR2: 0000009b9614e800 CR3: 0000000418c0e000 CR4: 00000000003406e0
> Aug 29 17:28:04 localhost kernel: [   46.484012] Call Trace:
> Aug 29 17:28:04 localhost kernel: [   46.484019]  ? __slab_alloc.isra.76+0x72/0xb0
> Aug 29 17:28:04 localhost kernel: [   46.484023]  ? rt_spin_lock_slowlock+0x50/0x80
> Aug 29 17:28:04 localhost kernel: [   46.484029]  ? __kmalloc_reserve.isra.35+0x2e/0x80
> Aug 29 17:28:04 localhost kernel: [   46.484056]  ? hci_send_to_channel+0x2c/0xe0 [bluetooth]
> Aug 29 17:28:04 localhost kernel: [   46.484080]  ? hci_send_monitor_ctrl_event+0x17a/0x1b0 [bluetooth]
> Aug 29 17:28:04 localhost kernel: [   46.484108]  ? mgmt_send_event+0x104/0x110 [bluetooth]
> Aug 29 17:28:04 localhost kernel: [   46.484131]  ? mgmt_set_class_of_dev_complete+0xb6/0x150 [bluetooth]
> Aug 29 17:28:04 localhost kernel: [   46.484152]  ? hci_cmd_complete_evt+0x15c5/0x2f40 [bluetooth]
> Aug 29 17:28:04 localhost kernel: [   46.484172]  ? hci_event_packet+0x13b2/0x2cd0 [bluetooth]
> Aug 29 17:28:04 localhost kernel: [   46.484178]  ? cpuacct_charge+0x5f/0x80
> Aug 29 17:28:04 localhost kernel: [   46.484181]  ? unpin_current_cpu+0x37/0x90
> Aug 29 17:28:04 localhost kernel: [   46.484187]  ? migrate_enable+0x230/0x380
> Aug 29 17:28:04 localhost kernel: [   46.484206]  ? hci_rx_work+0x192/0x370 [bluetooth]
> Aug 29 17:28:04 localhost kernel: [   46.484222]  ? hci_rx_work+0x192/0x370 [bluetooth]
> Aug 29 17:28:04 localhost kernel: [   46.484226]  ? process_one_work+0x174/0x480
> Aug 29 17:28:04 localhost kernel: [   46.484230]  ? worker_thread+0x4a/0x4d0
> Aug 29 17:28:04 localhost kernel: [   46.484233]  ? process_one_work+0x480/0x480
> Aug 29 17:28:04 localhost kernel: [   46.484237]  ? kthread+0x118/0x130
> Aug 29 17:28:04 localhost kernel: [   46.484241]  ? kthread_create_on_node+0x70/0x70
> Aug 29 17:28:04 localhost kernel: [   46.484244]  ? do_group_exit+0x47/0xc0
> Aug 29 17:28:04 localhost kernel: [   46.484247]  ? ret_from_fork+0x25/0x30
> Aug 29 17:28:04 localhost kernel: [   46.484250] Code: ff ff ff 7f 0f 85 4b fe ff ff 41 8b 74 24 08 85 f6 0f 85 3e fe ff ff 49 8b 04 24 f6 c4 02 0f 84 31 fe ff ff e9 27 fe ff ff 0f 0b <0f> 0b a9 ff ff ff 7f 0f 85 20 ff ff ff 41 8b 46 08 8
> 5 c0 0f 85
> Aug 29 17:28:04 localhost kernel: [   46.484286] RIP: rt_spin_lock_slowlock_locked+0x26e/0x2d0 RSP: ffff9edcc339bb20
> Aug 29 17:28:04 localhost kernel: [   46.561380] ---[ end trace 0000000000000002 ]---
>
> --
> "We will need a longer wall when the revolution comes."
> --- AJS, quoting an uncertain source.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
