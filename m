From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH 0/7] Backport of swait v3 patches to v4.1.10-rt10
Date: Wed, 28 Oct 2015 11:05:05 +0100
Message-ID: <1446026713-13154-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:46106 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755691AbbJ1KFQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Oct 2015 06:05:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Clark,

As you have indicated on IRQ you like to test the swait patches on how
it performs with -rt. Here is the backport of the swait v3 patch set.

In order to test these patches here drop following patches from
the 4.1.10-rt10 tree:

    wait-simple-implementation.patch
    work-simple-Simple-work-queue-implemenation.patch
    rcu-more-swait-conversions.patch
    completion-use-simple-wait-queues.patch
    block-blk-mq-use-swait.patch
    KVM-use-simple-waitqueue-for-vcpu-wq.patch

and apply the patche from this patch set. My test box is running since
one hour without crashing. hackbench, cyclictest, kernel build
and KVM torture running inside a KVM. 

Daniel Wagner (2):
  work-simple: Simple work queue implemenation
  rcu: Do not call rcu_nocb_gp_cleanup() while holding rnp->lock

Marcelo Tosatti (1):
  KVM: use simple waitqueue for vcpu->wq

Paul Gortmaker (1):
  rcu: use simple wait queues where possible in rcutree

Peter Zijlstra (Intel) (1):
  wait.[ch]: Introduce the simple waitqueue (swait) implementation

Sebastian Andrzej Siewior (1):
  block: blk-mq: Use swait

Thomas Gleixner (1):
  completion: Use simple wait queues

 arch/arm/kvm/arm.c                         |   4 +-
 arch/arm/kvm/psci.c                        |   4 +-
 arch/mips/kvm/mips.c                       |   8 +-
 arch/powerpc/include/asm/kvm_host.h        |   4 +-
 arch/powerpc/kvm/book3s_hv.c               |  23 ++--
 arch/s390/include/asm/kvm_host.h           |   2 +-
 arch/s390/kvm/interrupt.c                  |   8 +-
 arch/x86/kvm/lapic.c                       |   6 +-
 block/blk-core.c                           |   2 +-
 block/blk-mq.c                             |  10 +-
 drivers/net/wireless/orinoco/orinoco_usb.c |   2 +-
 drivers/usb/gadget/function/f_fs.c         |   2 +-
 drivers/usb/gadget/legacy/inode.c          |   4 +-
 include/linux/blkdev.h                     |   2 +-
 include/linux/completion.h                 |   9 +-
 include/linux/kvm_host.h                   |   5 +-
 include/linux/swait.h                      | 172 ++++++++++++++++++++++++++++
 include/linux/uprobes.h                    |   1 +
 include/linux/work-simple.h                |  24 ++++
 kernel/rcu/tree.c                          |  16 +--
 kernel/rcu/tree.h                          |  10 +-
 kernel/rcu/tree_plugin.h                   |  32 ++++--
 kernel/sched/Makefile                      |   2 +-
 kernel/sched/completion.c                  |  32 +++---
 kernel/sched/core.c                        |  10 +-
 kernel/sched/swait.c                       | 122 ++++++++++++++++++++
 kernel/sched/work-simple.c                 | 173 +++++++++++++++++++++++++++++
 virt/kvm/async_pf.c                        |   4 +-
 virt/kvm/kvm_main.c                        |  16 +--
 29 files changed, 610 insertions(+), 99 deletions(-)
 create mode 100644 include/linux/swait.h
 create mode 100644 include/linux/work-simple.h
 create mode 100644 kernel/sched/swait.c
 create mode 100644 kernel/sched/work-simple.c

-- 
2.4.3

