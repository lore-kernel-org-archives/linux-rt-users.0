Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABFEC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 07:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1AD60EBB
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 07:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhJRHep (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 03:34:45 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:49460 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhJRHep (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Oct 2021 03:34:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 048FF5E41F;
        Mon, 18 Oct 2021 09:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1634542353; h=from:subject:date:message-id:to;
        bh=htHBl7LTVtrun8Qh6LDU13m6PCVLoGfxzMI00HofErY=;
        b=KTS3ANkapDNjHuz7EeOzQf1Y9rclX9RhcGHuupJfg7mdMLCphyofjwL3wb6XRKmfz4BlkI
        RZEy47/1XGyGpt82dpqJNuOEeR47/G04JP6k5RBZiihMZG9DDyjlS0k4nUwpSxqY1sucyt
        748FlMDbNPBXhhkrv2Q8PbhUB5crqZhuUWi3XIEgmM7/XcpgA5o/ugFlSmHV518LP8jJkM
        863aFSmCJ6NlQ4l/VvPmTorhldh+nA+LOUc7lR80jn/9Er6rttZpdEz31Re8p24hTQUyZp
        3pgm+ifnKGGBlSmkQlHvyFsAQy549Iijj5hUjbZkpCnWlktm/L5VKcig0UYICw==
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.289-rt227
Date:   Mon, 18 Oct 2021 07:29:23 -0000
Message-ID: <163454216364.8829.1868721617239541377@beryllium.lan>
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

I'm pleased to announce the 4.4.289-rt227 stable release.
This is just an update the latest stable release. No RT
specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: e3a040806a55a1d307693e64f1f9e5fcb0221570

I've still not resolved the upload issue. I've post my new gpg key but
havent' heard anything yet. Will write to the helpdesk see if this
helps.

Enjoy!
Daniel

Changes from v4.4.285-rt226:
---

Anand K Mistry (1):
      perf/x86: Reset destroy callback on event init failure

Andrea Claudi (1):
      ipvs: check that ip_vs_conn_tab_bits is between 8 and 20

Andy Shevchenko (1):
      ptp_pch: Load module automatically if ID matches

Anirudh Rayabharam (1):
      HID: usbhid: free raw_report buffers in usbhid_stop

Aya Levin (1):
      net/mlx4_en: Don't allow aRFS for encapsulated packets

Baokun Li (1):
      scsi: iscsi: Adjust iface sysfs attr detection

Carlo Lobrano (1):
      USB: serial: option: add Telit LN920 compositions

Colin Ian King (1):
      scsi: virtio_scsi: Fix spelling mistake "Unsupport" -> "Unsupported"

Dan Carpenter (3):
      usb: gadget: r8a66597: fix a loop in set_feature()
      usb: musb: tusb6010: uninitialized data in tusb_fifo_write_unaligned()
      ext2: fix sleeping in atomic bugs on error

Dan Li (1):
      arm64: Mark __stack_chk_guard as __ro_after_init

Daniel Wagner (2):
      Merge tag 'v4.4.289' into v4.4-rt
      Linux 4.4.289-rt227

Eric Dumazet (3):
      af_unix: fix races in sk_peer_pid and sk_peer_cred accesses
      net_sched: fix NULL deref in fifo_set_limit()
      netlink: annotate data races around nlk->bound

F.A.Sulaiman (1):
      HID: betop: fix slab-out-of-bounds Write in betop_probe

Faizel K B (1):
      usb: testusb: Fix for showing the connection speed

Greg Kroah-Hartman (5):
      Linux 4.4.286
      Revert "arm64: Mark __stack_chk_guard as __ro_after_init"
      Linux 4.4.287
      Linux 4.4.288
      Linux 4.4.289

Guenter Roeck (5):
      m68k: Double cast io functions to unsigned long
      compiler.h: Introduce absolute_pointer macro
      net: i825xx: Use absolute_pointer for memcpy from fixed memory location
      alpha: Declare virt_to_phys and virt_to_bus parameter as pointer to volatile
      net: 6pack: Fix tx timeout and slot time

Helge Deller (1):
      parisc: Use absolute_pointer() to define PAGE0

Igor Matheus Andrade Torrente (1):
      tty: Fix out-of-bound vmalloc access in imageblit

Jacob Keller (2):
      e100: fix length calculation in e100_get_regs_len
      e100: fix buffer overrun in e100_get_regs

Jan Beulich (2):
      xen/x86: fix PV trap handling on secondary processors
      xen-netback: correct success/error reporting for the SKB-with-fraglist case

Jeremy Sowden (1):
      netfilter: ip6_tables: zero-initialize fragment offset

Jiapeng Chong (1):
      scsi: ses: Fix unsigned comparison with less than zero

Jiri Benc (1):
      i40e: fix endless loop under rtnl

Johan Hovold (8):
      net: hso: fix muxed tty registration
      ipack: ipoctal: fix stack information leak
      ipack: ipoctal: fix tty registration race
      ipack: ipoctal: fix tty-registration error handling
      ipack: ipoctal: fix missing allocation-failure check
      ipack: ipoctal: fix module reference leak
      USB: cdc-acm: fix racy tty buffer accesses
      USB: cdc-acm: fix break reporting

Johannes Berg (1):
      mac80211: fix use-after-free in CCMP/GCMP RX

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix oversized kvmalloc() calls

Kate Hsuan (1):
      libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860 and 870 SSD.

Krzysztof Kozlowski (2):
      USB: serial: mos7840: remove duplicated 0xac24 device ID
      USB: serial: option: remove duplicate USB device ID

Linus Torvalds (6):
      sparc: avoid stringop-overread errors
      qnx4: avoid stringop-overread errors
      spi: Fix tegra20 build with CONFIG_PM=n
      qnx4: work around gcc false positive warning bug
      sparc64: fix pci_iounmap() when CONFIG_PCI is not set
      gup: document and work around "COW can break either way" issue

Lorenzo Stoakes (1):
      mm: check VMA flags to avoid invalid PROT_NONE NUMA balancing

Max Filippov (1):
      xtensa: call irqchip_init only when CONFIG_USE_OF is selected

Ming Lei (1):
      scsi: sd: Free scsi_disk device via put_device()

Mizuho Mori (1):
      HID: apple: Fix logical maximum and usage maximum of Magic Keyboard JIS

NeilBrown (1):
      cred: allow get_cred() and put_cred() to be given NULL.

Oleksij Rempel (1):
      ARM: imx6: disable the GIC CPU interface before calling stby-poweroff sequence

Pavel Skripkin (1):
      phy: mdio: fix memory leak

Sai Krishna Potthuri (1):
      EDAC/synopsys: Fix wrong value type assignment for edac_mode

Slark Xiao (1):
      USB: serial: option: add device id for Foxconn T99W265

Steve French (1):
      cifs: fix incorrect check for null pointer in header_assemble

Suzuki K Poulose (1):
      arm64: Extend workaround for erratum 1024718 to all versions of Cortex-A55

Trond Myklebust (1):
      nfsd4: Handle the NFSv4 READDIR 'dircount' hint being zero

Uwe Brandt (1):
      USB: serial: cp210x: add ID for GW Instek GDM-834x Digital Multimeter

YueHaibing (1):
      mac80211: Drop frames from invalid MAC address in ad-hoc mode

Zhihao Cheng (1):
      blktrace: Fix uaf in blk_trace access after removing by sysfs

yangerkun (1):
      ext4: fix potential infinite loop in ext4_dx_readdir()
---
Makefile                                       |  2 +-
 arch/alpha/include/asm/io.h                    |  6 +--
 arch/arm/mach-imx/pm-imx6.c                    |  2 +
 arch/arm64/Kconfig                             |  2 +-
 arch/arm64/mm/proc.S                           |  4 +-
 arch/m68k/include/asm/raw_io.h                 | 20 ++++----
 arch/parisc/include/asm/page.h                 |  2 +-
 arch/sparc/kernel/mdesc.c                      |  3 +-
 arch/sparc/lib/iomap.c                         |  2 +
 arch/x86/kernel/cpu/perf_event.c               |  1 +
 arch/x86/xen/enlighten.c                       | 15 +++---
 arch/xtensa/kernel/irq.c                       |  2 +-
 drivers/ata/libata-core.c                      | 34 ++++++++++++-
 drivers/edac/synopsys_edac.c                   |  2 +-
 drivers/hid/hid-apple.c                        |  7 +++
 drivers/hid/hid-betopff.c                      | 13 +++--
 drivers/hid/usbhid/hid-core.c                  | 13 ++++-
 drivers/ipack/devices/ipoctal.c                | 63 +++++++++++++++++------
 drivers/net/ethernet/i825xx/82596.c            |  2 +-
 drivers/net/ethernet/intel/e100.c              | 22 +++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c |  3 ++
 drivers/net/hamradio/6pack.c                   |  4 +-
 drivers/net/phy/mdio_bus.c                     |  7 +++
 drivers/net/usb/hso.c                          | 12 ++---
 drivers/net/xen-netback/netback.c              |  2 +-
 drivers/ptp/ptp_pch.c                          |  1 +
 drivers/scsi/scsi_transport_iscsi.c            |  8 +--
 drivers/scsi/sd.c                              |  9 ++--
 drivers/scsi/ses.c                             |  2 +-
 drivers/scsi/virtio_scsi.c                     |  4 +-
 drivers/spi/spi-tegra20-slink.c                |  4 +-
 drivers/tty/vt/vt.c                            | 21 +++++++-
 drivers/usb/class/cdc-acm.c                    |  8 +++
 drivers/usb/gadget/udc/r8a66597-udc.c          |  2 +-
 drivers/usb/musb/tusb6010.c                    |  1 +
 drivers/usb/serial/cp210x.c                    |  1 +
 drivers/usb/serial/mos7840.c                   |  2 -
 drivers/usb/serial/option.c                    | 11 +++-
 fs/cifs/connect.c                              |  5 +-
 fs/ext2/balloc.c                               | 14 +++---
 fs/ext4/dir.c                                  |  6 +--
 fs/nfsd/nfs4xdr.c                              | 19 ++++---
 fs/qnx4/dir.c                                  | 69 +++++++++++++++++++-------
 include/linux/compiler.h                       |  2 +
 include/linux/cred.h                           | 14 ++++--
 include/linux/libata.h                         |  1 +
 include/net/sock.h                             |  2 +
 kernel/trace/blktrace.c                        |  8 +++
 localversion-rt                                |  2 +-
 mm/gup.c                                       | 48 +++++++++++++++---
 mm/huge_memory.c                               | 10 ++--
 mm/memory.c                                    | 12 +++--
 net/core/sock.c                                | 12 +++--
 net/ipv6/netfilter/ip6_tables.c                |  1 +
 net/mac80211/rx.c                              |  3 +-
 net/mac80211/wpa.c                             |  6 +++
 net/netfilter/ipset/ip_set_hash_gen.h          |  4 +-
 net/netfilter/ipvs/ip_vs_conn.c                |  4 ++
 net/netlink/af_netlink.c                       | 14 ++++--
 net/sched/sch_fifo.c                           |  3 ++
 net/unix/af_unix.c                             | 34 ++++++++++---
 tools/usb/testusb.c                            | 14 +++---
 63 files changed, 455 insertions(+), 173 deletions(-)
