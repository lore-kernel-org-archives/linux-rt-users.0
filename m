Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFCCC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 06:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC53160720
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 06:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhG3Gxa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 02:53:30 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:49342 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbhG3Gx3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jul 2021 02:53:29 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 02:53:29 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 515855E365;
        Fri, 30 Jul 2021 08:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1627627531; h=from:subject:date:message-id:to;
        bh=4PKd3BZyidcWMuckuL/X+cda0P229N3fFA39S0laNhY=;
        b=wbj9iGmjTASP2qhBGypd+k4Aj20tLbgOtPAl87SOG3t+bP4w3D53/TAHSBNBtJsMyqcNj6
        NqP+GPArbXhDKI9ojN1VtLA8OHUlnrqFs05VtS9OrVD4kJbyurdO0stT+GxGRHNAmzkjLP
        eF1Dm0ONK9vmtVNy4nrNX+5O2xj3FQcDINUmy3WoQhrPN/H52TjlR5HJT3lIPFiujRRrEk
        2Bx/YjQ+yI5fYuANkrqg0VsLlLvOZs/a3Eg5+HC/OekVAiOx+oQIdSdiTtyp6AowxTGKzz
        zpae4YCH/nwBJDScOrwLa0w+vGHh5FNIRwS50GPMeZQ/9Gvklem4TuKXPGWFZg==
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.277-rt224
Date:   Fri, 30 Jul 2021 06:39:07 -0000
Message-ID: <162762714720.5121.4789079771844033633@beryllium.lan>
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
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.277-rt224 stable release.

This is just an update to the latest stable release. No RT specific
changes.

Sorry for the long delay. I was refactoring and improving my test
setup which took a bit longer than I expected. I switched from a
Debian based rootfs to an Tumbleweed based one, for obvious
reasons. Anyway, this should not matter at all.

Known issue:

  - locktorture reports a might_sleep warning for spin_locks test

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 03818d523698ad1ae46f9f5b74711a180a75f76e

Or to build 4.4.277-rt224 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.277.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.277-rt224.patch.xz

Enjoy!
Daniel

Changes from v4.4.270-rt222:
---

Al Cooper (1):
      mmc: sdhci: Fix warning message when accessing RPMB in HS400 mode

Al Viro (1):
      iov_iter_fault_in_readable() should do nothing in xarray case

Alaa Emad (1):
      media: dvb: Add check on sp8870_readreg return

Aleksandr Loktionov (1):
      igb: Check if num of q_vectors is smaller than max before array access

Alexander Aring (1):
      fs: dlm: cancel work sync othercon

Alexander Kuznetsov (1):
      cgroup1: don't allow '\n' in renaming

Alexander Larkin (1):
      Input: joydev - prevent use of not validated data in JSIOCSBTNMAP ioctl

Alexander Usyskin (1):
      mei: request autosuspend after sending rx flow control

Alexandre GRIVEAUX (1):
      USB: serial: omninet: add device id for Zyxel Omni 56K Plus

Andy Shevchenko (2):
      net: pch_gbe: Propagate error from devm_gpio_request_one()
      net: pch_gbe: Use proper accessors to BE data in pch_ptp_match()

Anirudh Rayabharam (4):
      net: fujitsu: fix potential null-ptr-deref
      HID: usbhid: fix info leak in hid_submit_ctrl
      ext4: fix kernel infoleak via ext4_extent_header
      media: pvrusb2: fix warning in pvr2_i2c_core_done

Antti Järvinen (1):
      PCI: Mark TI C667X to avoid bus reset

Ard Biesheuvel (1):
      crypto: shash - avoid comparing pointers to exported functions under CFI

Arnd Bergmann (2):
      ARM: 9081/1: fix gcc-10 thumb2-kernel regression
      ia64: mca_drv: fix incorrect array size calculation

Arturo Giusti (1):
      udf: Fix NULL pointer dereference in udf_symlink function

Athira Rajeev (1):
      selftests/powerpc: Fix "no_handler" EBB selftest

Axel Lin (1):
      regulator: da9052: Ensure enough delay time for .set_voltage_time_sel

Benjamin Drung (1):
      media: uvcvideo: Fix pixel format change for Elgato Cam Link 4K

Benjamin Herrenschmidt (1):
      powerpc/boot: Fixup device-tree on little endian

Bibo Mao (1):
      hugetlb: clear huge pte during flush function on mips platform

Bixuan Cui (3):
      HID: gt683r: add missing MODULE_DEVICE_TABLE
      crypto: nx - add missing MODULE_DEVICE_TABLE
      power: reset: gpio-poweroff: add missing MODULE_DEVICE_TABLE

Bumyong Lee (1):
      dmaengine: pl330: fix wrong usage of spinlock flags in dma_cyclc

Chen Li (1):
      radeon: use memcpy_to/fromio for UVD fw upload

Chris Packham (4):
      powerpc/fsl: set fsl,i2c-erratum-a004447 flag for P2041 i2c controllers
      powerpc/fsl: set fsl,i2c-erratum-a004447 flag for P1010 i2c controllers
      i2c: mpc: Make use of i2c_recover_bus()
      i2c: mpc: implement erratum A-004447 workaround

Christian König (1):
      drm/nouveau: fix dma_address check for CPU/GPU sync

Christophe JAILLET (11):
      net: netcp: Fix an error message
      qlcnic: Fix an error handling path in 'qlcnic_probe()'
      netxen_nic: Fix an error handling path in 'netxen_nic_probe()'
      be2net: Fix an error handling path in 'be_probe()'
      brcmsmac: mac80211_if: Fix a resource leak in an error handling path
      tty: nozomi: Fix a resource leak in an error handling function
      tty: nozomi: Fix the error handling path of 'nozomi_card_init()'
      phy: ti: dm816x: Fix the error handling path in 'dm816x_usb_phy_probe()
      tty: serial: 8250: serial_cs: Fix a memory leak in error handling path
      scsi: be2iscsi: Fix an error handling path in beiscsi_dev_probe()
      iavf: Fix an error handling path in 'iavf_probe()'

Christophe Leroy (1):
      btrfs: disable build on platforms having page size 256K

Chunfeng Yun (1):
      usb: core: reduce power-on-good delay time of root hub

Colin Ian King (3):
      drm: qxl: ensure surf.data is ininitialized
      scsi: aic7xxx: Fix unintentional sign extension issue on left shift of u8
      s390/bpf: Perform r1 range checking before accessing jit->seen_reg[r1]

Corentin Labbe (1):
      crypto: ixp4xx - dma_unmap the correct address

Daehwan Jung (1):
      ALSA: usb-audio: fix rate on Ozone Z90 USB headset

Dai Ngo (1):
      NFSv4: nfs4_proc_set_acl needs to restore NFS_CAP_UIDGID_NOMAP on error.

Dan Carpenter (8):
      NFS: fix an incorrect limit in filelayout_decode_layout()
      staging: emxx_udc: fix loop in _nbu2ss_nuke()
      scsi: libsas: Use _safe() loop in sas_resume_port()
      net: mdiobus: get rid of a BUG_ON()
      NFS: Fix a potential NULL dereference in nfs_get_client()
      staging: gdm724x: check for buffer overflow in gdm_lte_multi_sdu_pkt()
      staging: gdm724x: check for overflow in gdm_lte_netif_rx()
      rtc: fix snprintf() checking in is_rtc_hctosys()

Daniel Wagner (4):
      Merge tag 'v4.4.273' into v4.4-rt
      Linux 4.4.273-rt223
      erge tag 'v4.4.277' into v4.4-rt
      Linux 4.4.277-rt224

Daniele Palmas (1):
      USB: serial: option: add Telit LE910-S1 compositions 0x7010, 0x7011

David Sterba (2):
      btrfs: clear defrag status of a root if starting transaction fails
      btrfs: compression: don't try to compress if we don't have enough pages

Davis Mosenkovs (1):
      mac80211: fix memory corruption in EAPOL handling

Desmond Cheong Zhi Xi (1):
      ntfs: fix validity check for file name attribute

Dillon Min (1):
      media: s5p-g2d: Fix a memory leak on ctx->fh.m2m_ctx

Dimitri John Ledkov (1):
      lib/decompress_unlz4.c: correctly handle zero-padding around initrds.

Dinghao Liu (1):
      i40e: Fix error handling in i40e_vsi_open

Dmitry Bogdanov (2):
      scsi: target: qla2xxx: Wait for stop_phase1 at WWN removal
      scsi: target: Fix protect handling in WRITE SAME(32)

Dmitry Osipenko (1):
      ASoC: tegra: Set driver_name=tegra for all machine drivers

Dominik Andreas Schorpp (1):
      USB: serial: ftdi_sio: add IDs for IDS GmbH Products

Dongliang Mu (3):
      NFC: nci: fix memory leak in nci_allocate_device
      misc/uss720: fix memory leak in uss720_probe
      net: usb: fix possible use-after-free in smsc75xx_bind

Doug Berger (1):
      net: bcmgenet: ensure EXT_ENERGY_DET_MASK is clear

Du Cheng (2):
      net: caif: remove BUG_ON(dev == NULL) in caif_xmit
      cfg80211: call cfg80211_leave_ocb when switching away from OCB

Eric Dumazet (6):
      net/af_unix: fix a data-race in unix_dgram_sendmsg / unix_release_sock
      inet: use bigger hash table for IP ID generation
      inet: annotate date races around sk->sk_txhash
      vxlan: add missing rcu_read_lock() in neigh_reduce()
      tcp: annotate data races around tp->mtu_info
      ipv6: tcp: drop silly ICMPv6 packet too big messages

Eric Sandeen (1):
      seq_file: disallow extremely large seq buffer allocations

Esben Haabendal (1):
      net: ll_temac: Avoid ndo_start_xmit returning NETDEV_TX_BUSY

Florian Fainelli (1):
      net: bcmgenet: Ensure all TX/RX queues DMAs are disabled

Fugang Duan (1):
      net: fec_ptp: add clock rate zero check

Gao Xiang (1):
      nfs: fix acl memory leak of posix_acl_create()

Geoff Levand (1):
      powerpc/ps3: Add dma_mask to ps3_dma_region

George McCollister (1):
      USB: serial: ftdi_sio: add NovaTech OrionMX product ID

Gerd Rausch (1):
      RDMA/cma: Fix rdma_resolve_route() memory leak

Greg Kroah-Hartman (10):
      kgdb: fix gcc-11 warnings harder
      libertas: register sysfs groups properly
      media: gspca: properly check for errors in po1030_probe()
      Linux 4.4.271
      Linux 4.4.272
      Linux 4.4.273
      Linux 4.4.275
      Linux 4.4.276
      Revert "memory: fsl_ifc: fix leak of IO mapping on probe failure"
      Linux 4.4.277

Gustavo A. R. Silva (3):
      media: siano: Fix out-of-bounds warnings in smscore_load_firmware_family2()
      wireless: wext-spy: Fix out-of-bounds warning
      media: ngene: Fix out-of-bounds bug in ngene_command_config_free_buf()

H. Peter Anvin (1):
      x86, asm: change the GEN_*_RMWcc() macros to not quote the condition

Hanjun Guo (1):
      ACPI: bus: Call kobject_put() in acpi_init() error path

Hannu Hartikainen (1):
      USB: cdc-acm: blacklist Heimann USB Appset device

Haoran Luo (1):
      tracing: Fix bug in rb_per_cpu_empty() that might cause deadloop.

Herbert Xu (1):
      crypto: nx - Fix RCU warning in nx842_OF_upd_status

Hillf Danton (1):
      gfs2: Fix use-after-free in gfs2_glock_shrink_scan

Hoang Le (1):
      Revert "net:tipc: Fix a double free in tipc_sk_mcast_rcv"

Hou Tao (1):
      dm btree remove: assign new_root only when removal succeeds

Ian Ray (1):
      USB: serial: cp210x: fix comments for GE CS1000

Ido Schimmel (1):
      rtnetlink: Fix regression in bridge VLAN configuration

Jack Xu (2):
      crypto: qat - check return code of qat_hal_rd_rel_reg()
      crypto: qat - remove unused macro in FW loader

James Smart (1):
      scsi: lpfc: Fix "Unexpected timeout" error in direct attach topology

Jan Beulich (3):
      x86/asm: Add instruction suffixes to bitops
      x86/entry/64: Add instruction suffix
      xen-pciback: redo VF placement in the virtual topology

Jay Fang (1):
      spi: spi-topcliff-pch: Fix potential double free in pch_spi_process_messages()

Jean Delvare (1):
      i2c: i801: Don't generate an interrupt on bus reset

Jeff Layton (1):
      ceph: remove bogus checks and WARN_ONs from ceph_set_page_dirty

Jeimon (1):
      net/nfc/rawsock.c: fix a permission check bug

Jesse Brandeburg (1):
      e100: handle eeprom as little endian

Jiajun Cao (1):
      ALSA: hda: Add IRQ check for platform_get_irq()

Jiapeng Chong (6):
      bnx2x: Fix missing error code in bnx2x_iov_init_one()
      ethernet: myri10ge: Fix missing error code in myri10ge_probe()
      rtnetlink: Fix missing error code in rtnl_bridge_notify()
      platform/x86: toshiba_acpi: Fix missing error code in toshiba_acpi_setup_keyboard()
      RDMA/cxgb4: Fix missing error code in create_qp()
      fs/jfs: Fix missing error code in lmLogInit()

Jisheng Zhang (1):
      net: stmmac: dwmac1000: Fix extended MAC address registers definition

Joe Thornber (1):
      dm space maps: don't reset space map allocation cursor when committing

Johan Hovold (8):
      net: hso: fix control-request directions
      USB: trancevibrator: fix control-request direction
      USB: serial: quatech2: fix control-request directions
      i2c: robotfuzz-osif: fix control-request directions
      Input: usbtouchscreen - fix control-request directions
      mmc: vub3000: fix control-request direction
      media: gspca/sq905: fix control-request direction
      media: gspca/sunplus: fix zero-length control requests

Johannes Berg (8):
      mac80211: drop A-MSDUs on old ciphers
      mac80211: add fragment cache to sta_info
      mac80211: check defrag PN against current frame
      mac80211: prevent attacks on TKIP/WEP as well
      mac80211: do not accept/forward invalid EAPOL frames
      bonding: init notify_work earlier to avoid uninitialized use
      netlink: disable IRQs for netlink_lock_table()
      mac80211: drop multicast fragments

John Keeping (1):
      USB: serial: cp210x: add ID for CEL EM3588 USB ZigBee stick

Jonathan Cameron (3):
      iio: accel: bma180: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: stk8312: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: stk8ba50: Fix buffer alignment in iio_push_to_buffers_with_timestamp()

Jonathan Neuschäfer (1):
      ARM: imx: pm-imx5: Fix references to imx5_cpu_suspend_info

Josef Bacik (2):
      btrfs: do not BUG_ON in link_to_fixup_dir
      btrfs: fixup error handling in fixup_inode_link_counts

Josh Triplett (1):
      net: ipconfig: Don't override command-line hostnames or domains

Juergen Gross (1):
      xen/events: reset active flag for lateeoi events later

Julian Anastasov (1):
      ipvs: ignore IP_VS_SVC_F_HASHED flag when adding service

Julian Sikorski (1):
      USB: usb-storage: Add LaCie Rugged USB3-FW to IGNORE_UAS

Junxiao Bi (1):
      ocfs2: fix data corruption by fallocate

Kai-Heng Feng (2):
      platform/x86: hp_accel: Avoid invoking _INI to speed up resume
      Bluetooth: Shutdown controller after workqueues are flushed or cancelled

Kees Cook (5):
      proc: Check /proc/$pid/attr/ writes against file opener
      proc: Track /proc/$pid/attr/ opener mm_struct
      r8152: Avoid memcpy() over-reading of ETH_SS_STATS
      sh_eth: Avoid memcpy() over-reading of ETH_SS_STATS
      r8169: Avoid memcpy() over-reading of ETH_SS_STATS

Krzysztof Kozlowski (5):
      i2c: s3c2410: fix possible NULL pointer deref on read message after write
      nfc: fix NULL ptr dereference in llcp_sock_getname() after failed connect
      ARM: dts: exynos: fix PWM LED max brightness on Odroid XU4
      memory: fsl_ifc: fix leak of IO mapping on probe failure
      memory: fsl_ifc: fix leak of private memory on probe failure

Krzysztof Wilczyński (2):
      ACPI: sysfs: Fix a buffer overrun problem with description_show()
      PCI/sysfs: Fix dsm_label_utf16s_to_utf8s() buffer overrun

Lai Jiangshan (1):
      KVM: X86: Disable hardware breakpoints unconditionally before kvm_x86->run()

Lee Gibson (1):
      wl1251: Fix possible buffer overflow in wl1251_cmd_scan

Leo Yan (1):
      perf session: Correct buffer copying when peeking events

Lin Ma (3):
      bluetooth: eliminate the potential race condition when removing the HCI controller
      Bluetooth: fix the erroneous flush_work() order
      Bluetooth: use correct lock to prevent UAF of hdev object

Linus Torvalds (1):
      proc: only require mm_struct for writing

Linus Walleij (3):
      power: supply: ab8500: Fix an old bug
      power: supply: ab8500: Avoid NULL pointers
      iio: accel: bma180: Use explicit member assignment

Linyu Yuan (3):
      usb: gadget: eem: fix wrong eem header operation
      net: cdc_eem: fix tx fixup skb leak
      usb: gadget: eem: fix echo command packet response issue

Liu Shixin (1):
      netlabel: Fix memory leak in netlbl_mgmt_add_common

Lucas Stankus (1):
      staging: iio: cdc: ad7746: avoid overwrite of num_channels

Ludovic Desroches (1):
      ARM: dts: at91: sama5d4: fix pinctrl muxing

Lukas Wunner (1):
      spi: spi-sh: Fix use-after-free on unbind

Lv Yunlong (3):
      media: v4l2-core: Avoid the dangling pointer in v4l2_fh_release
      ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe
      misc/libmasm/module: Fix two use after free in ibmasm_init_one

Maciej Żenczykowski (2):
      USB: f_ncm: ncm_bitrate (speed) is unsigned
      net: cdc_ncm: switch to eth%d interface naming

ManYi Li (1):
      scsi: sr: Return appropriate error code when disk is ejected

Marc Kleine-Budde (1):
      iio: ltr501: mark register holding upper 8 bits of ALS_DATA{0,1} and PS_DATA as volatile, too

Marcelo Henrique Cerri (1):
      proc: Avoid mixing integer types in mem_rw()

Marcelo Ricardo Leitner (1):
      sctp: add size validation when walking chunks

Marco De Marco (1):
      USB: serial: option: add support for u-blox LARA-R6 family

Marco Elver (1):
      perf: Fix data race between pin_count increment/decrement

Marek Szyprowski (1):
      extcon: max8997: Add missing modalias string

Marian-Cristian Rotariu (1):
      usb: dwc3: ep0: fix NULL pointer exception

Mario Limonciello (1):
      ACPI: processor idle: Fix up C-state latency if not ordered

Mark Bolhuis (1):
      HID: Add BUS_VIRTUAL to hid_connect logging

Mark Rutland (1):
      pid: take a reference when initializing `cad_pid`

Mark Tomlinson (2):
      netfilter: x_tables: Use correct memory barriers.
      usb: max-3421: Prevent corruption of freed memory

Martin Fäcknitz (1):
      MIPS: vdso: Invalid GIC access through VDSO

Masami Hiramatsu (1):
      arm: kprobes: Allow to handle reentered kprobe on single-stepping

Mathias Nyman (2):
      xhci: Fix lost USB 2 remote wake
      usb: hub: Disable USB 3 device initiated lpm if exit latency is too high

Mathy Vanhoef (4):
      mac80211: assure all fragments are encrypted
      mac80211: prevent mixed key and fragment cache attacks
      mac80211: properly handle A-MSDUs that start with an RFC 1042 header
      cfg80211: mitigate A-MSDU aggregation attacks

Matt Wang (2):
      scsi: BusLogic: Fix 64-bit system enumeration error for Buslogic
      scsi: vmw_pvscsi: Set correct residual data length

Matthias Maennich (1):
      kbuild: mkcompile_h: consider timestamp if KBUILD_BUILD_TIMESTAMP is set

Maurizio Lombardi (1):
      scsi: target: core: Fix warning on realtime kernels

Mauro Carvalho Chehab (1):
      media: dvb_net: avoid speculation from net slot

Max Gurtovoy (1):
      vfio/platform: fix module_put call in error flow

Maxim Mikityanskiy (1):
      netfilter: synproxy: Fix out of bounds when parsing TCP options

Michael Buesch (1):
      ssb: sdio: Don't overwrite const buffer if block_write fails

Michael Weiser (1):
      arm64: Remove unimplemented syscall log message

Mike Christie (2):
      scsi: iscsi: Add iscsi_cls_conn refcount helpers
      scsi: iscsi: Fix iface sysfs attr detection

Mike Kravetz (1):
      hugetlbfs: hugetlb_fault_mutex_hash() cleanup

Miklos Szeredi (2):
      fuse: check connected before queueing on fpq->io
      fuse: reject internal errno

Mikulas Patocka (1):
      dm snapshot: properly fix a crash when an origin has no snapshots

Minchan Kim (1):
      selinux: use __GFP_NOWARN with GFP_NOWAIT in the AVC

Ming Lei (2):
      scsi: core: Only put parent device if host state differs from SHOST_CREATED
      scsi: core: Put .shost_dev in failure path if host state changes to RUNNING

Mirko Vogt (1):
      spi: spi-sun6i: Fix chipselect/clock bug

Muchun Song (1):
      writeback: fix obtain a reference to a freeing memcg css

Nanyong Sun (1):
      net: ipv4: fix memory leak in netlbl_cipsov4_add_std

Nathan Chancellor (3):
      Makefile: Move -Wno-unused-but-set-variable out of GCC only block
      powerpc/barrier: Avoid collision with clang's __lwsync macro
      hexagon: use common DISCARDS macro

Nguyen Dinh Phi (1):
      netrom: Decrease sock refcount when sock timers expire

Nicholas Piggin (1):
      KVM: PPC: Book3S: Fix H_RTAS rets buffer overflow

Nick Desaulniers (1):
      ARM: 9087/1: kprobes: test-thumb: fix for LLVM_IAS=1

Norbert Slusarek (1):
      can: bcm: fix infoleak in struct bcm_msg_head

Nuno Sa (1):
      iio: adis_buffer: do not return ints in irq handlers

Odin Ugedal (1):
      sched/fair: Fix CFS bandwidth hrtimer expiry type

Oliver Hartkopp (1):
      can: gw: synchronize rcu operations before removing gw job entry

Oliver Lang (2):
      iio: ltr501: ltr559: fix initialization of LTR501_ALS_CONTR
      iio: ltr501: ltr501_read_ps(): add missing endianness conversion

Ondrej Zary (1):
      serial_cs: Add Option International GSM-Ready 56K/ISDN modem

Pablo Neira Ayuso (2):
      netfilter: nfnetlink_cthelper: hit EBUSY on updates if size mismatches
      netfilter: nft_exthdr: check for IPv6 packet before further processing

Pali Rohár (1):
      ath9k: Fix kernel NULL pointer dereference during ath_reset_internal()

Pan Dong (1):
      ext4: fix avefreec in find_group_orlov

Paolo Bonzini (2):
      kvm: avoid speculation-based attacks from out-of-range memslot accesses
      kvm: fix previous commit for 32-bit builds

Pavel Skripkin (21):
      net: usb: fix memory leak in smsc75xx_bind
      net: caif: added cfserl_release function
      net: caif: add proper error handling
      net: caif: fix memory leak in caif_device_notify
      net: caif: fix memory leak in cfusbl_device_notify
      net: rds: fix memory leak in rds_recvmsg
      net: hamradio: fix memory leak in mkiss_close
      net: ethernet: fix potential use-after-free in ec_bhf_remove
      net: caif: fix memory leak in ldisc_open
      nilfs2: fix memory leak in nilfs_sysfs_delete_device_group
      media: dvb-usb: fix wrong definition
      net: can: ems_usb: fix use-after-free in ems_usb_disconnect()
      media: cpia2: fix memory leak in cpia2_usb_probe
      net: ethernet: aeroflex: fix UAF in greth_of_remove
      net: ethernet: ezchip: fix UAF in nps_enet_remove
      net: ethernet: ezchip: fix error handling
      reiserfs: add check for invalid 1st journal block
      media: zr364xx: fix memory leak in zr364xx_start_readpipe
      jfs: fix GPF in diFree
      net: moxa: fix UAF in moxart_mac_probe
      net: ti: fix UAF in tlan_remove_one

Peter Zijlstra (1):
      openrisc: Define memory barrier mb

Petr Pavlu (1):
      ipmi/watchdog: Stop watchdog timer when the current action is 'none'

Phillip Potter (1):
      isdn: mISDNinfineon: check/cleanup ioremap failure correctly in setup_io

Primoz Fiser (1):
      ARM: dts: imx6: phyFLEX: Fix UART hardware flow control

Quat Le (1):
      scsi: core: Retry I/O for Notify (Enable Spinup) Required error

Rafael J. Wysocki (1):
      Revert "PCI: PM: Do not read power state in pci_enable_device_flags()"

Rafał Miłecki (2):
      ARM: brcmstb: dts: fix NAND nodes names
      ARM: dts: BCM63xx: Fix NAND nodes names

Randy Dunlap (7):
      MIPS: alchemy: xxs1500: add gpio-au1000.h header file
      MIPS: ralink: export rt_sysc_membase for rt2880_wdt.c
      media: I2C: change 'RST' to "RSET" to fix multiple build errors
      wireless: carl9170: fix LEDS build errors & warnings
      scsi: FlashPoint: Rename si_flags field
      s390: appldata depends on PROC_SYSCTL
      mips: disable branch profiling in boot/decompress.o

Rasmus Villemoes (1):
      efi: cper: fix snprintf() use in cper_dimm_err_location()

Riccardo Mancini (2):
      perf test bpf: Free obj_buf
      perf probe-file: Delete namelist in del_events() on the error path

Richard Fitzgerald (1):
      random32: Fix implicit truncation warning in prandom_seed_state()

Ritesh Harjani (1):
      btrfs: return value from btrfs_mark_extent_written() in case of error

Ruslan Bilovol (1):
      usb: gadget: f_hid: fix endianness issue with descriptors

Sasha Levin (1):
      Linux 4.4.274

Saubhik Mukherjee (1):
      net: appletalk: cops: Fix data race in cops_probe1

Sean Christopherson (2):
      KVM: SVM: Truncate GPR value for DR and CR accesses in !64-bit mode
      KVM: x86: Use guest MAXPHYADDR from CPUID.0x8000_0008 iff TDP is enabled

Sebastian Andrzej Siewior (1):
      net: Treat __napi_schedule_irqoff() as __napi_schedule() on PREEMPT_RT

Sergey Shtylyov (4):
      sata_highbank: fix deferred probing
      pata_rb532_cf: fix deferred probing
      pata_octeon_cf: avoid WARN_ON() in ata_host_activate()
      pata_ep93xx: fix deferred probing

Shanker Donthineni (1):
      PCI: Mark some NVIDIA GPUs to avoid bus reset

Sherry Sun (1):
      tty: serial: fsl_lpuart: fix the potential risk of division or modulo by zero

Srinivas Neeli (1):
      gpio: zynq: Check return value of pm_runtime_get_sync

Srinivas Pandruvada (1):
      HID: hid-sensor-hub: Return error for hid_set_field() failure

Steffen Klassert (1):
      xfrm: Fix error reporting in xfrm_state_construct.

Stephan Gerhold (2):
      extcon: sm5502: Drop invalid register write in sm5502_reg_data
      iio: accel: bma180: Fix BMA25x bandwidth register values

Stephen Brennan (1):
      mm, vmstat: drop zone->lock in /proc/pagetypeinfo

Steven Rostedt (VMware) (4):
      ftrace: Do not blindly read the ip address in ftrace_bug()
      tracing: Do no increment trace_clock_global() by one
      tracing: Do not stop recording cmdlines when tracing is off
      tracing: Do not stop recording comms if the trace file is being read

Taehee Yoo (3):
      mld: fix panic in mld_newpack()
      sch_dsmark: fix a NULL deref in qdisc_reset()
      net: validate lwtstate->data before returning from skb_tunnel_info()

Takashi Iwai (3):
      ALSA: timer: Fix master timer notification
      ALSA: sb: Fix potential double-free of CSP mixer elements
      ALSA: sb: Fix potential ABBA deadlock in CSP driver

Takashi Sakamoto (2):
      Revert "ALSA: bebob/oxfw: fix Kconfig entry for Mackie d.2 Pro"
      ALSA: bebob: add support for ToneWeal FW66

Tetsuo Handa (1):
      can: bcm/raw/isotp: use per module netdevice notifier

Thadeu Lima de Souza Cascardo (2):
      Bluetooth: cmtp: fix file refcount when cmtp_attach_device fails
      can: bcm: delay release of struct bcm_op after synchronize_rcu()

Thomas Gleixner (2):
      x86/fpu: Reset state for all signal restore failures
      x86/fpu: Make init_fpstate correct with optimized XSAVE

Tian Tao (1):
      spi: omap-100k: Fix the length judgment problem

Tiezhu Yang (1):
      MIPS: Fix kernel hang under FUNCTION_GRAPH_TRACER and PREEMPT_TRACER

Tim Jiang (1):
      Bluetooth: btusb: fix bt fiwmare downloading failure issue for qca btsoc.

Timo Sigurdsson (1):
      ata: ahci_sunxi: Disable DIPM

Tom Seewald (1):
      char: hpet: add checks after calling ioremap

Tony Lindgren (1):
      wlcore/wl12xx: Fix wl12xx get_mac error if device is in ELP

Trond Myklebust (1):
      NFS: Don't corrupt the value of pg_bytes_written in nfs_do_recoalesce()

Uwe Kleine-König (2):
      backlight: lm3630a: Fix return code of .update_status() callback
      pwm: spear: Don't modify HW state in .remove callback

Vadim Fedorenko (1):
      net: ipv6: fix return value of ip6_skb_dst_mtu

Vasily Gorbik (1):
      s390/ftrace: fix ftrace_update_ftrace_func implementation

Vincent Palatin (1):
      Revert "USB: quirks: ignore remote wake-up on Fibocom L850-GL LTE modem"

Vineeth Vijayan (1):
      s390/cio: dont call css_wait_for_slow_path() inside a lock

Vladyslav Tarasiuk (1):
      net/mlx4: Fix EEPROM dump support

Wei Yongjun (1):
      ieee802154: fix error return code in ieee802154_llsec_getparams()

Wen Gong (1):
      mac80211: extend protection against mixed key and fragment cache attacks

William A. Kennington III (1):
      spi: Fix use-after-free with devm_spi_alloc_*

Willy Tarreau (1):
      ipv6: use prandom_u32() for ID generation

Xie Yongji (3):
      drm/virtio: Fix double free on probe failure
      virtio-blk: Fix memory leak among suspend/resume procedure
      virtio_console: Assure used length from device is limited

Xin Long (1):
      tipc: skb_linearize the head skb when reassembling msgs

Yajun Deng (1):
      net: decnet: Fix sleeping inside in af_decnet

Yang Li (1):
      ath10k: Fix an error code in ath10k_add_interface()

Yang Yingliang (5):
      dmaengine: stedma40: add missing iounmap() on error in d40_probe()
      net: micrel: check return value after calling platform_get_resource()
      ALSA: ppc: fix error return code in snd_pmac_probe()
      usb: gadget: hid: fix error return code in hid_bind()
      thermal/core: Correct function name thermal_zone_device_unregister()

Ye Bin (1):
      ext4: fix bug on in ext4_es_cache_extent as ext4_split_extent_at failed

Yongqiang Liu (1):
      ARM: OMAP2+: Fix build warning when mmc_omap is not built

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: Fix superfluous irqs happen after usb_pkt_pop()

Yu Kuai (1):
      char: pcmcia: error out if 'num_bytes_read' is greater than 4 in set_protocol()

Yu Liu (1):
      Bluetooth: Fix the HCI to MGMT status conversion table

YueHaibing (1):
      iio: adc: ad7793: Add missing error code in ad7793_setup()

Yun Zhou (2):
      seq_buf: Make trace_seq_putmem_hex() support data longer than 8
      seq_buf: Fix overflow in seq_buf_putmem_hex()

Zhang Xiaoxu (3):
      NFSv4: Fix v4.0/v4.1 SEEK_DATA return -ENOTSUPP when set NFS_V4_2 config
      SUNRPC: Fix the batch tasks count wraparound.
      SUNRPC: Should wake up the privileged task firstly.

Zhang Yi (2):
      ext4: correct the cache_nr in tracepoint ext4_es_shrink_exit
      ext4: remove check for zero nr_to_scan in ext4_es_scan()

Zhen Lei (14):
      net: bnx2: Fix error return code in bnx2_init_board()
      vfio/pci: Fix error return code in vfio_ecap_init()
      HID: pidff: fix error return code in hid_pidff_init()
      ieee802154: fix error return code in ieee802154_add_iface()
      crypto: ux500 - Fix error return code in hash_hw_final()
      media: tc358743: Fix error return code in tc358743_probe_of()
      mmc: usdhi6rol0: fix error return code in usdhi6_probe()
      ehea: fix error return code in ehea_restart_qps()
      Input: hil_kbd - fix error return code in hil_dev_connect()
      scsi: mpt3sas: Fix error return value in _scsih_expander_add()
      ASoC: soc-core: Fix the error return code in snd_soc_of_parse_audio_routing()
      um: fix error return code in slip_open()
      um: fix error return code in winch_tramp()
      ALSA: isa: Fix error return code in snd_cmi8330_probe()

Zheng Yongjun (4):
      net/x25: Return the correct errno code
      net: Return the correct errno code
      fib: Return the correct errno code
      ping: Check return value of function 'ping_queue_rcv_skb'

Zheyu Ma (7):
      serial: rp2: use 'request_firmware' instead of 'request_firmware_nowait'
      isdn: mISDN: netjet: Fix crash in nj_probe:
      net/qla3xxx: fix schedule while atomic in ql_sem_spinlock
      media: bt8xx: Fix a missing check bug in bt878_probe
      mmc: via-sdmmc: add a check against NULL pointer dereference
      atm: nicstar: use 'dma_free_coherent' instead of 'kfree'
      atm: nicstar: register the interrupt handler in the right place

Ziyang Xuan (1):
      net: fix uninit-value in caif_seqpkt_sendmsg

Zolton Jheng (1):
      USB: serial: pl2303: add device id for ADLINK ND-6530 GC

Zong Li (1):
      net: macb: ensure the device is available before accessing GEMGXL control registers

Zou Wei (11):
      ASoC: sti-sas: add missing MODULE_DEVICE_TABLE
      atm: iphase: fix possible use-after-free in ia_module_exit()
      mISDN: fix possible use-after-free in HFC_cleanup()
      atm: nicstar: Fix possible use-after-free in nicstar_cleanup()
      cw1200: add missing MODULE_DEVICE_TABLE
      mfd: da9052/stmpe: Add and modify MODULE_DEVICE_TABLE
      watchdog: Fix possible use-after-free in wdt_startup()
      watchdog: sc520_wdt: Fix possible use-after-free in wdt_turnoff()
      watchdog: Fix possible use-after-free by calling del_timer_sync()
      power: supply: charger-manager: add missing MODULE_DEVICE_TABLE
      power: supply: ab8500: add missing MODULE_DEVICE_TABLE

xinhui pan (1):
      drm/amdgpu: Fix a use-after-free

zhangyi (F) (1):
      block_dump: remove block_dump feature in mark_inode_dirty()

Íñigo Huguet (2):
      sfc: avoid double pci_remove of VFs
      sfc: error code if SRIOV cannot be disabled
