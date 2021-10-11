Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B085EC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 04:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C8360E90
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 04:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhJKEHx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 00:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhJKEHx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Oct 2021 00:07:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8467D60F38;
        Mon, 11 Oct 2021 04:05:53 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.210-rt90
Date:   Mon, 11 Oct 2021 04:05:12 -0000
Message-ID: <163392511218.1212024.13127164965978538956@puck.lan>
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

I'm pleased to announce the 4.19.210-rt90 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: b5ac0451f5314ea7ee015c33065ba962e633cc68

Or to build 4.19.210-rt90 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.210.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.210-rt90.patch.xz


You can also build from 4.19.209-rt89 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.209-rt89-rt90.patch.xz

Enjoy!
Clark

Changes from v4.19.209-rt89:
---

Changbin Du (1):
      tools/vm/page-types: remove dependency on opt_file for idle page tracking

Clark Williams (2):
      Merge tag 'v4.19.210' into v4.19-rt
      Linux 4.19.210-rt90

Dan Carpenter (1):
      ext2: fix sleeping in atomic bugs on error

Davidlohr Bueso (1):
      lib/timerqueue: Rely on rbtree semantics for next timer

Faizel K B (1):
      usb: testusb: Fix for showing the connection speed

Greg Kroah-Hartman (1):
      Linux 4.19.210

Jan Beulich (1):
      xen-netback: correct success/error reporting for the SKB-with-fraglist case

Kate Hsuan (1):
      libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860 and 870 SSD.

Li Zhijian (1):
      selftests: be sure to make khdr before other targets

Linus Torvalds (1):
      sparc64: fix pci_iounmap() when CONFIG_PCI is not set

Ming Lei (1):
      scsi: sd: Free scsi_disk device via put_device()

Vladimir Oltean (1):
      net: mdio: introduce a shutdown method to mdio device drivers

Wen Xiong (1):
      scsi: ses: Retry failed Send/Receive Diagnostic commands

Yang Yingliang (1):
      usb: dwc2: check return value after calling platform_get_resource()
---
Makefile                          |  2 +-
 arch/sparc/lib/iomap.c            |  2 ++
 drivers/ata/libata-core.c         | 34 ++++++++++++++++++++++++++++++++--
 drivers/net/phy/mdio_device.c     | 11 +++++++++++
 drivers/net/xen-netback/netback.c |  2 +-
 drivers/scsi/sd.c                 |  9 +++++----
 drivers/scsi/ses.c                | 22 ++++++++++++++++++----
 drivers/usb/dwc2/hcd.c            |  4 ++++
 fs/ext2/balloc.c                  | 14 ++++++--------
 include/linux/libata.h            |  1 +
 include/linux/mdio.h              |  3 +++
 include/linux/timerqueue.h        | 13 ++++++-------
 lib/timerqueue.c                  | 30 ++++++++++++------------------
 localversion-rt                   |  2 +-
 tools/testing/selftests/lib.mk    |  1 +
 tools/usb/testusb.c               | 14 ++++++++------
 tools/vm/page-types.c             |  2 +-
 17 files changed, 113 insertions(+), 53 deletions(-)
---
