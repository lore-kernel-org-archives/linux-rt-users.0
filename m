Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BECC636C9
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CBB61351
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 22:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbhGSVke (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 17:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383762AbhGSSKM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jul 2021 14:10:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43EFA6108B;
        Mon, 19 Jul 2021 18:50:51 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.197-rt84
Date:   Mon, 19 Jul 2021 18:48:07 -0000
Message-ID: <162672048731.603329.3599964871498893076@puck.lan>
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

I'm pleased to announce the 4.19.197-rt84 stable release.

NOTE: I had a conflict in kernel/kthread.c that I believe is resolved, but
if you start having issues with kthread_cancel_* please let me know. 

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 8f51923033a34461ff3c65f2011ee86426141471

Or to build 4.19.197-rt84 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.197.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.197-rt84.patch.xz


You can also build from 4.19.196-rt83 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.196-rt83-rt84.patch.xz

Enjoy!
Clark

Changes from v4.19.196-rt83:
---

Alex Shi (1):
      mm: add VM_WARN_ON_ONCE_PAGE() macro

Alper Gun (1):
      KVM: SVM: Call SEV Guest Decommission if ASID binding fails

Anson Huang (1):
      ARM: dts: imx6qdl-sabresd: Remove incorrect power supply assignment

Christian König (1):
      drm/nouveau: fix dma_address check for CPU/GPU sync

Clark Williams (2):
      Merge tag 'v4.19.197' into v4.19-rt
      Linux 4.19.197-rt84

David Rientjes (1):
      KVM: SVM: Periodically schedule when unregistering regions on destroy

Greg Kroah-Hartman (1):
      Linux 4.19.197

Hugh Dickins (16):
      mm/thp: fix __split_huge_pmd_locked() on shmem migration entry
      mm/thp: make is_huge_zero_pmd() safe and quicker
      mm/thp: try_to_unmap() use TTU_SYNC for safe splitting
      mm/thp: fix vma_address() if virtual address below file offset
      mm/thp: unmap_mapping_page() to fix THP truncate_cleanup_page()
      mm: page_vma_mapped_walk(): use page for pvmw->page
      mm: page_vma_mapped_walk(): settle PageHuge on entry
      mm: page_vma_mapped_walk(): use pmde for *pvmw->pmd
      mm: page_vma_mapped_walk(): prettify PVMW_MIGRATION block
      mm: page_vma_mapped_walk(): crossing page table boundary
      mm: page_vma_mapped_walk(): add a level of indentation
      mm: page_vma_mapped_walk(): use goto instead of while (1)
      mm: page_vma_mapped_walk(): get vma_address_end() earlier
      mm/thp: fix page_vma_mapped_walk() if THP mapped by ptes
      mm/thp: another PVMW_SYNC fix in page_vma_mapped_walk()
      mm, futex: fix shared futex pgoff on shmem huge page

Jue Wang (1):
      mm/thp: fix page_address_in_vma() on file THP tails

Juergen Gross (1):
      xen/events: reset active flag for lateeoi events later

ManYi Li (1):
      scsi: sr: Return appropriate error code when disk is ejected

Miaohe Lin (2):
      mm/rmap: remove unneeded semicolon in page_not_mapped()
      mm/rmap: use page_not_mapped in try_to_unmap()

Petr Mladek (2):
      kthread_worker: split code for canceling the delayed work timer
      kthread: prevent deadlock when kthread_mod_delayed_work() races with kthread_cancel_delayed_work_sync()

Tahsin Erdogan (1):
      ext4: eliminate bogus error in ext4_data_block_valid_rcu()

Tony Lindgren (3):
      clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support
      clocksource/drivers/timer-ti-dm: Prepare to handle dra7 timer wrap issue
      clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940

Yang Shi (1):
      mm: thp: replace DEBUG_VM BUG with VM_WARN when unmap fails for split

afzal mohammed (1):
      ARM: OMAP: replace setup_irq() by request_irq()
---
Makefile                               |   2 +-
 arch/arm/boot/dts/dra7.dtsi            |  11 ++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   4 -
 arch/arm/mach-omap1/pm.c               |  13 ++-
 arch/arm/mach-omap1/time.c             |  10 +-
 arch/arm/mach-omap1/timer32k.c         |  10 +-
 arch/arm/mach-omap2/board-generic.c    |   4 +-
 arch/arm/mach-omap2/timer.c            | 181 +++++++++++++++++++++++----------
 arch/x86/kvm/svm.c                     |  33 ++++--
 drivers/clk/ti/clk-7xx.c               |   1 +
 drivers/gpu/drm/nouveau/nouveau_bo.c   |   4 +-
 drivers/scsi/sr.c                      |   2 +
 drivers/xen/events/events_base.c       |  23 ++++-
 fs/ext4/block_validity.c               |   4 +-
 include/linux/cpuhotplug.h             |   1 +
 include/linux/huge_mm.h                |   8 +-
 include/linux/hugetlb.h                |  16 ---
 include/linux/mm.h                     |   3 +
 include/linux/mmdebug.h                |  13 +++
 include/linux/pagemap.h                |  13 +--
 include/linux/rmap.h                   |   3 +-
 kernel/futex.c                         |   2 +-
 kernel/kthread.c                       |  77 +++++++++-----
 localversion-rt                        |   2 +-
 mm/huge_memory.c                       |  56 +++++-----
 mm/hugetlb.c                           |   5 +-
 mm/internal.h                          |  53 +++++++---
 mm/memory.c                            |  41 ++++++++
 mm/page_vma_mapped.c                   | 160 ++++++++++++++++++-----------
 mm/pgtable-generic.c                   |   4 +-
 mm/rmap.c                              |  48 +++++----
 mm/truncate.c                          |  43 ++++----
 32 files changed, 546 insertions(+), 304 deletions(-)
---
