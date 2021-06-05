Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32659C47082
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Jun 2021 18:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B88613FE
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Jun 2021 18:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFESfd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 5 Jun 2021 14:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhFESfd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 5 Jun 2021 14:35:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D826D613DF;
        Sat,  5 Jun 2021 18:33:44 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.193-rt81
Date:   Sat, 05 Jun 2021 18:32:32 -0000
Message-ID: <162291795287.1461400.1185835369064633002@puck.lan>
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

I'm pleased to announce the 4.19.193-rt81 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: bc58d4d90cfb326853b7026cfe4cecbaa6fb964b

Or to build 4.19.193-rt81 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.193.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.193-rt81.patch.xz


You can also build from 4.19.191-rt80 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.191-rt80-rt81.patch.xz

Enjoy!
Clark

Changes from v4.19.191-rt80:
---

Adrian Hunter (2):
      perf intel-pt: Fix sample instruction bytes
      perf intel-pt: Fix transaction abort handling

Alaa Emad (1):
      media: dvb: Add check on sp8870_readreg return

Alan Stern (1):
      USB: usbfs: Don't WARN about excessively large memory allocations

Alexander Usyskin (1):
      mei: request autosuspend after sending rx flow control

Alexei Starovoitov (1):
      bpf: extend is_branch_taken to registers

Andrey Ignatov (1):
      selftests/bpf: Test narrow loads with off > 0 in test_verifier

Andy Shevchenko (1):
      platform/x86: intel_punit_ipc: Append MODULE_DEVICE_TABLE for ACPI

Anirudh Rayabharam (4):
      rapidio: handle create_workqueue() failure
      net: stmicro: handle clk_prepare() failure during init
      video: hgafb: correctly handle card detect failure during probe
      net: fujitsu: fix potential null-ptr-deref

Anna Schumaker (1):
      NFSv4: Fix a NULL pointer dereference in pnfs_mark_matching_lsegs_return()

Atul Gopinathan (2):
      cdrom: gdrom: deallocate struct gdrom_unit fields in remove_gdrom
      serial: max310x: unregister uart driver in case of failure and abort

Aurelien Aptel (1):
      cifs: set server->cipher_type to AES-128-CCM for SMB3.0

Chris Park (1):
      drm/amd/display: Disconnect non-DP with no EDID

Christophe JAILLET (4):
      openrisc: Fix a memory leak
      net: netcp: Fix an error message
      net: mdio: thunder: Fix a double free issue in the .remove function
      net: mdio: octeon: Fix some double free issues

Chunfeng Yun (1):
      usb: core: reduce power-on-good delay time of root hub

Clark Williams (3):
      Merge tag 'v4.19.192' into v4.19-rt
      Merge tag 'v4.19.193' into v4.19-rt
      Linux 4.19.193-rt81

DENG Qingfang (1):
      net: dsa: mt7530: fix VLAN traffic leaks

Dan Carpenter (6):
      firmware: arm_scpi: Prevent the ternary sign expansion bug
      NFS: fix an incorrect limit in filelayout_decode_layout()
      net: dsa: fix a crash if ->get_sset_count() fails
      staging: emxx_udc: fix loop in _nbu2ss_nuke()
      ASoC: cs35l33: fix an error code in probe()
      scsi: libsas: Use _safe() loop in sas_resume_port()

Daniel Borkmann (13):
      bpf, test_verifier: switch bpf_get_stack's 0 s> r8 test
      bpf: Move off_reg into sanitize_ptr_alu
      bpf: Ensure off_reg has no mixed signed bounds for all types
      bpf: Rework ptr_limit into alu_limit and add common error path
      bpf: Improve verifier error messages for users
      bpf: Refactor and streamline bounds check into helper
      bpf: Move sanitize_val_alu out of op switch
      bpf: Tighten speculative pointer arithmetic mask
      bpf: Update selftests to reflect new error states
      bpf: Fix leakage of uninitialized bpf stack under speculation
      bpf: Wrap aux data inside bpf_sanitize_info container
      bpf: Fix mask direction swap upon off reg sign change
      bpf: No need to simulate speculative domain for immediates

Daniel Wagner (1):
      nvmet: seset ns->file when open fails

Daniele Palmas (1):
      USB: serial: option: add Telit LE910-S1 compositions 0x7010, 0x7011

Dominik Andreas Schorpp (1):
      USB: serial: ftdi_sio: add IDs for IDS GmbH Products

Dongliang Mu (2):
      NFC: nci: fix memory leak in nci_allocate_device
      misc/uss720: fix memory leak in uss720_probe

Du Cheng (2):
      ethernet: sun: niu: fix missing checks of niu_pci_eeprom_read()
      net: caif: remove BUG_ON(dev == NULL) in caif_xmit

Felix Fietkau (1):
      perf jevents: Fix getting maximum number of fds

Francesco Ruggeri (1):
      ipv6: record frag_max_size in atomic fragments in input path

Fugang Duan (1):
      net: fec: fix the potential memory leak in fec_enet_init()

Geert Uytterhoeven (1):
      serial: sh-sci: Fix off-by-one error in FIFO threshold register setting

Greg Kroah-Hartman (23):
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
      Linux 4.19.192
      kgdb: fix gcc-11 warnings harder
      libertas: register sysfs groups properly
      ASoC: cs43130: handle errors in cs43130_probe() properly
      media: gspca: properly check for errors in po1030_probe()
      Linux 4.19.193

Hans de Goede (1):
      platform/x86: dell-smbios-wmi: Fix oops on rmmod dell_smbios

Hoang Le (1):
      Revert "net:tipc: Fix a double free in tipc_sk_mcast_rcv"

Hui Wang (1):
      ALSA: hda/realtek: reset eapd coeff to default value for alc287

Igor Matheus Andrade Torrente (1):
      video: hgafb: fix potential NULL pointer dereference

Jack Pham (1):
      usb: dwc3: gadget: Enable suspend events

Jan Beulich (1):
      xen-pciback: reconfigure also from backend watch handler

Jean Delvare (1):
      i2c: i801: Don't generate an interrupt on bus reset

Jesse Brandeburg (2):
      ixgbe: fix large MTU request from VF
      drivers/net/ethernet: clean up unused assignments

Jingwen Chen (1):
      drm/amd/amdgpu: fix refcount leak

Johan Hovold (2):
      net: hso: fix control-request directions
      USB: trancevibrator: fix control-request direction

Johannes Berg (5):
      mac80211: drop A-MSDUs on old ciphers
      mac80211: add fragment cache to sta_info
      mac80211: check defrag PN against current frame
      mac80211: prevent attacks on TKIP/WEP as well
      mac80211: do not accept/forward invalid EAPOL frames

John Fastabend (1):
      bpf: Test_verifier, bpf_get_stack return value add <0

Josef Bacik (1):
      btrfs: do not BUG_ON in link_to_fixup_dir

Jussi Maki (1):
      bpf: Set mac_len in bpf_skb_change_head

Kai-Heng Feng (1):
      platform/x86: hp_accel: Avoid invoking _INI to speed up resume

Kees Cook (1):
      proc: Check /proc/$pid/attr/ writes against file opener

Krzysztof Kozlowski (1):
      i2c: s3c2410: fix possible NULL pointer deref on read message after write

Leon Romanovsky (1):
      RDMA/rxe: Clear all QP fields if creation failed

Lucas Stankus (1):
      staging: iio: cdc: ad7746: avoid overwrite of num_channels

Luiz Augusto von Dentz (1):
      Bluetooth: SMP: Fail if remote and local public keys are identical

Lukas Wunner (3):
      spi: gpio: Don't leak SPI master in probe error path
      spi: mt7621: Disable clock in probe error path
      spi: mt7621: Don't leak SPI master in probe error path

Maciej W. Rozycki (2):
      vgacon: Record video mode changes with VT_RESIZEX
      vt: Fix character height handling with VT_RESIZEX

Maor Gottlieb (1):
      RDMA/mlx5: Recover from fatal event in dual port mode

Mathias Nyman (1):
      thunderbolt: dma_port: Fix NVM read buffer bounds and offset issue

Mathy Vanhoef (4):
      mac80211: assure all fragments are encrypted
      mac80211: prevent mixed key and fragment cache attacks
      mac80211: properly handle A-MSDUs that start with an RFC 1042 header
      cfg80211: mitigate A-MSDU aggregation attacks

Matt Wang (1):
      scsi: BusLogic: Fix 64-bit system enumeration error for Buslogic

Mike Kravetz (1):
      hugetlbfs: hugetlb_fault_mutex_hash() cleanup

Mikulas Patocka (2):
      dm snapshot: fix crash with transient storage and zero chunk size
      dm snapshot: properly fix a crash when an origin has no snapshots

Neil Armstrong (1):
      drm/meson: fix shutdown crash when component not probed

Oleg Nesterov (1):
      ptrace: make ptrace() fail if the tracee changed its pid unexpectedly

Ovidiu Panait (2):
      bpf: fix up selftests after backports were fixed
      selftests/bpf: add selftest part of "bpf: improve verifier branch analysis"

Pavel Skripkin (1):
      net: usb: fix memory leak in smsc75xx_bind

PeiSen Hou (1):
      ALSA: hda/realtek: Add some CLOVE SSIDs of ALC293

Peter Zijlstra (1):
      openrisc: Define memory barrier mb

Phillip Potter (4):
      scsi: ufs: handle cleanup correctly on devm_reset_control_get error
      leds: lp5523: check return value of lp5xx_read and jump to cleanup code
      isdn: mISDNinfineon: check/cleanup ioremap failure correctly in setup_io
      dmaengine: qcom_hidma: comment platform_driver_register call

Piotr Krysiuk (1):
      bpf, selftests: Fix up some test_verifier cases for unprivileged

Randy Dunlap (2):
      MIPS: alchemy: xxs1500: add gpio-au1000.h header file
      MIPS: ralink: export rt_sysc_membase for rt2880_wdt.c

Rolf Eike Beer (1):
      iommu/vt-d: Fix sysfs leak in alloc_iommu()

Ronnie Sahlberg (1):
      cifs: fix memory leak in smb2_copychunk_range

Sean MacLennan (1):
      USB: serial: ti_usb_3410_5052: add startech.com device id

Shyam Sundar S K (1):
      platform/x86: hp-wireless: add AMD's hardware id to the supported list

Sriram R (1):
      ath10k: Validate first subframe of A-MSDU before processing the list

Stephen Brennan (1):
      mm, vmstat: drop zone->lock in /proc/pagetypeinfo

Steve French (1):
      SMB3: incorrect file id in requests compounded with open

Taehee Yoo (2):
      mld: fix panic in mld_newpack()
      sch_dsmark: fix a NULL deref in qdisc_reset()

Takashi Iwai (2):
      ALSA: line6: Fix racy initialization of LINE6 MIDI
      ALSA: usb-audio: Validate MS endpoint descriptors

Takashi Sakamoto (3):
      ALSA: dice: fix stream format for TC Electronic Konnekt Live at high sampling transfer frequency
      ALSA: dice: fix stream format at middle sampling rate for Alesis iO 26
      ALSA: bebob/oxfw: fix Kconfig entry for Mackie d.2 Pro

Tao Liu (1):
      openvswitch: meter: fix race when getting now_ms.

Tetsuo Handa (1):
      tty: vt: always invoke vc->vc_sw->con_resize callback

Thadeu Lima de Souza Cascardo (1):
      Bluetooth: cmtp: fix file refcount when cmtp_attach_device fails

Thinh Nguyen (1):
      usb: dwc3: gadget: Properly track pending and queued SG

Tom Seewald (2):
      qlcnic: Add null check after calling netdev_alloc_skb
      char: hpet: add checks after calling ioremap

Trond Myklebust (1):
      NFS: Don't corrupt the value of pg_bytes_written in nfs_do_recoalesce()

Vladimir Oltean (1):
      net: dsa: fix error code getting shifted with 4 in dsa_slave_get_sset_count

Vladyslav Tarasiuk (1):
      net/mlx4: Fix EEPROM dump support

Wen Gong (1):
      mac80211: extend protection against mixed key and fragment cache attacks

Xin Long (1):
      tipc: skb_linearize the head skb when reassembling msgs

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: Fix a race in usb3_start_pipen()

YueHaibing (1):
      iio: adc: ad7793: Add missing error code in ad7793_setup()

Yunsheng Lin (1):
      net: hns3: check the return of skb_checksum_help()

Zhang Xiaoxu (1):
      NFSv4: Fix v4.0/v4.1 SEEK_DATA return -ENOTSUPP when set NFS_V4_2 config

Zhen Lei (2):
      scsi: qla2xxx: Fix error return code in qla82xx_write_flash_dword()
      net: bnx2: Fix error return code in bnx2_init_board()

Zheyu Ma (1):
      serial: rp2: use 'request_firmware' instead of 'request_firmware_nowait'

Zolton Jheng (1):
      USB: serial: pl2303: add device id for ADLINK ND-6530 GC

Zqiang (1):
      locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal

xinhui pan (1):
      drm/amdgpu: Fix a use-after-free
---
Makefile                                           |   2 +-
 arch/mips/alchemy/board-xxs1500.c                  |   1 +
 arch/mips/ralink/of.c                              |   2 +
 arch/openrisc/include/asm/barrier.h                |   9 +
 arch/openrisc/kernel/setup.c                       |   2 +
 drivers/cdrom/gdrom.c                              |  13 +-
 drivers/char/hpet.c                                |   4 +
 drivers/dma/qcom/hidma_mgmt.c                      |  14 +
 drivers/firmware/arm_scpi.c                        |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  18 ++
 drivers/gpu/drm/meson/meson_drv.c                  |   9 +-
 drivers/hwmon/lm80.c                               |  11 +-
 drivers/i2c/busses/i2c-i801.c                      |   6 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |   3 +
 drivers/iio/adc/ad7793.c                           |   1 +
 drivers/infiniband/hw/mlx5/main.c                  |   1 +
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   7 +
 drivers/iommu/dmar.c                               |   4 +-
 drivers/isdn/hardware/mISDN/mISDNinfineon.c        |  24 +-
 drivers/leds/leds-lp5523.c                         |   2 +-
 drivers/md/dm-snap.c                               |   3 +-
 drivers/media/dvb-frontends/sp8870.c               |   4 +-
 drivers/media/platform/rcar_drif.c                 |   1 -
 drivers/media/usb/gspca/m5602/m5602_po1030.c       |  10 +-
 drivers/misc/kgdbts.c                              |   3 +-
 drivers/misc/lis3lv02d/lis3lv02d.h                 |   1 +
 drivers/misc/mei/interrupt.c                       |   3 +
 drivers/net/caif/caif_serial.c                     |   1 -
 drivers/net/dsa/mt7530.c                           |   8 -
 drivers/net/ethernet/broadcom/bnx2.c               |   2 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |   7 +-
 drivers/net/ethernet/dec/tulip/de4x5.c             |   4 +-
 drivers/net/ethernet/dec/tulip/media.c             |   5 -
 drivers/net/ethernet/freescale/fec_main.c          |  11 +-
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c          |   5 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  16 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx4/port.c          | 107 +++++++-
 drivers/net/ethernet/micrel/ksz884x.c              |   3 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   6 +-
 drivers/net/ethernet/neterion/vxge/vxge-traffic.c  |  32 +--
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   3 +-
 drivers/net/ethernet/sfc/falcon/farch.c            |  29 +-
 drivers/net/ethernet/sis/sis900.c                  |   5 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |   8 +-
 drivers/net/ethernet/sun/niu.c                     |  32 ++-
 drivers/net/ethernet/synopsys/dwc-xlgmac-common.c  |   2 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   5 +-
 drivers/net/ethernet/ti/netcp_core.c               |   2 +-
 drivers/net/ethernet/ti/tlan.c                     |   4 +-
 drivers/net/ethernet/via/via-velocity.c            |  13 -
 drivers/net/phy/mdio-octeon.c                      |   2 -
 drivers/net/phy/mdio-thunder.c                     |   1 -
 drivers/net/usb/hso.c                              |   4 +-
 drivers/net/usb/smsc75xx.c                         |   8 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |  61 ++++-
 drivers/net/wireless/marvell/libertas/mesh.c       |  28 +-
 drivers/net/wireless/realtek/rtlwifi/base.c        |  19 +-
 drivers/nvme/target/io-cmd-file.c                  |   8 +-
 drivers/platform/x86/dell-smbios-wmi.c             |   3 +-
 drivers/platform/x86/hp-wireless.c                 |   2 +
 drivers/platform/x86/hp_accel.c                    |  22 +-
 drivers/platform/x86/intel_punit_ipc.c             |   1 +
 drivers/rapidio/rio_cm.c                           |  17 +-
 drivers/scsi/BusLogic.c                            |   6 +-
 drivers/scsi/BusLogic.h                            |   2 +-
 drivers/scsi/libsas/sas_port.c                     |   4 +-
 drivers/scsi/qla2xxx/qla_nx.c                      |   3 +-
 drivers/scsi/ufs/ufs-hisi.c                        |  15 +-
 drivers/spi/spi-gpio.c                             |   8 +-
 drivers/staging/emxx_udc/emxx_udc.c                |   4 +-
 drivers/staging/iio/cdc/ad7746.c                   |   1 -
 drivers/staging/mt7621-spi/spi-mt7621.c            |  10 +-
 drivers/thunderbolt/dma_port.c                     |  11 +-
 drivers/tty/serial/max310x.c                       |   6 +-
 drivers/tty/serial/mvebu-uart.c                    |   3 -
 drivers/tty/serial/rp2.c                           |  52 ++--
 drivers/tty/serial/sh-sci.c                        |   4 +-
 drivers/tty/vt/vt.c                                |   2 +-
 drivers/tty/vt/vt_ioctl.c                          |   6 +-
 drivers/usb/core/devio.c                           |  11 +-
 drivers/usb/core/hub.h                             |   6 +-
 drivers/usb/dwc3/gadget.c                          |  17 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   5 +-
 drivers/usb/misc/trancevibrator.c                  |   4 +-
 drivers/usb/misc/uss720.c                          |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   3 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   7 +
 drivers/usb/serial/option.c                        |   4 +
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   1 +
 drivers/usb/serial/ti_usb_3410_5052.c              |   3 +
 drivers/video/console/vgacon.c                     |  56 ++--
 drivers/video/fbdev/core/fbcon.c                   |   2 +-
 drivers/video/fbdev/hgafb.c                        |  21 +-
 drivers/video/fbdev/imsttfb.c                      |   5 -
 drivers/xen/xen-pciback/xenbus.c                   |  22 +-
 fs/btrfs/tree-log.c                                |   2 -
 fs/cifs/smb2ops.c                                  |   2 +
 fs/cifs/smb2pdu.c                                  |  13 +-
 fs/ecryptfs/crypto.c                               |   6 +-
 fs/hugetlbfs/inode.c                               |   4 +-
 fs/nfs/filelayout/filelayout.c                     |   2 +-
 fs/nfs/nfs4file.c                                  |   2 +-
 fs/nfs/pagelist.c                                  |  12 +-
 fs/nfs/pnfs.c                                      |  15 +-
 fs/proc/base.c                                     |   4 +
 include/linux/bpf_verifier.h                       |   5 +-
 include/linux/console_struct.h                     |   1 +
 include/linux/hugetlb.h                            |   2 +-
 include/net/cfg80211.h                             |   4 +-
 include/net/nfc/nci_core.h                         |   1 +
 kernel/bpf/verifier.c                              | 300 ++++++++++++++-------
 kernel/locking/mutex-debug.c                       |   4 +-
 kernel/locking/mutex-debug.h                       |   2 +-
 kernel/locking/mutex.c                             |  18 +-
 kernel/locking/mutex.h                             |   4 +-
 kernel/ptrace.c                                    |  18 +-
 localversion-rt                                    |   2 +-
 mm/hugetlb.c                                       |  10 +-
 mm/userfaultfd.c                                   |   2 +-
 mm/vmstat.c                                        |   3 +
 net/bluetooth/cmtp/core.c                          |   5 +
 net/bluetooth/smp.c                                |   9 +
 net/core/filter.c                                  |   1 +
 net/dsa/master.c                                   |   5 +-
 net/dsa/slave.c                                    |  12 +-
 net/ipv6/mcast.c                                   |   3 -
 net/ipv6/reassembly.c                              |   4 +-
 net/mac80211/ieee80211_i.h                         |  36 +--
 net/mac80211/iface.c                               |  11 +-
 net/mac80211/key.c                                 |   7 +
 net/mac80211/key.h                                 |   2 +
 net/mac80211/rx.c                                  | 150 ++++++++---
 net/mac80211/sta_info.c                            |   6 +-
 net/mac80211/sta_info.h                            |  32 +++
 net/mac80211/wpa.c                                 |  13 +-
 net/nfc/nci/core.c                                 |   1 +
 net/nfc/nci/hci.c                                  |   5 +
 net/openvswitch/meter.c                            |   8 +
 net/sched/sch_dsmark.c                             |   3 +-
 net/tipc/msg.c                                     |   9 +-
 net/tipc/socket.c                                  |   5 +-
 net/wireless/util.c                                |   7 +-
 sound/firewire/Kconfig                             |   4 +-
 sound/firewire/bebob/bebob.c                       |   2 +-
 sound/firewire/dice/dice-alesis.c                  |   2 +-
 sound/firewire/dice/dice-tcelectronic.c            |   4 +-
 sound/firewire/oxfw/oxfw.c                         |   1 -
 sound/isa/sb/sb8.c                                 |   4 -
 sound/pci/hda/patch_realtek.c                      |  20 +-
 sound/soc/codecs/cs35l33.c                         |   1 +
 sound/soc/codecs/cs43130.c                         |  28 +-
 sound/usb/line6/driver.c                           |   4 +
 sound/usb/line6/pod.c                              |   5 -
 sound/usb/line6/variax.c                           |   6 -
 sound/usb/midi.c                                   |   4 +
 tools/perf/pmu-events/jevents.c                    |   2 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   6 +-
 tools/perf/util/intel-pt.c                         |   5 +-
 tools/testing/selftests/bpf/test_verifier.c        | 112 ++++++--
 165 files changed, 1285 insertions(+), 671 deletions(-)
