Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDFEC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 20:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4011161456
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 20:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhEGUKa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 16:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhEGUKa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 16:10:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAB7F613ED;
        Fri,  7 May 2021 20:09:29 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.190-rt79
Date:   Fri, 07 May 2021 20:06:55 -0000
Message-ID: <162041801544.443223.1510428885860989541@puck.lan>
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

I'm pleased to announce the 4.19.190-rt79 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 484b86536efcc0cc4ff43f5528f3ebf19cc9550e

Or to build 4.19.190-rt79 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.190.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.190-rt79.patch.xz


You can also build from 4.19.189-rt78 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.189-rt78-rt79.patch.xz

Enjoy!
Clark

Changes from v4.19.189-rt78:
---

Chris Chiu (1):
      USB: Add reset-resume quirk for WD19's Realtek Hub

Clark Williams (2):
      Merge tag 'v4.19.190' into v4.19-rt
      Linux 4.19.190-rt79

Daniel Borkmann (1):
      bpf: Fix masking negation logic upon negative dst register

Gao Xiang (1):
      erofs: fix extended inode could cross boundary

Greg Kroah-Hartman (1):
      Linux 4.19.190

Jiri Kosina (2):
      iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()
      iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_gen2_enqueue_hcmd()

Kai-Heng Feng (1):
      USB: Add LPM quirk for Lenovo ThinkPad USB-C Dock Gen2 Ethernet

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Correct thermal sensor allocation

Miklos Szeredi (1):
      ovl: allow upperdir inside lowerdir

Phillip Potter (1):
      net: usb: ax88179_178a: initialize local variables before use

Rafael J. Wysocki (2):
      ACPI: tables: x86: Reserve memory occupied by ACPI tables
      ACPI: x86: Call acpi_boot_table_init() after acpi_table_upgrade()

Romain Naour (1):
      mips: Do not include hi and lo in clobber list for R6

Takashi Iwai (1):
      ALSA: usb-audio: Add MIDI quirk for Vox ToneLab EX
---
Makefile                                          |   2 +-
 arch/mips/vdso/gettimeofday.c                     |  14 ++-
 arch/x86/kernel/acpi/boot.c                       |  25 ++--
 arch/x86/kernel/setup.c                           |   7 +-
 drivers/acpi/tables.c                             |  42 ++++++-
 drivers/net/usb/ax88179_178a.c                    |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c      |   7 +-
 drivers/platform/x86/thinkpad_acpi.c              |  31 +++--
 drivers/staging/erofs/inode.c                     | 135 ++++++++++++++--------
 drivers/usb/core/quirks.c                         |   4 +
 fs/overlayfs/super.c                              |  12 +-
 include/linux/acpi.h                              |   9 +-
 kernel/bpf/verifier.c                             |  12 +-
 localversion-rt                                   |   2 +-
 sound/usb/quirks-table.h                          |  10 ++
 16 files changed, 222 insertions(+), 101 deletions(-)
