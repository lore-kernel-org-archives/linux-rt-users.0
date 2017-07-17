From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [BUG] drivers: staging: comedi: do not call blocking ops when
 !TASK_RUNNING; state=1
Date: Mon, 17 Jul 2017 17:02:45 +0100
Message-ID: <710d1c24-a4f2-c0c0-3d20-76e1f0e402a9@mev.co.uk>
References: <20170717144850.GA1696@piotrpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, sebastian.siewior@linutronix.de,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org
To: Piotr Gregor <piotrgregor@rsyncme.org>,
        linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717144850.GA1696@piotrpc>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 17/07/17 15:48, Piotr Gregor wrote:
> Calling blocking operations from wrong context.
> Kernel:
> 
> Linux piotrpc 4.4.70-rt83 #1 SMP PREEMPT RT Thu Jul 13 08:42:02 BST 2017 x86_64 GNU/Linux
> 
> [   80.542018] NOHZ: local_softirq_pending 80
> [  125.175471] ------------[ cut here ]------------
> [  125.175491] WARNING: CPU: 0 PID: 1497 at kernel/sched/core.c:7833 __might_sleep+0x9f/0xb0()
> [  125.175728] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffffc0575741>] comedi_read+0x1a1/0x610 [comedi]
> [  125.175735] Modules linked in: cpufreq_conservative cpufreq_powersave cpufreq_userspace cfg80211 nfsd auth_rpcgss oid_registry nfs_acl nfs lockd grace fscache sunrpc nls_ascii nls_cp437 vfat fat snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic intel_rapl joydev intel_powerclamp coretemp kvm drbg efi_pstore ansi_cprng irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd i915 serio_raw pcspkr efivars snd_hda_intel amplc_dio200_pci(C) amplc_dio200_common(C) snd_hda_codec iTCO_wdt comedi_8254(C) comedi_pci(C) iTCO_vendor_support comedi(C) snd_hda_core snd_hwdep snd_pcm drm_kms_helper snd_timer drm snd mei_me soundcore mei i2c_algo_bit shpchp eeepc_wmi asus_wmi sparse_keymap mxm_wmi battery hci_uart btb
 cm btqca btintel
> [  125.175824]  bluetooth
> [  125.175825]  wmi
> [  125.175826]  rfkill
> [  125.175827]  video
> [  125.175828]  intel_lpss_acpi
> [  125.175830]  intel_lpss
> [  125.175831]  evdev
> [  125.175832]  mfd_core
> [  125.175833]  acpi_als
> [  125.175834]  acpi_pad
> [  125.175835]  kfifo_buf
> [  125.175836]  button
> [  125.175838]  industrialio
> [  125.175839]  fuse
> [  125.175840]  parport_pc
> [  125.175841]  ppdev
> [  125.175842]  lp
> [  125.175843]  parport
> [  125.175844]  autofs4
> [  125.175845]  ext4
> [  125.175846]  crc16
> [  125.175847]  mbcache
> [  125.175848]  jbd2
> [  125.175849]  hid_generic
> [  125.175851]  usbhid
> [  125.175852]  sg
> [  125.175853]  sr_mod
> [  125.175854]  cdrom
> [  125.175855]  sd_mod
> [  125.175856]  crc32c_intel
> [  125.175857]  ahci
> [  125.175858]  libahci
> [  125.175859]  psmouse
> [  125.175860]  xhci_pci
> [  125.175861]  libata
> [  125.175862]  r8169
> [  125.175864]  i2c_i801
> [  125.175865]  mii
> [  125.175866]  xhci_hcd
> [  125.175867]  tg3
> [  125.175868]  ptp
> [  125.175869]  scsi_mod
> [  125.175870]  usbcore
> [  125.175871]  pps_core
> [  125.175872]  libphy
> [  125.175873]  usb_common
> [  125.175874]  fan
> [  125.175875]  thermal
> [  125.175876]  i2c_hid
> [  125.175877]  hid
> [  125.175878]  fjes
> 
> [  125.175926] CPU: 0 PID: 1497 Comm: txrx Tainted: G        WC      4.4.70-rt83 #1
> [  125.175928] Hardware name: NOVATECH LTD PC-XB04472/H110M-C, BIOS 3019 01/06/2017
> [  125.175935]  0000000000000000 ffff8802205b3cb0 ffffffff81387160 ffff8802205b3cf8
> [  125.175940]  0000000000000009 ffff8802205b3ce8 ffffffff81089766 ffffffffc057ca60
> [  125.175944]  00000000000002dc 0000000000000000 0000000000000001 0000000000000001
> [  125.175945] Call Trace:
> [  125.175955]  [<ffffffff81387160>] dump_stack+0x85/0xc5
> [  125.175963]  [<ffffffff81089766>] warn_slowpath_common+0x86/0xe0
> [  125.175971]  [<ffffffff8108980c>] warn_slowpath_fmt+0x4c/0x50
> [  125.175980]  [<ffffffff81185577>] ? trace_preempt_on+0x1a7/0x2b0
> [  125.175985]  [<ffffffff8168ca95>] ? schedule+0x55/0xe0
> [  125.175994]  [<ffffffffc0575741>] ? comedi_read+0x1a1/0x610 [comedi]
> [  125.176001]  [<ffffffffc0575741>] ? comedi_read+0x1a1/0x610 [comedi]
> [  125.176005]  [<ffffffff810b6d0f>] __might_sleep+0x9f/0xb0
> [  125.176012]  [<ffffffff811f54cb>] __might_fault+0x3b/0xb0
> [  125.176020]  [<ffffffffc057597f>] comedi_read+0x3df/0x610 [comedi]
> [  125.176034]  [<ffffffff810bebf0>] ? wake_up_process+0x20/0x20
> [  125.176044]  [<ffffffff812406d8>] __vfs_read+0x28/0xe0
> [  125.176053]  [<ffffffff812f1f06>] ? security_file_permission+0xa6/0xc0
> [  125.176060]  [<ffffffff81240c53>] ? rw_verify_area+0x53/0xf0
> [  125.176066]  [<ffffffff81240d79>] vfs_read+0x89/0x130
> [  125.176074]  [<ffffffff81241b79>] SyS_read+0x49/0xb0
> [  125.176084]  [<ffffffff81691876>] entry_SYSCALL_64_fastpath+0x16/0x7a
> [  125.176095] ---[ end trace 0000000000000003 ]---
> 
> 
> cheers,
> Piotr

Thanks for the bug report.  I think comedi_read() in 
"drivers/staging/comedi/comedi_fops.c" needs a call to 
set_current_state(TASK_RUNNING) just before the call to copy_to_user(...).

Similarly, comedi_write() needs a call to set_current_task(TASK_RUNNING) 
just before the call to copy_from_user(...), and another call to 
set_current_task(TASK_RUNNING) before the call to mutex_lock().

I'll work on a patch.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
