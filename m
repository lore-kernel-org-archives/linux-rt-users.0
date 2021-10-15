Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A42AC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 15:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E22F60F23
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 15:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhJOP7M (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 11:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhJOP7L (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Oct 2021 11:59:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90E0060E54;
        Fri, 15 Oct 2021 15:57:04 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.211-rt91
Date:   Fri, 15 Oct 2021 15:55:57 -0000
Message-ID: <163431335714.225589.2579717971596146895@puck.lan>
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

I'm pleased to announce the 4.19.211-rt91 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 3fe7f64cc252c2f300cd599554f909deb00e854a

Or to build 4.19.211-rt91 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.211.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.211-rt91.patch.xz


You can also build from 4.19.210-rt90 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.210-rt90-rt91.patch.xz

Enjoy!
Clark

Changes from v4.19.210-rt90:
---

Andy Shevchenko (1):
      ptp_pch: Load module automatically if ID matches

Ben Hutchings (1):
      Partially revert "usb: Kconfig: using select for USB_COMMON dependency"

Clark Williams (2):
      Merge tag 'v4.19.211' into v4.19-rt
      Linux 4.19.211-rt91

David Heidelberg (1):
      ARM: dts: qcom: apq8064: use compatible which contains chipid

Eric Dumazet (4):
      net_sched: fix NULL deref in fifo_set_limit()
      net: bridge: use nla_total_size_64bit() in br_get_linkxstats_size()
      netlink: annotate data races around nlk->bound
      rtnetlink: fix if_nlmsg_stats_size() under estimation

Greg Kroah-Hartman (1):
      Linux 4.19.211

Jamie Iles (1):
      i2c: acpi: fix resource leak in reconfiguration device addition

Jan Beulich (1):
      xen/privcmd: fix error handling in mmap-resource processing

Jiri Benc (1):
      i40e: fix endless loop under rtnl

Johan Almbladh (1):
      bpf, arm: Fix register clobbering in div/mod implementation

Johan Hovold (2):
      USB: cdc-acm: fix racy tty buffer accesses
      USB: cdc-acm: fix break reporting

Juergen Gross (1):
      xen/balloon: fix cancelled balloon action

Lukas Bulwahn (1):
      x86/Kconfig: Correct reference to MWINCHIP3D

Max Filippov (1):
      xtensa: call irqchip_init only when CONFIG_USE_OF is selected

Oleksij Rempel (1):
      ARM: imx6: disable the GIC CPU interface before calling stby-poweroff sequence

Pali Rohár (1):
      powerpc/fsl/dts: Fix phy-connection-type for fm1mac3

Pavel Skripkin (1):
      phy: mdio: fix memory leak

Piotr Krysiuk (1):
      bpf, mips: Validate conditional branch offsets

Roger Quadros (1):
      ARM: dts: omap3430-sdp: Fix NAND device node

Sean Anderson (1):
      net: sfp: Fix typo in state machine debug string

Sylwester Dziedziuch (1):
      i40e: Fix freeing of uninitialized misc IRQ vector

Tatsuhiko Yasumatsu (1):
      bpf: Fix integer overflow in prealloc_elems_and_freelist()

Trond Myklebust (1):
      nfsd4: Handle the NFSv4 READDIR 'dircount' hint being zero

Yang Yingliang (1):
      drm/nouveau/debugfs: fix file release memory leak

Zheng Liang (1):
      ovl: fix missing negative dentry check in ovl_rename()
---
Makefile                                    |  2 +-
 arch/arm/boot/dts/omap3430-sdp.dts          |  2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi         |  3 +-
 arch/arm/mach-imx/pm-imx6.c                 |  2 +
 arch/arm/net/bpf_jit_32.c                   | 19 ++++++++++
 arch/mips/net/bpf_jit.c                     | 57 ++++++++++++++++++++++-------
 arch/powerpc/boot/dts/fsl/t1023rdb.dts      |  2 +-
 arch/x86/Kconfig                            |  2 +-
 arch/xtensa/kernel/irq.c                    |  2 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c   |  1 +
 drivers/i2c/i2c-core-acpi.c                 |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c |  5 ++-
 drivers/net/phy/mdio_bus.c                  |  7 ++++
 drivers/net/phy/sfp.c                       |  2 +-
 drivers/ptp/ptp_pch.c                       |  1 +
 drivers/usb/Kconfig                         |  3 +-
 drivers/usb/class/cdc-acm.c                 |  8 ++++
 drivers/xen/balloon.c                       | 21 ++++++++---
 drivers/xen/privcmd.c                       |  7 ++--
 fs/nfsd/nfs4xdr.c                           | 19 ++++++----
 fs/overlayfs/dir.c                          | 10 +++--
 kernel/bpf/stackmap.c                       |  3 +-
 localversion-rt                             |  2 +-
 net/bridge/br_netlink.c                     |  2 +-
 net/core/rtnetlink.c                        |  2 +-
 net/netlink/af_netlink.c                    | 14 +++++--
 net/sched/sch_fifo.c                        |  3 ++
 27 files changed, 148 insertions(+), 54 deletions(-)
---
