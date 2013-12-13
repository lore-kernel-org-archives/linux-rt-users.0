From: Allen Pais <allen.pais@oracle.com>
Subject: [PATCH 1/3] sparc64: use generic rwsem spinlocks rt
Date: Fri, 13 Dec 2013 09:44:41 +0530
Message-ID: <1386908084-32064-2-git-send-email-allen.pais@oracle.com>
References: <1386908084-32064-1-git-send-email-allen.pais@oracle.com>
Cc: tglx@linutronix.de, Allen Pais <allen.pais@oracle.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17671 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab3LMEP2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Dec 2013 23:15:28 -0500
In-Reply-To: <1386908084-32064-1-git-send-email-allen.pais@oracle.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/Kconfig |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 6787bd3..554995d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -179,12 +179,10 @@ config NR_CPUS
 source kernel/Kconfig.hz
 
 config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y if SPARC32
+	def_bool PREEMPT_RT_FULL
 
 config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y if SPARC64
+	def_bool !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT_FULL
 
 config GENERIC_HWEIGHT
 	bool
-- 
1.7.10.4

