Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEAAC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Sep 2021 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B767F60462
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Sep 2021 15:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349745AbhICP3e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349653AbhICP3d (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Sep 2021 11:29:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D5BC61056;
        Fri,  3 Sep 2021 15:28:33 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.206-rt87
Date:   Fri, 03 Sep 2021 15:27:33 -0000
Message-ID: <163068285333.1001878.13698469774076687811@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.206-rt87 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: e4215cf649dc8c5b424cc8a72dc0da8c4d54fe35

Or to build 4.19.206-rt87 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.206.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.206-rt87.patch.xz


You can also build from 4.19.199-rt86 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.199-rt86-rt87.patch.xz

Enjoy!
Clark

Changes from v4.19.199-rt86:
---

Adrian Larumbe (1):
      dmaengine: xilinx_dma: Fix read-after-free bug when terminating transfers

Alex Xu (Hello71) (1):
      pipe: increase minimum default pipe size to 2 pages

Alexander Tsoy (1):
      ALSA: usb-audio: Add registration quirk for JBL Quantum 600

Andy Shevchenko (1):
      ptp_pch: Restore dependency on PCI

Anirudh Rayabharam (2):
      firmware_loader: use -ETIMEDOUT instead of -EAGAIN in fw_load_sysfs_fallback
      firmware_loader: fix use-after-free in firmware_fallback_sysfs

Anson Huang (1):
      ARM: imx: add mmdc ipg clock operation for mmdc

Antoine Tenart (1):
      net: ipv6: fix returned variable type in ip6_skb_dst_mtu

Arkadiusz Kubalewski (1):
      i40e: Fix logic of disabling queues

Arnaldo Carvalho de Melo (1):
      Revert "perf map: Fix dso->nsinfo refcounting"

Axel Lin (1):
      regulator: rt5033: Fix n_voltages settings for BUCK and LDO

Babu Moger (1):
      x86/resctrl: Fix default monitoring groups reporting

Ben Skeggs (1):
      drm/nouveau/disp: power down unused DP links during init

Bixuan Cui (1):
      genirq/msi: Ensure deactivation on teardown

Chris Lesiak (1):
      iio: humidity: hdc100x: Add margin to the conversion time

Christoph Hellwig (3):
      bdi: move bdi_dev_name out of line
      bdi: add a ->dev_name field to struct backing_dev_info
      libata: fix ata_pio_sector for CONFIG_HIGHMEM

Christophe JAILLET (1):
      xgene-v2: Fix a resource leak in the error handling path of 'xge_probe()'

Clark Williams (5):
      Merge tag 'v4.19.201' into v4.19-rt
      Merge tag 'v4.19.204' into v4.19-rt
      Merge tag 'v4.19.205' into v4.19-rt
      Merge tag 'v4.19.206' into v4.19-rt
      Linux 4.19.206-rt87

Colin Ian King (1):
      iio: adc: Fix incorrect exit of for-loop

Cristian Marussi (1):
      firmware: arm_scmi: Fix range check for the maximum number of pending messages

DENG Qingfang (1):
      net: dsa: mt7530: add the missing RxUnicast MIB counter

Dan Carpenter (2):
      can: hi311x: fix a signedness bug in hi3110_cmd()
      bnx2x: fix an error code in bnx2x_nic_load()

Dan Williams (1):
      ACPI: NFIT: Fix support for virtual SPA ranges

Daniel Borkmann (7):
      bpf: Inherit expanded/patched seen count from old aux data
      bpf: Do not mark insn as seen under speculative path verification
      bpf: Fix leakage under speculation on mispredicted branches
      bpf, selftests: Adjust few selftest outcomes wrt unreachable code
      bpf: Do not use ax register in interpreter on div/mod
      bpf: Fix 32 bit src register truncation on div/mod
      bpf: Fix truncation handling for mod32 dst reg wrt zero

Daniel Jordan (2):
      padata: validate cpumask without removed CPU during offline
      padata: add separate cpuhp node for CPUHP_PADATA_DEAD

Daniele Palmas (1):
      USB: serial: option: add Telit FD980 composition 0x1056

Dario Binacchi (1):
      clk: stm32f4: fix post divisor setup for I2S/SAI PLLs

Dave Gerlach (1):
      ARM: dts: am43x-epos-evm: Reduce i2c0 bus speed for tps65218

David Bauer (1):
      USB: serial: ftdi_sio: add device ID for Auto-M3 OP-COM v2

Denis Efremov (1):
      Revert "floppy: reintroduce O_NDELAY fix"

Desmond Cheong Zhi Xi (4):
      hfs: add missing clean-up in hfs_fill_super
      hfs: fix high memory mapping in hfs_bnode_read
      hfs: add lock nesting notation to hfs_find_init
      btrfs: fix rw device counting in __btrfs_free_extra_devids

Dinghao Liu (1):
      net: qlcnic: add missed unlock in qlcnic_83xx_flash_read32

Dmitry Osipenko (1):
      usb: otg-fsm: Fix hrtimer list corruption

Dongliang Mu (5):
      spi: meson-spicc: fix memory leak in meson_spicc_remove
      ieee802154: hwsim: fix GPF in hwsim_set_edge_lqi
      ieee802154: hwsim: fix GPF in hwsim_new_edge_nl
      ipack: tpci200: fix many double free issues in tpci200_pci_probe
      ipack: tpci200: fix memory leak in the tpci200_register

Eric Dumazet (5):
      net: annotate data race around sk_ll_usec
      virtio_net: Do not pull payload in skb->head
      gro: ensure frag0 meets IP header alignment
      net: igmp: fix data-race in igmp_ifc_timer_expire()
      net: igmp: increase size of mr_ifc_count

Fei Qin (1):
      nfp: update ethtool reporting of pauseframe control

Florian Westphal (2):
      netfilter: conntrack: adjust stop timestamp to real expiry value
      netfilter: conntrack: collect all entries in one cycle

George Kennedy (1):
      fbmem: add margin check to fb_check_caps()

Gerd Rausch (1):
      net/rds: dma_map_sg is entitled to merge entries

Goldwyn Rodrigues (1):
      btrfs: mark compressed range uptodate only if all bio succeed

Greg Kroah-Hartman (10):
      selftest: fix build error in tools/testing/selftests/vm/userfaultfd.c
      Linux 4.19.200
      Linux 4.19.201
      Revert "Bluetooth: Shutdown controller after workqueues are flushed or cancelled"
      Revert "watchdog: iTCO_wdt: Account for rebooting on second timeout"
      Linux 4.19.202
      Linux 4.19.203
      Linux 4.19.204
      i2c: dev: zero out array used for i2c reads from userspace
      Linux 4.19.206

Guangbin Huang (1):
      net: hns3: fix get wrong pfc_en when query PFC configuration

Guenter Roeck (2):
      spi: mediatek: Fix fifo transfer
      ARC: Fix CONFIG_STACKDEPOT

H. Nikolaus Schaller (2):
      omap5-board-common: remove not physically existing vdds_1v8_main fixed-regulator
      mips: Fix non-POSIX regexp

Hans Verkuil (1):
      media: videobuf2-core: dequeue if start_streaming fails

Harshvardhan Jha (1):
      scsi: megaraid_mm: Fix end of loop tests for list_for_each_entry()

Hoang Le (1):
      tipc: fix sleeping in tipc accept routine

Hui Su (1):
      scripts/tracing: fix the bug that can't parse raw_trace_func

Hyunchul Lee (1):
      cifs: fix the out of range assignment to bit fields in parse_server_interfaces

Ivan T. Ivanov (1):
      net: usb: lan78xx: don't modify phy_device state concurrently

Jakub Kicinski (2):
      bnxt: don't lock the tx queue from napi poll
      bnxt: disable napi before canceling DIM

Jan Kiszka (1):
      x86/asm: Ensure asm/proto.h can be included stand-alone

Jani Nikula (1):
      drm/i915: Ensure intel_engine_init_execlist() builds with Clang

Jaroslav Kysela (1):
      ALSA: hda - fix the 'Capture Switch' value change notifications

Jedrzej Jagielski (1):
      i40e: Fix log TC creation failure when max num of queues is exceeded

Jeff Layton (2):
      locks: print a warning when mount fails due to lack of "mand" support
      fs: warn about impending deprecation of mandatory locks

Jens Axboe (1):
      net: split out functions related to registering inflight socket files

Jerome Brunet (1):
      usb: gadget: u_audio: fix race condition on endpoint stop

Jia He (1):
      qed: fix possible unpaired spin_{un}lock_bh in _qed_mcp_cmd_and_union()

Jiapeng Chong (1):
      mlx4: Fix missing error code in mlx4_load_one()

Johan Hovold (2):
      media: rtl28xxu: fix zero-length control request
      Revert "USB: serial: ch341: fix character loss at high transfer rates"

Johannes Berg (1):
      mac80211: drop data frames without key on encrypted links

Jouni Malinen (5):
      ath: Use safer key clearing with key cache entries
      ath9k: Clear key cache explicitly on disabling hardware
      ath: Export ath_hw_keysetmac()
      ath: Modify ath_key_delete() to not need full key entry
      ath9k: Postpone key cache entry deletion for TXQ frames reference it

Juergen Gross (1):
      x86/kvm: fix vcpu-id indexed array sizes

Junxiao Bi (2):
      ocfs2: fix zero out valid data
      ocfs2: issue zeroout to EOF blocks

Kefeng Wang (1):
      once: Fix panic when module unload

Krzysztof Kozlowski (1):
      nfc: nfcsim: fix use after free during module unload

Kyle Russell (1):
      ASoC: tlv320aic31xx: fix reversed bclk/wclk master bits

Lai Jiangshan (1):
      KVM: X86: MMU: Use the correct inherited permissions to get shadow page

Letu Ren (1):
      net/qla3xxx: fix schedule while atomic in ql_wait_for_drvr_lock and ql_adapter_reset

Li Manyi (1):
      scsi: sr: Return correct event when media event code is 3

Like Xu (1):
      perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY bit inside the guest

Linus Torvalds (1):
      vt_kdsetmode: extend console locking

Longfang Liu (1):
      USB:ehci:fix Kunpeng920 ehci hardware problem

Longpeng(Mike) (1):
      vsock/virtio: avoid potential deadlock when vsock device remove

Lukasz Cieplicki (1):
      i40e: Add additional info to PHY type error

Maciej W. Rozycki (2):
      serial: 8250: Mask out floating 16/32-bit bus bits
      MIPS: Malta: Do not byte-swap accesses to the CBUS UART

Maor Gottlieb (1):
      net/mlx5: Fix flow table chaining

Marcelo Ricardo Leitner (1):
      sctp: fix return value check in __sctp_rcv_asconf_lookup

Marcin Bachry (1):
      PCI: Increase D3 delay for AMD Renoir/Cezanne XHCI

Marek Behún (1):
      cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant

Mark Yacoub (1):
      drm: Copy drm_wait_vblank to user before returning

Masami Hiramatsu (1):
      tracing: Reject string operand in the histogram expression

Maxim Devaev (2):
      usb: gadget: f_hid: added GET_IDLE and SET_IDLE handlers
      usb: gadget: f_hid: idle uses the highest byte for duration

Maxim Kiselev (1):
      net: marvell: fix MVNETA_TX_IN_PRGRS bit number

Maxim Levitsky (3):
      KVM: x86: determine if an exception has an error code only when injecting it.
      KVM: nSVM: always intercept VMLOAD/VMSAVE when nested (CVE-2021-3656)
      KVM: nSVM: avoid picking up unsupported bits from L2 in int_ctl (CVE-2021-3653)

Maximilian Heyne (1):
      xen/events: Fix race in set_evtchn_to_irq

Michał Mirosław (1):
      opp: remove WARN when no valid OPPs remain

Miklos Szeredi (2):
      af_unix: fix garbage collect vs MSG_PEEK
      ovl: prevent private clone if bind mount is not allowed

Nathan Chancellor (1):
      vmlinux.lds.h: Handle clang's module.{c,d}tor sections

Neal Cardwell (1):
      tcp_bbr: fix u32 wrap bug in round logic if bbr_init() called after 2B packets

Neeraj Upadhyay (1):
      vringh: Use wiov->used to check for read/write desc order

NeilBrown (1):
      btrfs: prevent rename2 from exchanging a subvol with a directory from different parents

Nguyen Dinh Phi (1):
      cfg80211: Fix possible memory leak in function cfg80211_bss_update

Ole Bjørn Midtbø (1):
      Bluetooth: hidp: use correct wait queue when removing ctrl_wait

Oleksandr Suvorov (1):
      ARM: dts: colibri-imx6ull: limit SDIO clock to 25MHz

Pablo Neira Ayuso (1):
      netfilter: nft_nat: allow to specify layer 4 protocol NAT only

Pali Rohár (2):
      ppp: Fix generating ppp unit id when ifname is not specified
      ppp: Fix generating ifname when empty IFLA_IFNAME is specified

Paolo Bonzini (1):
      KVM: x86: accept userspace interrupt only if no event is injected

Parav Pandit (2):
      virtio: Improve vq->broken access to avoid any compiler optimization
      virtio_pci: Support surprise removal of virtio pci device

Paul Jakma (1):
      NIU: fix incorrect error return, missed in previous revert

Pavel Skripkin (9):
      can: mcba_usb_start(): add missing urb->transfer_dma initialization
      can: usb_8dev: fix memory leak
      can: ems_usb: fix memory leak
      can: esd_usb2: fix memory leak
      net: llc: fix skb_over_panic
      net: pegasus: fix uninit-value in get_interrupt_interval
      net: fec: fix use-after-free in fec_drv_remove
      net: vxge: fix use-after-free in vxge_device_unregister
      net: 6pack: fix slab-out-of-bounds in decode_data

Peter Collingbourne (1):
      net: don't unconditionally copy_from_user a struct ifreq for socket ioctls

Peter Ujfalusi (1):
      dmaengine: of-dma: router_xlate to return -EPROBE_DEFER if controller is not yet available

Phil Elwell (1):
      usb: gadget: f_hid: fixed NULL pointer dereference

Prarit Bhargava (1):
      alpha: Send stop IPI to send to online CPUs

Pravin B Shelar (1):
      net: Fix zero-copy head len calculation.

Pu Lehui (1):
      powerpc/kprobes: Fix kprobe Oops happens in booke

Qiang.zhang (1):
      USB: usbtmc: Fix RCU stall warning

Rafael J. Wysocki (1):
      Revert "ACPICA: Fix memory leak caused by _CID repair function"

Randy Dunlap (2):
      x86/tools: Fix objdump version check again
      dccp: add do-while-0 stubs for dccp_pr_debug macros

Reinhard Speyerer (1):
      qmi_wwan: add network device usage statistics for qmimux devices

Richard Fitzgerald (5):
      ASoC: cs42l42: Correct definition of ADC Volume control
      ASoC: cs42l42: Don't allow SND_SOC_DAIFMT_LEFT_J
      ASoC: cs42l42: Fix inversion of ADC Notch Switch control
      ASoC: cs42l42: Remove duplicate control for WNF filter frequency
      ASoC: cs42l42: Fix LRCLK frame start edge

Roi Dayan (1):
      psample: Add a fwd declaration for skbuff

Ruslan Babayev (1):
      iio: dac: ds4422/ds4424 drop of_node check

Saeed Mirzamohammadi (1):
      iommu/vt-d: Fix agaw for a supported 48 bit guest address width

Saravana Kannan (2):
      net: mdio-mux: Don't ignore memory allocation errors
      net: mdio-mux: Handle -EPROBE_DEFER correctly

Sasha Levin (1):
      Linux 4.19.205

Sasha Neftin (1):
      e1000e: Fix the max snoop/no-snoop latency for 10M

Sean Christopherson (3):
      KVM: x86/mmu: Fix per-cpu counter corruption on 32-bit builds
      KVM: SVM: Fix off-by-one indexing when nullifying last used SEV VMCB
      KVM: x86/mmu: Treat NX as used (not reserved) for all !TDP shadow MMUs

Sergey Marinkevich (1):
      netfilter: nft_exthdr: fix endianness of tcp option cast

Shai Malin (2):
      qed: qed ll2 race condition fixes
      qed: Fix null-pointer dereference in qed_rdma_create_qp()

Shreyansh Chouhan (2):
      reiserfs: check directory items on read from disk
      ip_gre: add validation for csum_start

Sreekanth Reddy (1):
      scsi: core: Avoid printing an error if target_alloc() returns -ENXIO

Srikar Dronamraju (1):
      powerpc/pseries: Fix regression while building external modules

Srinivas Kandagatla (3):
      slimbus: messaging: start transaction ids from 1 instead of zero
      slimbus: messaging: check for valid transaction id
      slimbus: ngd: reset dma setup during runtime pm

Stefan Mätje (1):
      can: usb: esd_usb2: esd_usb2_rx_event(): fix the interchange of the CAN RX and TX error counters

Steven Rostedt (VMware) (3):
      tracing / histogram: Give calculation hist_fields a size
      tracing/histogram: Rename "cpu" to "common_cpu"
      tracing / histogram: Fix NULL pointer dereference on strcmp() on NULL event name

Sudeep Holla (4):
      firmware: arm_scmi: Fix possible scmi_linux_errmap buffer overflow
      ARM: dts: versatile: Fix up interrupt controller node names
      firmware: arm_scmi: Ensure drivers provide a probe function
      ARM: dts: nomadik: Fix up interrupt controller node names

Takashi Iwai (4):
      r8152: Fix potential PM refcount imbalance
      ALSA: seq: Fix racy deletion of subscriber
      ASoC: intel: atom: Fix reference to PCM buffer address
      ASoC: intel: atom: Fix breakage for PCM buffer address setup

Takeshi Misawa (1):
      net: Fix memory leak in ieee802154_raw_deliver

Tetsuo Handa (1):
      Bluetooth: defer cleanup of resources in hci_unregister_dev()

Theodore Ts'o (1):
      ext4: fix potential htree corruption when growing large_dir directories

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix dwc3_calc_trbs_left()

Thomas Gleixner (12):
      genirq: Provide IRQCHIP_AFFINITY_PRE_STARTUP
      x86/msi: Force affinity setup before startup
      x86/ioapic: Force affinity setup before startup
      PCI/MSI: Enable and mask MSI-X early
      PCI/MSI: Do not set invalid bits in MSI mask
      PCI/MSI: Correct misleading comments
      PCI/MSI: Use msi_mask_irq() in pci_msi_shutdown()
      PCI/MSI: Protect msi_desc::masked for multi-MSI
      PCI/MSI: Mask all unused MSI-X entries
      PCI/MSI: Enforce that MSI-X table entry is masked for update
      PCI/MSI: Enforce MSI[X] entry updates to be visible
      x86/fpu: Make init_fpstate correct with optimized XSAVE

Tuo Li (1):
      IB/hfi1: Fix possible null-pointer dereference in _extend_sdma_tx_descs()

Tyler Hicks (1):
      optee: Clear stale cache entries during initialization

Vincent Whitchurch (1):
      mmc: dw_mmc: Fix hang on data CRC error

Vladimir Oltean (1):
      net: dsa: lan9303: fix broken backpressure in .port_fdb_dump

Wang Hai (3):
      tulip: windbond-840: Fix missing pci_disable_device() in probe and remove
      sis900: Fix missing pci_disable_device() in probe and remove
      net: natsemi: Fix missing pci_disable_device() in probe and remove

Wesley Cheng (1):
      usb: dwc3: gadget: Stop EP0 transfers during pullup disable

Willy Tarreau (1):
      USB: serial: ch341: fix character loss at high transfer rates

Xiangyang Zhang (1):
      staging: rtl8723bs: Fix a resource leak in sd_int_dpc

Xiaolong Huang (1):
      net: qrtr: fix another OOB Read in qrtr_endpoint_post

Xie Yongji (1):
      vhost: Fix the calculation in vhost_overflow()

Xin Long (2):
      sctp: move 198 addresses from unusable to private scope
      sctp: move the active_key update after sh_keys is added

Yang Yingliang (5):
      workqueue: fix UAF in pwq_unbound_release_workfn()
      net/802/mrp: fix memleak in mrp_request_join()
      net/802/garp: fix memleak in garp_request_join()
      ARM: imx: add missing iounmap()
      net: bridge: fix memleak in br_add_if()

Ye Bin (1):
      scsi: scsi_dh_rdac: Avoid crash during rdac_bus_attach()

Yu Kuai (3):
      blk-iolatency: error out if blk_get_queue() failed in iolatency_set_limit()
      reiserfs: add check for root_inode in reiserfs_fill_super
      dmaengine: usb-dmac: Fix PM reference leak in usb_dmac_probe()

YueHaibing (1):
      net: xilinx_emaclite: Do not print real IOMEM pointer

Yufen Yu (1):
      bdi: use bdi_dev_name() to get device name

Zhengjun Zhang (1):
      USB: serial: option: add new VID/PID to support Fibocom FG150

Zheyu Ma (1):
      pcmcia: i82092: fix a null pointer dereference bug

Ziyang Xuan (1):
      can: raw: raw_setsockopt(): fix raw_rcv panic for sock UAF

chihhao.chen (1):
      ALSA: usb-audio: fix incorrect clock source setting
---
Documentation/filesystems/mandatory-locking.txt    |  10 ++
 Documentation/trace/histogram.rst                  |   2 +-
 Documentation/virtual/kvm/mmu.txt                  |   4 +-
 Makefile                                           |   2 +-
 arch/alpha/kernel/smp.c                            |   2 +-
 arch/arc/kernel/vmlinux.lds.S                      |   2 +
 arch/arm/boot/dts/am43x-epos-evm.dts               |   2 +-
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi        |   1 +
 arch/arm/boot/dts/omap5-board-common.dtsi          |   9 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |   4 +-
 arch/arm/boot/dts/versatile-ab.dts                 |   5 +-
 arch/arm/boot/dts/versatile-pb.dts                 |   2 +-
 arch/arm/mach-imx/mmdc.c                           |  21 ++-
 arch/mips/Makefile                                 |   2 +-
 arch/mips/mti-malta/malta-platform.c               |   3 +-
 arch/powerpc/kernel/kprobes.c                      |   3 +-
 arch/powerpc/platforms/pseries/setup.c             |   2 +-
 arch/x86/events/perf_event.h                       |   3 +-
 arch/x86/include/asm/fpu/internal.h                |  30 ++---
 arch/x86/include/asm/proto.h                       |   2 +
 arch/x86/include/asm/svm.h                         |   2 +
 arch/x86/kernel/apic/io_apic.c                     |   6 +-
 arch/x86/kernel/apic/msi.c                         |  13 +-
 arch/x86/kernel/cpu/intel_rdt_monitor.c            |  27 ++--
 arch/x86/kernel/fpu/xstate.c                       |  38 +++++-
 arch/x86/kvm/ioapic.c                              |   2 +-
 arch/x86/kvm/ioapic.h                              |   4 +-
 arch/x86/kvm/mmu.c                                 |  13 +-
 arch/x86/kvm/paging_tmpl.h                         |  14 +-
 arch/x86/kvm/svm.c                                 |  20 +--
 arch/x86/kvm/x86.c                                 |  26 +++-
 arch/x86/tools/chkobjdump.awk                      |   1 +
 block/bfq-iosched.c                                |   6 +-
 block/blk-cgroup.c                                 |   2 +-
 block/blk-iolatency.c                              |   6 +-
 drivers/acpi/acpica/nsrepair2.c                    |   7 -
 drivers/acpi/nfit/core.c                           |   3 +
 drivers/ata/libata-sff.c                           |  35 +++--
 drivers/base/core.c                                |   1 +
 drivers/base/firmware_loader/fallback.c            |  14 +-
 drivers/base/firmware_loader/firmware.h            |  10 +-
 drivers/base/firmware_loader/main.c                |   2 +
 drivers/block/floppy.c                             |  27 ++--
 drivers/clk/clk-stm32f4.c                          |  10 +-
 drivers/cpufreq/armada-37xx-cpufreq.c              |   6 +-
 drivers/dma/of-dma.c                               |   9 +-
 drivers/dma/sh/usb-dmac.c                          |   2 +-
 drivers/dma/xilinx/xilinx_dma.c                    |  12 ++
 drivers/firmware/arm_scmi/bus.c                    |   3 +
 drivers/firmware/arm_scmi/driver.c                 |  12 +-
 drivers/gpu/drm/drm_ioc32.c                        |   4 +-
 drivers/gpu/drm/i915/intel_engine_cs.c             |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h      |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c    |   9 ++
 drivers/i2c/i2c-dev.c                              |   5 +-
 drivers/iio/adc/palmas_gpadc.c                     |   4 +-
 drivers/iio/dac/ds4424.c                           |   6 -
 drivers/iio/humidity/hdc100x.c                     |   6 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |   9 +-
 drivers/iommu/intel-iommu.c                        |   7 +-
 drivers/ipack/carriers/tpci200.c                   |  60 +++++----
 drivers/media/common/videobuf2/videobuf2-core.c    |  13 +-
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |  11 +-
 drivers/mmc/host/dw_mmc.c                          |   6 +-
 drivers/net/can/spi/hi311x.c                       |   2 +-
 drivers/net/can/usb/ems_usb.c                      |  14 +-
 drivers/net/can/usb/esd_usb2.c                     |  20 ++-
 drivers/net/can/usb/mcba_usb.c                     |   2 +
 drivers/net/can/usb/usb_8dev.c                     |  15 ++-
 drivers/net/dsa/lan9303-core.c                     |  34 ++---
 drivers/net/dsa/mt7530.c                           |   1 +
 drivers/net/ethernet/apm/xgene-v2/main.c           |   4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  57 ++++----
 drivers/net/ethernet/dec/tulip/winbond-840.c       |   7 +-
 drivers/net/ethernet/freescale/fec_main.c          |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  13 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  14 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.h        |   3 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  60 +++++----
 drivers/net/ethernet/marvell/mvneta.c              |   2 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  10 +-
 drivers/net/ethernet/natsemi/natsemi.c             |   8 +-
 drivers/net/ethernet/neterion/vxge/vxge-main.c     |   6 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |   2 +
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |  20 +++
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |  23 +++-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |   3 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |   6 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   4 +-
 drivers/net/ethernet/sis/sis900.c                  |   7 +-
 drivers/net/ethernet/sun/niu.c                     |   3 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |   5 +-
 drivers/net/hamradio/6pack.c                       |   6 +
 drivers/net/ieee802154/mac802154_hwsim.c           |   6 +-
 drivers/net/phy/mdio-mux.c                         |  36 +++--
 drivers/net/ppp/ppp_generic.c                      |  21 ++-
 drivers/net/usb/lan78xx.c                          |  16 ++-
 drivers/net/usb/pegasus.c                          |  14 +-
 drivers/net/usb/qmi_wwan.c                         |  76 ++++++++++-
 drivers/net/usb/r8152.c                            |   3 +-
 drivers/net/virtio_net.c                           |  10 +-
 drivers/net/wireless/ath/ath.h                     |   3 +-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c      |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |   2 +-
 drivers/net/wireless/ath/ath9k/hw.h                |   1 +
 drivers/net/wireless/ath/ath9k/main.c              |  95 ++++++++++++-
 drivers/net/wireless/ath/key.c                     |  41 +++---
 drivers/nfc/nfcsim.c                               |   3 +-
 drivers/opp/of.c                                   |   5 +-
 drivers/pci/msi.c                                  | 120 +++++++++++------
 drivers/pci/quirks.c                               |   1 +
 drivers/pcmcia/i82092.c                            |   1 +
 drivers/ptp/Kconfig                                |   3 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c         |   4 +-
 drivers/scsi/megaraid/megaraid_mm.c                |  21 ++-
 drivers/scsi/scsi_scan.c                           |   3 +-
 drivers/scsi/sr.c                                  |   2 +-
 drivers/slimbus/messaging.c                        |   7 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |   5 +-
 drivers/spi/spi-meson-spicc.c                      |   2 +
 drivers/spi/spi-mt65xx.c                           |  19 +--
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |   2 +
 drivers/tee/optee/call.c                           |  36 ++++-
 drivers/tee/optee/core.c                           |   9 ++
 drivers/tee/optee/optee_private.h                  |   1 +
 drivers/tty/serial/8250/8250_port.c                |  12 +-
 drivers/tty/vt/vt_ioctl.c                          |  11 +-
 drivers/usb/class/usbtmc.c                         |   9 +-
 drivers/usb/common/usb-otg-fsm.c                   |   6 +-
 drivers/usb/dwc3/gadget.c                          |  23 ++--
 drivers/usb/gadget/function/f_hid.c                |  44 +++++-
 drivers/usb/gadget/function/u_audio.c              |   5 +-
 drivers/usb/host/ehci-pci.c                        |   3 +
 drivers/usb/serial/ftdi_sio.c                      |   1 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   3 +
 drivers/usb/serial/option.c                        |   4 +
 drivers/vhost/vhost.c                              |  10 +-
 drivers/vhost/vringh.c                             |   2 +-
 drivers/video/fbdev/core/fbmem.c                   |   4 +
 drivers/virtio/virtio_pci_common.c                 |   7 +
 drivers/virtio/virtio_ring.c                       |   6 +-
 drivers/watchdog/iTCO_wdt.c                        |  12 +-
 drivers/xen/events/events_base.c                   |  20 ++-
 fs/btrfs/compression.c                             |   3 +-
 fs/btrfs/inode.c                                   |  10 +-
 fs/btrfs/volumes.c                                 |   1 +
 fs/ceph/debugfs.c                                  |   2 +-
 fs/cifs/smb2ops.c                                  |   4 +-
 fs/ext4/namei.c                                    |   2 +-
 fs/hfs/bfind.c                                     |  14 +-
 fs/hfs/bnode.c                                     |  25 +++-
 fs/hfs/btree.h                                     |   7 +
 fs/hfs/super.c                                     |  10 +-
 fs/namespace.c                                     |  57 +++++---
 fs/ocfs2/file.c                                    | 103 ++++++++------
 fs/pipe.c                                          |  19 ++-
 fs/reiserfs/stree.c                                |  31 ++++-
 fs/reiserfs/super.c                                |   8 ++
 include/asm-generic/vmlinux.lds.h                  |   1 +
 include/linux/backing-dev-defs.h                   |   1 +
 include/linux/backing-dev.h                        |   9 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/device.h                             |   1 +
 include/linux/filter.h                             |  24 ++++
 include/linux/inetdevice.h                         |   2 +-
 include/linux/irq.h                                |   2 +
 include/linux/mfd/rt5033-private.h                 |   4 +-
 include/linux/msi.h                                |   2 +-
 include/linux/netdevice.h                          |   4 +
 include/linux/once.h                               |   4 +-
 include/linux/padata.h                             |   6 +-
 include/linux/skbuff.h                             |   9 ++
 include/linux/usb/otg-fsm.h                        |   1 +
 include/linux/virtio_net.h                         |  14 +-
 include/net/af_unix.h                              |   1 +
 include/net/bluetooth/hci_core.h                   |   1 +
 include/net/busy_poll.h                            |   2 +-
 include/net/ip6_route.h                            |   2 +-
 include/net/llc_pdu.h                              |  31 +++--
 include/net/psample.h                              |   2 +
 include/net/sctp/constants.h                       |   4 +-
 include/trace/events/wbt.h                         |   8 +-
 kernel/bpf/core.c                                  |  32 +++--
 kernel/bpf/verifier.c                              |  95 ++++++++++---
 kernel/irq/chip.c                                  |   5 +-
 kernel/irq/msi.c                                   |  13 +-
 kernel/padata.c                                    |  28 ++--
 kernel/trace/trace.c                               |   4 +
 kernel/trace/trace_events_hist.c                   |  41 +++++-
 kernel/workqueue.c                                 |  20 ++-
 lib/once.c                                         |  11 +-
 localversion-rt                                    |   2 +-
 mm/backing-dev.c                                   |  13 +-
 net/802/garp.c                                     |  14 ++
 net/802/mrp.c                                      |  14 ++
 net/Makefile                                       |   2 +-
 net/bluetooth/hci_core.c                           |  32 ++---
 net/bluetooth/hci_sock.c                           |  49 ++++---
 net/bluetooth/hci_sysfs.c                          |   3 +
 net/bluetooth/hidp/core.c                          |   2 +-
 net/bridge/br_if.c                                 |   2 +
 net/can/raw.c                                      |  20 ++-
 net/core/dev.c                                     |   3 +-
 net/core/skbuff.c                                  |   5 +-
 net/core/sock.c                                    |   2 +-
 net/dccp/dccp.h                                    |   6 +-
 net/ieee802154/socket.c                            |   7 +-
 net/ipv4/igmp.c                                    |  21 ++-
 net/ipv4/ip_gre.c                                  |   2 +
 net/ipv4/tcp_bbr.c                                 |   2 +-
 net/llc/af_llc.c                                   |  10 +-
 net/llc/llc_s_ac.c                                 |   2 +-
 net/mac80211/debugfs_sta.c                         |   1 +
 net/mac80211/key.c                                 |   1 +
 net/mac80211/sta_info.h                            |   1 +
 net/mac80211/tx.c                                  |  12 +-
 net/netfilter/nf_conntrack_core.c                  |  78 ++++-------
 net/netfilter/nft_exthdr.c                         |   8 +-
 net/netfilter/nft_nat.c                            |   4 +-
 net/qrtr/qrtr.c                                    |   2 +-
 net/rds/ib_frmr.c                                  |   4 +-
 net/sctp/auth.c                                    |  14 +-
 net/sctp/input.c                                   |   2 +-
 net/sctp/protocol.c                                |   3 +-
 net/socket.c                                       |   6 +-
 net/tipc/socket.c                                  |   9 +-
 net/unix/Kconfig                                   |   5 +
 net/unix/Makefile                                  |   2 +
 net/unix/af_unix.c                                 | 102 +++++++-------
 net/unix/garbage.c                                 |  68 +---------
 net/unix/scm.c                                     | 148 +++++++++++++++++++++
 net/unix/scm.h                                     |  10 ++
 net/vmw_vsock/virtio_transport.c                   |   7 +-
 net/wireless/scan.c                                |   6 +-
 scripts/tracing/draw_functrace.py                  |   6 +-
 sound/core/seq/seq_ports.c                         |  39 ++++--
 sound/pci/hda/hda_generic.c                        |  10 +-
 sound/soc/codecs/cs42l42.c                         |  39 +++---
 sound/soc/codecs/tlv320aic31xx.h                   |   4 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   3 +-
 sound/usb/clock.c                                  |   6 +
 sound/usb/quirks.c                                 |   1 +
 tools/perf/util/map.c                              |   2 -
 tools/testing/selftests/bpf/test_verifier.c        |   2 +
 tools/testing/selftests/vm/userfaultfd.c           |   2 +-
 249 files changed, 2176 insertions(+), 1025 deletions(-)
---
