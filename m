From: Mart van de Wege <mvdwege@gmail.com>
Subject: kernel BUG at kernel/locking/rtmutex.c:1059
Date: Wed, 30 Aug 2017 23:25:53 +0200
Message-ID: <86val4928u.fsf@gaheris.avalon.lan>
Mime-Version: 1.0
Content-Type: text/plain
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:50678 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750980AbdH3V0J (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 30 Aug 2017 17:26:09 -0400
Received: from hector (localhost [127.0.0.1])
        by hector.avalon.lan (Postfix) with ESMTP id 7DCE866002
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Aug 2017 23:26:06 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

As of v4.11.12-rt8 my laptop runs into trouble booting up, throwing a
kernel BUG when starting up bluetooth. Bisecting *seems* to lead back to
commit 6fb87cb1181786dc88432c6c6093a02a897e5789, 'Add the hotplug rework
including all its side stories'.

The issue persists up to v4.11.12-rt10

Stacktrace:

Aug 29 17:28:04 localhost kernel: [   46.483810] ------------[ cut here ]------------
Aug 29 17:28:04 localhost kernel: [   46.483812] kernel BUG at kernel/locking/rtmutex.c:1059!
Aug 29 17:28:04 localhost kernel: [   46.483816] invalid opcode: 0000 [#1] PREEMPT SMP
Aug 29 17:28:04 localhost kernel: [   46.483817] Modules linked in: cmac bnep msr fuse intel_rapl intel_powerclamp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel uvcvideo videobuf2_vmalloc videobuf2_memops video
buf2_v4l2 videobuf2_core videodev pcbc media aesni_intel btusb joydev evdev aes_x86_64 btrtl crypto_simd glue_helper serio_raw cryptd intel_cstate intel_uncore hci_uart intel_rapl_perf btbcm efi_pstore arc4 snd_hda_codec_hdmi snd_hda_code
c_realtek snd_hda_codec_generic btqca btintel iwlmvm snd_hda_intel mac80211 snd_hda_codec pcspkr snd_hda_core iwlwifi i915 snd_hwdep snd_pcm_oss iTCO_wdt sg efivars iTCO_vendor_support rtsx_pci_ms memstick wmi bluetooth crc16 drm_kms_help
er snd_mixer_oss snd_pcm snd_timer mei_me snd cfg80211 drm soundcore mei rfkill i2c_algo_bit intel_lpss_acpi intel_lpss video battery
Aug 29 17:28:04 localhost kernel: [   46.483870]  ac acpi_pad button intel_pch_thermal tpm_crb shpchp binfmt_misc nls_ascii nls_cp437 vfat fat coretemp ecryptfs cbc encrypted_keys parport_pc ppdev lp parport loop dm_crypt dm_mod sunrpc ef
ivarfs ip_tables x_tables autofs4 btrfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath linear md_mod sr_mod cdrom sd_mod mmc_block rtsx_pci_sdmmc mmc_c
ore ahci libahci xhci_pci xhci_hcd libata rtsx_pci r8169 crc32c_intel psmouse mfd_core mii i2c_i801 scsi_mod usbcore thermal i2c_hid hid
Aug 29 17:28:04 localhost kernel: [   46.483945] CPU: 3 PID: 227 Comm: kworker/u9:0 Not tainted 4.11.12-rt8+ #6
Aug 29 17:28:04 localhost kernel: [   46.483947] Hardware name: Notebook                         W94_95_97JU/W94_95_97JU, BIOS 5.11 10/21/2015
Aug 29 17:28:04 localhost kernel: [   46.483988] Workqueue: hci0 hci_rx_work [bluetooth]
Aug 29 17:28:04 localhost kernel: [   46.483990] task: ffff935b9a506000 task.stack: ffff9edcc3398000
Aug 29 17:28:04 localhost kernel: [   46.483996] RIP: 0010:rt_spin_lock_slowlock_locked+0x26e/0x2d0
Aug 29 17:28:04 localhost kernel: [   46.483998] RSP: 0018:ffff9edcc339bb20 EFLAGS: 00010046
Aug 29 17:28:04 localhost kernel: [   46.484000] RAX: ffff935b9a506000 RBX: ffffffffc0b13268 RCX: 0000000000000001
Aug 29 17:28:04 localhost kernel: [   46.484002] RDX: 0000000000000000 RSI: ffff935b9a506000 RDI: ffffffffc0b13268
Aug 29 17:28:04 localhost kernel: [   46.484003] RBP: 0000000000000246 R08: ffff935b9a506000 R09: ffffffffc0b13280
Aug 29 17:28:04 localhost kernel: [   46.484004] R10: ffff935b9a506001 R11: 0000000000000001 R12: ffff935b9a506000
Aug 29 17:28:04 localhost kernel: [   46.484005] R13: ffff9edcc339bb68 R14: 0000000000000246 R15: ffff935b8f0de800
Aug 29 17:28:04 localhost kernel: [   46.484008] FS:  0000000000000000(0000) GS:ffff935bb3d80000(0000) knlGS:0000000000000000
Aug 29 17:28:04 localhost kernel: [   46.484009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 29 17:28:04 localhost kernel: [   46.484011] CR2: 0000009b9614e800 CR3: 0000000418c0e000 CR4: 00000000003406e0
Aug 29 17:28:04 localhost kernel: [   46.484012] Call Trace:
Aug 29 17:28:04 localhost kernel: [   46.484019]  ? __slab_alloc.isra.76+0x72/0xb0
Aug 29 17:28:04 localhost kernel: [   46.484023]  ? rt_spin_lock_slowlock+0x50/0x80
Aug 29 17:28:04 localhost kernel: [   46.484029]  ? __kmalloc_reserve.isra.35+0x2e/0x80
Aug 29 17:28:04 localhost kernel: [   46.484056]  ? hci_send_to_channel+0x2c/0xe0 [bluetooth]
Aug 29 17:28:04 localhost kernel: [   46.484080]  ? hci_send_monitor_ctrl_event+0x17a/0x1b0 [bluetooth]
Aug 29 17:28:04 localhost kernel: [   46.484108]  ? mgmt_send_event+0x104/0x110 [bluetooth]
Aug 29 17:28:04 localhost kernel: [   46.484131]  ? mgmt_set_class_of_dev_complete+0xb6/0x150 [bluetooth]
Aug 29 17:28:04 localhost kernel: [   46.484152]  ? hci_cmd_complete_evt+0x15c5/0x2f40 [bluetooth]
Aug 29 17:28:04 localhost kernel: [   46.484172]  ? hci_event_packet+0x13b2/0x2cd0 [bluetooth]
Aug 29 17:28:04 localhost kernel: [   46.484178]  ? cpuacct_charge+0x5f/0x80
Aug 29 17:28:04 localhost kernel: [   46.484181]  ? unpin_current_cpu+0x37/0x90
Aug 29 17:28:04 localhost kernel: [   46.484187]  ? migrate_enable+0x230/0x380
Aug 29 17:28:04 localhost kernel: [   46.484206]  ? hci_rx_work+0x192/0x370 [bluetooth]
Aug 29 17:28:04 localhost kernel: [   46.484222]  ? hci_rx_work+0x192/0x370 [bluetooth]
Aug 29 17:28:04 localhost kernel: [   46.484226]  ? process_one_work+0x174/0x480
Aug 29 17:28:04 localhost kernel: [   46.484230]  ? worker_thread+0x4a/0x4d0
Aug 29 17:28:04 localhost kernel: [   46.484233]  ? process_one_work+0x480/0x480
Aug 29 17:28:04 localhost kernel: [   46.484237]  ? kthread+0x118/0x130
Aug 29 17:28:04 localhost kernel: [   46.484241]  ? kthread_create_on_node+0x70/0x70
Aug 29 17:28:04 localhost kernel: [   46.484244]  ? do_group_exit+0x47/0xc0
Aug 29 17:28:04 localhost kernel: [   46.484247]  ? ret_from_fork+0x25/0x30
Aug 29 17:28:04 localhost kernel: [   46.484250] Code: ff ff ff 7f 0f 85 4b fe ff ff 41 8b 74 24 08 85 f6 0f 85 3e fe ff ff 49 8b 04 24 f6 c4 02 0f 84 31 fe ff ff e9 27 fe ff ff 0f 0b <0f> 0b a9 ff ff ff 7f 0f 85 20 ff ff ff 41 8b 46 08 8
5 c0 0f 85 
Aug 29 17:28:04 localhost kernel: [   46.484286] RIP: rt_spin_lock_slowlock_locked+0x26e/0x2d0 RSP: ffff9edcc339bb20
Aug 29 17:28:04 localhost kernel: [   46.561380] ---[ end trace 0000000000000002 ]---

-- 
"We will need a longer wall when the revolution comes."
--- AJS, quoting an uncertain source.
