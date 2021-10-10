Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E068BC433EF
	for <linux-rt-users@archiver.kernel.org>; Sun, 10 Oct 2021 18:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B020760F22
	for <linux-rt-users@archiver.kernel.org>; Sun, 10 Oct 2021 18:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhJJSKW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 10 Oct 2021 14:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhJJSKV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 10 Oct 2021 14:10:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7CB360EE5;
        Sun, 10 Oct 2021 18:08:22 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.209-rt89
Date:   Sun, 10 Oct 2021 18:07:12 -0000
Message-ID: <163388923226.1021048.9949667933423030159@puck.lan>
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

I'm pleased to announce the 4.19.209-rt89 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 17fbb7d705550e41e0dd31b3b3d8f712f8591918

Or to build 4.19.209-rt89 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.209.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.209-rt89.patch.xz


You can also build from 4.19.207-rt88 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.207-rt88-rt89.patch.xz

Enjoy!
Clark

Changes from v4.19.207-rt88:
---

Alex Sverdlin (4):
      ARM: 9077/1: PLT: Move struct plt_entries definition to header
      ARM: 9078/1: Add warn suppress parameter to arm_gen_branch_link()
      ARM: 9079/1: ftrace: Add MODULE_PLTS support
      ARM: 9098/1: ftrace: MODULE_PLT: Fix build problem without DYNAMIC_FTRACE

Andrea Claudi (1):
      ipvs: check that ip_vs_conn_tab_bits is between 8 and 20

Andy Shevchenko (2):
      apparmor: remove duplicate macro list_entry_is_head()
      dmaengine: acpi: Avoid comparison GSI with Linux vIRQ

Anirudh Rayabharam (1):
      HID: usbhid: free raw_report buffers in usbhid_stop

Anton Eidelman (1):
      nvme-multipath: fix ANA state updates when a namespace is not present

Aya Levin (1):
      net/mlx4_en: Don't allow aRFS for encapsulated packets

Baokun Li (1):
      scsi: iscsi: Adjust iface sysfs attr detection

Carlo Lobrano (1):
      USB: serial: option: add Telit LN920 compositions

Charlene Liu (1):
      drm/amd/display: Pass PCI deviceid into DC

Chen Jingwen (1):
      elf: don't use MAP_FIXED_NOREPLACE for elf interpreter mappings

Chih-Kang Chang (1):
      mac80211: Fix ieee80211_amsdu_aggregate frag_tail bug

Christoph Hellwig (1):
      md: fix a lock order reversal in md_alloc

Christophe Leroy (1):
      crypto: talitos - fix max key size for sha384 and sha512

Clark Williams (2):
      Merge tag 'v4.19.209' into v4.19-rt
      Linux 4.19.209-rt89

Cyrill Gorcunov (1):
      prctl: allow to setup brk for et_dyn executables

Dan Carpenter (6):
      thermal/drivers/exynos: Fix an error code in exynos_tmu_probe()
      usb: gadget: r8a66597: fix a loop in set_feature()
      usb: musb: tusb6010: uninitialized data in tusb_fifo_write_unaligned()
      mcb: fix error handling in mcb_alloc_bus()
      thermal/core: Potential buffer overflow in thermal_build_list_of_policies()
      crypto: ccp - fix resource leaks in ccp_run_aes_gcm_cmd()

Dan Li (1):
      arm64: Mark __stack_chk_guard as __ro_after_init

Dongliang Mu (2):
      usb: hso: fix error handling code of hso_create_net_device
      usb: hso: remove the bailout parameter

Eric Dumazet (4):
      tcp: address problems caused by EDT misshaps
      tcp: adjust rto_base in retransmits_timed_out()
      af_unix: fix races in sk_peer_pid and sk_peer_cred accesses
      net: udp: annotate data race around udp_sk(sk)->corkflag

Evan Wang (1):
      PCI: aardvark: Fix checking for PIO status

F.A.Sulaiman (1):
      HID: betop: fix slab-out-of-bounds Write in betop_probe

Gao Xiang (1):
      erofs: fix up erofs_lookup tracepoint

Greg Kroah-Hartman (2):
      Linux 4.19.208
      Linux 4.19.209

Guenter Roeck (8):
      parisc: Move pci_dev_is_behind_card_dino to where it is used
      drm/nouveau/nvkm: Replace -ENOSYS with -ENODEV
      m68k: Double cast io functions to unsigned long
      compiler.h: Introduce absolute_pointer macro
      net: i825xx: Use absolute_pointer for memcpy from fixed memory location
      alpha: Declare virt_to_phys and virt_to_bus parameter as pointer to volatile
      net: 6pack: Fix tx timeout and slot time
      hwmon: (tmp421) Replace S_<PERMS> with octal values

Helge Deller (1):
      parisc: Use absolute_pointer() to define PAGE0

Igor Matheus Andrade Torrente (1):
      tty: Fix out-of-bound vmalloc access in imageblit

Ilya Leoshkevich (1):
      s390/bpf: Fix optimizing out zero-extensions

Jacob Keller (2):
      e100: fix length calculation in e100_get_regs_len
      e100: fix buffer overrun in e100_get_regs

James Morse (1):
      cpufreq: schedutil: Destroy mutex before kobject_put() frees the memory

Jan Beulich (1):
      xen/x86: fix PV trap handling on secondary processors

Jeff Layton (1):
      ceph: lockdep annotations for try_nonblocking_invalidate

Jens Axboe (1):
      Revert "block, bfq: honor already-setup queue merges"

Jesper Nilsson (1):
      net: stmmac: allow CSR clock of 300MHz

Jiapeng Chong (1):
      fpga: machxo2-spi: Fix missing error code in machxo2_write_complete()

Jiri Slaby (1):
      tty: synclink_gt, drop unneeded forward declarations

Johan Hovold (8):
      USB: cdc-acm: fix minor-number release
      staging: greybus: uart: fix tty use after free
      net: hso: fix muxed tty registration
      ipack: ipoctal: fix stack information leak
      ipack: ipoctal: fix tty registration race
      ipack: ipoctal: fix tty-registration error handling
      ipack: ipoctal: fix missing allocation-failure check
      ipack: ipoctal: fix module reference leak

Johannes Berg (2):
      dmaengine: ioat: depends on !UML
      mac80211: fix use-after-free in CCMP/GCMP RX

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix oversized kvmalloc() calls

Juergen Gross (2):
      xen/balloon: use a kernel thread instead a workqueue
      xen/balloon: fix balloon kthread freezing

Julian Sikorski (1):
      Re-enable UAS for LaCie Rugged USB3-FW with fk quirk

Kaige Fu (1):
      irqchip/gic-v3-its: Fix potential VPE leak on error

Karsten Graul (1):
      net/smc: add missing error check in smc_clc_prfx_set()

Kevin Hao (1):
      cpufreq: schedutil: Use kobject release() method to free sugov_tunables

Krzysztof Kozlowski (2):
      USB: serial: mos7840: remove duplicated 0xac24 device ID
      USB: serial: option: remove duplicate USB device ID

Kunihiko Hayashi (1):
      gpio: uniphier: Fix void functions to remove return value

Li Huafei (1):
      tracing/kprobe: Fix kprobe_on_func_entry() modification

Li Jinlin (1):
      blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()

Linus Torvalds (4):
      sparc: avoid stringop-overread errors
      qnx4: avoid stringop-overread errors
      spi: Fix tegra20 build with CONFIG_PM=n
      qnx4: work around gcc false positive warning bug

Lorenzo Bianconi (1):
      mac80211: limit injected vht mcs/nss in ieee80211_parse_tx_radiotap

Lukas Bulwahn (1):
      Kconfig.debug: drop selecting non-existing HARDLOCKUP_DETECTOR_ARCH

Marcelo Ricardo Leitner (2):
      sctp: validate chunk size in __rcv_asconf_lookup
      sctp: add param size validation for SCTP_PARAM_SET_PRIMARY

Michael Chan (1):
      bnxt_en: Fix TX timeout when TX ring size is set to the smallest

Minas Harutyunyan (1):
      usb: dwc2: gadget: Fix ISOC transfer complete handling for DDMA

Nanyong Sun (6):
      nilfs2: fix memory leak in nilfs_sysfs_create_device_group
      nilfs2: fix NULL pointer in nilfs_##name##_attr_release
      nilfs2: fix memory leak in nilfs_sysfs_create_##name##_group
      nilfs2: fix memory leak in nilfs_sysfs_delete_##name##_group
      nilfs2: fix memory leak in nilfs_sysfs_create_snapshot_group
      nilfs2: fix memory leak in nilfs_sysfs_delete_snapshot_group

Neeraj Upadhyay (1):
      rcu: Fix missed wakeup of exp_wq waiters

NeilBrown (1):
      cred: allow get_cred() and put_cred() to be given NULL.

Oliver Neukum (1):
      hso: fix bailout in error case of probe

Ondrej Zary (1):
      usb-storage: Add quirk for ScanLogic SL11R-IDE older than 2.6c

Pali Rohár (2):
      serial: mvebu-uart: fix driver's tx_empty callback
      arm64: dts: marvell: armada-37xx: Extend PCIe MEM space

Paul Fertser (2):
      hwmon: (tmp421) report /PVLD condition as fault
      hwmon: (tmp421) fix rounding for negative values

Pavel Skripkin (1):
      profiling: fix shift-out-of-bounds bugs

Radhey Shyam Pandey (1):
      dmaengine: xilinx_dma: Set DMA mask for coherent APIs

Radim Krčmář (1):
      KVM: remember position in kvm->vcpus array

Rahul Lakkireddy (1):
      scsi: csiostor: Add module softdep on cxgb4

Randy Dunlap (2):
      tty: synclink_gt: rename a conflicting function name
      irqchip/goldfish-pic: Select GENERIC_IRQ_CHIP to fix build

Sai Krishna Potthuri (1):
      EDAC/synopsys: Fix wrong value type assignment for edac_mode

Slark Xiao (1):
      USB: serial: option: add device id for Foxconn T99W265

Steve French (1):
      cifs: fix incorrect check for null pointer in header_assemble

Thomas Gleixner (1):
      drivers: base: cacheinfo: Get rid of DEFINE_SMP_CALL_CACHE_FUNCTION()

Tom Rix (1):
      fpga: machxo2-spi: Return an error on failure

Tong Zhang (1):
      net: macb: fix use after free on rmmod

Uwe Brandt (1):
      USB: serial: cp210x: add ID for GW Instek GDM-834x Digital Multimeter

Uwe Kleine-König (4):
      pwm: lpc32xx: Don't modify HW state in .probe() after the PWM chip was registered
      pwm: img: Don't modify HW state in .remove() callback
      pwm: rockchip: Don't modify HW state in .remove() callback
      pwm: stm32-lp: Don't modify HW state in .remove() callback

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Return non-zero value when fan current state is enforced from sysfs

Wengang Wang (1):
      ocfs2: drop acl cache for directories too

Xie Yongji (1):
      9p/trans_virtio: Remove sysfs file on probe failure

Xin Long (1):
      sctp: break out if skb_header_pointer returns NULL in sctp_rcv_ootb

Yuchung Cheng (2):
      tcp: always set retrans_stamp on recovery
      tcp: create a helper to model exponential backoff

Zelin Deng (1):
      x86/kvmclock: Move this_cpu_pvti into kvmclock.h

Zhen Lei (1):
      nilfs2: use refcount_dec_and_lock() to fix potential UAF

Zhihao Cheng (1):
      blktrace: Fix uaf in blk_trace access after removing by sysfs

Zou Wei (1):
      dmaengine: sprd: Add missing MODULE_DEVICE_TABLE

yangerkun (1):
      ext4: fix potential infinite loop in ext4_dx_readdir()
---
Makefile                                           |   2 +-
 arch/alpha/include/asm/io.h                        |   6 +-
 arch/arm/include/asm/ftrace.h                      |   3 +
 arch/arm/include/asm/insn.h                        |   8 +-
 arch/arm/include/asm/module.h                      |  10 ++
 arch/arm/kernel/ftrace.c                           |  50 ++++++++--
 arch/arm/kernel/insn.c                             |  19 ++--
 arch/arm/kernel/module-plts.c                      |  49 +++++++---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  11 ++-
 arch/arm64/kernel/cacheinfo.c                      |   7 +-
 arch/arm64/kernel/process.c                        |   2 +-
 arch/m68k/include/asm/raw_io.h                     |  20 ++--
 arch/mips/kernel/cacheinfo.c                       |   7 +-
 arch/parisc/include/asm/page.h                     |   2 +-
 arch/riscv/kernel/cacheinfo.c                      |   7 +-
 arch/s390/net/bpf_jit_comp.c                       |  50 +++++-----
 arch/sparc/kernel/mdesc.c                          |   3 +-
 arch/x86/include/asm/kvmclock.h                    |  14 +++
 arch/x86/kernel/cpu/cacheinfo.c                    |   7 +-
 arch/x86/kernel/kvmclock.c                         |  13 +--
 arch/x86/xen/enlighten_pv.c                        |  15 +--
 block/bfq-iosched.c                                |  16 +---
 block/blk-throttle.c                               |   1 +
 drivers/cpufreq/cpufreq_governor_attr_set.c        |   2 +-
 drivers/crypto/ccp/ccp-ops.c                       |  14 +--
 drivers/crypto/talitos.c                           |   2 +-
 drivers/dma/Kconfig                                |   2 +-
 drivers/dma/acpi-dma.c                             |  10 +-
 drivers/dma/sprd-dma.c                             |   1 +
 drivers/dma/xilinx/xilinx_dma.c                    |   2 +-
 drivers/edac/synopsys_edac.c                       |   2 +-
 drivers/fpga/machxo2-spi.c                         |   6 +-
 drivers/gpio/gpio-uniphier.c                       |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c  |   2 +-
 drivers/hid/hid-betopff.c                          |  13 ++-
 drivers/hid/usbhid/hid-core.c                      |  13 ++-
 drivers/hwmon/mlxreg-fan.c                         |  12 ++-
 drivers/hwmon/tmp421.c                             |  35 +++----
 drivers/ipack/devices/ipoctal.c                    |  63 +++++++++----
 drivers/irqchip/Kconfig                            |   1 +
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/mcb/mcb-core.c                             |  12 +--
 drivers/md/md.c                                    |   5 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   5 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   2 +-
 drivers/net/ethernet/cadence/macb_pci.c            |   2 +-
 drivers/net/ethernet/i825xx/82596.c                |   2 +-
 drivers/net/ethernet/intel/e100.c                  |  22 +++--
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/hamradio/6pack.c                       |   4 +-
 drivers/net/usb/hso.c                              |  45 +++++----
 drivers/nvme/host/multipath.c                      |   7 +-
 drivers/parisc/dino.c                              |  18 ++--
 drivers/pci/controller/pci-aardvark.c              |  62 +++++++++++--
 drivers/pwm/pwm-img.c                              |  16 ----
 drivers/pwm/pwm-lpc32xx.c                          |  10 +-
 drivers/pwm/pwm-rockchip.c                         |  14 ---
 drivers/pwm/pwm-stm32-lp.c                         |   2 -
 drivers/scsi/csiostor/csio_init.c                  |   1 +
 drivers/scsi/scsi_transport_iscsi.c                |   8 +-
 drivers/spi/spi-tegra20-slink.c                    |   4 +-
 drivers/staging/erofs/include/trace/events/erofs.h |   6 +-
 drivers/staging/greybus/uart.c                     |  62 +++++++------
 drivers/thermal/samsung/exynos_tmu.c               |   1 +
 drivers/thermal/thermal_core.c                     |   7 +-
 drivers/tty/serial/mvebu-uart.c                    |   2 +-
 drivers/tty/synclink_gt.c                          | 101 +++++----------------
 drivers/tty/vt/vt.c                                |  21 ++++-
 drivers/usb/class/cdc-acm.c                        |   7 +-
 drivers/usb/class/cdc-acm.h                        |   2 +
 drivers/usb/dwc2/gadget.c                          |   4 +-
 drivers/usb/gadget/udc/r8a66597-udc.c              |   2 +-
 drivers/usb/musb/tusb6010.c                        |   1 +
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/mos7840.c                       |   2 -
 drivers/usb/serial/option.c                        |  11 ++-
 drivers/usb/storage/unusual_devs.h                 |   9 +-
 drivers/usb/storage/unusual_uas.h                  |   2 +-
 drivers/xen/balloon.c                              |  62 +++++++++----
 fs/binfmt_elf.c                                    |   2 +-
 fs/ceph/caps.c                                     |   2 +
 fs/cifs/connect.c                                  |   5 +-
 fs/ext4/dir.c                                      |   6 +-
 fs/nilfs2/sysfs.c                                  |  26 +++---
 fs/nilfs2/the_nilfs.c                              |   9 +-
 fs/ocfs2/dlmglue.c                                 |   3 +-
 fs/qnx4/dir.c                                      |  69 ++++++++++----
 include/linux/cacheinfo.h                          |  18 ----
 include/linux/compiler.h                           |   2 +
 include/linux/cred.h                               |  14 ++-
 include/linux/kvm_host.h                           |  11 +--
 include/net/sock.h                                 |   2 +
 kernel/profile.c                                   |  21 +++--
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/sched/cpufreq_schedutil.c                   |  16 +++-
 kernel/sys.c                                       |   7 --
 kernel/trace/blktrace.c                            |   8 ++
 kernel/trace/trace_kprobe.c                        |   3 +-
 lib/Kconfig.debug                                  |   1 -
 localversion-rt                                    |   2 +-
 net/9p/trans_virtio.c                              |   4 +-
 net/core/sock.c                                    |  32 +++++--
 net/ipv4/tcp_input.c                               |  16 ++--
 net/ipv4/tcp_output.c                              |   9 +-
 net/ipv4/tcp_timer.c                               |  63 ++++++-------
 net/ipv4/udp.c                                     |  10 +-
 net/ipv6/udp.c                                     |   2 +-
 net/mac80211/tx.c                                  |  12 +++
 net/mac80211/wpa.c                                 |   6 ++
 net/netfilter/ipset/ip_set_hash_gen.h              |   4 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |   4 +
 net/sctp/input.c                                   |   5 +-
 net/sctp/sm_make_chunk.c                           |  13 ++-
 net/smc/smc_clc.c                                  |   3 +-
 net/unix/af_unix.c                                 |  34 +++++--
 security/apparmor/apparmorfs.c                     |   3 -
 virt/kvm/kvm_main.c                                |   5 +-
 120 files changed, 898 insertions(+), 622 deletions(-)
---
