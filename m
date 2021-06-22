Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0846C4743C
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Jun 2021 00:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E30611C1
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Jun 2021 00:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFVA1y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhFVA1x (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Jun 2021 20:27:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF2BC60FEB;
        Tue, 22 Jun 2021 00:25:38 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.195-rt82
Date:   Tue, 22 Jun 2021 00:24:30 -0000
Message-ID: <162432147014.2806348.4438942426199912367@puck.lan>
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

I'm pleased to announce the 4.19.195-rt82 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 1ccd6c0733d31badbdfc9dacb71ff95768edfd7b

Or to build 4.19.195-rt82 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.195.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.195-rt82.patch.xz


You can also build from 4.19.193-rt81 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.193-rt81-rt82.patch.xz

Enjoy!
Clark

Changes from v4.19.193-rt81:
---

Ahelenia Ziemiańska (1):
      HID: multitouch: require Finger field to mark Win8 reports as MT

Alaa Hleihel (1):
      IB/mlx5: Fix initializing CQ fragments buffer

Alexander Kuznetsov (1):
      cgroup1: don't allow '\n' in renaming

Alexandre GRIVEAUX (1):
      USB: serial: omninet: add device id for Zyxel Omni 56K Plus

Anand Jain (1):
      btrfs: fix unmountable seed device after fstrim

Anant Thazhemadam (1):
      nl80211: validate key indexes for cfg80211_registered_device

Anna Schumaker (1):
      NFS: Fix use-after-free in nfs4_init_client()

Anson Huang (1):
      ARM: dts: imx6qdl-sabresd: Assign corresponding power supply for LDOs

Arnd Bergmann (1):
      HID: i2c-hid: fix format string mismatch

Björn Töpel (2):
      selftests/bpf: add "any alignment" annotation for some tests
      selftests/bpf: Avoid running unprivileged tests with alignment requirements

Carlos M (1):
      ALSA: hda: Fix for mute key LED for HP Pavilion 15-CK0xx

Cheng Jian (1):
      sched/fair: Optimize select_idle_cpu

Chris Packham (4):
      powerpc/fsl: set fsl,i2c-erratum-a004447 flag for P2041 i2c controllers
      powerpc/fsl: set fsl,i2c-erratum-a004447 flag for P1010 i2c controllers
      i2c: mpc: Make use of i2c_recover_bus()
      i2c: mpc: implement erratum A-004447 workaround

Clark Williams (2):
      Merge tag 'v4.19.195' into v4.19-rt
      Linux 4.19.195-rt82

Dai Ngo (1):
      NFSv4: nfs4_proc_set_acl needs to restore NFS_CAP_UIDGID_NOMAP on error.

Dan Carpenter (2):
      net: mdiobus: get rid of a BUG_ON()
      NFS: Fix a potential NULL dereference in nfs_get_client()

Daniel Borkmann (2):
      bpf: fix test suite to enable all unpriv program types
      bpf: test make sure to run unpriv test cases in test_verifier

David S. Miller (4):
      bpf: Add BPF_F_ANY_ALIGNMENT.
      bpf: Adjust F_NEEDS_EFFICIENT_UNALIGNED_ACCESS handling in test_verifier.c
      bpf: Make more use of 'any' alignment in test_verifier.c
      bpf: Apply F_NEEDS_EFFICIENT_UNALIGNED_ACCESS to more ACCEPT test cases.

Desmond Cheong Zhi Xi (2):
      drm: Fix use-after-free read in drm_getunique()
      drm: Lock pointer access in drm_master_release()

Dmitry Baryshkov (1):
      regulator: core: resolve supply for boot-on/always-on regulators

Dmitry Bogdanov (1):
      scsi: target: qla2xxx: Wait for stop_phase1 at WWN removal

Dmitry Osipenko (1):
      regulator: max77620: Use device_set_of_node_from_dev()

Erik Schmauss (1):
      ACPI: probe ECDT before loading AML tables regardless of module-level code flag

George McCollister (1):
      USB: serial: ftdi_sio: add NovaTech OrionMX product ID

Grant Grundler (1):
      net: usb: cdc_ncm: don't spew notifications

Greg Kroah-Hartman (2):
      Linux 4.19.194
      Linux 4.19.195

Hannes Reinecke (1):
      nvme-fabrics: decode host pathing error for connect

Hans de Goede (2):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Glavey TM800A550L tablet
      ASoC: Intel: bytcr_rt5640: Add quirk for the Lenovo Miix 3-830 tablet

Heiner Kallweit (1):
      efi: Allow EFI_MEMORY_XP and EFI_MEMORY_RO both to be cleared

Hoang Le (2):
      tipc: add extack messages for bearer/media failure
      tipc: fix unique bearer names sanity check

Ian Rogers (1):
      perf/cgroups: Don't rotate events for cgroups unnecessarily

Jan Beulich (1):
      xen-pciback: redo VF placement in the virtual topology

Javed Hasan (1):
      scsi: bnx2fc: Return failure if io_req is already in ABTS processing

Jeimon (1):
      net/nfc/rawsock.c: fix a permission check bug

Jiapeng Chong (1):
      bnx2x: Fix missing error code in bnx2x_iov_init_one()

Joe Stringer (1):
      selftests/bpf: Generalize dummy program types

Johan Hovold (1):
      USB: serial: quatech2: fix control-request directions

Johannes Berg (2):
      bonding: init notify_work earlier to avoid uninitialized use
      netlink: disable IRQs for netlink_lock_table()

Josef Bacik (4):
      btrfs: mark ordered extent and inode with error if we fail to finish
      btrfs: fix error handling in btrfs_del_csums
      btrfs: return errors from btrfs_del_csums in cleanup_ref_head
      btrfs: fixup error handling in fixup_inode_link_counts

Julian Anastasov (1):
      ipvs: ignore IP_VS_SVC_F_HASHED flag when adding service

Junxiao Bi (1):
      ocfs2: fix data corruption by fallocate

Kees Cook (1):
      proc: Track /proc/$pid/attr/ opener mm_struct

Krzysztof Kozlowski (1):
      nfc: fix NULL ptr dereference in llcp_sock_getname() after failed connect

Kyle Tso (1):
      usb: pd: Set PD_T_SINK_WAIT_CAP to 310ms

Leo Yan (1):
      perf session: Correct buffer copying when peeking events

Liangyan (1):
      tracing: Correct the length check which causes memory corruption

Lin Ma (2):
      Bluetooth: fix the erroneous flush_work() order
      Bluetooth: use correct lock to prevent UAF of hdev object

Linus Torvalds (1):
      proc: only require mm_struct for writing

Linyu Yuan (1):
      usb: gadget: eem: fix wrong eem header operation

Maciej Żenczykowski (4):
      USB: f_ncm: ncm_bitrate (speed) is unsigned
      usb: f_ncm: only first packet of aggregate needs to start timer
      usb: fix various gadgets null ptr deref on 10gbps cabling.
      usb: fix various gadget panics on 10gbps cabling

Magnus Karlsson (1):
      ixgbevf: add correct exception tracing for XDP

Marc Zyngier (1):
      KVM: arm64: Fix debug register indexing

Marco Elver (1):
      perf: Fix data race between pin_count increment/decrement

Marek Vasut (1):
      ARM: dts: imx6q-dhcom: Add PU,VDD1P1,VDD2P5 regulators

Marian-Cristian Rotariu (1):
      usb: dwc3: ep0: fix NULL pointer exception

Mark Rutland (1):
      pid: take a reference when initializing `cad_pid`

Matt Wang (1):
      scsi: vmw_pvscsi: Set correct residual data length

Max Gurtovoy (1):
      vfio/platform: fix module_put call in error flow

Mayank Rana (1):
      usb: typec: ucsi: Clear PPM capability data in ucsi_init() error path

Michael Chan (1):
      bnxt_en: Remove the setting of dev_port.

Mina Almasry (1):
      mm, hugetlb: fix simple resv_huge_pages underflow on UFFDIO_COPY

Ming Lei (3):
      scsi: core: Fix error handling of scsi_host_alloc()
      scsi: core: Put .shost_dev in failure path if host state changes to RUNNING
      scsi: core: Only put parent device if host state differs from SHOST_CREATED

Nathan Chancellor (1):
      vmlinux.lds.h: Avoid orphan section with !SMP

Pablo Neira Ayuso (1):
      netfilter: nfnetlink_cthelper: hit EBUSY on updates if size mismatches

Paolo Bonzini (2):
      kvm: avoid speculation-based attacks from out-of-range memslot accesses
      kvm: fix previous commit for 32-bit builds

Pavel Skripkin (4):
      net: caif: added cfserl_release function
      net: caif: add proper error handling
      net: caif: fix memory leak in caif_device_notify
      net: caif: fix memory leak in cfusbl_device_notify

Peter Zijlstra (1):
      perf/core: Fix endless multiplex timer

Phil Elwell (1):
      usb: dwc2: Fix build in periphal-only mode

Pierre-Louis Bossart (1):
      ALSA: usb: update old-style static const declaration

Rafael J. Wysocki (1):
      ACPI: EC: Look for ECDT EC after calling acpi_load_tables()

Randy Dunlap (1):
      vfio/pci: zap_vma_ptes() needs MMU

Rao Shoaib (1):
      RDS tcp loopback connection can hang

Rasmus Villemoes (1):
      efi: cper: fix snprintf() use in cper_dimm_err_location()

Ritesh Harjani (1):
      btrfs: return value from btrfs_mark_extent_written() in case of error

Saubhik Mukherjee (1):
      net: appletalk: cops: Fix data race in cops_probe1

Sean Christopherson (1):
      KVM: SVM: Truncate GPR value for DR and CR accesses in !64-bit mode

Sergey Senozhatsky (1):
      wq: handle VM suspension in stall detection

Shakeel Butt (1):
      cgroup: disable controllers at parse time

Shay Drory (1):
      RDMA/mlx4: Do not map the core_clock page to user space unless enabled

Song Liu (1):
      perf/core: Fix corner case in perf_rotate_context()

Stefan Agner (1):
      USB: serial: cp210x: fix alternate function for CP2102N QFN20

Steven Rostedt (VMware) (1):
      ftrace: Do not blindly read the ip address in ftrace_bug()

Takashi Iwai (1):
      ALSA: timer: Fix master timer notification

Thomas Gleixner (1):
      x86/apic: Mark _all_ legacy interrupts when IO/APIC is missing

Tiezhu Yang (1):
      MIPS: Fix kernel hang under FUNCTION_GRAPH_TRACER and PREEMPT_TRACER

Trond Myklebust (2):
      NFSv4: Fix deadlock between nfs4_evict_inode() and nfs4_opendata_get_inode()
      NFSv4: Fix second deadlock in nfs4_evict_inode()

Vincent Guittot (1):
      sched/fair: Make sure to update tg contrib for blocked load

Wei Yongjun (2):
      samples: vfio-mdev: fix error handing in mdpy_fb_probe()
      ieee802154: fix error return code in ieee802154_llsec_getparams()

Wenli Looi (1):
      staging: rtl8723bs: Fix uninitialized variables

Wesley Cheng (1):
      usb: gadget: f_fs: Ensure io_completion_wq is idle during unbind

Ye Bin (1):
      ext4: fix bug on in ext4_es_cache_extent as ext4_split_extent_at failed

Zhen Lei (3):
      vfio/pci: Fix error return code in vfio_ecap_init()
      HID: pidff: fix error return code in hid_pidff_init()
      ieee802154: fix error return code in ieee802154_add_iface()

Zheyu Ma (2):
      isdn: mISDN: netjet: Fix crash in nj_probe:
      net/qla3xxx: fix schedule while atomic in ql_sem_spinlock

Zong Li (1):
      net: macb: ensure the device is available before accessing GEMGXL control registers

Zou Wei (1):
      ASoC: sti-sas: add missing MODULE_DEVICE_TABLE
---
Makefile                                          |   2 +-
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi            |  12 ++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi            |  12 ++
 arch/arm/boot/dts/imx6qdl.dtsi                    |   6 +-
 arch/arm64/kvm/sys_regs.c                         |  42 ++--
 arch/mips/lib/mips-atomic.c                       |  12 +-
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi       |   8 +
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi       |  16 ++
 arch/x86/include/asm/apic.h                       |   1 +
 arch/x86/kernel/apic/apic.c                       |   1 +
 arch/x86/kernel/apic/vector.c                     |  20 ++
 arch/x86/kvm/svm.c                                |   8 +-
 drivers/acpi/bus.c                                |  42 ++--
 drivers/firmware/efi/cper.c                       |   4 +-
 drivers/firmware/efi/memattr.c                    |   5 -
 drivers/gpu/drm/drm_auth.c                        |   3 +-
 drivers/gpu/drm/drm_ioctl.c                       |   9 +-
 drivers/hid/hid-multitouch.c                      |  10 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                |   4 +-
 drivers/hid/usbhid/hid-pidff.c                    |   1 +
 drivers/i2c/busses/i2c-mpc.c                      |  95 ++++++++-
 drivers/infiniband/hw/mlx4/main.c                 |   5 +-
 drivers/infiniband/hw/mlx5/cq.c                   |   9 +-
 drivers/isdn/hardware/mISDN/netjet.c              |   1 -
 drivers/net/appletalk/cops.c                      |   4 +-
 drivers/net/bonding/bond_main.c                   |   2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |   1 -
 drivers/net/ethernet/cadence/macb_main.c          |   3 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   3 +
 drivers/net/ethernet/mellanox/mlx4/fw.c           |   3 +
 drivers/net/ethernet/mellanox/mlx4/fw.h           |   1 +
 drivers/net/ethernet/mellanox/mlx4/main.c         |   6 +
 drivers/net/ethernet/qlogic/qla3xxx.c             |   2 +-
 drivers/net/phy/mdio_bus.c                        |   3 +-
 drivers/net/usb/cdc_ncm.c                         |  12 +-
 drivers/nvme/host/fabrics.c                       |   5 +
 drivers/regulator/core.c                          |   6 +
 drivers/regulator/max77620-regulator.c            |   7 +
 drivers/scsi/bnx2fc/bnx2fc_io.c                   |   1 +
 drivers/scsi/hosts.c                              |  33 ++--
 drivers/scsi/qla2xxx/qla_target.c                 |   2 +
 drivers/scsi/vmw_pvscsi.c                         |   8 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   2 +-
 drivers/usb/dwc2/core_intr.c                      |   4 +
 drivers/usb/dwc3/ep0.c                            |   3 +
 drivers/usb/gadget/config.c                       |   8 +
 drivers/usb/gadget/function/f_ecm.c               |   2 +-
 drivers/usb/gadget/function/f_eem.c               |   6 +-
 drivers/usb/gadget/function/f_fs.c                |   3 +
 drivers/usb/gadget/function/f_hid.c               |   3 +-
 drivers/usb/gadget/function/f_loopback.c          |   2 +-
 drivers/usb/gadget/function/f_ncm.c               |  10 +-
 drivers/usb/gadget/function/f_printer.c           |   3 +-
 drivers/usb/gadget/function/f_rndis.c             |   2 +-
 drivers/usb/gadget/function/f_serial.c            |   2 +-
 drivers/usb/gadget/function/f_sourcesink.c        |   3 +-
 drivers/usb/gadget/function/f_subset.c            |   2 +-
 drivers/usb/gadget/function/f_tcm.c               |   3 +-
 drivers/usb/serial/cp210x.c                       |  20 +-
 drivers/usb/serial/ftdi_sio.c                     |   1 +
 drivers/usb/serial/ftdi_sio_ids.h                 |   1 +
 drivers/usb/serial/omninet.c                      |   2 +
 drivers/usb/serial/quatech2.c                     |   6 +-
 drivers/usb/typec/ucsi/ucsi.c                     |   1 +
 drivers/vfio/pci/Kconfig                          |   1 +
 drivers/vfio/pci/vfio_pci_config.c                |   2 +-
 drivers/vfio/platform/vfio_platform_common.c      |   2 +-
 drivers/xen/xen-pciback/vpci.c                    |  14 +-
 fs/btrfs/extent-tree.c                            |  12 +-
 fs/btrfs/file-item.c                              |  10 +-
 fs/btrfs/file.c                                   |   4 +-
 fs/btrfs/inode.c                                  |  12 ++
 fs/btrfs/tree-log.c                               |  13 +-
 fs/ext4/extents.c                                 |  43 +++--
 fs/nfs/client.c                                   |   2 +-
 fs/nfs/nfs4_fs.h                                  |   1 +
 fs/nfs/nfs4client.c                               |   2 +-
 fs/nfs/nfs4proc.c                                 |  29 ++-
 fs/ocfs2/file.c                                   |  55 +++++-
 fs/proc/base.c                                    |  11 +-
 include/asm-generic/vmlinux.lds.h                 |   1 +
 include/linux/kvm_host.h                          |  10 +-
 include/linux/mlx4/device.h                       |   1 +
 include/linux/perf_event.h                        |   5 +
 include/linux/usb/pd.h                            |   2 +-
 include/linux/usb/usbnet.h                        |   2 +
 include/net/caif/caif_dev.h                       |   2 +-
 include/net/caif/cfcnfg.h                         |   2 +-
 include/net/caif/cfserl.h                         |   1 +
 include/uapi/linux/bpf.h                          |  14 ++
 init/main.c                                       |   2 +-
 kernel/bpf/syscall.c                              |   7 +-
 kernel/bpf/verifier.c                             |   3 +
 kernel/cgroup/cgroup-v1.c                         |   4 +
 kernel/cgroup/cgroup.c                            |  13 +-
 kernel/events/core.c                              |  72 ++++---
 kernel/sched/fair.c                               |   9 +-
 kernel/trace/ftrace.c                             |   8 +-
 kernel/trace/trace.c                              |   2 +-
 kernel/workqueue.c                                |  12 +-
 localversion-rt                                   |   2 +-
 mm/hugetlb.c                                      |  14 +-
 net/bluetooth/hci_core.c                          |   7 +-
 net/bluetooth/hci_sock.c                          |   4 +-
 net/caif/caif_dev.c                               |  13 +-
 net/caif/caif_usb.c                               |  14 +-
 net/caif/cfcnfg.c                                 |  16 +-
 net/caif/cfserl.c                                 |   5 +
 net/ieee802154/nl-mac.c                           |   4 +-
 net/ieee802154/nl-phy.c                           |   4 +-
 net/netfilter/ipvs/ip_vs_ctl.c                    |   2 +-
 net/netfilter/nfnetlink_cthelper.c                |   8 +-
 net/netlink/af_netlink.c                          |   6 +-
 net/nfc/llcp_sock.c                               |   2 +
 net/nfc/rawsock.c                                 |   2 +-
 net/rds/connection.c                              |  23 ++-
 net/rds/tcp.c                                     |   4 +-
 net/rds/tcp.h                                     |   3 +-
 net/rds/tcp_listen.c                              |   6 +
 net/tipc/bearer.c                                 |  94 ++++++---
 net/wireless/core.h                               |   2 +
 net/wireless/nl80211.c                            |   7 +-
 net/wireless/util.c                               |  39 +++-
 samples/vfio-mdev/mdpy-fb.c                       |  13 +-
 sound/core/timer.c                                |   3 +-
 sound/pci/hda/patch_realtek.c                     |   1 +
 sound/soc/codecs/sti-sas.c                        |   1 +
 sound/soc/intel/boards/bytcr_rt5640.c             |  25 +++
 sound/usb/mixer_quirks.c                          |   2 +-
 tools/include/uapi/linux/bpf.h                    |  14 ++
 tools/lib/bpf/bpf.c                               |   8 +-
 tools/lib/bpf/bpf.h                               |   2 +-
 tools/perf/util/session.c                         |   1 +
 tools/testing/selftests/bpf/test_align.c          |   4 +-
 tools/testing/selftests/bpf/test_verifier.c       | 224 ++++++++++++++++------
 136 files changed, 1109 insertions(+), 378 deletions(-)
