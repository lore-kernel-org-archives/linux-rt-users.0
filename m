Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E2C47096
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Jun 2021 10:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10A1613EF
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Jun 2021 10:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFFKZb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 6 Jun 2021 06:25:31 -0400
Received: from mail.monom.org ([188.138.9.77]:57126 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhFFKZa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 6 Jun 2021 06:25:30 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 0291F500517;
        Sun,  6 Jun 2021 12:23:39 +0200 (CEST)
Received: from localhost (unknown [94.31.103.148])
        by mail.monom.org (Postfix) with ESMTPSA id 8B96750026A;
        Sun,  6 Jun 2021 12:23:38 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.270-rt222
Date:   Sun, 06 Jun 2021 10:21:23 -0000
Message-ID: <162297488316.3841.17048300458348543179@beryllium>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.270-rt222 stable release.

This is just an update to the latest stable release. No RT
specific changes.

Known issue:

  - locktorture reports a might_sleep warning for spin_locks test

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 1b6673e62b15959b144c31d41d83644e814f3113

Or to build 4.4.270-rt222 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.270.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.270-rt222.patch.xz

Enjoy!
Daniel

Changes from v4.4.267-rt221:
---

Alexander Aring (8):
      net: ieee802154: stop dump llsec keys for monitors
      net: ieee802154: stop dump llsec devs for monitors
      net: ieee802154: forbid monitor for add llsec dev
      net: ieee802154: stop dump llsec devkeys for monitors
      net: ieee802154: forbid monitor for add llsec devkey
      net: ieee802154: stop dump llsec seclevels for monitors
      net: ieee802154: forbid monitor for add llsec seclevel
      fs: dlm: fix debugfs dump

Alexander Shiyan (1):
      ASoC: fsl_esai: Fix TDM slot setup for I2S mode

Alexey Kardashevskiy (1):
      powerpc/iommu: Annotate nested lock for lockdep

Amey Telawane (1):
      tracing: Use strlcpy() instead of strcpy() in __trace_find_cmdline()

Andy Shevchenko (5):
      dmaengine: dw: Make it dependent to HAS_IOMEM
      usb: gadget: pch_udc: Revert d3cb25a12138 completely
      usb: gadget: pch_udc: Replace cpu_to_le32() by lower_32_bits()
      usb: gadget: pch_udc: Check if driver is present before calling ->setup()
      usb: gadget: pch_udc: Check for DMA mapping error

Anirudh Rayabharam (4):
      net: hso: fix null-ptr-deref during tty device unregistration
      usb: gadget: dummy_hcd: fix gpf in gadget_setup
      net: stmicro: handle clk_prepare() failure during init
      video: hgafb: correctly handle card detect failure during probe

Archie Pusaka (2):
      Bluetooth: verify AMP hci_chan before amp_destroy
      Bluetooth: Set CONF_NOT_COMPLETE as l2cap_chan default

Arnd Bergmann (8):
      ARM: keystone: fix integer overflow warning
      Input: i8042 - fix Pegatron C15B ID entry
      scsi: fcoe: Fix mismatched fcoe_wwn_from_mac declaration
      media: dvb-usb-remote: fix dvb_usb_nec_rc_key_to_event type mismatch
      x86/msr: Fix wr/rdmsr_safe_regs_on_cpu() prototypes
      kgdb: fix gcc-11 warning on indentation
      usb: sl811-hcd: improve misleading indentation
      isdn: capi: fix mismatched prototypes

Atul Gopinathan (1):
      cdrom: gdrom: deallocate struct gdrom_unit fields in remove_gdrom

Bart Van Assche (1):
      scsi: libfc: Fix a format specifier

Bill Wendling (1):
      arm64/vdso: Discard .note.gnu.property sections in vDSO

Chaitanya Kulkarni (1):
      scsi: target: pscsi: Fix warning in pscsi_complete_cmd()

Chris Chiu (1):
      USB: Add reset-resume quirk for WD19's Realtek Hub

Christoph Hellwig (1):
      md: factor out a mddev_find_locked helper from mddev_find

Christophe JAILLET (4):
      net: davicom: Fix regulator not turned off on failed probe
      usb: fotg210-hcd: Fix an error message
      xhci: Do not use GFP_KERNEL in (potentially) atomic context
      openrisc: Fix a memory leak

Christophe Leroy (1):
      powerpc/52xx: Fix an invalid ASM expression ('addi' used instead of 'add')

Chunfeng Yun (1):
      usb: core: hub: fix race condition about TRSMRCY of resume

Claudio Imbrenda (1):
      KVM: s390: split kvm_s390_real_to_abs

Colin Ian King (11):
      clk: socfpga: arria10: Fix memory leak of socfpga_clk on error return
      drm/radeon: fix copy of uninitialized variable back to userspace
      memory: gpmc: fix out of bounds read and dereference on gpmc_cs[]
      staging: rtl8192u: Fix potential infinite loop
      usb: gadget: r8a66597: Add missing null check on return from platform_get_resource
      media: vivid: fix assignment of dev->fbuf_out_flags
      media: m88rs6000t: avoid potential out-of-bounds reads on arrays
      mt7601u: fix always true expression
      net: thunderx: Fix unintentional sign extension issue
      net: davinci_emac: Fix incorrect masking of tx and rx error channel
      iio: tsl2583: Fix division by a zero lux_val

Dan Carpenter (4):
      ipw2x00: potential buffer overflow in libipw_wx_set_encodeext()
      HSI: core: fix resource leaks in hsi_add_client_from_dt()
      nfc: pn533: prevent potential memory corruption
      kfifo: fix ternary sign extension bugs

Daniel Niv (1):
      media: media/saa7164: fix saa7164_encoder_register() memory leak bugs

Daniel Wagner (2):
      Merge tag 'v4.4.270' into v4.4-rt
      Linux 4.4.270-rt222

David Ward (2):
      ASoC: rt286: Generalize support for ALC3263 codec
      ASoC: rt286: Make RT286_SET_GPIO_* readable and writable

Davide Caratti (1):
      openvswitch: fix stack OOB read while fragmenting IPv4 packets

Dean Anderson (1):
      usb: gadget/function/f_fs string table fix for multiple languages

Dmitry Baryshkov (1):
      PCI: Release OF node in pci_scan_device()'s error path

DooHyun Hwang (1):
      mmc: core: Do a power cycle when the CMD11 fails

Du Cheng (1):
      ethernet: sun: niu: fix missing checks of niu_pci_eeprom_read()

Emmanuel Grumbach (1):
      mac80211: clear the beacon's CRC after channel switch

Eric Caruso (1):
      timerfd: Reject ALARM timerfds without CAP_WAKE_ALARM

Eric Dumazet (4):
      ip6_vti: proper dev_{hold|put} in ndo_[un]init methods
      sit: proper dev_{hold|put} in ndo_[un]init methods
      ip6_tunnel: sit: proper dev_{hold|put} in ndo_[un]init methods
      ipv6: remove extra dev_hold() for fallback tunnels

Fabian Vogt (7):
      Input: nspire-keypad - enable interrupts only when opened
      fotg210-udc: Fix DMA on EP0 for length > max packet size
      fotg210-udc: Fix EP0 IN requests bigger than two packets
      fotg210-udc: Remove a dubious condition leading to fotg210_done
      fotg210-udc: Mask GRP2 interrupts we don't handle
      fotg210-udc: Don't DMA more than the buffer can take
      fotg210-udc: Complete OUT requests on short packets

Feilong Lin (1):
      ACPI / hotplug / PCI: Fix reference count leak in enable_slot()

Fengnan Chang (1):
      ext4: fix error code in ext4_commit_super

Fredrik Strupe (1):
      ARM: 9071/1: uprobes: Don't hook on thumb instructions

Giovanni Cabiddu (1):
      crypto: qat - fix error path in adf_isr_resource_alloc()

Greg Kroah-Hartman (17):
      Linux 4.4.268
      kobject_uevent: remove warning in init_uevent_argv()
      Linux 4.4.269
      Revert "ALSA: sb8: add a check for request_region"
      Revert "video: hgafb: fix potential NULL pointer dereference"
      Revert "net: stmicro: fix a missing check of clk_prepare"
      Revert "leds: lp5523: fix a missing check of return value of lp55xx_read"
      Revert "hwmon: (lm80) fix a missing check of bus read in lm80 probe"
      Revert "video: imsttfb: fix potential NULL pointer dereferences"
      Revert "ecryptfs: replace BUG_ON with error handling code"
      Revert "gdrom: fix a memory leak bug"
      cdrom: gdrom: initialize global variable at init time
      Revert "rtlwifi: fix a potential NULL pointer dereference"
      Revert "qlcnic: Avoid potential NULL pointer dereference"
      Revert "niu: fix missing checks of niu_pci_eeprom_read"
      net: rtlwifi: properly check for alloc_workqueue() failure
      Linux 4.4.270

Guchun Chen (1):
      drm/amdgpu: fix NULL pointer dereference

Guenter Roeck (1):
      pcnet32: Use pci_resource_len to validate PCI resource

Gustavo A. R. Silva (3):
      sctp: Fix out-of-bounds warning in sctp_process_asconf_param()
      wl3501_cs: Fix out-of-bounds warnings in wl3501_send_pkt
      wl3501_cs: Fix out-of-bounds warnings in wl3501_mgmt_join

Hans Verkuil (2):
      media: gspca/sq905.c: fix uninitialized variable
      media: gscpa/stv06xx: fix memory leak

Hans de Goede (1):
      misc: lis3lv02d: Fix false-positive WARN on various HP models

Hoang Le (1):
      tipc: convert dest node's address to network order

Hui Wang (1):
      ALSA: hda: generic: change the DAC ctl name for LO+SPK or LO+HP

Igor Matheus Andrade Torrente (1):
      video: hgafb: fix potential NULL pointer dereference

James Smart (1):
      scsi: lpfc: Fix crash when a REG_RPI mailbox fails triggering a LOGO response

Jan Beulich (1):
      xen-pciback: reconfigure also from backend watch handler

Jason Xing (1):
      i40e: fix the panic when running bpf in xdpdrv mode

Jeffrey Mitchell (1):
      ecryptfs: fix kernel panic with null dev_name

Jia Zhou (1):
      ALSA: core: remove redundant spin_lock pair in snd_card_disconnect

Jia-Ju Bai (1):
      kernel: kexec_file: fix error return code of kexec_calculate_store_digests()

Jiri Kosina (1):
      iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()

Joe Thornber (2):
      dm persistent data: packed struct should have an aligned() attribute too
      dm space map common: fix division bug in sm_ll_find_free_block()

Joel Fernandes (1):
      tracing: Treat recording comm for idle task as a success

Johan Hovold (3):
      net: hso: fix NULL-deref on disconnect regression
      USB: cdc-acm: fix unprivileged TIOCCSERIAL
      tty: fix return value for unsupported ioctls

Johannes Berg (3):
      cfg80211: scan: drop entry from hidden_list on overflow
      mac80211: bail out if cipher schemes are invalid
      um: Mark all kernel symbols as local

John Millikin (1):
      x86/build: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)

John Paul Adrian Glaubitz (1):
      ia64: tools: remove duplicate definition of ia64_mf() on ia64

Jolly Shah (1):
      scsi: libsas: Reset num_scatter if libata marks qc as NODATA

Jonathan McDowell (1):
      net: stmmac: Set FIFO sizes for ipq806x

Josef Bacik (1):
      btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s

Kai-Heng Feng (1):
      USB: Add LPM quirk for Lenovo ThinkPad USB-C Dock Gen2 Ethernet

Kaixu Xia (1):
      cxgb4: Fix the -Wmisleading-indentation warning

Kees Cook (2):
      overflow.h: Add allocation size calculation helpers
      drm/radeon: Fix off-by-one power_state index heap overwrite

Krzysztof Kozlowski (2):
      ARM: dts: exynos: correct PMIC interrupt trigger level on SMDK5250
      ARM: dts: exynos: correct PMIC interrupt trigger level on Snow

Luiz Augusto von Dentz (1):
      Bluetooth: SMP: Fail if remote and local public keys are identical

Lukasz Luba (1):
      thermal/core/fair share: Lock the thermal zone while looping over instances

Lv Yunlong (5):
      ALSA: emu8000: Fix a use after free in snd_emu8000_create_mixer
      ALSA: sb: Fix two use after free in snd_sb_qsound_build
      crypto: qat - Fix a double free in adf_create_ring
      mwl8k: Fix a double Free in mwl8k_probe_hw
      net:nfc:digital: Fix a double free in digital_tg_recv_dep_req

Maciej W. Rozycki (4):
      FDDI: defxx: Bail out gracefully with unassigned PCI resource for CSR
      FDDI: defxx: Make MMIO the configuration default except for EISA
      vgacon: Record video mode changes with VT_RESIZEX
      vt: Fix character height handling with VT_RESIZEX

Mahesh Salgaonkar (1):
      powerpc/eeh: Fix EEH handling for hugepages in ioremap space.

Marijn Suijten (1):
      drm/msm/mdp5: Configure PP_SYNC_HEIGHT to double the vtotal

Mark Langsdorf (2):
      ACPI: custom_method: fix potential use-after-free issue
      ACPI: custom_method: fix a possible memory leak

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Correct thermal sensor allocation

Maxim Mikityanskiy (1):
      HID: plantronics: Workaround for double volume key presses

Maximilian Luz (1):
      usb: xhci: Increase timeout for HC halt

Miaohe Lin (1):
      ksm: fix potential missing rmap_item for stable_node

Michael Brown (1):
      xen-netback: Check for hotplug-status existence before watching

Michael Ellerman (1):
      powerpc/64s: Fix crashes when toggling entry flush barrier

Michael Walle (1):
      mtd: require write permissions for locking and badblock ioctls

Mihai Moldovan (1):
      kconfig: nconf: stop endless search loops

Mike Galbraith (1):
      x86/crash: Fix crash_setup_memmap_entries() out-of-bounds access

Miklos Szeredi (1):
      cuse: prevent clone

Mikulas Patocka (2):
      dm ioctl: fix out of bounds array access when no devices
      dm snapshot: fix crash with transient storage and zero chunk size

Muhammad Usama Anjum (1):
      media: em28xx: fix memory leak

Nathan Chancellor (2):
      x86/events/amd/iommu: Fix sysfs type mismatch
      powerpc/prom: Mark identical_pvr_fixup as __init

Nikola Livic (1):
      pNFS/flexfiles: fix incorrect size check in decode_nfs_fh()

Oleg Nesterov (1):
      ptrace: make ptrace() fail if the tracee changed its pid unexpectedly

Olga Kornievskaia (1):
      NFSv4.2 fix handling of sr_eof in SEEK's reply

Or Cohen (2):
      net/sctp: fix race condition in sctp_destroy_sock
      net/nfc: fix use-after-free llcp_sock_bind/connect

Pavel Machek (1):
      intel_th: Consistency and off-by-one fix

Pavel Skripkin (1):
      media: dvb-usb: fix memory leak in dvb_usb_adapter_init

Pawel Laszczak (1):
      usb: gadget: uvc: add bInterval checking for HS mode

Phil Elwell (1):
      usb: dwc2: Fix gadget DMA unmap direction

Phillip Lougher (1):
      squashfs: fix divide error in calculate_skip()

Phillip Potter (3):
      net: usb: ax88179_178a: initialize local variables before use
      fbdev: zero-fill colormap in fbcmap.c
      leds: lp5523: check return value of lp5xx_read and jump to cleanup code

Rafael J. Wysocki (1):
      PCI: PM: Do not read power state in pci_enable_device_flags()

Randy Dunlap (2):
      ia64: fix discontig.c section mismatches
      powerpc: iommu: fix build when neither PCI or IBMVIO is set

Rasmus Villemoes (1):
      compiler.h: enable builtin overflow checkers and add fallback code

Ronnie Sahlberg (1):
      cifs: fix memory leak in smb2_copychunk_range

Sean Young (1):
      media: ite-cir: check for receive overflow

Sergey Shtylyov (11):
      pata_arasan_cf: fix IRQ check
      pata_ipx4xx_cf: fix IRQ check
      sata_mv: add IRQ checks
      ata: libahci_platform: fix IRQ check
      scsi: jazz_esp: Add IRQ check
      scsi: sun3x_esp: Add IRQ check
      scsi: sni_53c710: Add IRQ check
      i2c: cadence: add IRQ check
      i2c: jz4780: add IRQ check
      i2c: sh7760: add IRQ check
      i2c: sh7760: fix IRQ error path

Seunghui Lee (1):
      mmc: core: Set read only for SD cards with permanent write protect bit

Stefano Garzarella (1):
      vsock/vmci: log once the failed queue pair allocation

Steven Rostedt (VMware) (3):
      ftrace: Handle commands when closing set_ftrace_filter file
      tracing: Map all PIDs to command lines
      tracing: Restructure trace_clock_global() to never block

Taehee Yoo (1):
      hsr: use netdev_err() instead of WARN_ONCE()

Takashi Iwai (7):
      ALSA: usb-audio: Add MIDI quirk for Vox ToneLab EX
      ALSA: hda/realtek: Re-order ALC882 Acer quirk table entries
      ALSA: hda/realtek: Re-order ALC882 Sony quirk table entries
      ALSA: hda/realtek: Re-order ALC269 Sony quirk table entries
      ALSA: hda/realtek: Remove redundant entry for ALC861 Haier/Uniwill devices
      ALSA: usb-audio: Add error checks for usb_driver_claim_interface() calls
      ALSA: usb-audio: Validate MS endpoint descriptors

Takashi Sakamoto (1):
      ALSA: bebob/oxfw: fix Kconfig entry for Mackie d.2 Pro

Tetsuo Handa (5):
      misc: vmw_vmci: explicitly initialize vmci_notify_bm_set_msg struct
      misc: vmw_vmci: explicitly initialize vmci_datagram payload
      ttyprintk: Add TTY hangup callback.
      Bluetooth: initialize skb_queue_head at l2cap_chan_create()
      tty: vt: always invoke vc->vc_sw->con_resize callback

Thomas Gleixner (1):
      KVM: x86: Cancel pvclock_gtod_work on module removal

Toke Høiland-Jørgensen (1):
      ath9k: Fix error check in ath9k_hw_read_revisions() for PCI devices

Tom Seewald (1):
      qlcnic: Add null check after calling netdev_alloc_skb

Tong Zhang (4):
      crypto: qat - don't release uninitialized resources
      ALSA: hdsp: don't disable if not enabled
      ALSA: hdspm: don't disable if not enabled
      ALSA: rme9652: don't disable if not enabled

Tong Zhu (1):
      neighbour: Disregard DEAD dst in neigh_update

Tony Ambardar (1):
      powerpc: fix EDEADLOCK redefinition error in uapi/asm/errno.h

Tony Lindgren (2):
      ARM: dts: Fix moving mmc devices with aliases for omap4 & 5
      ARM: dts: Fix swapped mmc order for omap3

Trond Myklebust (1):
      NFS: Deal correctly with attribute generation counter overflow

Tyrel Datwyler (1):
      powerpc/pseries: extract host bridge from pci_bus prior to bus removal

Vasily Gorbik (2):
      s390/entry: save the caller of psw_idle
      s390/disassembler: increase ebpf disasm buffer size

Vineet Gupta (1):
      ARC: entry: fix off-by-one error in syscall number validation

Wan Jiabing (1):
      cavium/liquidio: Fix duplicate argument

Wang Qing (1):
      arc: kernel: Return -EFAULT if copy_to_user() fails

Wei Yongjun (2):
      spi: dln2: Fix reference leak to master
      spi: omap-100k: Fix reference leak to master

Xie He (1):
      net: lapbether: Prevent racing when checking whether the netif is running

Xin Long (3):
      Revert "net/sctp: fix race condition in sctp_destroy_sock"
      sctp: delay auto_asconf init until binding the first addr
      sctp: fix a SCTP_MIB_CURRESTAB leak in sctp_sf_do_dupcook_b

Yang Yang (1):
      jffs2: check the validity of dstlen in jffs2_zlib_compress()

Yang Yingliang (5):
      phy: phy-twl4030-usb: Fix possible use-after-free in twl4030_usb_remove()
      power: supply: generic-adc-battery: fix possible use-after-free in gab_remove()
      power: supply: s3c_adc_battery: fix possible use-after-free in s3c_adc_bat_remove()
      media: i2c: adv7511-v4l2: fix possible use-after-free in adv7511_remove()
      media: omap4iss: return error code when omap4iss_get() failed

Yonghong Song (1):
      selftests: Set CC to clang in lib.mk if LLVM is set

Zhang Yi (2):
      ext4: correct error label in ext4_rename()
      ext4: fix check to prevent false positive report of incorrect used inodes

Zhao Heming (1):
      md: md_open returns -EBUSY when entering racing area

Zhen Lei (1):
      scsi: qla2xxx: Fix error return code in qla82xx_write_flash_dword()

karthik alapati (1):
      staging: wimax/i2400m: fix byte-order issue

lizhe (1):
      jffs2: Fix kasan slab-out-of-bounds problem
---
Makefile                                           |   2 +-
 arch/arc/kernel/entry.S                            |   4 +-
 arch/arc/kernel/signal.c                           |   4 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |   2 +-
 arch/arm/boot/dts/omap3.dtsi                       |   3 +
 arch/arm/boot/dts/omap4.dtsi                       |   5 +
 arch/arm/boot/dts/omap5.dtsi                       |   5 +
 arch/arm/mach-keystone/keystone.c                  |   4 +-
 arch/arm/probes/uprobes/core.c                     |   4 +-
 arch/arm64/kernel/vdso/vdso.lds.S                  |   8 +-
 arch/ia64/mm/discontig.c                           |   6 +-
 arch/openrisc/kernel/setup.c                       |   2 +
 arch/powerpc/Kconfig.debug                         |   1 +
 arch/powerpc/include/uapi/asm/errno.h              |   1 +
 arch/powerpc/kernel/eeh.c                          |  11 +-
 arch/powerpc/kernel/iommu.c                        |   4 +-
 arch/powerpc/kernel/prom.c                         |   2 +-
 arch/powerpc/lib/feature-fixups.c                  |  17 +-
 arch/powerpc/platforms/52xx/lite5200_sleep.S       |   2 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c         |   4 +-
 arch/s390/kernel/dis.c                             |   2 +-
 arch/s390/kernel/entry.S                           |   1 +
 arch/s390/kvm/gaccess.h                            |  23 +-
 arch/um/kernel/dyn.lds.S                           |   6 +
 arch/um/kernel/uml.lds.S                           |   6 +
 arch/x86/Makefile                                  |   1 +
 arch/x86/kernel/cpu/perf_event_amd_iommu.c         |   6 +-
 arch/x86/kernel/crash.c                            |   3 +-
 arch/x86/kvm/x86.c                                 |   1 +
 arch/x86/lib/msr-smp.c                             |   4 +-
 drivers/acpi/custom_method.c                       |   4 +-
 drivers/ata/libahci_platform.c                     |   4 +-
 drivers/ata/pata_arasan_cf.c                       |  15 +-
 drivers/ata/pata_ixp4xx_cf.c                       |   6 +-
 drivers/ata/sata_mv.c                              |   4 +
 drivers/cdrom/gdrom.c                              |  13 +-
 drivers/char/ttyprintk.c                           |  11 +
 drivers/clk/socfpga/clk-gate-a10.c                 |   1 +
 drivers/crypto/qat/qat_common/adf_transport.c      |   1 +
 drivers/crypto/qat/qat_dh895xcc/adf_isr.c          |  29 ++-
 drivers/crypto/qat/qat_dh895xccvf/adf_isr.c        |  17 +-
 drivers/dma/dw/Kconfig                             |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   2 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_cmd_encoder.c    |  10 +-
 drivers/gpu/drm/radeon/radeon_atombios.c           |   6 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |   1 +
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-plantronics.c                      |  60 ++++-
 drivers/hsi/hsi.c                                  |   3 +-
 drivers/hwmon/lm80.c                               |  11 +-
 drivers/hwtracing/intel_th/gth.c                   |   4 +-
 drivers/i2c/busses/i2c-cadence.c                   |   5 +-
 drivers/i2c/busses/i2c-jz4780.c                    |   5 +-
 drivers/i2c/busses/i2c-sh7760.c                    |   5 +-
 drivers/input/keyboard/nspire-keypad.c             |  56 +++--
 drivers/input/serio/i8042-x86ia64io.h              |   1 +
 drivers/isdn/capi/kcapi.c                          |   4 +-
 drivers/leds/leds-lp5523.c                         |   2 +-
 drivers/md/dm-ioctl.c                              |   2 +-
 drivers/md/dm-snap.c                               |   1 +
 drivers/md/dm-table.c                              |  10 +-
 drivers/md/md.c                                    |  35 +--
 drivers/md/persistent-data/dm-btree-internal.h     |   4 +-
 drivers/md/persistent-data/dm-space-map-common.c   |   2 +
 drivers/md/persistent-data/dm-space-map-common.h   |   8 +-
 drivers/media/i2c/adv7511-v4l2.c                   |   2 +-
 drivers/media/pci/saa7164/saa7164-encoder.c        |  20 +-
 drivers/media/platform/vivid/vivid-vid-out.c       |   2 +-
 drivers/media/rc/ite-cir.c                         |   8 +-
 drivers/media/tuners/m88rs6000t.c                  |   6 +-
 drivers/media/usb/dvb-usb/dvb-usb-init.c           |  20 +-
 drivers/media/usb/dvb-usb/dvb-usb.h                |   3 +-
 drivers/media/usb/em28xx/em28xx-dvb.c              |   1 +
 drivers/media/usb/gspca/gspca.c                    |   2 +
 drivers/media/usb/gspca/gspca.h                    |   1 +
 drivers/media/usb/gspca/sq905.c                    |   2 +-
 drivers/media/usb/gspca/stv06xx/stv06xx.c          |   9 +
 drivers/memory/omap-gpmc.c                         |   7 +-
 drivers/misc/kgdbts.c                              |  26 +-
 drivers/misc/lis3lv02d/lis3lv02d.c                 |  21 +-
 drivers/misc/vmw_vmci/vmci_doorbell.c              |   2 +-
 drivers/misc/vmw_vmci/vmci_guest.c                 |   2 +-
 drivers/mmc/core/core.c                            |   2 +-
 drivers/mmc/core/sd.c                              |   6 +
 drivers/mtd/mtdchar.c                              |   8 +-
 drivers/net/ethernet/amd/pcnet32.c                 |   5 +-
 drivers/net/ethernet/cavium/liquidio/cn66xx_regs.h |   2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c |   2 +-
 drivers/net/ethernet/davicom/dm9000.c              |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   6 +
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   3 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |   8 +-
 drivers/net/ethernet/sun/niu.c                     |  32 ++-
 drivers/net/ethernet/ti/davinci_emac.c             |   4 +-
 drivers/net/fddi/Kconfig                           |  15 +-
 drivers/net/fddi/defxx.c                           |  47 ++--
 drivers/net/usb/ax88179_178a.c                     |   4 +-
 drivers/net/usb/hso.c                              |  35 +--
 drivers/net/wan/lapbether.c                        |  32 ++-
 drivers/net/wimax/i2400m/op-rfkill.c               |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |   2 +-
 drivers/net/wireless/ath/ath9k/hw.c                |   2 +-
 drivers/net/wireless/ipw2x00/libipw_wx.c           |   6 +-
 drivers/net/wireless/iwlwifi/pcie/tx.c             |   7 +-
 drivers/net/wireless/mediatek/mt7601u/eeprom.c     |   2 +-
 drivers/net/wireless/mwl8k.c                       |   1 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |  19 +-
 drivers/net/wireless/wl3501.h                      |  47 ++--
 drivers/net/wireless/wl3501_cs.c                   |  54 ++--
 drivers/net/xen-netback/xenbus.c                   |  12 +-
 drivers/nfc/pn533.c                                |   3 +
 drivers/pci/hotplug/acpiphp_glue.c                 |   1 +
 drivers/pci/pci.c                                  |  16 +-
 drivers/pci/probe.c                                |   1 +
 drivers/phy/phy-twl4030-usb.c                      |   2 +-
 drivers/platform/x86/thinkpad_acpi.c               |  31 ++-
 drivers/power/generic-adc-battery.c                |   2 +-
 drivers/power/s3c_adc_battery.c                    |   2 +-
 drivers/scsi/jazz_esp.c                            |   4 +-
 drivers/scsi/libfc/fc_lport.c                      |   2 +-
 drivers/scsi/libsas/sas_ata.c                      |   9 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |   2 -
 drivers/scsi/lpfc/lpfc_sli.c                       |   1 -
 drivers/scsi/qla2xxx/qla_nx.c                      |   3 +-
 drivers/scsi/sni_53c710.c                          |   5 +-
 drivers/scsi/sun3x_esp.c                           |   4 +-
 drivers/spi/spi-dln2.c                             |   2 +-
 drivers/spi/spi-omap-100k.c                        |   6 +-
 drivers/staging/iio/light/tsl2583.c                |   9 +
 drivers/staging/media/omap4iss/iss.c               |   4 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   2 +-
 drivers/target/target_core_pscsi.c                 |   3 +-
 drivers/thermal/fair_share.c                       |   4 +
 drivers/tty/tty_io.c                               |   8 +-
 drivers/tty/vt/vt.c                                |   2 +-
 drivers/tty/vt/vt_ioctl.c                          |   6 +-
 drivers/usb/class/cdc-acm.c                        |   2 -
 drivers/usb/core/hub.c                             |   6 +-
 drivers/usb/core/quirks.c                          |   4 +
 drivers/usb/dwc2/core.h                            |   2 +
 drivers/usb/dwc2/gadget.c                          |   3 +-
 drivers/usb/gadget/function/f_fs.c                 |   3 +-
 drivers/usb/gadget/function/f_uvc.c                |   7 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |  23 +-
 drivers/usb/gadget/udc/fotg210-udc.c               |  26 +-
 drivers/usb/gadget/udc/pch_udc.c                   |  49 ++--
 drivers/usb/gadget/udc/r8a66597-udc.c              |   2 +
 drivers/usb/host/fotg210-hcd.c                     |   4 +-
 drivers/usb/host/sl811-hcd.c                       |   9 +-
 drivers/usb/host/xhci-ext-caps.h                   |   5 +-
 drivers/usb/host/xhci.c                            |   6 +-
 drivers/video/console/fbcon.c                      |   2 +-
 drivers/video/console/vgacon.c                     |  56 +++--
 drivers/video/fbdev/core/fbcmap.c                  |   8 +-
 drivers/video/fbdev/hgafb.c                        |  21 +-
 drivers/video/fbdev/imsttfb.c                      |   5 -
 drivers/xen/xen-pciback/xenbus.c                   |  22 +-
 fs/btrfs/relocation.c                              |   6 +-
 fs/cifs/smb2ops.c                                  |   2 +
 fs/dlm/debug_fs.c                                  |   1 +
 fs/ecryptfs/crypto.c                               |   6 +-
 fs/ecryptfs/main.c                                 |   6 +
 fs/ext4/ialloc.c                                   |  48 ++--
 fs/ext4/namei.c                                    |   2 +-
 fs/ext4/super.c                                    |   6 +-
 fs/fuse/cuse.c                                     |   2 +
 fs/jffs2/compr_rtime.c                             |   3 +
 fs/jffs2/scan.c                                    |   2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c             |   2 +-
 fs/nfs/inode.c                                     |   8 +-
 fs/nfs/nfs42proc.c                                 |   5 +-
 fs/squashfs/file.c                                 |   6 +-
 fs/timerfd.c                                       |  10 +
 include/linux/compiler-clang.h                     |  14 ++
 include/linux/compiler-gcc.h                       |   4 +
 include/linux/compiler-intel.h                     |   4 +
 include/linux/console_struct.h                     |   1 +
 include/linux/hid.h                                |   2 +
 include/linux/overflow.h                           | 278 +++++++++++++++++++++
 include/linux/tty_driver.h                         |   2 +-
 include/net/bluetooth/hci_core.h                   |   1 +
 include/scsi/libfcoe.h                             |   2 +-
 kernel/kexec_file.c                                |   4 +-
 kernel/ptrace.c                                    |  18 +-
 kernel/trace/ftrace.c                              |   5 +-
 kernel/trace/trace.c                               |  45 ++--
 kernel/trace/trace_clock.c                         |  44 ++--
 lib/kobject_uevent.c                               |   9 +-
 localversion-rt                                    |   2 +-
 mm/ksm.c                                           |   1 +
 net/bluetooth/hci_event.c                          |   3 +-
 net/bluetooth/l2cap_core.c                         |   4 +
 net/bluetooth/smp.c                                |   9 +
 net/core/neighbour.c                               |   2 +-
 net/hsr/hsr_framereg.c                             |   3 +-
 net/ieee802154/nl802154.c                          |  29 +++
 net/ipv6/ip6_gre.c                                 |   3 -
 net/ipv6/ip6_tunnel.c                              |   3 +-
 net/ipv6/ip6_vti.c                                 |   3 +-
 net/ipv6/sit.c                                     |   5 +-
 net/mac80211/main.c                                |   7 +-
 net/mac80211/mlme.c                                |   5 +
 net/nfc/digital_dep.c                              |   2 +
 net/nfc/llcp_sock.c                                |   4 +
 net/openvswitch/actions.c                          |   8 +-
 net/sctp/sm_make_chunk.c                           |   2 +-
 net/sctp/sm_statefuns.c                            |   3 +-
 net/sctp/socket.c                                  |  31 +--
 net/tipc/netlink_compat.c                          |   2 +-
 net/vmw_vsock/vmci_transport.c                     |   3 +-
 net/wireless/scan.c                                |   2 +
 samples/kfifo/bytestream-example.c                 |   8 +-
 samples/kfifo/inttype-example.c                    |   8 +-
 samples/kfifo/record-example.c                     |   8 +-
 scripts/kconfig/nconf.c                            |   2 +-
 sound/core/init.c                                  |   2 -
 sound/firewire/Kconfig                             |   4 +-
 sound/firewire/bebob/bebob.c                       |   2 +-
 sound/firewire/oxfw/oxfw.c                         |   1 -
 sound/isa/sb/emu8000.c                             |   4 +-
 sound/isa/sb/sb16_csp.c                            |   8 +-
 sound/isa/sb/sb8.c                                 |   4 -
 sound/pci/hda/hda_generic.c                        |  16 +-
 sound/pci/hda/patch_realtek.c                      |  17 +-
 sound/pci/rme9652/hdsp.c                           |   3 +-
 sound/pci/rme9652/hdspm.c                          |   3 +-
 sound/pci/rme9652/rme9652.c                        |   3 +-
 sound/soc/codecs/rt286.c                           |  23 +-
 sound/soc/fsl/fsl_esai.c                           |   8 +-
 sound/usb/card.c                                   |  14 +-
 sound/usb/midi.c                                   |   4 +
 sound/usb/quirks-table.h                           |  10 +
 sound/usb/quirks.c                                 |  16 +-
 sound/usb/usbaudio.h                               |   2 +
 tools/arch/ia64/include/asm/barrier.h              |   3 -
 tools/testing/selftests/lib.mk                     |   4 +
 239 files changed, 1577 insertions(+), 683 deletions(-)
