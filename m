From: Allen Pais <allen.pais@oracle.com>
Subject: [PATCH 2/4] [V1] sparc64: support forced irq threading
Date: Wed, 18 Dec 2013 15:59:42 +0530
Message-ID: <1387362584-29249-3-git-send-email-allen.pais@oracle.com>
References: <1387362584-29249-1-git-send-email-allen.pais@oracle.com>
Cc: bigeasy@linutronix.de, Allen Pais <allen.pais@oracle.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:34732 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab3LRKaN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Dec 2013 05:30:13 -0500
In-Reply-To: <1387362584-29249-1-git-send-email-allen.pais@oracle.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 554995d..aae5aa9 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -27,6 +27,7 @@ config SPARC
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_GENERIC_HARDIRQS
+	select IRQ_FORCED_THREADING
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select USE_GENERIC_SMP_HELPERS if SMP
-- 
1.7.10.4

