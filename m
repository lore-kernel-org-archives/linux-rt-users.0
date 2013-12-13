From: Allen Pais <allen.pais@oracle.com>
Subject: [PATCH 0/3]  PREEMPT_RT support for Sparc64
Date: Fri, 13 Dec 2013 09:44:40 +0530
Message-ID: <1386908084-32064-1-git-send-email-allen.pais@oracle.com>
Cc: tglx@linutronix.de, Allen Pais <allen.pais@oracle.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17627 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab3LMEPN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Dec 2013 23:15:13 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

PREEMPT_RT support for Sparc64. 
I have tested it UltraSparc T4 (Niagara4).

Allen Pais (3):
  sparc64: use generic rwsem spinlocks rt
  sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
  sparc64: convert ctx_alloc_lock raw_spinlock_t

 arch/sparc/Kconfig                      |    7 +++----
 arch/sparc/include/asm/mmu_64.h         |    2 +-
 arch/sparc/include/asm/mmu_context_64.h |   10 +++++-----
 arch/sparc/kernel/smp_64.c              |    4 ++--
 arch/sparc/mm/init_64.c                 |   14 +++++++-------
 arch/sparc/mm/tsb.c                     |   20 ++++++++++----------
 6 files changed, 28 insertions(+), 29 deletions(-)

-- 
1.7.10.4

