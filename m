Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DF9C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 15:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B8B64FE7
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 15:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhCKPw6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:52:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234324AbhCKPw0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Mar 2021 10:52:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 223E664FDE;
        Thu, 11 Mar 2021 15:52:25 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.225-rt108
Date:   Thu, 11 Mar 2021 15:51:01 -0000
Message-ID: <161547786136.724078.3244775266456292306@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.225-rt108 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 9be9032dc85d3b02a04145284595ef2333b4c250

Or to build 4.14.225-rt108 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.225.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.225-rt108.patch.xz


You can also build from 4.14.224-rt107 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.224-rt107-rt108.patch.xz

Enjoy!
Clark

Changes from v4.14.224-rt107:
---

Andrey Ryabinin (1):
      iommu/amd: Fix sleeping in atomic in increase_address_space()

AngeloGioacchino Del Regno (1):
      drm/msm/a5xx: Remove overwriting A5XX_PC_DBG_ECO_CNTL register

Antonio Borneo (1):
      usbip: tools: fix build error for multiple definition

Aswath Govindraju (1):
      misc: eeprom_93xx46: Add quirk to support Microchip 93LC46B eeprom

Bjorn Helgaas (1):
      PCI: Add function 1 DMA alias quirk for Marvell 9215 SATA controller

Clark Williams (2):
      Merge tag 'v4.14.225' into v4.14-rt
      Linux 4.14.225-rt108

Colin Ian King (1):
      ALSA: ctxfi: cthw20k2: fix mask on conf to allow 4 bits

Dan Carpenter (1):
      rsxx: Return -EFAULT if copy_to_user() fails

David Sterba (1):
      btrfs: raid56: simplify tracking of Q stripe presence

Greg Kroah-Hartman (1):
      Linux 4.14.225

Hans de Goede (6):
      platform/x86: acer-wmi: Cleanup ACER_CAP_FOO defines
      platform/x86: acer-wmi: Cleanup accelerometer device handling
      platform/x86: acer-wmi: Add new force_caps module parameter
      platform/x86: acer-wmi: Add ACER_CAP_SET_FUNCTION_MODE capability flag
      platform/x86: acer-wmi: Add support for SW_TABLET_MODE on Switch devices
      platform/x86: acer-wmi: Add ACER_CAP_KBD_DOCK quirk for the Aspire Switch 10E SW3-016

Ira Weiny (1):
      btrfs: fix raid6 qstripe kmap

Jeffle Xu (3):
      dm table: fix iterate_devices based device capability checks
      dm table: fix DAX iterate_devices based device capability checks
      dm table: fix zoned iterate_devices based device capability checks

Rafael J. Wysocki (1):
      PM: runtime: Update device status before letting suppliers suspend

Tsuchiya Yuto (1):
      mwifiex: pcie: skip cancel_work_sync() on reset failure path
---
Makefile                                    |   2 +-
 drivers/base/power/runtime.c                |  62 ++++++----
 drivers/block/rsxx/core.c                   |   8 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |   2 -
 drivers/iommu/amd_iommu.c                   |  10 +-
 drivers/md/dm-table.c                       | 168 ++++++++++++---------------
 drivers/misc/eeprom/eeprom_93xx46.c         |  15 +++
 drivers/net/wireless/marvell/mwifiex/pcie.c |  18 ++-
 drivers/net/wireless/marvell/mwifiex/pcie.h |   2 +
 drivers/pci/quirks.c                        |   3 +
 drivers/platform/x86/acer-wmi.c             | 169 +++++++++++++++++++++++-----
 fs/btrfs/raid56.c                           |  58 ++++------
 include/linux/eeprom_93xx46.h               |   2 +
 localversion-rt                             |   2 +-
 sound/pci/ctxfi/cthw20k2.c                  |   2 +-
 tools/usb/usbip/libsrc/usbip_host_common.c  |   2 +-
 16 files changed, 326 insertions(+), 199 deletions(-)
