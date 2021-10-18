Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE90C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 20:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB9B611EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 20:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhJRULE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhJRULE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Oct 2021 16:11:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 621EE6115B;
        Mon, 18 Oct 2021 20:08:52 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.212-rt92
Date:   Mon, 18 Oct 2021 20:08:16 -0000
Message-ID: <163458769602.551117.3363510485181296627@puck.lan>
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

I'm pleased to announce the 4.19.212-rt92 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 5e483063f8915dab2fa7abff54b1a4bbeeb921a9

Or to build 4.19.212-rt92 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.212.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.212-rt92.patch.xz


You can also build from 4.19.211-rt91 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.211-rt91-rt92.patch.xz

Enjoy!
Clark

Changes from v4.19.211-rt91:
---

Al Viro (1):
      m68k: Handle arrivals of multiple signals correctly

Anand K Mistry (1):
      perf/x86: Reset destroy callback on event init failure

Clark Williams (2):
      Merge tag 'v4.19.212' into v4.19-rt
      Linux 4.19.212-rt92

Colin Ian King (1):
      scsi: virtio_scsi: Fix spelling mistake "Unsupport" -> "Unsupported"

Florian Fainelli (1):
      net: phy: bcm7xxx: Fixed indirect MMD operations

Greg Kroah-Hartman (1):
      Linux 4.19.212

Jeremy Sowden (1):
      netfilter: ip6_tables: zero-initialize fragment offset

Jiapeng Chong (1):
      scsi: ses: Fix unsigned comparison with less than zero

MichelleJin (1):
      mac80211: check return value of rhashtable_init

Mizuho Mori (1):
      HID: apple: Fix logical maximum and usage maximum of Magic Keyboard JIS

Peter Zijlstra (1):
      sched: Always inline is_percpu_thread()

Randy Dunlap (1):
      net: sun: SUNVNET_COMMON should depend on INET

YueHaibing (1):
      mac80211: Drop frames from invalid MAC address in ad-hoc mode

王贇 (1):
      net: prevent user from passing illegal stab size
---
Makefile                         |  2 +-
 arch/m68k/kernel/signal.c        | 88 ++++++++++++++++++-------------------
 arch/x86/events/core.c           |  1 +
 drivers/hid/hid-apple.c          |  7 +++
 drivers/net/ethernet/sun/Kconfig |  1 +
 drivers/net/phy/bcm7xxx.c        | 94 ++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ses.c               |  2 +-
 drivers/scsi/virtio_scsi.c       |  4 +-
 include/linux/sched.h            |  2 +-
 include/net/pkt_sched.h          |  1 +
 localversion-rt                  |  2 +-
 net/ipv6/netfilter/ip6_tables.c  |  1 +
 net/mac80211/mesh_pathtbl.c      |  5 ++-
 net/mac80211/rx.c                |  3 +-
 net/sched/sch_api.c              |  6 +++
 15 files changed, 165 insertions(+), 54 deletions(-)
---
