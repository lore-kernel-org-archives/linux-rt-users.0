From: Allen Pais <allen.pais@oracle.com>
Subject: [PATCH 0/4] PREEMPT_RT support for sparc64
Date: Wed, 18 Dec 2013 15:59:40 +0530
Message-ID: <1387362584-29249-1-git-send-email-allen.pais@oracle.com>
Cc: bigeasy@linutronix.de, Allen Pais <allen.pais@oracle.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43626 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab3LRKaH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Dec 2013 05:30:07 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

PREEMPT_RT support for sparc64
All the patches are based on v3.10.24-rt22
commit e88b1c51941d964e77ef7e9099075ae2e8dafd75

Have tested it on UltraSparc T4 (Niagara4). 

Allen Pais (4):
  [V1] sparc64: use generic rwsem spinlocks rt
  [V1] sparc64: support forced irq threading
  [V1] sparc64: convert spinloc_t to raw_spinlock_t in mmu_context_t
  [V1] sparc64: convert ctx_alloc_lock raw_spinlock_t

 arch/sparc/Kconfig                      |    7 +++----
 arch/sparc/include/asm/mmu_64.h         |    2 +-
 arch/sparc/include/asm/mmu_context_64.h |   10 +++++-----
 arch/sparc/kernel/smp_64.c              |    4 ++--
 arch/sparc/mm/init_64.c                 |   14 +++++++-------
 arch/sparc/mm/tsb.c                     |   20 ++++++++++----------
 6 files changed, 28 insertions(+), 29 deletions(-)

-- 
1.7.10.4

