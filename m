Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765F8C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 18:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCE960E93
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 18:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhKLSv1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 13:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhKLSv0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Nov 2021 13:51:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B10860F5B;
        Fri, 12 Nov 2021 18:48:35 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.217-rt95
Date:   Fri, 12 Nov 2021 18:47:50 -0000
Message-ID: <163674287029.182903.16497578928079021732@puck.lan>
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

I'm pleased to announce the 4.19.217-rt95 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: f2d85c190cae0c1aa34ad354eaa2b9a29b827ed7

Or to build 4.19.217-rt95 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.217.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.217-rt95.patch.xz


You can also build from 4.19.215-rt94 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.215-rt94-rt95.patch.xz

Enjoy!
Clark

Changes from v4.19.215-rt94:
---

Arnd Bergmann (1):
      arch: pgtable: define MAX_POSSIBLE_PHYSMEM_BITS where needed

Clark Williams (3):
      Merge tag 'v4.19.216' into v4.19-rt
      Merge tag 'v4.19.217' into v4.19-rt
      Linux 4.19.217-rt95

Dan Carpenter (1):
      media: firewire: firedtv-avc: fix a buffer overflow in avc_ca_pmt()

Erik Ekman (1):
      sfc: Fix reading non-legacy supported link modes

Geert Uytterhoeven (1):
      usb: gadget: Mark USB_FSL_QE broken on 64-bit

Greg Kroah-Hartman (2):
      Linux 4.19.216
      Linux 4.19.217

Gustavo A. R. Silva (1):
      IB/qib: Use struct_size() helper

James Buren (1):
      usb-storage: Add compatibility quirk flags for iODD 2531/2541

Jan Kara (1):
      isofs: Fix out of bound access for corrupted isofs image

Johan Hovold (8):
      comedi: dt9812: fix DMA buffers on stack
      comedi: ni_usb6501: fix NULL-deref in command paths
      comedi: vmk80xx: fix transfer-buffer overflows
      comedi: vmk80xx: fix bulk-buffer overflow
      comedi: vmk80xx: fix bulk and interrupt message timeouts
      staging: r8712u: fix control-message timeout
      staging: rtl8192u: fix control-message timeouts
      rsi: fix control-message timeout

Juergen Gross (1):
      Revert "x86/kvm: fix vcpu-id indexed array sizes"

Mike Marciniszyn (1):
      IB/qib: Protect from buffer overflow in struct qib_user_sdma_pkt fields

Ming Lei (1):
      scsi: core: Put LLD module refcnt after SCSI device is released

Neal Liu (1):
      usb: ehci: handshake CMD_RUN instead of STS_HALT

Petr Mladek (1):
      printk/console: Allow to disable console output by using console="" or console=null

Viraj Shah (1):
      usb: musb: Balance list entry in musb_gadget_queue

Wang Kefeng (1):
      ARM: 9120/1: Revert "amba: make use of -1 IRQs warn"
---
Makefile                                    |   2 +-
 arch/arc/include/asm/pgtable.h              |   2 +
 arch/arm/include/asm/pgtable-2level.h       |   2 +
 arch/arm/include/asm/pgtable-3level.h       |   2 +
 arch/mips/include/asm/pgtable-32.h          |   3 +
 arch/powerpc/include/asm/pte-common.h       |   2 +
 arch/riscv/include/asm/pgtable-32.h         |   2 +
 arch/x86/kvm/ioapic.c                       |   2 +-
 arch/x86/kvm/ioapic.h                       |   4 +-
 drivers/amba/bus.c                          |   3 -
 drivers/infiniband/hw/qib/qib_user_sdma.c   |  34 +++++---
 drivers/media/firewire/firedtv-avc.c        |  14 +++-
 drivers/media/firewire/firedtv-ci.c         |   2 +
 drivers/net/ethernet/sfc/ethtool.c          |  10 +--
 drivers/net/wireless/rsi/rsi_91x_usb.c      |   2 +-
 drivers/scsi/scsi.c                         |   4 +-
 drivers/scsi/scsi_sysfs.c                   |   9 +++
 drivers/staging/comedi/drivers/dt9812.c     | 115 +++++++++++++++++++++-------
 drivers/staging/comedi/drivers/ni_usb6501.c |  10 +++
 drivers/staging/comedi/drivers/vmk80xx.c    |  28 +++----
 drivers/staging/rtl8192u/r8192U_core.c      |  18 ++---
 drivers/staging/rtl8712/usb_ops_linux.c     |   2 +-
 drivers/usb/gadget/udc/Kconfig              |   1 +
 drivers/usb/host/ehci-hcd.c                 |  11 ++-
 drivers/usb/host/ehci-platform.c            |   6 ++
 drivers/usb/host/ehci.h                     |   1 +
 drivers/usb/musb/musb_gadget.c              |   4 +-
 drivers/usb/storage/unusual_devs.h          |  10 +++
 fs/isofs/inode.c                            |   2 +
 include/asm-generic/pgtable.h               |  13 ++++
 kernel/printk/printk.c                      |   9 ++-
 localversion-rt                             |   2 +-
 32 files changed, 245 insertions(+), 86 deletions(-)
---
