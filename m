From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 2.6.23-rc2-rt2] ARM: use raw lock in __new_context
Date: Thu, 30 Aug 2007 20:08:41 -0700
Message-ID: <20070831030841.799694742@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:52758 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753865AbXHaDJD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Aug 2007 23:09:03 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The ARM CPU ASID lock should be raw as it's used by schedule() when
creating a new context.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

--- dev.orig/arch/arm/mm/context.c
+++ dev/arch/arm/mm/context.c
@@ -14,7 +14,7 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
-static DEFINE_SPINLOCK(cpu_asid_lock);
+static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
 unsigned int cpu_last_asid = ASID_FIRST_VERSION;
 
 /*
--
