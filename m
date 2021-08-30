Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB048C432BE
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Aug 2021 14:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929916023E
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Aug 2021 14:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhH3OhO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237084AbhH3OhN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Aug 2021 10:37:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 110A460240;
        Mon, 30 Aug 2021 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630334179;
        bh=RkRMuzUXh/Ibc6A5HZREwdFbXzcf9zmo4Bh6BMnIEBY=;
        h=Subject:From:To:Date:From;
        b=cOJ/+nHxlzrT0TrIh4XaBvlH4QX0lwgkUqyT3pDN7SUeeMOJDYCIMCvRTs9ErHZ1/
         nkcKJ8lAtASnUQ816fJHIMWePtNF8ZmwQClkfWYZsfPrlLW43zwjbaOEBVKxnE5uTt
         lDWYshhPWtLnDXSNCl2nodhZVGMpqGAMhwnrfpVNpmTXZGff99F/avwob8iuf3E03R
         XSQXvi9oeXzY6c49VjSV5tvcB1ortz6GAKWukKmKZCNcjwxdYgjuZNiXVYRRIA2yzZ
         QxmEVtOR7xXuxa8kE7SQ/7J73d2e6KElycnAu8kpFNK/e2ka26kyIkr8c9McVXdHsv
         +W5I/rtwZVLlQ==
Message-ID: <399eb74808000e46d651483f2f499e4a79b749b1.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.143-rt63
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
Date:   Mon, 30 Aug 2021 09:36:17 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.143-rt63 stable release.

This release is just an update to the new stable 5.4.143
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 7c575707241264e4f084566dc1a1a9406af5ea5e

Or to build 5.4.143-rt63 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.143.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.143-rt63.patch.xz

Enjoy!

   Tom

Changes from v5.4.138-rt62:
---

Adrian Larumbe (1):
      dmaengine: xilinx_dma: Fix read-after-free bug when terminating transfers

Alain Volmat (1):
      spi: stm32h7: fix full duplex irq handler handling

Alan Stern (1):
      USB: core: Avoid WARNings for 0-length descriptor requests

Alex Xu (Hello71) (1):
      pipe: increase minimum default pipe size to 2 pages

Alexander Monakov (1):
      ALSA: hda/realtek: add mic quirk for Acer SF314-42

Alexander Tsoy (1):
      ALSA: usb-audio: Add registration quirk for JBL Quantum 600

Alexandre Courbot (1):
      media: v4l2-mem2mem: always consider OUTPUT queue during poll

Andreas Persson (1):
      mtd: cfi_cmdset_0002: fix crash when erasing/writing AMD cards

Andy Shevchenko (2):
      serial: 8250_pci: Enumerate Elkhart Lake UARTs via dedicated driver
      ptp_pch: Restore dependency on PCI

Anirudh Rayabharam (2):
      firmware_loader: use -ETIMEDOUT instead of -EAGAIN in fw_load_sysfs_fallback
      firmware_loader: fix use-after-free in firmware_fallback_sysfs

Antoine Tenart (1):
      net: ipv6: fix returned variable type in ip6_skb_dst_mtu

Arkadiusz Kubalewski (1):
      i40e: Fix ATR queue selection

Arnd Bergmann (2):
      soc: ixp4xx: fix printing resources
      soc: ixp4xx/qmgr: fix invalid __iomem access

Axel Lin (1):
      regulator: rt5033: Fix n_voltages settings for BUCK and LDO

Aya Levin (1):
      net/mlx5: Fix return value from tracer initialization

Babu Moger (1):
      x86/resctrl: Fix default monitoring groups reporting

Ben Dai (1):
      genirq/timings: Prevent potential array overflow in __irq_timings_store()

Ben Hutchings (2):
      net: phy: micrel: Fix link detection on ksz87xx switch"
      net: dsa: microchip: Fix ksz_read64()

Bing Guo (1):
      drm/amd/display: Fix Dynamic bpp issue with 8K30 with Navi 1X

Bixuan Cui (1):
      genirq/msi: Ensure deactivation on teardown

Brian Norris (1):
      clk: fix leak on devm_clk_bulk_get_all() unwind

Chris Lesiak (1):
      iio: humidity: hdc100x: Add margin to the conversion time

Christian Hewitt (1):
      drm/meson: fix colour distortion from HDR set during vendor u-boot

Christoph Hellwig (1):
      libata: fix ata_pio_sector for CONFIG_HIGHMEM

Colin Ian King (2):
      ARM: imx: fix missing 3rd argument in macro imx_mmdc_perf_init
      iio: adc: Fix incorrect exit of for-loop

Cristian Marussi (1):
      firmware: arm_scmi: Add delayed response status check

DENG Qingfang (1):
      net: dsa: mt7530: add the missing RxUnicast MIB counter

Dan Carpenter (2):
      bnx2x: fix an error code in bnx2x_nic_load()
      media: zr364xx: fix memory leaks in probe()

Dan Williams (2):
      ACPI: NFIT: Fix support for virtual SPA ranges
      libnvdimm/region: Fix label activation vs errors

Daniel Borkmann (5):
      bpf: Inherit expanded/patched seen count from old aux data
      bpf: Do not mark insn as seen under speculative path verification
      bpf: Fix leakage under speculation on mispredicted branches
      bpf, selftests: Adjust few selftest outcomes wrt unreachable code
      bpf, selftests: Adjust few selftest result_unpriv outcomes

Daniele Palmas (1):
      USB: serial: option: add Telit FD980 composition 0x1056

Dario Binacchi (2):
      clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
      ARM: dts: am437x-l4: fix typo in can@0 node

Dave Gerlach (1):
      ARM: dts: am43x-epos-evm: Reduce i2c0 bus speed for tps65218

David Bauer (1):
      USB: serial: ftdi_sio: add device ID for Auto-M3 OP-COM v2

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

Eric Dumazet (2):
      net: igmp: fix data-race in igmp_ifc_timer_expire()
      net: igmp: increase size of mr_ifc_count

Evgeny Novikov (1):
      media: zr364xx: propagate errors from zr364xx_start_readpipe()

Fei Qin (1):
      nfp: update ethtool reporting of pauseframe control

Filipe Manana (4):
      btrfs: do not commit logs and transactions during link and rename operations
      btrfs: fix race causing unnecessary inode logging during link and rename
      btrfs: fix lost inode on log replay after mix of fsync, rename and inode eviction
      btrfs: fix lockdep splat when enabling and disabling qgroups

Florian Eckert (1):
      platform/x86: pcengines-apuv2: revert wiring up simswitch GPIO as LED

Frank Wunderlich (1):
      iommu: Check if group is NULL before remove device

Greg Kroah-Hartman (7):
      Revert "Bluetooth: Shutdown controller after workqueues are flushed or cancelled"
      Revert "watchdog: iTCO_wdt: Account for rebooting on second timeout"
      Linux 5.4.139
      Linux 5.4.140
      Linux 5.4.141
      i2c: dev: zero out array used for i2c reads from userspace
      Linux 5.4.142

Guenter Roeck (1):
      spi: mediatek: Fix fifo transfer

H. Nikolaus Schaller (2):
      omap5-board-common: remove not physically existing vdds_1v8_main fixed-regulator
      mips: Fix non-POSIX regexp

Hangbin Liu (1):
      net: sched: act_mirred: Reset ct info when mirror/redirect skb

Hans Verkuil (1):
      media: videobuf2-core: dequeue if start_streaming fails

Hans de Goede (1):
      platform/x86: pcengines-apuv2: Add missing terminating entries to gpio-lookup tables

Harshvardhan Jha (1):
      scsi: megaraid_mm: Fix end of loop tests for list_for_each_entry()

Hui Su (1):
      scripts/tracing: fix the bug that can't parse raw_trace_func

Ilya Leoshkevich (1):
      bpf: Clear zext_dst of dead insns

Ivan T. Ivanov (1):
      net: usb: lan78xx: don't modify phy_device state concurrently

Jakub Kicinski (2):
      bnxt: don't lock the tx queue from napi poll
      bnxt: disable napi before canceling DIM

Jakub Sitnicki (1):
      net, gro: Set inner transport header offset in tcp/udp GRO hook

Jaroslav Kysela (1):
      ALSA: hda - fix the 'Capture Switch' value change notifications

Jason Wang (1):
      virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO

Jeff Layton (4):
      ceph: add some lockdep assertions around snaprealm handling
      ceph: clean up locking annotation for ceph_get_snap_realm and __lookup_snap_realm
      ceph: take snap_empty_lock atomically with snaprealm refcount change
      fs: warn about impending deprecation of mandatory locks

Jens Wiklander (1):
      tee: add tee_shm_alloc_kernel_buf()

Jia He (1):
      qed: fix possible unpaired spin_{un}lock_bh in _qed_mcp_cmd_and_union()

Johan Hovold (1):
      media: rtl28xxu: fix zero-length control request

Johannes Weiner (1):
      mm: memcontrol: fix occasional OOMs due to proportional memory.low reclaim

John Fastabend (2):
      bpf: Test_verifier, add alu32 bounds tracking tests
      bpf, selftests: Add a verifier test for assigning 32bit reg states to 64bit ones

Jon Hunter (1):
      serial: tegra: Only print FIFO error message when an error occurs

Jouni Malinen (5):
      ath: Use safer key clearing with key cache entries
      ath9k: Clear key cache explicitly on disabling hardware
      ath: Export ath_hw_keysetmac()
      ath: Modify ath_key_delete() to not need full key entry
      ath9k: Postpone key cache entry deletion for TXQ frames reference it

Juergen Borleis (1):
      dmaengine: imx-dma: configure the generic DMA type to make it work

Keith Busch (1):
      nvme: fix nvme_setup_command metadata trace event

Kyle Russell (1):
      ASoC: tlv320aic31xx: fix reversed bclk/wclk master bits

Lahav Schlesinger (1):
      vrf: Reset skb conntrack connection on VRF rcv

Lai Jiangshan (1):
      KVM: X86: MMU: Use the correct inherited permissions to get shadow page

Letu Ren (1):
      net/qla3xxx: fix schedule while atomic in ql_wait_for_drvr_lock and ql_adapter_reset

Li Manyi (1):
      scsi: sr: Return correct event when media event code is 3

Like Xu (1):
      perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY bit inside the guest

Linus Torvalds (1):
      ACPI: fix NULL pointer dereference

Longfang Liu (1):
      USB:ehci:fix Kunpeng920 ehci hardware problem

Longpeng(Mike) (1):
      vsock/virtio: avoid potential deadlock when vsock device remove

Luis Henriques (1):
      ceph: reduce contention in ceph_check_delayed_caps()

Luke D Jones (1):
      ALSA: hda: Add quirk for ASUS Flow x13

Maciej W. Rozycki (2):
      serial: 8250: Mask out floating 16/32-bit bus bits
      MIPS: Malta: Do not byte-swap accesses to the CBUS UART

Marcin Bachry (1):
      PCI: Increase D3 delay for AMD Renoir/Cezanne XHCI

Marek Behún (1):
      cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant

Marek Vasut (3):
      ARM: dts: imx: Swap M53Menlo pinctrl_power_button/pinctrl_power_out pins
      spi: imx: mx51-ecspi: Reinstate low-speed CONFIGREG delay
      spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation

Mario Kleiner (1):
      serial: 8250_pci: Avoid irq sharing for MSI(-X) interrupts.

Mark Rutland (1):
      arm64: fix compat syscall return truncation

Masami Hiramatsu (1):
      tracing: Reject string operand in the histogram expression

Matteo Croce (1):
      virt_wifi: fix error on connect

Matthias Schiffer (1):
      gpio: tqmx86: really make IRQ optional

Maxim Devaev (2):
      usb: gadget: f_hid: added GET_IDLE and SET_IDLE handlers
      usb: gadget: f_hid: idle uses the highest byte for duration

Maxim Levitsky (2):
      KVM: nSVM: avoid picking up unsupported bits from L2 in int_ctl (CVE-2021-3653)
      KVM: nSVM: always intercept VMLOAD/VMSAVE when nested (CVE-2021-3656)

Maxime Chevallier (1):
      ARM: dts: imx6qdl-sr-som: Increase the PHY reset duration to 10ms

Maximilian Heyne (1):
      xen/events: Fix race in set_evtchn_to_irq

Md Fahad Iqbal Polash (1):
      iavf: Set RSS LUT and key in reset handle path

Michael Chan (1):
      bnxt_en: Add missing DMA memory barriers

Miklos Szeredi (1):
      ovl: prevent private clone if bind mount is not allowed

Murphy Zhou (1):
      ovl: add splice file read write helper

Nathan Chancellor (1):
      vmlinux.lds.h: Handle clang's module.{c,d}tor sections

Neal Cardwell (1):
      tcp_bbr: fix u32 wrap bug in round logic if bbr_init() called after 2B packets

NeilBrown (1):
      btrfs: prevent rename2 from exchanging a subvol with a directory from different parents

Nikolay Borisov (4):
      btrfs: make qgroup_free_reserved_data take btrfs_inode
      btrfs: make btrfs_qgroup_reserve_data take btrfs_inode
      btrfs: export and rename qgroup_reserve_meta
      btrfs: don't flush from btrfs_delayed_inode_reserve_metadata

Ole Bjørn Midtbø (1):
      Bluetooth: hidp: use correct wait queue when removing ctrl_wait

Oleksandr Suvorov (1):
      ARM: dts: colibri-imx6ull: limit SDIO clock to 25MHz

Pali Rohár (3):
      arm64: dts: armada-3720-turris-mox: remove mrvl,i2c-fast-mode
      ppp: Fix generating ppp unit id when ifname is not specified
      ppp: Fix generating ifname when empty IFLA_IFNAME is specified

Paolo Bonzini (2):
      KVM: x86: accept userspace interrupt only if no event is injected
      KVM: Do not leak memory for duplicate debugfs directories

Parav Pandit (1):
      virtio: Protect vqs list access

Pavel Skripkin (6):
      net: pegasus: fix uninit-value in get_interrupt_interval
      net: fec: fix use-after-free in fec_drv_remove
      net: vxge: fix use-after-free in vxge_device_unregister
      staging: rtl8712: get rid of flush_scheduled_work
      media: drivers/media/usb: fix memory leak in zr364xx_probe
      net: 6pack: fix slab-out-of-bounds in decode_data

Pawel Laszczak (1):
      usb: cdns3: Fixed incorrect gadget state

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

Qu Wenruo (5):
      btrfs: qgroup: allow to unreserve range without releasing other ranges
      btrfs: qgroup: try to flush qgroup space when we get -EDQUOT
      btrfs: transaction: Cleanup unused TRANS_STATE_BLOCKED
      btrfs: qgroup: remove ASYNC_COMMIT mechanism in favor of reserve retry-after-EDQUOT
      btrfs: qgroup: don't commit transaction when we already hold the handle

Rafael J. Wysocki (1):
      Revert "ACPICA: Fix memory leak caused by _CID repair function"

Randy Dunlap (3):
      btrfs: delete duplicated words + other fixes in comments
      x86/tools: Fix objdump version check again
      dccp: add do-while-0 stubs for dccp_pr_debug macros

Richard Fitzgerald (5):
      ASoC: cs42l42: Correct definition of ADC Volume control
      ASoC: cs42l42: Don't allow SND_SOC_DAIFMT_LEFT_J
      ASoC: cs42l42: Fix inversion of ADC Notch Switch control
      ASoC: cs42l42: Remove duplicate control for WNF filter frequency
      ASoC: cs42l42: Fix LRCLK frame start edge

Ritesh Harjani (1):
      ext4: fix EXT4_MAX_LOGICAL_BLOCK macro

Roi Dayan (1):
      psample: Add a fwd declaration for skbuff

Saeed Mirzamohammadi (1):
      iommu/vt-d: Fix agaw for a supported 48 bit guest address width

Saravana Kannan (2):
      net: mdio-mux: Don't ignore memory allocation errors
      net: mdio-mux: Handle -EPROBE_DEFER correctly

Sasha Levin (1):
      Linux 5.4.143

Sean Christopherson (3):
      KVM: x86/mmu: Fix per-cpu counter corruption on 32-bit builds
      KVM: SVM: Fix off-by-one indexing when nullifying last used SEV VMCB
      KVM: VMX: Use current VMCS to query WAITPKG support for MSR emulation

Sergey Marinkevich (1):
      netfilter: nft_exthdr: fix endianness of tcp option cast

Shreyansh Chouhan (1):
      reiserfs: check directory items on read from disk

Sreekanth Reddy (1):
      scsi: core: Avoid printing an error if target_alloc() returns -ENXIO

Srinivas Kandagatla (3):
      slimbus: messaging: start transaction ids from 1 instead of zero
      slimbus: messaging: check for valid transaction id
      slimbus: ngd: reset dma setup during runtime pm

Steve Bennett (1):
      net: phy: micrel: Fix detection of ksz87xx switch

Steven Rostedt (VMware) (2):
      tracing / histogram: Give calculation hist_fields a size
      tracing / histogram: Fix NULL pointer dereference on strcmp() on NULL event name

Sudeep Holla (2):
      firmware: arm_scmi: Ensure drivers provide a probe function
      ARM: dts: nomadik: Fix up interrupt controller node names

Sumit Garg (1):
      tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag

Sylwester Dziedziuch (1):
      iavf: Fix ping is lost after untrusted VF had tried to change MAC

Takashi Iwai (5):
      r8152: Fix potential PM refcount imbalance
      ALSA: seq: Fix racy deletion of subscriber
      ASoC: xilinx: Fix reference to PCM buffer address
      ASoC: intel: atom: Fix reference to PCM buffer address
      ASoC: intel: atom: Fix breakage for PCM buffer address setup

Takeshi Misawa (1):
      net: Fix memory leak in ieee802154_raw_deliver

Tetsuo Handa (1):
      Bluetooth: defer cleanup of resources in hci_unregister_dev()

Theodore Ts'o (1):
      ext4: fix potential htree corruption when growing large_dir directories

Thomas Gleixner (13):
      timers: Move clearing of base::timer_running under base:: Lock
      genirq: Provide IRQCHIP_AFFINITY_PRE_STARTUP
      x86/msi: Force affinity setup before startup
      x86/ioapic: Force affinity setup before startup
      PCI/MSI: Enable and mask MSI-X early
      PCI/MSI: Mask all unused MSI-X entries
      PCI/MSI: Enforce that MSI-X table entry is masked for update
      PCI/MSI: Enforce MSI[X] entry updates to be visible
      PCI/MSI: Do not set invalid bits in MSI mask
      PCI/MSI: Correct misleading comments
      PCI/MSI: Use msi_mask_irq() in pci_msi_shutdown()
      PCI/MSI: Protect msi_desc::masked for multi-MSI
      x86/fpu: Make init_fpstate correct with optimized XSAVE

Tom Zanussi (2):
      Merge tag 'v5.4.143' into v5.4-rt
      Linux 5.4.143-rt63

Tyler Hicks (3):
      optee: Clear stale cache entries during initialization
      optee: Fix memory leak when failing to register shm pages
      tpm_ftpm_tee: Free and unregister TEE shared memory during kexec

Uwe Kleine-König (1):
      iio: adc: ti-ads7950: Ensure CS is deasserted after reading channels

Vincent Whitchurch (1):
      mmc: dw_mmc: Fix hang on data CRC error

Vladimir Oltean (6):
      arm64: dts: ls1028a: fix node name for the sysclk
      net: dsa: sja1105: overwrite dynamic FDB entries with static ones in .port_fdb_add
      net: dsa: sja1105: invalidate dynamic FDB entries learned concurrently with statically added ones
      net: dsa: lan9303: fix broken backpressure in .port_fdb_dump
      net: dsa: lantiq: fix broken backpressure in .port_fdb_dump
      net: dsa: sja1105: fix broken backpressure in .port_fdb_dump

Wang Hai (1):
      net: natsemi: Fix missing pci_disable_device() in probe and remove

Wei Shuyu (1):
      md/raid10: properly indicate failure when ending a failed write request

Wesley Cheng (7):
      usb: dwc3: Stop active transfers before halting the controller
      usb: dwc3: gadget: Allow runtime suspend if UDC unbinded
      usb: dwc3: gadget: Restart DWC3 gadget when enabling pullup
      usb: dwc3: gadget: Prevent EP queuing while stopping transfers
      usb: dwc3: gadget: Clear DEP flags after stop transfers in ep disable
      usb: dwc3: gadget: Disable gadget IRQ during pullup disable
      usb: dwc3: gadget: Avoid runtime resume if disabling pullup

Will Deacon (1):
      arm64: vdso: Avoid ISB after reading from cntvct_el0

Willy Tarreau (2):
      USB: serial: ch341: fix character loss at high transfer rates
      net: linkwatch: fix failure to restore device state across suspend/resume

Xiangyang Zhang (1):
      staging: rtl8723bs: Fix a resource leak in sd_int_dpc

Xie Yongji (2):
      nbd: Aovid double completion of a request
      vhost: Fix the calculation in vhost_overflow()

Xin Long (1):
      sctp: move the active_key update after sh_keys is added

Xuan Zhuo (1):
      virtio-net: support XDP when not more queues

Yafang Shao (1):
      mm, memcg: avoid stale protection values when cgroup is above protection

Yajun Deng (1):
      netfilter: nf_conntrack_bridge: Fix memory leak when error

Yang Yingliang (3):
      ARM: imx: add missing iounmap()
      ARM: imx: add missing clk_disable_unprepare()
      net: bridge: fix memleak in br_add_if()

Ye Bin (1):
      scsi: scsi_dh_rdac: Avoid crash during rdac_bus_attach()

Yu Kuai (3):
      blk-iolatency: error out if blk_get_queue() failed in iolatency_set_limit()
      reiserfs: add check for root_inode in reiserfs_fill_super
      dmaengine: usb-dmac: Fix PM reference leak in usb_dmac_probe()

YueHaibing (1):
      net: xilinx_emaclite: Do not print real IOMEM pointer

Zheyu Ma (1):
      pcmcia: i82092: fix a null pointer dereference bug

Zhiyong Tao (1):
      serial: 8250_mtk: fix uart corruption issue when rx power off

chihhao.chen (1):
      ALSA: usb-audio: fix incorrect clock source setting

kaixi.fan (1):
      ovs: clear skb->tstamp in forwarding path

lijinlin (1):
      scsi: core: Fix capacity set to zero after offlinining device
---
Documentation/virt/kvm/mmu.txt                     |   4 +-
 Makefile                                           |   2 +-
 arch/alpha/kernel/smp.c                            |   2 +-
 arch/arm/boot/dts/am437x-l4.dtsi                   |   2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   2 +-
 arch/arm/boot/dts/imx53-m53menlo.dts               |   4 +-
 arch/arm/boot/dts/imx6qdl-sr-som.dtsi              |   8 +-
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi        |   1 +
 arch/arm/boot/dts/omap5-board-common.dtsi          |   9 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |   4 +-
 arch/arm/mach-imx/mmdc.c                           |  17 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |   2 +-
 .../boot/dts/marvell/armada-3720-turris-mox.dts    |   1 +
 arch/arm64/include/asm/arch_timer.h                |  21 --
 arch/arm64/include/asm/barrier.h                   |  19 ++
 arch/arm64/include/asm/ptrace.h                    |  12 +-
 arch/arm64/include/asm/syscall.h                   |  19 +-
 arch/arm64/include/asm/vdso/gettimeofday.h         |   6 +-
 arch/arm64/kernel/ptrace.c                         |   2 +-
 arch/arm64/kernel/signal.c                         |   3 +-
 arch/arm64/kernel/syscall.c                        |   7 +-
 arch/mips/Makefile                                 |   2 +-
 arch/mips/mti-malta/malta-platform.c               |   3 +-
 arch/powerpc/kernel/kprobes.c                      |   3 +-
 arch/x86/events/perf_event.h                       |   3 +-
 arch/x86/include/asm/fpu/internal.h                |  30 +-
 arch/x86/include/asm/svm.h                         |   2 +
 arch/x86/kernel/apic/io_apic.c                     |   6 +-
 arch/x86/kernel/apic/msi.c                         |  13 +-
 arch/x86/kernel/cpu/resctrl/monitor.c              |  27 +-
 arch/x86/kernel/fpu/xstate.c                       |  38 ++-
 arch/x86/kvm/mmu.c                                 |   2 +-
 arch/x86/kvm/paging_tmpl.h                         |  14 +-
 arch/x86/kvm/svm.c                                 |  20 +-
 arch/x86/kvm/vmx/vmx.h                             |   2 +-
 arch/x86/kvm/x86.c                                 |  13 +-
 arch/x86/tools/chkobjdump.awk                      |   1 +
 block/blk-iolatency.c                              |   6 +-
 drivers/acpi/acpica/nsrepair2.c                    |   7 -
 drivers/acpi/nfit/core.c                           |   3 +
 drivers/ata/libata-sff.c                           |  35 ++-
 drivers/base/core.c                                |   1 +
 drivers/base/firmware_loader/fallback.c            |  14 +-
 drivers/base/firmware_loader/firmware.h            |  10 +-
 drivers/base/firmware_loader/main.c                |   2 +
 drivers/block/nbd.c                                |  14 +-
 drivers/char/tpm/tpm_ftpm_tee.c                    |   8 +-
 drivers/clk/clk-devres.c                           |   9 +-
 drivers/clk/clk-stm32f4.c                          |  10 +-
 drivers/cpufreq/armada-37xx-cpufreq.c              |   6 +-
 drivers/dma/imx-dma.c                              |   2 +
 drivers/dma/of-dma.c                               |   9 +-
 drivers/dma/sh/usb-dmac.c                          |   2 +-
 drivers/dma/xilinx/xilinx_dma.c                    |  12 +
 drivers/firmware/arm_scmi/bus.c                    |   3 +
 drivers/firmware/arm_scmi/driver.c                 |   8 +-
 drivers/gpio/gpio-tqmx86.c                         |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  |   2 +-
 drivers/gpu/drm/meson/meson_registers.h            |   5 +
 drivers/gpu/drm/meson/meson_viu.c                  |   7 +-
 drivers/i2c/i2c-dev.c                              |   5 +-
 drivers/iio/adc/palmas_gpadc.c                     |   4 +-
 drivers/iio/adc/ti-ads7950.c                       |   1 -
 drivers/iio/humidity/hdc100x.c                     |   6 +-
 drivers/iommu/intel-iommu.c                        |   7 +-
 drivers/iommu/iommu.c                              |   3 +
 drivers/ipack/carriers/tpci200.c                   |  60 ++--
 drivers/md/raid1.c                                 |   2 -
 drivers/md/raid10.c                                |   4 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |  13 +-
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |  11 +-
 drivers/media/usb/zr364xx/zr364xx.c                |  77 +++--
 drivers/media/v4l2-core/v4l2-mem2mem.c             |   6 +-
 drivers/mmc/host/dw_mmc.c                          |   6 +-
 drivers/mtd/chips/cfi_cmdset_0002.c                |   2 +-
 drivers/net/dsa/lan9303-core.c                     |  34 ++-
 drivers/net/dsa/lantiq_gswip.c                     |  14 +-
 drivers/net/dsa/microchip/ksz_common.h             |   8 +-
 drivers/net/dsa/mt7530.c                           |   1 +
 drivers/net/dsa/sja1105/sja1105_main.c             |  71 ++++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  69 +++--
 drivers/net/ethernet/freescale/fec_main.c          |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   3 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  14 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  47 ++-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |  11 +-
 drivers/net/ethernet/natsemi/natsemi.c             |   8 +-
 drivers/net/ethernet/neterion/vxge/vxge-main.c     |   6 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |   2 +
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |  23 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |   6 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   4 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |   5 +-
 drivers/net/hamradio/6pack.c                       |   6 +
 drivers/net/ieee802154/mac802154_hwsim.c           |   6 +-
 drivers/net/phy/mdio-mux.c                         |  36 ++-
 drivers/net/phy/micrel.c                           |  12 +-
 drivers/net/ppp/ppp_generic.c                      |  21 +-
 drivers/net/usb/lan78xx.c                          |  16 +-
 drivers/net/usb/pegasus.c                          |  14 +-
 drivers/net/usb/r8152.c                            |   3 +-
 drivers/net/virtio_net.c                           |  76 +++--
 drivers/net/vrf.c                                  |   4 +
 drivers/net/wireless/ath/ath.h                     |   3 +-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c      |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |   2 +-
 drivers/net/wireless/ath/ath9k/hw.h                |   1 +
 drivers/net/wireless/ath/ath9k/main.c              |  95 +++++-
 drivers/net/wireless/ath/key.c                     |  41 ++-
 drivers/net/wireless/virt_wifi.c                   |  52 ++--
 drivers/nvdimm/namespace_devs.c                    |  17 +-
 drivers/nvme/host/trace.h                          |   6 +-
 drivers/pci/msi.c                                  | 125 +++++---
 drivers/pci/quirks.c                               |   1 +
 drivers/pcmcia/i82092.c                            |   1 +
 drivers/platform/x86/pcengines-apuv2.c             |   5 +-
 drivers/ptp/Kconfig                                |   3 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c         |   4 +-
 drivers/scsi/megaraid/megaraid_mm.c                |  21 +-
 drivers/scsi/scsi_scan.c                           |   3 +-
 drivers/scsi/scsi_sysfs.c                          |   9 +-
 drivers/scsi/sr.c                                  |   2 +-
 drivers/slimbus/messaging.c                        |   7 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |   5 +-
 drivers/soc/ixp4xx/ixp4xx-npe.c                    |  11 +-
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                   |   9 +-
 drivers/spi/spi-imx.c                              |  52 ++--
 drivers/spi/spi-meson-spicc.c                      |   2 +
 drivers/spi/spi-mt65xx.c                           |  19 +-
 drivers/spi/spi-stm32.c                            |  15 +-
 drivers/staging/rtl8712/rtl8712_led.c              |   8 +
 drivers/staging/rtl8712/rtl871x_led.h              |   1 +
 drivers/staging/rtl8712/rtl871x_pwrctrl.c          |   8 +
 drivers/staging/rtl8712/rtl871x_pwrctrl.h          |   1 +
 drivers/staging/rtl8712/usb_intf.c                 |   3 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |   2 +
 drivers/tee/optee/call.c                           |  38 ++-
 drivers/tee/optee/core.c                           |  12 +-
 drivers/tee/optee/optee_private.h                  |   1 +
 drivers/tee/optee/rpc.c                            |   5 +-
 drivers/tee/optee/shm_pool.c                       |  20 +-
 drivers/tee/tee_shm.c                              |  20 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   5 +
 drivers/tty/serial/8250/8250_pci.c                 |   7 +
 drivers/tty/serial/8250/8250_port.c                |  12 +-
 drivers/tty/serial/serial-tegra.c                  |   6 +-
 drivers/usb/cdns3/ep0.c                            |   1 +
 drivers/usb/class/usbtmc.c                         |   9 +-
 drivers/usb/common/usb-otg-fsm.c                   |   6 +-
 drivers/usb/core/message.c                         |   6 +
 drivers/usb/dwc3/ep0.c                             |   2 +-
 drivers/usb/dwc3/gadget.c                          | 118 ++++++--
 drivers/usb/gadget/function/f_hid.c                |  44 ++-
 drivers/usb/host/ehci-pci.c                        |   3 +
 drivers/usb/serial/ch341.c                         |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   1 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   3 +
 drivers/usb/serial/option.c                        |   2 +
 drivers/vhost/vhost.c                              |  10 +-
 drivers/virtio/virtio.c                            |   1 +
 drivers/virtio/virtio_ring.c                       |   8 +
 drivers/watchdog/iTCO_wdt.c                        |  12 +-
 drivers/xen/events/events_base.c                   |  20 +-
 fs/btrfs/block-group.c                             |   2 +-
 fs/btrfs/ctree.c                                   |   2 +-
 fs/btrfs/ctree.h                                   |  13 +-
 fs/btrfs/delalloc-space.c                          |   2 +-
 fs/btrfs/delayed-inode.c                           |   3 +-
 fs/btrfs/disk-io.c                                 |   6 +-
 fs/btrfs/extent_io.c                               |   2 +-
 fs/btrfs/file.c                                    |   7 +-
 fs/btrfs/free-space-cache.c                        |   2 +-
 fs/btrfs/inode.c                                   | 127 ++------
 fs/btrfs/qgroup.c                                  | 330 ++++++++++++++++-----
 fs/btrfs/qgroup.h                                  |   5 +-
 fs/btrfs/transaction.c                             |  16 +-
 fs/btrfs/transaction.h                             |  15 -
 fs/btrfs/tree-log.c                                | 107 +++----
 fs/btrfs/tree-log.h                                |  14 +-
 fs/ceph/caps.c                                     |  17 +-
 fs/ceph/mds_client.c                               |  25 +-
 fs/ceph/snap.c                                     |  54 ++--
 fs/ceph/super.h                                    |   2 +-
 fs/ext4/ext4.h                                     |   2 +-
 fs/ext4/namei.c                                    |   2 +-
 fs/namespace.c                                     |  48 ++-
 fs/overlayfs/file.c                                |  47 +++
 fs/pipe.c                                          |  19 +-
 fs/reiserfs/stree.c                                |  31 +-
 fs/reiserfs/super.c                                |   8 +
 include/acpi/acpi_bus.h                            |   3 +-
 include/asm-generic/vmlinux.lds.h                  |   1 +
 include/linux/device.h                             |   1 +
 include/linux/inetdevice.h                         |   2 +-
 include/linux/irq.h                                |   2 +
 include/linux/memcontrol.h                         |  59 +++-
 include/linux/mfd/rt5033-private.h                 |   4 +-
 include/linux/msi.h                                |   2 +-
 include/linux/tee_drv.h                            |   2 +
 include/linux/usb/otg-fsm.h                        |   1 +
 include/linux/virtio.h                             |   1 +
 include/net/bluetooth/hci_core.h                   |   1 +
 include/net/ip6_route.h                            |   2 +-
 include/net/psample.h                              |   2 +
 kernel/bpf/verifier.c                              |  66 ++++-
 kernel/irq/chip.c                                  |   5 +-
 kernel/irq/msi.c                                   |  13 +-
 kernel/irq/timings.c                               |   5 +
 kernel/trace/trace_events_hist.c                   |  26 +-
 localversion-rt                                    |   2 +-
 mm/memcontrol.c                                    |   8 +
 mm/vmscan.c                                        |  26 +-
 net/bluetooth/hci_core.c                           |  32 +-
 net/bluetooth/hci_sock.c                           |  49 ++-
 net/bluetooth/hci_sysfs.c                          |   3 +
 net/bluetooth/hidp/core.c                          |   2 +-
 net/bridge/br_if.c                                 |   2 +
 net/bridge/netfilter/nf_conntrack_bridge.c         |   6 +
 net/core/link_watch.c                              |   5 +-
 net/core/skbuff.c                                  |   5 +-
 net/dccp/dccp.h                                    |   6 +-
 net/ieee802154/socket.c                            |   7 +-
 net/ipv4/igmp.c                                    |  21 +-
 net/ipv4/tcp_bbr.c                                 |   2 +-
 net/ipv4/tcp_offload.c                             |   3 +
 net/ipv4/udp_offload.c                             |   4 +
 net/netfilter/nft_exthdr.c                         |   8 +-
 net/openvswitch/vport.c                            |   1 +
 net/sched/act_mirred.c                             |   3 +
 net/sctp/auth.c                                    |  14 +-
 net/vmw_vsock/virtio_transport.c                   |   7 +-
 scripts/tracing/draw_functrace.py                  |   6 +-
 sound/core/seq/seq_ports.c                         |  39 ++-
 sound/pci/hda/hda_generic.c                        |  10 +-
 sound/pci/hda/patch_realtek.c                      |   2 +
 sound/soc/codecs/cs42l42.c                         |  39 +--
 sound/soc/codecs/tlv320aic31xx.h                   |   4 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   3 +-
 sound/soc/xilinx/xlnx_formatter_pcm.c              |   4 +-
 sound/usb/clock.c                                  |   6 +
 sound/usb/quirks.c                                 |   1 +
 tools/testing/selftests/bpf/test_verifier.c        |   2 +-
 tools/testing/selftests/bpf/verifier/bounds.c      |  65 ++++
 tools/testing/selftests/bpf/verifier/dead_code.c   |   2 +
 tools/testing/selftests/bpf/verifier/jmp32.c       |  22 ++
 tools/testing/selftests/bpf/verifier/jset.c        |  10 +-
 tools/testing/selftests/bpf/verifier/stack_ptr.c   |   2 -
 tools/testing/selftests/bpf/verifier/unpriv.c      |   2 +
 .../selftests/bpf/verifier/value_ptr_arith.c       |  15 +-
 virt/kvm/kvm_main.c                                |  18 +-
 252 files changed, 2556 insertions(+), 1167 deletions(-)

