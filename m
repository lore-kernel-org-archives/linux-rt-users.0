Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F699C4743D
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Jun 2021 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49F3613FA
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Jun 2021 17:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhFDRxG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDRxG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Jun 2021 13:53:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92117611CE;
        Fri,  4 Jun 2021 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622829079;
        bh=G5uODgYAiv7WY+4qEBEHp4GHgFUFiarGU1xh+mFW3ek=;
        h=Subject:From:To:Date:From;
        b=MD+Hk6Y/woBbbhkEdwpivyar5H8TapXaQQEnTIF/4+gFKnCXfWHqkbHHdRKrq74QF
         tMPsmQC9vkr1AZ22xVS9XeMfbWA5harED0KDsoPGH3loRRZWY1EizcWZJSM7pD3d1u
         W+mnDDDfDFHUFHz6+Rh22Ou1ACZJ4e+odKW/BXJLl0d8pgwR4bZFgG11erSYII0A36
         zsNSB6E6VGusILsXZ8pbe7yKOTcBnxD6gD+Qcg0X4l5Inr7g+O079CggyPpUnVH5x2
         Bj3H2E42glGRqLW6JBcrgPIqApeID1oz75YGYBN/ZHSBwuWAARjrDd74MF3RsXb69W
         RdciP3qkpCYyw==
Message-ID: <165f3ac193b98e44cd155aaf0a36a6a05616ab02.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.123-rt59
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 04 Jun 2021 12:51:17 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.123-rt59 stable release.

This release is just an update to the new stable 5.4.123
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: ebe9618282631855c924db0eccedacf84ec5e0dc

Or to build 5.4.123-rt59 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.123.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.123-rt59.patch.xz

Enjoy!

   Tom

Changes from v5.4.115-rt57:
---

Adrian Hunter (2):
      mmc: sdhci-pci: Fix initialization of some SD cards for Intel BYT-based controllers
      mmc: sdhci-pci: Add PCI IDs for Intel LKF

Alexander Aring (1):
      fs: dlm: fix debugfs dump

Alexander Lobakin (2):
      mtd: spinand: core: add missing MODULE_DEVICE_TABLE()
      gro: fix napi_gro_frags() Fast GRO breakage due to IP alignment check

Alexander Shishkin (2):
      intel_th: pci: Add Rocket Lake CPU support
      intel_th: pci: Add Alder Lake-M support

Alexandru Elisei (1):
      KVM: arm64: Initialize VCPU mdcr_el2 before loading it

Alexey Kardashevskiy (1):
      powerpc/iommu: Annotate nested lock for lockdep

Andrew Scull (1):
      bug: Remove redundant condition check in report_bug

Andy Shevchenko (5):
      usb: gadget: pch_udc: Revert d3cb25a12138 completely
      usb: gadget: pch_udc: Replace cpu_to_le32() by lower_32_bits()
      usb: gadget: pch_udc: Check if driver is present before calling ->setup()
      usb: gadget: pch_udc: Check for DMA mapping error
      scripts: switch explicitly to Python 3

Anirudh Rayabharam (4):
      usb: gadget: dummy_hcd: fix gpf in gadget_setup
      rapidio: handle create_workqueue() failure
      net: stmicro: handle clk_prepare() failure during init
      video: hgafb: correctly handle card detect failure during probe

Anson Jacob (2):
      drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
      drm/amd/display: Fix UBSAN warning for not a valid value for type '_Bool'

Anthony Wang (1):
      drm/amd/display: Force vsync flip when reconfiguring MPCC

Antonio Borneo (1):
      spi: stm32: drop devres version of spi_register_master

Anup Patel (1):
      RISC-V: Fix error code returned by riscv_hartid_to_cpuid()

Archie Pusaka (3):
      Bluetooth: verify AMP hci_chan before amp_destroy
      Bluetooth: Set CONF_NOT_COMPLETE as l2cap_chan default
      Bluetooth: check for zapped sk before connecting

Ard Biesheuvel (6):
      ARM: 9056/1: decompressor: fix BSS size calculation for LLVM ld.lld
      crypto: api - check for ERR pointers in crypto_destroy_tfm()
      ARM: 9011/1: centralize phys-to-virt conversion of DT/ATAGS address
      ARM: 9012/1: move device tree mapping out of linear region
      ARM: 9020/1: mm: use correct section size macro to describe the FDT virtual address
      ARM: 9027/1: head.S: explicitly map DT even if it lives in the first physical section

Aric Cyr (1):
      drm/amd/display: Don't optimize bandwidth before disabling planes

Arnaldo Carvalho de Melo (1):
      perf symbols: Fix dso__fprintf_symbols_by_name() to return the number of printed chars

Arnd Bergmann (10):
      avoid __memcat_p link failure
      amdgpu: avoid incorrect %hu format string
      security: commoncap: fix -Wstringop-overread warning
      irqchip/gic-v3: Fix OF_BAD_ADDR error handling
      smp: Fix smp_call_function_single_async prototype
      x86/msr: Fix wr/rdmsr_safe_regs_on_cpu() prototypes
      kgdb: fix gcc-11 warning on indentation
      usb: sl811-hcd: improve misleading indentation
      isdn: capi: fix mismatched prototypes
      PCI: thunder: Fix compile testing

Artur Petrosyan (3):
      usb: dwc2: Fix session request interrupt handler
      usb: dwc2: Fix host mode hibernation exit with remote wakeup flow.
      usb: dwc2: Fix hibernation between host and device modes.

Arun Easi (2):
      scsi: qla2xxx: Fix crash in qla2xxx_mqueuecommand()
      PCI: Allow VPD access for QLogic ISP2722

Athira Rajeev (1):
      powerpc/perf: Fix PMU constraint check for EBB events

Atul Gopinathan (1):
      cdrom: gdrom: deallocate struct gdrom_unit fields in remove_gdrom

Avri Altman (2):
      mmc: block: Update ext_csd.cache_ctrl if it was written
      mmc: block: Issue a cache flush only when it's enabled

Axel Rasmussen (1):
      userfaultfd: release page in error path to avoid BUG_ON

Badhri Jagan Sridharan (5):
      usb: typec: tcpm: Address incorrect values of tcpm psy for fixed supply
      usb: typec: tcpm: Address incorrect values of tcpm psy for pps supply
      usb: typec: tcpm: update power supply once partner accepts
      usb: typec: tcpci: Check ROLE_CONTROL while interpreting CC_STATUS
      usb: typec: tcpm: Fix error while calculating PPS out values

Baptiste Lepers (1):
      sunrpc: Fix misplaced barrier in call_decode

Bart Van Assche (4):
      scsi: qla2xxx: Always check the return value of qla24xx_get_isp_stats()
      scsi: libfc: Fix a format specifier
      blk-mq: Swap two calls in blk_mq_exit_queue()
      scsi: ufs: core: Increase the usable queue depth

Bence Csókás (1):
      i2c: Add I2C_AQ_NO_REP_START adapter quirk

Benjamin Block (1):
      dm rq: fix double free of blk_mq_tag_set in dev remove after table load fails

Bill Wendling (1):
      arm64/vdso: Discard .note.gnu.property sections in vDSO

Bixuan Cui (2):
      usb: musb: fix PM reference leak in musb_irq_work()
      usb: core: hub: Fix PM reference leak in usb_port_resume()

Bjorn Andersson (2):
      soc: qcom: mdt_loader: Validate that p_filesz < p_memsz
      soc: qcom: mdt_loader: Detect truncated read of segments

Bodo Stroesser (1):
      scsi: target: tcmu: Return from tcmu_handle_completions() if cmd_id not found

Boris Brezillon (2):
      drm/panfrost: Clear MMU irqs before handling the fault
      drm/panfrost: Don't try to map pages that are already mapped

Brian King (1):
      scsi: ibmvfc: Fix invalid state machine BUG_ON()

Chaitanya Kulkarni (1):
      scsi: target: pscsi: Fix warning in pscsi_complete_cmd()

Changfeng (1):
      drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid compute hang

Chao Yu (1):
      f2fs: fix to avoid out-of-bounds memory access

Chen Huang (1):
      powerpc: Fix HAVE_HARDLOCKUP_DETECTOR_ARCH build configuration

Chen Hui (1):
      clk: qcom: a53-pll: Add missing MODULE_DEVICE_TABLE

Chen Jun (1):
      posix-timers: Preserve return value in clock_adjtime32()

Chris Chiu (1):
      USB: Add reset-resume quirk for WD19's Realtek Hub

Christoph Hellwig (13):
      modules: mark ref_module static
      modules: mark find_symbol static
      modules: mark each_symbol_section static
      modules: unexport __module_text_address
      modules: unexport __module_address
      modules: rename the licence field in struct symsearch to license
      modules: return licensing information from find_symbol
      modules: inherit TAINT_PROPRIETARY_MODULE
      md: split mddev_find
      md: factor out a mddev_find_locked helper from mddev_find
      iomap: fix sub-page uptodate handling
      nvme: do not try to reconfigure APST when the controller is not live
      nvme-multipath: fix double initialization of ANA state

Christophe JAILLET (7):
      mmc: uniphier-sd: Fix an error handling path in uniphier_sd_probe()
      mmc: uniphier-sd: Fix a resource leak in the remove function
      usb: fotg210-hcd: Fix an error message
      ACPI: scan: Fix a memory leak in an error handling path
      xhci: Do not use GFP_KERNEL in (potentially) atomic context
      openrisc: Fix a memory leak
      uio_hv_generic: Fix a memory leak in error handling paths

Christophe Leroy (1):
      powerpc/52xx: Fix an invalid ASM expression ('addi' used instead of 'add')

Chunfeng Yun (5):
      arm64: dts: mt8173: fix property typo of 'phys' in dsi node
      usb: xhci-mtk: support quirk to disable usb2 lpm
      usb: xhci-mtk: remove or operator for setting schedule parameters
      usb: xhci-mtk: improve bandwidth scheduling with TT
      usb: core: hub: fix race condition about TRSMRCY of resume

Claudio Imbrenda (2):
      KVM: s390: split kvm_s390_logical_to_effective
      KVM: s390: split kvm_s390_real_to_abs

Colin Ian King (16):
      clk: socfpga: arria10: Fix memory leak of socfpga_clk on error return
      drm/radeon: fix copy of uninitialized variable back to userspace
      memory: gpmc: fix out of bounds read and dereference on gpmc_cs[]
      staging: rtl8192u: Fix potential infinite loop
      usb: gadget: r8a66597: Add missing null check on return from platform_get_resource
      media: vivid: fix assignment of dev->fbuf_out_flags
      media: m88rs6000t: avoid potential out-of-bounds reads on arrays
      clk: uniphier: Fix potential infinite loop
      liquidio: Fix unintented sign extension of a left shift of a u16
      mt7601u: fix always true expression
      cxgb4: Fix unintentional sign extension issues
      net: thunderx: Fix unintentional sign extension issue
      ALSA: usb: midi: don't return -ENOMEM when usb_urb_ep_type_check fails
      net: davinci_emac: Fix incorrect masking of tx and rx error channel
      f2fs: fix a redundant call to f2fs_balance_fs if an error occurs
      iio: tsl2583: Fix division by a zero lux_val

Cong Wang (1):
      smc: disallow TCP_ULP in smc_setsockopt()

Cédric Le Goater (1):
      powerpc/xive: Fix xmon command "dxi"

Dan Carpenter (13):
      scsi: ufs: Unlock on a couple error paths
      ipw2x00: potential buffer overflow in libipw_wx_set_encodeext()
      ovl: fix missing revert_creds() on error path
      mtd: rawnand: fsmc: Fix error code in fsmc_nand_probe()
      node: fix device cleanups in error handling code
      soc: aspeed: fix a ternary sign expansion bug
      HSI: core: fix resource leaks in hsi_add_client_from_dt()
      nfc: pn533: prevent potential memory corruption
      drm/i915/gvt: Fix error code in intel_gvt_init_device()
      bnxt_en: fix ternary sign extension bug in bnxt_show_temp()
      kfifo: fix ternary sign extension bugs
      firmware: arm_scpi: Prevent the ternary sign expansion bug
      RDMA/uverbs: Fix a NULL vs IS_ERR() bug

Daniel Beer (1):
      mmc: sdhci-pci-gli: increase 1.8V regulator wait

Daniel Borkmann (13):
      bpf: Move off_reg into sanitize_ptr_alu
      bpf: Ensure off_reg has no mixed signed bounds for all types
      bpf: Rework ptr_limit into alu_limit and add common error path
      bpf: Improve verifier error messages for users
      bpf: Refactor and streamline bounds check into helper
      bpf: Move sanitize_val_alu out of op switch
      bpf: Tighten speculative pointer arithmetic mask
      bpf: Update selftests to reflect new error states
      bpf: Fix masking negation logic upon negative dst register
      bpf: Fix leakage of uninitialized bpf stack under speculation
      bpf: Wrap aux data inside bpf_sanitize_info container
      bpf: Fix mask direction swap upon off reg sign change
      bpf: No need to simulate speculative domain for immediates

Daniel Cordova A (1):
      ALSA: hda: fixup headset for ASUS GU502 laptop

Daniel Niv (1):
      media: media/saa7164: fix saa7164_encoder_register() memory leak bugs

Daniel Wagner (1):
      nvmet: seset ns->file when open fails

Darrick J. Wong (1):
      ics932s401: fix broken handling of errors when word reading fails

Dave Rigby (1):
      perf unwind: Set userdata for all __report_module() paths

David Bauer (3):
      spi: ath79: always call chipselect function
      spi: ath79: remove spi-master setup and cleanup assignment
      mt76: mt76x0: disable GTK offloading

David E. Box (1):
      platform/x86: intel_pmc_core: Don't use global pmcdev in quirks

David Hildenbrand (1):
      s390: fix detection of vector enhancements facility 1 vs. vector packed decimal facility

David Ward (2):
      ASoC: rt286: Generalize support for ALC3263 codec
      ASoC: rt286: Make RT286_SET_GPIO_* readable and writable

Davide Caratti (1):
      openvswitch: fix stack OOB read while fragmenting IPv4 packets

Dean Anderson (1):
      usb: gadget/function/f_fs string table fix for multiple languages

Dinghao Liu (3):
      media: platform: sti: Fix runtime PM imbalance in regs_show
      mfd: arizona: Fix rumtime PM imbalance on error
      iio: proximity: pulsedlight: Fix rumtime PM imbalance on error

Dmitry Baryshkov (1):
      PCI: Release OF node in pci_scan_device()'s error path

Dmitry Osipenko (1):
      iio: gyro: mpu3050: Fix reported temperature value

Dmitry Vyukov (1):
      drm/vkms: fix misuse of WARN_ON

Dmytro Laktyushkin (1):
      drm/amd/display: fix dml prefetch validation

Dong Aisheng (1):
      PM / devfreq: Use more accurate returned new_freq as resume_freq

Dongliang Mu (1):
      NFC: nci: fix memory leak in nci_allocate_device

DooHyun Hwang (1):
      mmc: core: Do a power cycle when the CMD11 fails

Du Cheng (2):
      net: sched: tapr: prevent cycle_time == 0 in parse_taprio_schedule
      ethernet: sun: niu: fix missing checks of niu_pci_eeprom_read()

Eckhart Mohr (1):
      ALSA: hda/realtek: Add quirk for Intel Clevo PCx0Dx

Eddie James (1):
      hwmon: (occ) Fix poll rate limiting

Elia Devito (1):
      ALSA: hda/realtek: Add fixup for HP Spectre x360 15-df0xxx

Emmanuel Grumbach (1):
      mac80211: clear the beacon's CRC after channel switch

Eric Biggers (3):
      crypto: rng - fix crypto_rng_reset() refcounting when !CRYPTO_STATS
      f2fs: fix error handling in f2fs_end_enable_verity()
      ext4: fix error handling in ext4_end_enable_verity()

Eric Dumazet (8):
      inet: use bigger hash table for IP ID generation
      ip6_vti: proper dev_{hold|put} in ndo_[un]init methods
      netfilter: nftables: avoid overflows in nft_hash_buckets()
      virtio_net: Do not pull payload in skb->head
      ip6_gre: proper dev_{hold|put} in ndo_[un]init methods
      sit: proper dev_{hold|put} in ndo_[un]init methods
      ip6_tunnel: sit: proper dev_{hold|put} in ndo_[un]init methods
      ipv6: remove extra dev_hold() for fallback tunnels

Erwan Le Ray (2):
      serial: stm32: fix incorrect characters on console
      serial: stm32: fix tx_empty condition

Eryk Brol (1):
      drm/amd/display: Check for DSC support instead of ASIC revision

Ewan D. Milne (1):
      scsi: scsi_dh_alua: Remove check for ASC 24h in alua_rtpg()

Fabian Vogt (6):
      fotg210-udc: Fix DMA on EP0 for length > max packet size
      fotg210-udc: Fix EP0 IN requests bigger than two packets
      fotg210-udc: Remove a dubious condition leading to fotg210_done
      fotg210-udc: Mask GRP2 interrupts we don't handle
      fotg210-udc: Don't DMA more than the buffer can take
      fotg210-udc: Complete OUT requests on short packets

Fabrice Gasnier (1):
      mfd: stm32-timers: Avoid clearing auto reload register

Feilong Lin (1):
      ACPI / hotplug / PCI: Fix reference count leak in enable_slot()

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: fix RX VLAN offload

Felix Kuehling (1):
      drm/amdkfd: fix build error with AMD_IOMMU_V2=m

Fengnan Chang (1):
      ext4: fix error code in ext4_commit_super

Ferry Toth (1):
      usb: dwc3: pci: Enable usb2-gadget-lpm-disable for Intel Merrifield

Filipe Manana (2):
      btrfs: fix metadata extent leak after failure to create subvolume
      btrfs: fix race when picking most recent mod log operation for an old root

Finn Behrens (1):
      tweewide: Fix most Shebang lines

Finn Thain (1):
      m68k: mvme147,mvme16x: Don't wipe PCC timer config bits

Gao Xiang (1):
      erofs: add unsupported inode i_format check

Geert Uytterhoeven (1):
      phy: marvell: ARMADA375_USBCLUSTER_PHY should not default to y, unconditionally

Gerd Hoffmann (1):
      drm/qxl: release shadow on shutdown

Giovanni Cabiddu (1):
      crypto: qat - fix error path in adf_isr_resource_alloc()

Greg Kroah-Hartman (26):
      Linux 5.4.116
      Linux 5.4.117
      Linux 5.4.118
      Linux 5.4.119
      kobject_uevent: remove warning in init_uevent_argv()
      Linux 5.4.120
      Linux 5.4.121
      Revert "ALSA: sb8: add a check for request_region"
      Revert "rapidio: fix a NULL pointer dereference when create_workqueue() fails"
      Revert "serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference"
      Revert "video: hgafb: fix potential NULL pointer dereference"
      Revert "net: stmicro: fix a missing check of clk_prepare"
      Revert "leds: lp5523: fix a missing check of return value of lp55xx_read"
      Revert "hwmon: (lm80) fix a missing check of bus read in lm80 probe"
      Revert "video: imsttfb: fix potential NULL pointer dereferences"
      Revert "ecryptfs: replace BUG_ON with error handling code"
      Revert "scsi: ufs: fix a missing check of devm_reset_control_get"
      Revert "gdrom: fix a memory leak bug"
      cdrom: gdrom: initialize global variable at init time
      Revert "media: rcar_drif: fix a memory disclosure"
      Revert "rtlwifi: fix a potential NULL pointer dereference"
      Revert "qlcnic: Avoid potential NULL pointer dereference"
      Revert "niu: fix missing checks of niu_pci_eeprom_read"
      net: rtlwifi: properly check for alloc_workqueue() failure
      Linux 5.4.122
      Linux 5.4.123

Guchun Chen (3):
      drm/amdgpu: fix NULL pointer dereference
      drm/amdgpu: update gc golden setting for Navi12
      drm/amdgpu: update sdma golden setting for Navi12

Guochun Mao (1):
      ubifs: Only check replay with inode type to judge if inode linked

Gustavo A. R. Silva (5):
      sctp: Fix out-of-bounds warning in sctp_process_asconf_param()
      flow_dissector: Fix out-of-bounds warning in __skb_flow_bpf_to_target()
      ethtool: ioctl: Fix out-of-bounds warning in store_link_ksettings_for_user()
      wl3501_cs: Fix out-of-bounds warnings in wl3501_send_pkt
      wl3501_cs: Fix out-of-bounds warnings in wl3501_mgmt_join

Gustavo Pimentel (1):
      dmaengine: dw-edma: Fix crash on loading/unloading driver

Hannes Reinecke (1):
      nvme: retrigger ANA log update if group descriptor isn't found

Hans Verkuil (4):
      media: gspca/sq905.c: fix uninitialized variable
      media: vivid: update EDID
      media: gscpa/stv06xx: fix memory leak
      media: v4l2-ctrls.c: fix race condition in hdl->requests list

Hans de Goede (9):
      extcon: arizona: Fix some issues when HPDET IRQ fires after the jack has been unplugged
      extcon: arizona: Fix various races on driver unbind
      misc: lis3lv02d: Fix false-positive WARN on various HP models
      ASoC: Intel: bytcr_rt5640: Enable jack-detect support on Asus T100TAF
      ASoC: Intel: bytcr_rt5640: Add quirk for the Chuwi Hi8 tablet
      Input: elants_i2c - do not bind to i2c-hid compatible ACPI instantiated devices
      Input: silead - add workaround for x86 BIOS-es which bring the chip up in a stuck state
      gpiolib: acpi: Add quirk to ignore EC wakeups on Dell Venue 10 Pro 5055
      platform/x86: dell-smbios-wmi: Fix oops on rmmod dell_smbios

Hansem Ro (1):
      Input: ili210x - add missing negation for touch indication on ili210x

Hao Chen (1):
      net: hns3: fix for vxlan gpe tx checksum bug

Harald Freudenberger (1):
      s390/archrandom: add parameter check for s390_arch_random_generate

Harry Wentland (1):
      drm/amd/display: Reject non-zero src_y and src_x for video planes

He Ying (2):
      irqchip/gic-v3: Do not enable irqs when handling spurious interrups
      firmware: qcom-scm: Fix QCOM_SCM configuration

Heiko Carstens (1):
      KVM: s390: fix guarded storage control register handling

Heinz Mauelshagen (1):
      dm raid: fix inconclusive reshape layout on fast raid4/5/6 table reload sequences

Hemant Kumar (1):
      usb: gadget: Fix double free of device descriptor pointers

Heming Zhao (1):
      md-cluster: fix use-after-free issue when removing rdev

Hillf Danton (1):
      tty: n_gsm: check error while registering tty devices

Hoang Le (1):
      tipc: convert dest node's address to network order

Hou Pu (1):
      nvmet: use new ana_log_size instead the old one

Hui Tang (1):
      crypto: qat - fix unmap invalid dma address

Hui Wang (2):
      ALSA: hda: generic: change the DAC ctl name for LO+SPK or LO+HP
      ALSA: hda/realtek: reset eapd coeff to default value for alc287

Ido Schimmel (1):
      mlxsw: spectrum_mr: Update egress RIF list before route's action

Igor Matheus Andrade Torrente (1):
      video: hgafb: fix potential NULL pointer dereference

Ilya Lipnitskiy (3):
      MIPS: pci-mt7620: fix PLL lock check
      MIPS: pci-rt2880: fix slot 0 configuration
      MIPS: pci-legacy: stop using of_pci_range_to_resource

Ingo Molnar (1):
      x86/platform/uv: Fix !KEXEC build failure

Jack Pham (1):
      usb: dwc3: gadget: Enable suspend events

Jae Hyun Yoo (2):
      Revert "i3c master: fix missing destroy_workqueue() on error in i3c_master_register"
      media: aspeed: fix clock handling logic

James Smart (6):
      scsi: lpfc: Fix incorrect dbde assignment when building target abts wqe
      scsi: lpfc: Fix pt2pt connection does not recover after LOGO
      scsi: lpfc: Fix crash when a REG_RPI mailbox fails triggering a LOGO response
      scsi: lpfc: Fix error handling for mailboxes completed in MBX_POLL mode
      scsi: lpfc: Remove unsupported mbox PORT_CAPABILITIES logic
      scsi: lpfc: Fix illegal memory access on Abort IOCBs

Jan Beulich (1):
      xen-pciback: reconfigure also from backend watch handler

Jan Glauber (1):
      md: Fix missing unused status line of /proc/mdstat

Jan Kratochvil (1):
      perf unwind: Fix separate debug info files when using elfutils' libdw's unwinder

Jane Chu (1):
      mm/memory-failure: unnecessary amount of unmapping

Jared Baldridge (1):
      drm: Added orientation quirk for OneGX1 Pro

Jarkko Sakkinen (2):
      tpm, tpm_tis: Extend locality handling to TPM2 in tpm_tis_gen_interrupt()
      tpm, tpm_tis: Reserve locality in tpm_tis_resume()

Jaroslaw Gawin (1):
      i40e: fix the restart auto-negotiation after FEC modified

Jason Gunthorpe (2):
      vfio: Depend on MMU
      vfio/mdev: Do not allow a mdev_type to have a NULL parent pointer

Jeff Layton (2):
      ceph: fix inode leak on getattr error in __fh_to_dentry
      ceph: fix fscache invalidation

Jeffrey Mitchell (1):
      ecryptfs: fix kernel panic with null dev_name

Jerome Forissier (1):
      tee: optee: do not check memref size on return from Secure World

Jia Zhou (1):
      ALSA: core: remove redundant spin_lock pair in snd_card_disconnect

Jia-Ju Bai (4):
      media: platform: sunxi: sun6i-csi: fix error return code of sun6i_video_start_streaming()
      thermal: thermal_of: Fix error return code of thermal_of_populate_bind_params()
      rpmsg: qcom_glink_native: fix error return code of qcom_glink_rx_data()
      kernel: kexec_file: fix error return code of kexec_calculate_store_digests()

Jian Shen (1):
      net: hns3: add check for HNS3_NIC_STATE_INITED in hns3_reset_notify_up_enet()

Jiri Kosina (2):
      iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()
      iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_gen2_enqueue_hcmd()

Joe Thornber (2):
      dm persistent data: packed struct should have an aligned() attribute too
      dm space map common: fix division bug in sm_ll_find_free_block()

Johan Hovold (15):
      Revert "USB: cdc-acm: fix rounding error in TIOCSSERIAL"
      tty: moxa: fix TIOCSSERIAL jiffies conversions
      tty: amiserial: fix TIOCSSERIAL permission check
      USB: serial: usb_wwan: fix TIOCSSERIAL jiffies conversions
      staging: greybus: uart: fix TIOCSSERIAL jiffies conversions
      USB: serial: ti_usb_3410_5052: fix TIOCSSERIAL permission check
      staging: fwserial: fix TIOCSSERIAL jiffies conversions
      tty: moxa: fix TIOCSSERIAL permission check
      staging: fwserial: fix TIOCSSERIAL permission check
      staging: greybus: uart: fix unprivileged TIOCCSERIAL
      USB: cdc-acm: fix unprivileged TIOCCSERIAL
      USB: cdc-acm: fix TIOCGSERIAL implementation
      tty: actually undefine superseded ASYNC flags
      tty: fix return value for unsupported ioctls
      serial: core: return early on unsupported ioctls

Johannes Berg (4):
      cfg80211: scan: drop entry from hidden_list on overflow
      mac80211: bail out if cipher schemes are invalid
      um: Mark all kernel symbols as local
      um: Disable CONFIG_GCOV with MODULES

John Millikin (1):
      x86/build: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)

Jonathan Cameron (1):
      iio:accel:adis16201: Fix wrong axis assignment that prevents loading

Jonathan Kim (1):
      drm/amdgpu: mask the xgmi number of hops reported from psp to kfd

Jonathan McDowell (1):
      net: stmmac: Set FIFO sizes for ipq806x

Jonathon Reinhart (2):
      net: Only allow init netns to set default tcp cong to a restricted algo
      netfilter: conntrack: Make global sysctls readonly in non-init netns

Jordan Niethe (1):
      powerpc/64s: Fix pte update for kernel memory on radix

Josef Bacik (2):
      btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
      btrfs: avoid RCU stalls while running delayed iputs

Josh Poimboeuf (1):
      pinctrl: ingenic: Improve unreachable code generation

Jouni Roivas (1):
      hfsplus: prevent corruption in shrinking truncate

Julian Braha (1):
      media: drivers: media: pci: sta2x11: fix Kconfig dependency on GPIOLIB

Kai Stuhlemmer (ebee Engineering) (1):
      mtd: rawnand: atmel: Update ecc_stats.corrected counter

Kai Vehmanen (1):
      ALSA: hda/hdmi: fix race in handling acomp ELD notification at resume

Kai-Heng Feng (2):
      USB: Add LPM quirk for Lenovo ThinkPad USB-C Dock Gen2 Ethernet
      drm/radeon/dpm: Disable sclk switching on Oland when two 4K 60Hz monitors are connected

Kaixu Xia (1):
      cxgb4: Fix the -Wmisleading-indentation warning

Kees Cook (2):
      drm/radeon: Fix off-by-one power_state index heap overwrite
      drm/radeon: Avoid power table parsing memory leaks

Kevin Barnett (1):
      scsi: smartpqi: Add new PCI IDs

Krzysztof Kozlowski (8):
      ARM: dts: exynos: correct fuel gauge interrupt trigger level on Midas family
      ARM: dts: exynos: correct MUIC interrupt trigger level on Midas family
      ARM: dts: exynos: correct PMIC interrupt trigger level on Midas family
      ARM: dts: exynos: correct PMIC interrupt trigger level on Odroid X/U3 family
      ARM: dts: exynos: correct PMIC interrupt trigger level on SMDK5250
      ARM: dts: exynos: correct PMIC interrupt trigger level on Snow
      ASoC: simple-card: fix possible uninitialized single_cpu local variable
      pinctrl: samsung: use 'int' for register masks in Exynos

Kunihiko Hayashi (2):
      ARM: dts: uniphier: Change phy-mode to RGMII-ID to enable delay pins for RTL8211E
      arm64: dts: uniphier: Change phy-mode to RGMII-ID to enable delay pins for RTL8211E

Kuninori Morimoto (2):
      ASoC: rsnd: call rsnd_ssi_master_clk_start() from rsnd_ssi_init()
      ASoC: rsnd: check all BUSIF status when error

Laurent Pinchart (1):
      media: imx: capture: Return -EPIPE from __capture_legacy_try_fmt()

Lee Gibson (1):
      qtnfmac: Fix possible buffer overflow in qtnf_event_handle_external_auth

Leon Romanovsky (3):
      RDMA/siw: Properly check send and receive CQ pointers
      RDMA/siw: Release xarray entry
      RDMA/rxe: Clear all QP fields if creation failed

Liming Sun (1):
      platform/mellanox: mlxbf-tmfifo: Fix a memory barrier issue

Lin Ma (1):
      bluetooth: eliminate the potential race condition when removing the HCI controller

Lingutla Chandrasekhar (1):
      sched/fair: Ignore percpu threads for imbalance pulls

Linus Lüssing (1):
      net: bridge: mcast: fix broken length + header check for MRDv6 Adv.

Linus Torvalds (1):
      Fix misc new gcc warnings

Luis Henriques (1):
      virtiofs: fix memory leak in virtio_fs_probe()

Luiz Augusto von Dentz (2):
      Bluetooth: L2CAP: Fix handling LE modes by L2CAP_OPTIONS
      Bluetooth: SMP: Fail if remote and local public keys are identical

Lukasz Luba (1):
      thermal/core/fair share: Lock the thermal zone while looping over instances

Lukasz Majczak (1):
      ASoC: Intel: kbl_da7219_max98927: Fix kabylake_ssp_fixup function

Luke D Jones (1):
      ALSA: hda/realtek: GA503 use same quirks as GA401

Lv Yunlong (11):
      ALSA: emu8000: Fix a use after free in snd_emu8000_create_mixer
      ALSA: sb: Fix two use after free in snd_sb_qsound_build
      mtd: rawnand: gpmi: Fix a double free in gpmi_nand_init
      crypto: qat - Fix a double free in adf_create_ring
      drivers/block/null_blk/main: Fix a double free in null_init.
      mwl8k: Fix a double Free in mwl8k_probe_hw
      net:emac/emac-mac: Fix a use after free in emac_mac_tx_buf_send
      RDMA/siw: Fix a use after free in siw_alloc_mr
      RDMA/bnxt_re: Fix a double free in bnxt_qplib_alloc_res
      net:nfc:digital: Fix a double free in digital_tg_recv_dep_req
      ethernet:enic: Fix a use after free bug in enic_hard_start_xmit

Maciej W. Rozycki (7):
      FDDI: defxx: Bail out gracefully with unassigned PCI resource for CSR
      FDDI: defxx: Make MMIO the configuration default except for EISA
      MIPS: Reinstate platform `__div64_32' handler
      MIPS: Avoid DIVU in `__div64_32' is result would be zero
      MIPS: Avoid handcoded DIVU in `__div64_32' altogether
      vgacon: Record video mode changes with VT_RESIZEX
      vt: Fix character height handling with VT_RESIZEX

Maciej Żenczykowski (1):
      net: fix nla_strcmp to handle more then one trailing null character

Magnus Karlsson (1):
      xsk: Simplify detection of empty and full rings

Mahesh Salgaonkar (1):
      powerpc/eeh: Fix EEH handling for hugepages in ioremap space.

Manivannan Sadhasivam (3):
      mtd: Handle possible -EPROBE_DEFER from parse_mtd_partitions()
      mtd: rawnand: qcom: Return actual error code instead of -ENODEV
      ARM: 9075/1: kernel: Fix interrupted SMC calls

Maor Gottlieb (1):
      RDMA/mlx5: Recover from fatal event in dual port mode

Marc Kleine-Budde (1):
      can: m_can: m_can_tx_work_queue(): fix tx_skb race condition

Marc Zyngier (1):
      ACPI: GTDT: Don't corrupt interrupt mappings on watchdow probe failure

Marcel Hamer (1):
      usb: dwc3: omap: improve extcon initialization

Marek Behún (3):
      arm64: dts: marvell: armada-37xx: add syscon compatible to NB clk node
      cpufreq: armada-37xx: Fix setting TBG parent for load levels
      clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM clock

Marek Vasut (1):
      rsi: Use resume_noirq for SDIO

Marijn Suijten (2):
      drm/msm/mdp5: Configure PP_SYNC_HEIGHT to double the vtotal
      drm/msm/mdp5: Do not multiply vclk line count by 100

Mark Langsdorf (2):
      ACPI: custom_method: fix potential use-after-free issue
      ACPI: custom_method: fix a possible memory leak

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Correct thermal sensor allocation

Martin Schiller (1):
      net: phy: intel-xway: enable integrated led functions

Masahiro Yamada (1):
      kbuild: update config_data.gz only when the content of .config is changed

Masami Hiramatsu (1):
      x86/kprobes: Fix to check non boostable prefixes correctly

Mateusz Palczewski (1):
      i40e: Fix PHY type identifiers for 2.5G and 5G adapters

Mathias Nyman (2):
      xhci: check control context is valid before dereferencing it.
      xhci: fix potential array out of bounds with several interrupters

Matthew Wilcox (Oracle) (1):
      mm: fix struct page layout on 32-bit systems

Matthias Schiffer (1):
      power: supply: bq27xxx: fix power_avg for newer ICs

Maxim Mikityanskiy (1):
      HID: plantronics: Workaround for double volume key presses

Maximilian Luz (1):
      usb: xhci: Increase timeout for HC halt

Meng Li (1):
      regmap: set debugfs_name to NULL after it is freed

Miaohe Lin (4):
      khugepaged: fix wrong result value for trace_mm_collapse_huge_page_isolate()
      mm/hugeltb: handle the error case in hugetlb_fix_reserve_counts()
      mm/migrate.c: fix potential indeterminate pte entry in migrate_vma_insert_page()
      ksm: fix potential missing rmap_item for stable_node

Michael Chan (2):
      bnxt_en: Fix RX consumer index logic in the error path.
      bnxt_en: Add PCI IDs for Hyper-V VF devices.

Michael Ellerman (3):
      powerpc/pseries: Stop calling printk in rtas_stop_self()
      powerpc/64s: Fix crashes when toggling stf barrier
      powerpc/64s: Fix crashes when toggling entry flush barrier

Michael Kelley (1):
      Drivers: hv: vmbus: Increase wait time for VMbus unload

Michael Walle (2):
      mtd: require write permissions for locking and badblock ioctls
      rtc: fsl-ftm-alarm: add MODULE_TABLE()

Mihai Moldovan (1):
      kconfig: nconf: stop endless search loops

Mikhail Durnev (1):
      ASoC: rsnd: core: Check convert rate in rsnd_hw_params

Miklos Szeredi (2):
      ovl: allow upperdir inside lowerdir
      cuse: prevent clone

Mikulas Patocka (1):
      dm snapshot: fix crash with transient storage and zero chunk size

Muhammad Usama Anjum (1):
      media: em28xx: fix memory leak

Murthy Bhat (1):
      scsi: smartpqi: Correct request leakage during reset operations

Nathan Chancellor (7):
      Makefile: Move -Wno-unused-but-set-variable out of GCC only block
      ACPI: CPPC: Replace cppc_attr with kobj_attribute
      x86/events/amd/iommu: Fix sysfs type mismatch
      powerpc/fadump: Mark fadump_calculate_reserve_size as __init
      powerpc/prom: Mark identical_pvr_fixup as __init
      scripts/recordmcount.pl: Fix RISC-V regex for clang
      riscv: Workaround mcount name prior to clang-13

Nicholas Piggin (1):
      KVM: PPC: Book3S HV P9: Restore host CTRL SPR after guest exit

Nick Lowe (1):
      igb: Enable RSS for Intel I211 Ethernet Controller

Niklas Cassel (1):
      nvme-pci: don't simple map sgl when sgls are disabled

Nikola Livic (1):
      pNFS/flexfiles: fix incorrect size check in decode_nfs_fh()

Nikolay Aleksandrov (1):
      net: bridge: when suppression is enabled exclude RARP packets

Nobuhiro Iwamatsu (1):
      rtc: ds1307: Fix wday settings for rx8130

Odin Ugedal (1):
      sched/fair: Fix unfairness caused by missing load decay

Oleg Nesterov (1):
      ptrace: make ptrace() fail if the tracee changed its pid unexpectedly

Olga Kornievskaia (1):
      NFSv4.2 fix handling of sr_eof in SEEK's reply

Oliver Neukum (1):
      cdc-wdm: untangle a circular dependency between callback and softint

Omar Sandoval (1):
      kyber: fix out of bounds access when preempted

Ondrej Mosnacek (1):
      perf/core: Fix unconditional security_locked_down() call

Or Cohen (1):
      net/nfc: fix use-after-free llcp_sock_bind/connect

Otavio Pontes (1):
      x86/microcode: Check for offline CPUs before requesting new microcode

Pablo Neira Ayuso (2):
      netfilter: xt_SECMARK: add new revision to fix structure layout
      netfilter: nfnetlink_osf: Fix a missing skb_header_pointer() NULL check

Pali Rohár (6):
      cpufreq: armada-37xx: Fix the AVS value for load L1
      clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to 1 GHz
      clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1 to L0
      cpufreq: armada-37xx: Fix driver cleanup when registration failed
      cpufreq: armada-37xx: Fix determining base CPU frequency
      PCI: iproc: Fix return value of iproc_msi_irq_domain_alloc()

Pan Bian (1):
      bus: qcom: Put child node before return

Paul Aurich (1):
      cifs: Return correct error code from smb2_get_enc_key

Paul Clements (1):
      md/raid1: properly indicate failure when ending a failed write request

Paul Durrant (1):
      xen-blkback: fix compatibility bug with single page rings

Paul Menzel (1):
      Revert "iommu/amd: Fix performance counter initialization"

Pavel Machek (1):
      intel_th: Consistency and off-by-one fix

Pavel Skripkin (2):
      media: dvb-usb: fix memory leak in dvb_usb_adapter_init
      tty: fix memory leak in vc_deallocate

Pawel Laszczak (2):
      usb: gadget: uvc: add bInterval checking for HS mode
      usb: webcam: Invalid size of Processing Unit Descriptor

Paweł Chmiel (1):
      clk: exynos7: Mark aclk_fsys1_200 as critical

PeiSen Hou (1):
      ALSA: hda/realtek: Add some CLOVE SSIDs of ALC293

Peilin Ye (1):
      media: dvbdev: Fix memory leak in dvb_media_device_free()

Peng Li (1):
      net: hns3: use netif_tx_disable to stop the transmit queue

Peter Xu (1):
      mm/hugetlb: fix F_SEAL_FUTURE_WRITE

Petr Machata (1):
      selftests: net: mirror_gre_vlan_bridge_1q: Make an FDB entry static

Phil Calvin (1):
      ALSA: hda/realtek: fix mic boost on Intel NUC 8

Phil Elwell (1):
      usb: dwc2: Fix gadget DMA unmap direction

Phillip Lougher (1):
      squashfs: fix divide error in calculate_skip()

Phillip Potter (5):
      net: usb: ax88179_178a: initialize local variables before use
      fbdev: zero-fill colormap in fbcmap.c
      net: geneve: modify IP header check in geneve6_xmit_skb and geneve_xmit_skb
      scsi: ufs: handle cleanup correctly on devm_reset_control_get error
      leds: lp5523: check return value of lp5xx_read and jump to cleanup code

Pierre-Louis Bossart (1):
      ASoC: samsung: tm2_wm5110: check of of_parse return value

Ping-Ke Shih (2):
      rtw88: Fix array overrun in rtw_get_tx_power_params()
      rtlwifi: 8821ae: upgrade PHY and RF parameters

Potnuri Bharat Teja (1):
      RDMA/cxgb4: add missing qpid increment

Pradeep P V K (1):
      mmc: sdhci: Check for reset prior to DMA address unmap

Qinglang Miao (4):
      i2c: img-scb: fix reference leak when pm_runtime_get_sync fails
      i2c: imx-lpi2c: fix reference leak when pm_runtime_get_sync fails
      i2c: omap: fix reference leak when pm_runtime_get_sync fails
      i2c: sprd: fix reference leak when pm_runtime_get_sync fails

Qu Huang (1):
      drm/amdkfd: Fix cat debugfs hang_hws file causes system crash bug

Quanyang Wang (1):
      clk: zynqmp: move zynqmp_pll_set_mode out of round_rate callback

Quentin Perret (3):
      Revert "of/fdt: Make sure no-map does not remove already reserved regions"
      Revert "fdt: Properly handle "no-map" field in the memory region"
      sched: Fix out-of-bound access in uclamp

Quinn Tran (1):
      scsi: qla2xxx: Fix use after free in bsg

Rafael J. Wysocki (3):
      ACPI: tables: x86: Reserve memory occupied by ACPI tables
      ACPI: x86: Call acpi_boot_table_init() after acpi_table_upgrade()
      PCI: PM: Do not read power state in pci_enable_device_flags()

Rander Wang (1):
      soundwire: stream: fix memory leak in stream config error path

Randy Dunlap (1):
      powerpc: iommu: fix build when neither PCI or IBMVIO is set

Ricardo Ribalda (3):
      media: staging/intel-ipu3: Fix memory leak in imu_fmt
      media: staging/intel-ipu3: Fix set_fmt error handling
      media: staging/intel-ipu3: Fix race condition during set_fmt

Robin Murphy (1):
      perf/arm_pmu_platform: Fix error handling

Robin Singh (1):
      drm/amd/display: fixed divide by zero kernel crash during dsc enablement

Rodrigo Siqueira (1):
      drm/amd/display: Fix two cursor duplication when using overlay

Romain Naour (1):
      mips: Do not include hi and lo in clobber list for R6

Ronnie Sahlberg (1):
      cifs: fix memory leak in smb2_copychunk_range

Ruslan Bilovol (2):
      usb: gadget: f_uac2: validate input parameters
      usb: gadget: f_uac1: validate input parameters

Sagi Grimberg (2):
      nvme-tcp: block BH in sk state_change sk callback
      nvmet-tcp: fix incorrect locking in state_change sk callback

Salil Mehta (1):
      net: hns3: Limiting the scope of vector_ring_chain variable

Sami Loone (2):
      ALSA: hda/realtek: fix static noise on ALC285 Lenovo laptops
      ALSA: hda/realtek: ALC285 Thinkpad jack pin quirk is unreachable

Sandeep Singh (1):
      xhci: Add reset resume quirk for AMD xhci controller.

Sean Christopherson (4):
      x86/cpu: Initialize MSR_TSC_AUX if RDTSCP *or* RDPID is supported
      KVM: nVMX: Truncate bits 63:32 of VMCS field on nested check in !64-bit
      KVM: Stop looking for coalesced MMIO zones if the bus is destroyed
      KVM: x86/mmu: Remove the defunct update_pte() paging hook

Sean Young (1):
      media: ite-cir: check for receive overflow

Sergei Trofimovich (1):
      ia64: module: fix symbolizer crash on fdescr

Sergey Shtylyov (13):
      pata_arasan_cf: fix IRQ check
      pata_ipx4xx_cf: fix IRQ check
      sata_mv: add IRQ checks
      ata: libahci_platform: fix IRQ check
      scsi: hisi_sas: Fix IRQ checks
      scsi: jazz_esp: Add IRQ check
      scsi: sun3x_esp: Add IRQ check
      scsi: sni_53c710: Add IRQ check
      i2c: cadence: add IRQ check
      i2c: emev2: add IRQ check
      i2c: jz4780: add IRQ check
      i2c: sh7760: add IRQ check
      i2c: sh7760: fix IRQ error path

Seunghui Lee (1):
      mmc: core: Set read only for SD cards with permanent write protect bit

Shawn Guo (1):
      arm64: dts: qcom: sm8150: fix number of pins in 'gpio-ranges'

Shay Drory (1):
      RDMA/core: Don't access cm_id after its destruction

Shengjiu Wang (1):
      ASoC: ak5558: correct reset polarity

Shixin Liu (3):
      crypto: stm32/hash - Fix PM reference leak on stm32-hash.c
      crypto: stm32/cryp - Fix PM reference leak on stm32-cryp.c
      crypto: omap-aes - Fix PM reference leak on omap-aes.c

Shuah Khan (1):
      ath10k: Fix ath10k_wmi_tlv_op_pull_peer_stats_info() unlock without lock

Sindhu Devale (1):
      RDMA/i40iw: Fix error unwinding when i40iw_hmc_sd_one fails

Sreekanth Reddy (1):
      scsi: mpt3sas: Block PCI config access from userspace during reset

Srikar Dronamraju (1):
      powerpc/smp: Set numa node before updating mask

Srinivas Kandagatla (1):
      soundwire: bus: Fix device found flag correctly

Stefan Assmann (1):
      iavf: remove duplicate free resources calls

Stefan Berger (2):
      tpm: efi: Use local variable for calculating final log size
      tpm: vtpm_proxy: Avoid reading host log when using a virtual device

Stefano Garzarella (1):
      vsock/vmci: log once the failed queue pair allocation

Steffen Dirkwinkel (1):
      platform/x86: pmc_atom: Match all Beckhoff Automation baytrail boards with critclk_systems DMI table

Steven Rostedt (VMware) (3):
      ftrace: Handle commands when closing set_ftrace_filter file
      tracing: Map all PIDs to command lines
      tracing: Restructure trace_clock_global() to never block

Sudhakar Panneerselvam (1):
      md/bitmap: wait for external bitmap writes to complete during tear down

Sun Ke (1):
      nbd: Fix NULL pointer in flush_workqueue

Suravee Suthikulpanit (1):
      iommu/amd: Remove performance counter pre-initialization test

Taehee Yoo (1):
      hsr: use netdev_err() instead of WARN_ONCE()

Takashi Iwai (24):
      ALSA: usb-audio: Add MIDI quirk for Vox ToneLab EX
      ALSA: hda/conexant: Re-order CX5066 quirk table entries
      ALSA: usb-audio: Explicitly set up the clock selector
      ALSA: usb-audio: More constifications
      media: dvb-usb: Fix use-after-free access
      media: dvb-usb: Fix memory leak at error in dvb_usb_device_init()
      ALSA: hda/realtek: Re-order ALC882 Acer quirk table entries
      ALSA: hda/realtek: Re-order ALC882 Sony quirk table entries
      ALSA: hda/realtek: Re-order ALC882 Clevo quirk table entries
      ALSA: hda/realtek: Re-order ALC269 HP quirk table entries
      ALSA: hda/realtek: Re-order ALC269 Acer quirk table entries
      ALSA: hda/realtek: Re-order ALC269 Dell quirk table entries
      ALSA: hda/realtek: Re-order ALC269 ASUS quirk table entries
      ALSA: hda/realtek: Re-order ALC269 Sony quirk table entries
      ALSA: hda/realtek: Re-order ALC269 Lenovo quirk table entries
      ALSA: hda/realtek: Re-order remaining ALC269 quirk table entries
      ALSA: hda/realtek: Re-order ALC662 quirk table entries
      ALSA: hda/realtek: Remove redundant entry for ALC861 Haier/Uniwill devices
      ALSA: usb-audio: Add error checks for usb_driver_claim_interface() calls
      ALSA: intel8x0: Don't update period unless prepared
      ALSA: line6: Fix racy initialization of LINE6 MIDI
      ALSA: usb-audio: Validate MS endpoint descriptors
      ALSA: hda/realtek: Fix silent headphone output on ASUS UX430UA
      ALSA: hda/realtek: Add fixup for HP OMEN laptop

Takashi Sakamoto (6):
      ALSA: bebob: enable to deliver MIDI messages for multiple ports
      ALSA: dice: fix stream format for TC Electronic Konnekt Live at high sampling transfer frequency
      ALSA: dice: fix stream format at middle sampling rate for Alesis iO 26
      ALSA: firewire-lib: fix calculation for size of IR context payload
      ALSA: bebob/oxfw: fix Kconfig entry for Mackie d.2 Pro
      ALSA: firewire-lib: fix check for the size of isochronous packet payload

Tao Ren (1):
      usb: gadget: aspeed: fix dma map failure

Tetsuo Handa (5):
      misc: vmw_vmci: explicitly initialize vmci_notify_bm_set_msg struct
      misc: vmw_vmci: explicitly initialize vmci_datagram payload
      ttyprintk: Add TTY hangup callback.
      Bluetooth: initialize skb_queue_head at l2cap_chan_create()
      tty: vt: always invoke vc->vc_sw->con_resize callback

Thinh Nguyen (2):
      usb: xhci: Fix port minor revision
      usb: dwc3: gadget: Fix START_TRANSFER link state check

Thomas Gleixner (2):
      Revert 337f13046ff0 ("futex: Allow FUTEX_CLOCK_REALTIME with FUTEX_WAIT op")
      KVM: x86: Cancel pvclock_gtod_work on module removal

Thomas Richter (1):
      perf ftrace: Fix access to pid in array when setting a pid filter

Tian Tao (1):
      dm integrity: fix missing goto in bitmap_flush_interval error handling

Timo Gurr (1):
      ALSA: usb-audio: Add dB range mapping for Sennheiser Communications Headset PC 8

Toke Høiland-Jørgensen (1):
      ath9k: Fix error check in ath9k_hw_read_revisions() for PCI devices

Tom Seewald (1):
      qlcnic: Add null check after calling netdev_alloc_skb

Tom Zanussi (4):
      Merge tag 'v5.4.122' into v5.4-rt
      Linux 5.4.122-rt58
      Merge tag 'v5.4.123' into v5.4-rt
      Linux 5.4.123-rt59

Tong Zhang (5):
      crypto: qat - don't release uninitialized resources
      crypto: qat - ADF_STATUS_PF_RUNNING should be set after adf_dev_init
      ALSA: hdsp: don't disable if not enabled
      ALSA: hdspm: don't disable if not enabled
      ALSA: rme9652: don't disable if not enabled

Tony Ambardar (1):
      powerpc: fix EDEADLOCK redefinition error in uapi/asm/errno.h

Tony Lindgren (2):
      bus: ti-sysc: Probe for l4_wkup and l4_cfg interconnect devices first
      PM: runtime: Fix unpaired parent child_count for force_resume

Trond Myklebust (4):
      NFS: Don't discard pNFS layout segments that are marked for return
      NFSv4: Don't discard segments marked for return in _pnfs_return_layout()
      NFSv4.2: Always flush out writes in nfs42_proc_fallocate()
      NFS: Deal correctly with attribute generation counter overflow

Tudor Ambarus (1):
      spi: spi-ti-qspi: Free DMA resources

Tyrel Datwyler (1):
      powerpc/pseries: extract host bridge from pci_bus prior to bus removal

Ulf Hansson (1):
      mmc: core: Fix hanging on I/O during system suspend for removable cards

Vasily Gorbik (1):
      s390/disassembler: increase ebpf disasm buffer size

Ville Syrjälä (1):
      drm/i915: Avoid div-by-zero on gen2

Vineet Gupta (1):
      ARC: entry: fix off-by-one error in syscall number validation

Vitaly Chikunov (1):
      perf beauty: Fix fsconfig generator

Vitaly Kuznetsov (1):
      genirq/matrix: Prevent allocation counter corruption

Vivek Goyal (1):
      fuse: fix write deadlock

Vladimir Barinov (1):
      arm64: dts: renesas: r8a77980: Fix vin4-7 endpoint binding

Vladimir Isaev (1):
      ARC: mm: PAE: use 40-bit physical page mask

Waiman Long (1):
      sched/debug: Fix cgroup_path[] serialization

Wang Li (2):
      spi: qup: fix PM reference leak in spi_qup_remove()
      spi: fsl-lpspi: Fix PM reference leak in lpspi_prepare_xfer_hardware()

Wang Wensheng (4):
      RDMA/qedr: Fix error return code in qedr_iw_connect()
      IB/hfi1: Fix error return code in parse_platform_config()
      RDMA/srpt: Fix error return code in srpt_cm_req_recv()
      mm/sparse: add the missing sparse_buffer_fini() in error branch

Wei Yongjun (2):
      spi: dln2: Fix reference leak to master
      spi: omap-100k: Fix reference leak to master

Wesley Cheng (2):
      usb: dwc3: gadget: Ignore EP queue requests during bus reset
      usb: dwc3: gadget: Return success always for kick transfer in ep queue

William A. Kennington III (1):
      spi: Fix use-after-free with devm_spi_alloc_*

Wolfram Sang (1):
      i2c: bail out early when RDWR parameters are wrong

Xie He (1):
      net: lapbether: Prevent racing when checking whether the netif is running

Xin Long (4):
      Revert "net/sctp: fix race condition in sctp_destroy_sock"
      sctp: delay auto_asconf init until binding the first addr
      sctp: do asoc update earlier in sctp_sf_do_dupcook_a
      sctp: fix a SCTP_MIB_CURRESTAB leak in sctp_sf_do_dupcook_b

Xingui Yang (1):
      ata: ahci: Disable SXS for Hisilicon Kunpeng920

Yang Yang (1):
      jffs2: check the validity of dstlen in jffs2_zlib_compress()

Yang Yingliang (11):
      phy: phy-twl4030-usb: Fix possible use-after-free in twl4030_usb_remove()
      power: supply: generic-adc-battery: fix possible use-after-free in gab_remove()
      power: supply: s3c_adc_battery: fix possible use-after-free in s3c_adc_bat_remove()
      media: tc358743: fix possible use-after-free in tc358743_remove()
      media: adv7604: fix possible use-after-free in adv76xx_remove()
      media: i2c: adv7511-v4l2: fix possible use-after-free in adv7511_remove()
      media: i2c: tda1997: Fix possible use-after-free in tda1997x_remove()
      media: i2c: adv7842: fix possible use-after-free in adv7842_remove()
      USB: gadget: udc: fix wrong pointer passed to IS_ERR() and PTR_ERR()
      media: omap4iss: return error code when omap4iss_get() failed
      PCI: endpoint: Fix missing destroy_workqueue()

Yannick Vignon (1):
      net: stmmac: Do not enable RX FIFO overflow interrupts

Yaqi Chen (1):
      samples/bpf: Fix broken tracex1 due to kprobe argument change

Ye Bin (1):
      usbip: vudc: fix missing unlock on error in usbip_sockfd_store()

Yonghong Song (1):
      selftests: Set CC to clang in lib.mk if LLVM is set

Yoshihiro Shimoda (1):
      net: renesas: ravb: Fix a stuck issue when a lot of frames are received

Yufeng Mo (3):
      net: hns3: fix incorrect configuration for igu_egu_hw_err
      net: hns3: initialize the message content in hclge_get_link_mode()
      net: hns3: disable phy loopback setting in hclge_mac_start_phy

Yunjian Wang (1):
      i40e: Fix use-after-free in i40e_client_subtask()

Zhang Yi (2):
      ext4: fix check to prevent false positive report of incorrect used inodes
      ext4: do not set SB_ACTIVE in ext4_orphan_cleanup()

Zhang Zhengming (1):
      bridge: Fix possible races between assigning rx_handler_data and setting IFF_BRIDGE_PORT bit

Zhao Heming (1):
      md: md_open returns -EBUSY when entering racing area

Zhen Lei (4):
      perf data: Fix error return code in perf_data__create_dir()
      tpm: fix error return code in tpm2_get_cc_attrs_tbl()
      ARM: 9064/1: hw_breakpoint: Do not directly check the event's overflow_handler hook
      scsi: qla2xxx: Fix error return code in qla82xx_write_flash_dword()

Zqiang (2):
      lib: stackdepot: turn depot_lock spinlock to raw_spinlock
      locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal

dongjian (1):
      power: supply: Use IRQF_ONESHOT

gexueyuan (1):
      memory: pl353: fix mask of ECC page_size config register

karthik alapati (1):
      staging: wimax/i2400m: fix byte-order issue

lizhe (1):
      jffs2: Fix kasan slab-out-of-bounds problem

louis.wang (1):
      ARM: 9066/1: ftrace: pause/unpause function graph tracer in cpu_suspend()

shaoyunl (1):
      drm/amdgpu : Fix asic reset regression issue introduce by 8f211fe8ac7c4f

yangerkun (1):
      block: reexpand iov_iter after read/write

Álvaro Fernández Rojas (2):
      mtd: rawnand: brcmnand: fix OOB R/W with Hamming ECC
      mips: bmips: fix syscon-reboot nodes
---
Documentation/arm/memory.rst                       |   7 +-
 Documentation/sphinx/parse-headers.pl              |   2 +-
 Documentation/target/tcm_mod_builder.py            |   2 +-
 Documentation/trace/postprocess/decode_msr.py      |   2 +-
 .../postprocess/trace-pagealloc-postprocess.pl     |   2 +-
 .../trace/postprocess/trace-vmscan-postprocess.pl  |   2 +-
 Makefile                                           |  10 +-
 arch/arc/include/asm/page.h                        |  12 +
 arch/arc/include/asm/pgtable.h                     |  12 +-
 arch/arc/include/uapi/asm/page.h                   |   1 -
 arch/arc/kernel/entry.S                            |   4 +-
 arch/arc/mm/ioremap.c                              |   5 +-
 arch/arc/mm/tlb.c                                  |   2 +-
 arch/arm/boot/compressed/Makefile                  |   4 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi            |   6 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |   2 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |   2 +-
 arch/arm/include/asm/fixmap.h                      |   2 +-
 arch/arm/include/asm/kvm_host.h                    |   1 +
 arch/arm/include/asm/memory.h                      |   5 +
 arch/arm/include/asm/prom.h                        |   4 +-
 arch/arm/kernel/asm-offsets.c                      |   3 +
 arch/arm/kernel/atags.h                            |   4 +-
 arch/arm/kernel/atags_parse.c                      |   6 +-
 arch/arm/kernel/devtree.c                          |   6 +-
 arch/arm/kernel/head.S                             |   9 +-
 arch/arm/kernel/hw_breakpoint.c                    |   2 +-
 arch/arm/kernel/setup.c                            |  19 +-
 arch/arm/kernel/smccc-call.S                       |  11 +-
 arch/arm/kernel/suspend.c                          |  19 +-
 arch/arm/mm/init.c                                 |   1 -
 arch/arm/mm/mmu.c                                  |  20 +-
 arch/arm/mm/pv-fixup-asm.S                         |   4 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   3 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   2 +-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |  16 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |   4 +-
 arch/arm64/include/asm/kvm_host.h                  |   1 +
 arch/arm64/kernel/vdso/vdso.lds.S                  |   8 +-
 arch/arm64/kvm/debug.c                             |  88 ++--
 arch/ia64/include/asm/module.h                     |   6 +-
 arch/ia64/kernel/module.c                          |  29 +-
 arch/ia64/scripts/unwcheck.py                      |   2 +-
 arch/m68k/include/asm/mvme147hw.h                  |   3 +
 arch/m68k/mvme147/config.c                         |  14 +-
 arch/m68k/mvme16x/config.c                         |  14 +-
 arch/mips/boot/dts/brcm/bcm3368.dtsi               |   2 +-
 arch/mips/boot/dts/brcm/bcm63268.dtsi              |   2 +-
 arch/mips/boot/dts/brcm/bcm6358.dtsi               |   2 +-
 arch/mips/boot/dts/brcm/bcm6362.dtsi               |   2 +-
 arch/mips/boot/dts/brcm/bcm6368.dtsi               |   2 +-
 arch/mips/include/asm/div64.h                      |  55 ++-
 arch/mips/include/asm/vdso/gettimeofday.h          |  26 +-
 arch/mips/pci/pci-legacy.c                         |   9 +-
 arch/mips/pci/pci-mt7620.c                         |   5 +-
 arch/mips/pci/pci-rt2880.c                         |  37 +-
 arch/openrisc/kernel/setup.c                       |   2 +
 arch/powerpc/Kconfig                               |   2 +-
 arch/powerpc/Kconfig.debug                         |   1 +
 arch/powerpc/include/asm/book3s/64/radix.h         |   6 +-
 arch/powerpc/include/uapi/asm/errno.h              |   1 +
 arch/powerpc/kernel/eeh.c                          |  11 +-
 arch/powerpc/kernel/fadump.c                       |   2 +-
 arch/powerpc/kernel/iommu.c                        |   4 +-
 arch/powerpc/kernel/prom.c                         |   2 +-
 arch/powerpc/kernel/smp.c                          |   6 +-
 arch/powerpc/kvm/book3s_hv.c                       |   3 +
 arch/powerpc/lib/feature-fixups.c                  |  35 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |   4 +-
 arch/powerpc/perf/isa207-common.c                  |   4 +-
 arch/powerpc/platforms/52xx/lite5200_sleep.S       |   2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   3 -
 arch/powerpc/platforms/pseries/pci_dlpar.c         |   4 +-
 arch/powerpc/sysdev/xive/common.c                  |  14 +-
 arch/riscv/include/asm/ftrace.h                    |  14 +-
 arch/riscv/kernel/mcount.S                         |  10 +-
 arch/riscv/kernel/smp.c                            |   2 +-
 arch/s390/crypto/arch_random.c                     |   4 +
 arch/s390/kernel/dis.c                             |   2 +-
 arch/s390/kernel/setup.c                           |   4 +-
 arch/s390/kvm/gaccess.h                            |  54 ++-
 arch/s390/kvm/kvm-s390.c                           |   4 +-
 arch/um/Kconfig.debug                              |   1 +
 arch/um/kernel/Makefile                            |   1 -
 arch/um/kernel/dyn.lds.S                           |   6 +
 arch/um/kernel/gmon_syms.c                         |  16 -
 arch/um/kernel/uml.lds.S                           |   6 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/Makefile                                  |   1 +
 arch/x86/events/amd/iommu.c                        |   6 +-
 arch/x86/include/asm/kvm_host.h                    |   3 -
 arch/x86/kernel/acpi/boot.c                        |  25 +-
 arch/x86/kernel/cpu/common.c                       |   2 +-
 arch/x86/kernel/cpu/microcode/core.c               |   8 +-
 arch/x86/kernel/kprobes/core.c                     |  17 +-
 arch/x86/kernel/setup.c                            |   7 +-
 arch/x86/kvm/mmu.c                                 |  33 +-
 arch/x86/kvm/vmx/nested.c                          |   2 +-
 arch/x86/kvm/x86.c                                 |   2 +-
 arch/x86/lib/msr-smp.c                             |   4 +-
 block/bfq-iosched.c                                |   3 +-
 block/blk-mq-sched.c                               |   8 +-
 block/blk-mq.c                                     |   6 +-
 block/kyber-iosched.c                              |   5 +-
 block/mq-deadline.c                                |   3 +-
 crypto/api.c                                       |   2 +-
 crypto/rng.c                                       |  10 +-
 drivers/acpi/arm64/gtdt.c                          |  10 +-
 drivers/acpi/cppc_acpi.c                           |  14 +-
 drivers/acpi/custom_method.c                       |   4 +-
 drivers/acpi/scan.c                                |   1 +
 drivers/acpi/tables.c                              |  42 +-
 drivers/ata/ahci.c                                 |   5 +
 drivers/ata/ahci.h                                 |   1 +
 drivers/ata/libahci.c                              |   5 +
 drivers/ata/libahci_platform.c                     |   4 +-
 drivers/ata/pata_arasan_cf.c                       |  15 +-
 drivers/ata/pata_ixp4xx_cf.c                       |   6 +-
 drivers/ata/sata_mv.c                              |   4 +
 drivers/base/node.c                                |  26 +-
 drivers/base/power/runtime.c                       |  10 +-
 drivers/base/regmap/regmap-debugfs.c               |   1 +
 drivers/block/nbd.c                                |   3 +-
 drivers/block/null_blk_zoned.c                     |   1 +
 drivers/block/xen-blkback/common.h                 |   1 +
 drivers/block/xen-blkback/xenbus.c                 |  38 +-
 drivers/bus/qcom-ebi2.c                            |   4 +-
 drivers/bus/ti-sysc.c                              |  49 ++
 drivers/cdrom/gdrom.c                              |  13 +-
 drivers/char/tpm/eventlog/common.c                 |   3 +
 drivers/char/tpm/eventlog/efi.c                    |  29 +-
 drivers/char/tpm/tpm2-cmd.c                        |   1 +
 drivers/char/tpm/tpm_tis_core.c                    |  22 +-
 drivers/char/ttyprintk.c                           |  11 +
 drivers/clk/clk-ast2600.c                          |   4 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |  83 ++--
 drivers/clk/qcom/a53-pll.c                         |   1 +
 drivers/clk/samsung/clk-exynos7.c                  |   7 +-
 drivers/clk/socfpga/clk-gate-a10.c                 |   1 +
 drivers/clk/uniphier/clk-uniphier-mux.c            |   4 +-
 drivers/clk/zynqmp/pll.c                           |  12 +-
 drivers/cpufreq/armada-37xx-cpufreq.c              |  76 +++-
 drivers/crypto/omap-aes.c                          |   6 +-
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c           |   4 +-
 drivers/crypto/qat/qat_c62xvf/adf_drv.c            |   4 +-
 drivers/crypto/qat/qat_common/adf_isr.c            |  29 +-
 drivers/crypto/qat/qat_common/adf_transport.c      |   1 +
 drivers/crypto/qat/qat_common/adf_vf_isr.c         |  17 +-
 drivers/crypto/qat/qat_common/qat_algs.c           |  11 +-
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c        |   4 +-
 drivers/crypto/stm32/stm32-cryp.c                  |   4 +-
 drivers/crypto/stm32/stm32-hash.c                  |   8 +-
 drivers/devfreq/devfreq.c                          |   2 +-
 drivers/dma/dw-edma/dw-edma-core.c                 |  11 +-
 drivers/extcon/extcon-arizona.c                    |  57 +--
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/arm_scpi.c                        |   4 +-
 drivers/gpio/gpiolib-acpi.c                        |  14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   2 -
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c           |   7 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  17 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |   6 +
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h             |   9 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  76 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   7 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |  15 +-
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |   1 +
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |   1 +
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |  14 +
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   2 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     |   8 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c   |  18 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |  13 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |   4 +
 drivers/gpu/drm/radeon/radeon.h                    |   1 +
 drivers/gpu/drm/radeon/radeon_atombios.c           |  26 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |   1 +
 drivers/gpu/drm/radeon/radeon_pm.c                 |   8 +
 drivers/gpu/drm/radeon/si_dpm.c                    |   3 +
 drivers/gpu/drm/vkms/vkms_crtc.c                   |   3 +-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-plantronics.c                      |  60 ++-
 drivers/hsi/hsi_core.c                             |   3 +-
 drivers/hv/channel_mgmt.c                          |  30 +-
 drivers/hwmon/lm80.c                               |  11 +-
 drivers/hwmon/occ/common.c                         |   5 +-
 drivers/hwmon/occ/common.h                         |   2 +-
 drivers/hwtracing/intel_th/gth.c                   |   4 +-
 drivers/hwtracing/intel_th/pci.c                   |  10 +
 drivers/i2c/busses/i2c-cadence.c                   |   5 +-
 drivers/i2c/busses/i2c-emev2.c                     |   5 +-
 drivers/i2c/busses/i2c-img-scb.c                   |   4 +-
 drivers/i2c/busses/i2c-imx-lpi2c.c                 |   2 +-
 drivers/i2c/busses/i2c-jz4780.c                    |   5 +-
 drivers/i2c/busses/i2c-omap.c                      |   8 +-
 drivers/i2c/busses/i2c-sh7760.c                    |   5 +-
 drivers/i2c/busses/i2c-sprd.c                      |   4 +-
 drivers/i2c/i2c-dev.c                              |   9 +-
 drivers/i3c/master.c                               |   5 +-
 drivers/iio/accel/adis16201.c                      |   2 +-
 drivers/iio/gyro/mpu3050-core.c                    |  13 +-
 drivers/iio/light/tsl2583.c                        |   8 +
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   1 +
 drivers/infiniband/core/cma.c                      |   4 +-
 drivers/infiniband/core/uverbs_std_types_device.c  |   4 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |   1 +
 drivers/infiniband/hw/cxgb4/resource.c             |   2 +-
 drivers/infiniband/hw/hfi1/firmware.c              |   1 +
 drivers/infiniband/hw/i40iw/i40iw_pble.c           |   6 +-
 drivers/infiniband/hw/mlx5/main.c                  |   1 +
 drivers/infiniband/hw/qedr/qedr_iw_cm.c            |   4 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   7 +
 drivers/infiniband/sw/siw/siw_mem.c                |   4 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |  11 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   1 +
 drivers/input/touchscreen/elants_i2c.c             |  44 +-
 drivers/input/touchscreen/ili210x.c                |   2 +-
 drivers/input/touchscreen/silead.c                 |  44 +-
 drivers/iommu/amd_iommu_init.c                     |  49 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   |   2 +-
 drivers/irqchip/irq-gic-v3.c                       |   8 +-
 drivers/isdn/capi/kcapi.c                          |   4 +-
 drivers/leds/leds-lp5523.c                         |   2 +-
 drivers/md/dm-integrity.c                          |   1 +
 drivers/md/dm-raid.c                               |  34 +-
 drivers/md/dm-rq.c                                 |   2 +
 drivers/md/dm-snap.c                               |   1 +
 drivers/md/md-bitmap.c                             |   2 +
 drivers/md/md.c                                    |  73 +--
 drivers/md/persistent-data/dm-btree-internal.h     |   4 +-
 drivers/md/persistent-data/dm-space-map-common.c   |   2 +
 drivers/md/persistent-data/dm-space-map-common.h   |   8 +-
 drivers/md/raid1.c                                 |   2 +
 drivers/media/dvb-core/dvbdev.c                    |   1 +
 drivers/media/i2c/adv7511-v4l2.c                   |   2 +-
 drivers/media/i2c/adv7604.c                        |   2 +-
 drivers/media/i2c/adv7842.c                        |   2 +-
 drivers/media/i2c/tc358743.c                       |   2 +-
 drivers/media/i2c/tda1997x.c                       |   2 +-
 drivers/media/pci/saa7164/saa7164-encoder.c        |  20 +-
 drivers/media/pci/sta2x11/Kconfig                  |   1 +
 drivers/media/platform/aspeed-video.c              |   9 +-
 drivers/media/platform/rcar_drif.c                 |   1 -
 drivers/media/platform/sti/bdisp/bdisp-debug.c     |   2 +-
 .../media/platform/sunxi/sun6i-csi/sun6i_video.c   |   4 +-
 drivers/media/platform/vivid/vivid-core.c          |   6 +-
 drivers/media/platform/vivid/vivid-vid-out.c       |   2 +-
 drivers/media/rc/ite-cir.c                         |   8 +-
 drivers/media/tuners/m88rs6000t.c                  |   6 +-
 drivers/media/usb/dvb-usb/dvb-usb-init.c           |  90 ++--
 drivers/media/usb/dvb-usb/dvb-usb.h                |   2 +-
 drivers/media/usb/em28xx/em28xx-dvb.c              |   1 +
 drivers/media/usb/gspca/gspca.c                    |   2 +
 drivers/media/usb/gspca/gspca.h                    |   1 +
 drivers/media/usb/gspca/sq905.c                    |   2 +-
 drivers/media/usb/gspca/stv06xx/stv06xx.c          |   9 +
 drivers/media/v4l2-core/v4l2-ctrls.c               |  17 +-
 drivers/memory/omap-gpmc.c                         |   7 +-
 drivers/memory/pl353-smc.c                         |   2 +-
 drivers/mfd/arizona-irq.c                          |   2 +-
 drivers/mfd/stm32-timers.c                         |   7 +-
 drivers/misc/ics932s401.c                          |   2 +-
 drivers/misc/kgdbts.c                              |  26 +-
 drivers/misc/lis3lv02d/lis3lv02d.c                 |  21 +-
 drivers/misc/vmw_vmci/vmci_doorbell.c              |   2 +-
 drivers/misc/vmw_vmci/vmci_guest.c                 |   2 +-
 drivers/mmc/core/block.c                           |  16 +
 drivers/mmc/core/core.c                            |  76 +---
 drivers/mmc/core/core.h                            |  17 +-
 drivers/mmc/core/host.c                            |  40 +-
 drivers/mmc/core/mmc.c                             |   7 +
 drivers/mmc/core/mmc_ops.c                         |   4 +-
 drivers/mmc/core/sd.c                              |   6 +
 drivers/mmc/core/sdio.c                            |  28 +-
 drivers/mmc/host/sdhci-pci-core.c                  |  29 ++
 drivers/mmc/host/sdhci-pci-gli.c                   |   7 +-
 drivers/mmc/host/sdhci-pci.h                       |   2 +
 drivers/mmc/host/sdhci.c                           |  60 +--
 drivers/mmc/host/uniphier-sd.c                     |   5 +-
 drivers/mtd/mtdchar.c                              |   8 +-
 drivers/mtd/mtdcore.c                              |   3 +
 drivers/mtd/nand/raw/atmel/nand-controller.c       |   6 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           |   6 +
 drivers/mtd/nand/raw/fsmc_nand.c                   |   2 +
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         |   2 +-
 drivers/mtd/nand/raw/qcom_nandc.c                  |   7 +-
 drivers/mtd/nand/spi/core.c                        |   2 +
 drivers/net/can/m_can/m_can.c                      |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  29 +-
 .../net/ethernet/cavium/liquidio/cn23xx_pf_regs.h  |   2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c  |  22 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |   7 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  15 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |   2 +
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |   1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   7 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   2 -
 drivers/net/ethernet/intel/igb/igb_main.c          |   3 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |   1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c  |  30 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   3 +-
 drivers/net/ethernet/qualcomm/emac/emac-mac.c      |   4 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  35 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |   8 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |   7 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  14 +-
 drivers/net/ethernet/sun/niu.c                     |  32 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   4 +-
 drivers/net/fddi/Kconfig                           |  15 +-
 drivers/net/fddi/defxx.c                           |  47 +-
 drivers/net/geneve.c                               |   4 +-
 drivers/net/phy/intel-xway.c                       |  21 +
 drivers/net/usb/ax88179_178a.c                     |   4 +-
 drivers/net/virtio_net.c                           |  10 +-
 drivers/net/wan/lapbether.c                        |  32 +-
 drivers/net/wimax/i2400m/op-rfkill.c               |   2 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |   3 +
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |   2 +-
 drivers/net/wireless/ath/ath9k/hw.c                |   2 +-
 drivers/net/wireless/intel/ipw2x00/libipw_wx.c     |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |   7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |   7 +-
 drivers/net/wireless/marvell/mwl8k.c               |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |   4 +
 drivers/net/wireless/mediatek/mt7601u/eeprom.c     |   2 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c     |   6 +-
 drivers/net/wireless/realtek/rtlwifi/base.c        |  18 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/table.c | 500 +++++++++++++++------
 drivers/net/wireless/realtek/rtw88/phy.c           |   5 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |   2 +-
 drivers/net/wireless/wl3501.h                      |  47 +-
 drivers/net/wireless/wl3501_cs.c                   |  54 +--
 drivers/nfc/pn533/pn533.c                          |   3 +
 drivers/nvme/host/core.c                           |   6 +-
 drivers/nvme/host/multipath.c                      |  59 +--
 drivers/nvme/host/nvme.h                           |   8 +-
 drivers/nvme/host/pci.c                            |   2 +-
 drivers/nvme/host/tcp.c                            |   4 +-
 drivers/nvme/target/io-cmd-file.c                  |   8 +-
 drivers/nvme/target/tcp.c                          |   4 +-
 drivers/of/fdt.c                                   |  12 +-
 drivers/pci/controller/pci-thunder-ecam.c          |   2 +-
 drivers/pci/controller/pci-thunder-pem.c           |  13 +-
 drivers/pci/controller/pcie-iproc-msi.c            |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |   3 +
 drivers/pci/hotplug/acpiphp_glue.c                 |   1 +
 drivers/pci/pci.c                                  |  16 +-
 drivers/pci/pci.h                                  |   6 +
 drivers/pci/probe.c                                |   1 +
 drivers/pci/vpd.c                                  |   1 -
 drivers/perf/arm_pmu_platform.c                    |   2 +-
 drivers/phy/marvell/Kconfig                        |   4 +-
 drivers/phy/ti/phy-twl4030-usb.c                   |   2 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |   3 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |  10 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  11 +-
 drivers/platform/x86/dell-smbios-wmi.c             |   3 +-
 drivers/platform/x86/intel_pmc_core.c              |  19 +-
 drivers/platform/x86/pmc_atom.c                    |  28 +-
 drivers/platform/x86/thinkpad_acpi.c               |  31 +-
 drivers/power/supply/bq27xxx_battery.c             |  51 ++-
 drivers/power/supply/generic-adc-battery.c         |   2 +-
 drivers/power/supply/lp8788-charger.c              |   2 +-
 drivers/power/supply/pm2301_charger.c              |   2 +-
 drivers/power/supply/s3c_adc_battery.c             |   2 +-
 drivers/power/supply/tps65090-charger.c            |   2 +-
 drivers/power/supply/tps65217_charger.c            |   2 +-
 drivers/rapidio/rio_cm.c                           |  17 +-
 drivers/rpmsg/qcom_glink_native.c                  |   1 +
 drivers/rtc/rtc-ds1307.c                           |  12 +-
 drivers/rtc/rtc-fsl-ftm-alarm.c                    |   1 +
 drivers/scsi/device_handler/scsi_dh_alua.c         |   5 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c             |   6 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                     |  57 ++-
 drivers/scsi/jazz_esp.c                            |   4 +-
 drivers/scsi/libfc/fc_lport.c                      |   2 +-
 drivers/scsi/lpfc/lpfc_attr.c                      |  75 ++--
 drivers/scsi/lpfc/lpfc_crtn.h                      |   3 -
 drivers/scsi/lpfc/lpfc_hw4.h                       | 174 +------
 drivers/scsi/lpfc/lpfc_init.c                      | 112 +----
 drivers/scsi/lpfc/lpfc_mbox.c                      |  36 --
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |  11 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                     |   1 -
 drivers/scsi/lpfc/lpfc_sli.c                       |  54 ++-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   4 +
 drivers/scsi/qla2xxx/qla_attr.c                    |   8 +-
 drivers/scsi/qla2xxx/qla_bsg.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_nx.c                      |   3 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   7 -
 drivers/scsi/smartpqi/smartpqi_init.c              | 160 +++++++
 drivers/scsi/sni_53c710.c                          |   5 +-
 drivers/scsi/sun3x_esp.c                           |   4 +-
 drivers/scsi/ufs/ufs-hisi.c                        |  15 +-
 drivers/scsi/ufs/ufshcd.c                          |  19 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c              |   4 +-
 drivers/soc/qcom/mdt_loader.c                      |  17 +
 drivers/soundwire/bus.c                            |   3 +-
 drivers/soundwire/stream.c                         |  10 +-
 drivers/spi/spi-ath79.c                            |   3 +-
 drivers/spi/spi-dln2.c                             |   2 +-
 drivers/spi/spi-fsl-lpspi.c                        |   2 +-
 drivers/spi/spi-omap-100k.c                        |   6 +-
 drivers/spi/spi-qup.c                              |   2 +-
 drivers/spi/spi-stm32.c                            |   3 +-
 drivers/spi/spi-ti-qspi.c                          |  20 +-
 drivers/spi/spi.c                                  |   9 +-
 drivers/staging/fwserial/fwserial.c                |  10 +-
 drivers/staging/greybus/uart.c                     |  13 +-
 drivers/staging/media/imx/imx-media-capture.c      |   2 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c             |  36 +-
 drivers/staging/media/omap4iss/iss.c               |   4 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   2 +-
 drivers/target/target_core_pscsi.c                 |   3 +-
 drivers/target/target_core_user.c                  |   4 +-
 drivers/tee/optee/core.c                           |  10 -
 drivers/thermal/fair_share.c                       |   4 +
 drivers/thermal/of-thermal.c                       |   7 +-
 drivers/tty/amiserial.c                            |   1 +
 drivers/tty/moxa.c                                 |  18 +-
 drivers/tty/n_gsm.c                                |  14 +-
 drivers/tty/serial/mvebu-uart.c                    |   3 -
 drivers/tty/serial/serial_core.c                   |   6 +-
 drivers/tty/serial/stm32-usart.c                   |  17 +-
 drivers/tty/serial/stm32-usart.h                   |   3 -
 drivers/tty/tty_io.c                               |   8 +-
 drivers/tty/vt/vt.c                                |   3 +-
 drivers/tty/vt/vt_ioctl.c                          |   6 +-
 drivers/uio/uio_hv_generic.c                       |   8 +-
 drivers/usb/class/cdc-acm.c                        |  16 +-
 drivers/usb/class/cdc-wdm.c                        |  30 +-
 drivers/usb/core/hub.c                             |   8 +-
 drivers/usb/core/quirks.c                          |   4 +
 drivers/usb/dwc2/core.h                            |   2 +
 drivers/usb/dwc2/core_intr.c                       | 162 ++++---
 drivers/usb/dwc2/gadget.c                          |   3 +-
 drivers/usb/dwc2/hcd.c                             |  10 +-
 drivers/usb/dwc3/dwc3-omap.c                       |   5 +
 drivers/usb/dwc3/dwc3-pci.c                        |   1 +
 drivers/usb/dwc3/gadget.c                          |  30 +-
 drivers/usb/gadget/config.c                        |   4 +
 drivers/usb/gadget/function/f_fs.c                 |   3 +-
 drivers/usb/gadget/function/f_uac1.c               |  43 ++
 drivers/usb/gadget/function/f_uac2.c               |  39 +-
 drivers/usb/gadget/function/f_uvc.c                |   8 +-
 drivers/usb/gadget/legacy/webcam.c                 |   1 +
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |   3 +-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |   2 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |  23 +-
 drivers/usb/gadget/udc/fotg210-udc.c               |  26 +-
 drivers/usb/gadget/udc/pch_udc.c                   |  49 +-
 drivers/usb/gadget/udc/r8a66597-udc.c              |   2 +
 drivers/usb/gadget/udc/snps_udc_plat.c             |   4 +-
 drivers/usb/host/fotg210-hcd.c                     |   4 +-
 drivers/usb/host/sl811-hcd.c                       |   9 +-
 drivers/usb/host/xhci-ext-caps.h                   |   5 +-
 drivers/usb/host/xhci-mem.c                        |   9 +
 drivers/usb/host/xhci-mtk-sch.c                    |  80 +++-
 drivers/usb/host/xhci-mtk.c                        |   3 +
 drivers/usb/host/xhci-mtk.h                        |   7 +-
 drivers/usb/host/xhci-pci.c                        |   4 +-
 drivers/usb/host/xhci.c                            |  20 +-
 drivers/usb/musb/musb_core.c                       |   2 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |   9 +-
 drivers/usb/serial/usb_wwan.c                      |   9 +-
 drivers/usb/typec/tcpm/tcpci.c                     |  21 +-
 drivers/usb/typec/tcpm/tcpm.c                      | 105 +++--
 drivers/usb/usbip/vudc_sysfs.c                     |   2 +
 drivers/vfio/Kconfig                               |   2 +-
 drivers/vfio/mdev/mdev_sysfs.c                     |   2 +-
 drivers/video/console/vgacon.c                     |  56 ++-
 drivers/video/fbdev/core/fbcmap.c                  |   8 +-
 drivers/video/fbdev/core/fbcon.c                   |   2 +-
 drivers/video/fbdev/hgafb.c                        |  21 +-
 drivers/video/fbdev/imsttfb.c                      |   5 -
 drivers/xen/xen-pciback/xenbus.c                   |  22 +-
 fs/block_dev.c                                     |  20 +-
 fs/btrfs/ctree.c                                   |  20 +
 fs/btrfs/inode.c                                   |   1 +
 fs/btrfs/ioctl.c                                   |  18 +-
 fs/btrfs/relocation.c                              |   6 +-
 fs/ceph/caps.c                                     |   1 +
 fs/ceph/export.c                                   |   4 +-
 fs/ceph/inode.c                                    |   1 +
 fs/cifs/smb2ops.c                                  |   4 +-
 fs/dlm/debug_fs.c                                  |   1 +
 fs/ecryptfs/crypto.c                               |   6 +-
 fs/ecryptfs/main.c                                 |   6 +
 fs/erofs/erofs_fs.h                                |   3 +
 fs/erofs/inode.c                                   |   7 +
 fs/ext4/ialloc.c                                   |  48 +-
 fs/ext4/super.c                                    |   9 +-
 fs/ext4/verity.c                                   |  89 ++--
 fs/f2fs/inline.c                                   |   3 +-
 fs/f2fs/node.c                                     |   3 +
 fs/f2fs/verity.c                                   |  75 +++-
 fs/fuse/cuse.c                                     |   2 +
 fs/fuse/file.c                                     |  41 +-
 fs/fuse/fuse_i.h                                   |   1 +
 fs/fuse/virtio_fs.c                                |   1 +
 fs/hfsplus/extents.c                               |   7 +-
 fs/hugetlbfs/inode.c                               |   5 +
 fs/iomap/buffered-io.c                             |  34 +-
 fs/jffs2/compr_rtime.c                             |   3 +
 fs/jffs2/scan.c                                    |   2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c             |   2 +-
 fs/nfs/inode.c                                     |   8 +-
 fs/nfs/nfs42proc.c                                 |  21 +-
 fs/nfs/pnfs.c                                      |   7 +-
 fs/overlayfs/copy_up.c                             |   3 +-
 fs/overlayfs/super.c                               |  12 +-
 fs/squashfs/file.c                                 |   6 +-
 fs/ubifs/replay.c                                  |   3 +-
 include/crypto/acompress.h                         |   2 +
 include/crypto/aead.h                              |   2 +
 include/crypto/akcipher.h                          |   2 +
 include/crypto/hash.h                              |   4 +
 include/crypto/kpp.h                               |   2 +
 include/crypto/rng.h                               |   2 +
 include/crypto/skcipher.h                          |   2 +
 include/linux/acpi.h                               |   9 +-
 include/linux/bpf_verifier.h                       |   5 +-
 include/linux/console_struct.h                     |   1 +
 include/linux/elevator.h                           |   2 +-
 include/linux/hid.h                                |   2 +
 include/linux/i2c.h                                |   2 +
 include/linux/iomap.h                              |   1 +
 include/linux/kvm_host.h                           |   4 +-
 include/linux/mm.h                                 |  32 ++
 include/linux/mm_types.h                           |   4 +-
 include/linux/mmc/host.h                           |   3 -
 include/linux/module.h                             |  26 +-
 include/linux/pm.h                                 |   1 +
 include/linux/power/bq27xxx_battery.h              |   1 -
 include/linux/smp.h                                |   2 +-
 include/linux/spi/spi.h                            |   3 +
 include/linux/tty_driver.h                         |   2 +-
 include/linux/virtio_net.h                         |  14 +-
 include/net/addrconf.h                             |   1 -
 include/net/bluetooth/hci_core.h                   |   1 +
 include/net/nfc/nci_core.h                         |   1 +
 include/net/page_pool.h                            |  12 +-
 include/scsi/libfcoe.h                             |   2 +-
 include/uapi/linux/netfilter/xt_SECMARK.h          |   6 +
 include/uapi/linux/tty_flags.h                     |   4 +-
 include/uapi/linux/usb/video.h                     |   3 +-
 kernel/.gitignore                                  |   1 +
 kernel/Makefile                                    |   9 +-
 kernel/bpf/verifier.c                              | 278 ++++++++----
 kernel/events/core.c                               |  12 +-
 kernel/futex.c                                     |   3 +-
 kernel/irq/matrix.c                                |   4 +-
 kernel/kexec_file.c                                |   4 +-
 kernel/locking/mutex-debug.c                       |   4 +-
 kernel/locking/mutex-debug.h                       |   2 +-
 kernel/locking/mutex.c                             |  18 +-
 kernel/locking/mutex.h                             |   4 +-
 kernel/module.c                                    |  60 ++-
 kernel/ptrace.c                                    |  18 +-
 kernel/sched/core.c                                |   2 +-
 kernel/sched/debug.c                               |  42 +-
 kernel/sched/fair.c                                |  16 +-
 kernel/smp.c                                       |  10 +-
 kernel/time/posix-timers.c                         |   4 +-
 kernel/trace/ftrace.c                              |   5 +-
 kernel/trace/trace.c                               |  41 +-
 kernel/trace/trace_clock.c                         |  44 +-
 kernel/up.c                                        |   2 +-
 lib/Makefile                                       |   4 +-
 lib/bug.c                                          |  33 +-
 lib/kobject_uevent.c                               |   9 +-
 lib/nlattr.c                                       |   2 +-
 lib/stackdepot.c                                   |   6 +-
 localversion-rt                                    |   2 +-
 mm/hugetlb.c                                       |  11 +-
 mm/khugepaged.c                                    |  18 +-
 mm/ksm.c                                           |   1 +
 mm/memory-failure.c                                |   2 +-
 mm/migrate.c                                       |   7 +
 mm/shmem.c                                         |  34 +-
 mm/sparse.c                                        |   1 +
 net/bluetooth/ecdh_helper.h                        |   2 +-
 net/bluetooth/hci_event.c                          |   3 +-
 net/bluetooth/hci_request.c                        |  12 +-
 net/bluetooth/l2cap_core.c                         |   4 +
 net/bluetooth/l2cap_sock.c                         |  32 +-
 net/bluetooth/smp.c                                |   9 +
 net/bridge/br_arp_nd_proxy.c                       |   4 +-
 net/bridge/br_multicast.c                          |  33 +-
 net/bridge/br_netlink.c                            |   5 +-
 net/core/dev.c                                     |   8 +-
 net/core/ethtool.c                                 |   2 +-
 net/core/flow_dissector.c                          |   6 +-
 net/core/page_pool.c                               |   6 +-
 net/hsr/hsr_framereg.c                             |   3 +-
 net/ipv4/route.c                                   |  42 +-
 net/ipv4/tcp_cong.c                                |   4 +
 net/ipv6/ip6_gre.c                                 |   7 +-
 net/ipv6/ip6_tunnel.c                              |   3 +-
 net/ipv6/ip6_vti.c                                 |   3 +-
 net/ipv6/mcast_snoop.c                             |  12 +-
 net/ipv6/sit.c                                     |   5 +-
 net/mac80211/main.c                                |   7 +-
 net/mac80211/mlme.c                                |   5 +
 net/netfilter/nf_conntrack_standalone.c            |   5 +-
 net/netfilter/nfnetlink_osf.c                      |   2 +
 net/netfilter/nft_set_hash.c                       |  10 +-
 net/netfilter/xt_SECMARK.c                         |  88 +++-
 net/nfc/digital_dep.c                              |   2 +
 net/nfc/llcp_sock.c                                |   4 +
 net/nfc/nci/core.c                                 |   1 +
 net/nfc/nci/hci.c                                  |   5 +
 net/openvswitch/actions.c                          |   8 +-
 net/sched/sch_taprio.c                             |   6 +
 net/sctp/sm_make_chunk.c                           |   2 +-
 net/sctp/sm_statefuns.c                            |  28 +-
 net/sctp/socket.c                                  |  38 +-
 net/smc/af_smc.c                                   |   4 +-
 net/sunrpc/clnt.c                                  |  11 +-
 net/tipc/netlink_compat.c                          |   2 +-
 net/vmw_vsock/vmci_transport.c                     |   3 +-
 net/wireless/scan.c                                |   2 +
 net/xdp/xsk_queue.h                                |   7 +-
 samples/bpf/tracex1_kern.c                         |   4 +-
 samples/kfifo/bytestream-example.c                 |   8 +-
 samples/kfifo/inttype-example.c                    |   8 +-
 samples/kfifo/record-example.c                     |   8 +-
 scripts/bloat-o-meter                              |   2 +-
 scripts/config                                     |   2 +-
 scripts/diffconfig                                 |   2 +-
 scripts/get_abi.pl                                 |   2 +-
 scripts/kconfig/nconf.c                            |   2 +-
 scripts/recordmcount.pl                            |   2 +-
 scripts/show_delta                                 |   2 +-
 scripts/sphinx-pre-install                         |   2 +-
 scripts/split-man.pl                               |   2 +-
 scripts/tracing/draw_functrace.py                  |   2 +-
 security/commoncap.c                               |   2 +-
 sound/core/init.c                                  |   2 -
 sound/firewire/Kconfig                             |   4 +-
 sound/firewire/amdtp-stream.c                      |  27 +-
 sound/firewire/bebob/bebob.c                       |   2 +-
 sound/firewire/bebob/bebob_stream.c                |  12 +-
 sound/firewire/dice/dice-alesis.c                  |   2 +-
 sound/firewire/dice/dice-tcelectronic.c            |   4 +-
 sound/firewire/oxfw/oxfw.c                         |   1 -
 sound/isa/sb/emu8000.c                             |   4 +-
 sound/isa/sb/sb16_csp.c                            |   8 +-
 sound/isa/sb/sb8.c                                 |   4 -
 sound/pci/hda/hda_generic.c                        |  16 +-
 sound/pci/hda/patch_conexant.c                     |  14 +-
 sound/pci/hda/patch_hdmi.c                         |   4 +-
 sound/pci/hda/patch_realtek.c                      | 269 ++++++++---
 sound/pci/intel8x0.c                               |   7 +
 sound/pci/rme9652/hdsp.c                           |   3 +-
 sound/pci/rme9652/hdspm.c                          |   3 +-
 sound/pci/rme9652/rme9652.c                        |   3 +-
 sound/soc/codecs/ak5558.c                          |   4 +-
 sound/soc/codecs/rt286.c                           |  23 +-
 sound/soc/generic/audio-graph-card.c               |   2 +-
 sound/soc/generic/simple-card.c                    |   2 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  20 +
 sound/soc/intel/boards/kbl_da7219_max98927.c       |  38 +-
 sound/soc/samsung/tm2_wm5110.c                     |   2 +-
 sound/soc/sh/rcar/core.c                           |  69 ++-
 sound/soc/sh/rcar/ssi.c                            |  16 +-
 sound/usb/card.c                                   |  14 +-
 sound/usb/clock.c                                  |  18 +-
 sound/usb/line6/driver.c                           |   4 +
 sound/usb/line6/pod.c                              |   5 -
 sound/usb/line6/variax.c                           |   6 -
 sound/usb/midi.c                                   |   6 +-
 sound/usb/mixer.c                                  |  60 +--
 sound/usb/mixer_maps.c                             |  68 +--
 sound/usb/mixer_quirks.c                           |   6 +-
 sound/usb/mixer_scarlett.c                         |  14 +-
 sound/usb/proc.c                                   |   2 +-
 sound/usb/quirks-table.h                           |  10 +
 sound/usb/quirks.c                                 |  16 +-
 sound/usb/stream.c                                 |   4 +-
 sound/usb/usbaudio.h                               |   2 +
 sound/usb/validate.c                               |   4 +-
 tools/perf/builtin-ftrace.c                        |   2 +-
 tools/perf/python/tracepoint.py                    |   2 +-
 tools/perf/python/twatch.py                        |   2 +-
 tools/perf/trace/beauty/fsconfig.sh                |   7 +-
 tools/perf/util/data.c                             |   5 +-
 tools/perf/util/symbol_fprintf.c                   |   2 +-
 tools/perf/util/unwind-libdw.c                     |  35 +-
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |   2 +-
 tools/testing/ktest/compare-ktest-sample.pl        |   2 +-
 tools/testing/selftests/bpf/test_offload.py        |   2 +-
 .../selftests/bpf/verifier/bounds_deduction.c      |  21 +-
 .../bpf/verifier/bounds_mix_sign_unsign.c          |  13 -
 tools/testing/selftests/bpf/verifier/unpriv.c      |   2 +-
 .../selftests/bpf/verifier/value_ptr_arith.c       |   6 +-
 tools/testing/selftests/kselftest/prefix.pl        |   2 +-
 tools/testing/selftests/lib.mk                     |   4 +
 .../net/forwarding/mirror_gre_vlan_bridge_1q.sh    |   2 +-
 tools/testing/selftests/tc-testing/tdc_batch.py    |   2 +-
 .../testing/selftests/tc-testing/tdc_multibatch.py |   2 +-
 virt/kvm/arm/arm.c                                 |   2 +
 virt/kvm/coalesced_mmio.c                          |  19 +-
 virt/kvm/kvm_main.c                                |  10 +-
 725 files changed, 5924 insertions(+), 3224 deletions(-)

