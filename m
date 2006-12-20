From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [patch 1/4] ARM: Include compilation and warning fixes
Date: Wed, 20 Dec 2006 10:20:29 +0100
Message-ID: <4589005D.2060006@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010201010500030006040809"
Cc: tglx@linutronix.de, David Brownell <david-b@pacbell.net>,
	Daniel Walker <dwalker@mvista.com>,
	Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:21787 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964926AbWLTJUd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Dec 2006 04:20:33 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2594570nfa
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Dec 2006 01:20:32 -0800 (PST)
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------010201010500030006040809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix compilation issues and warnings for ARM in
include/asm-arm/system.h.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------010201010500030006040809
Content-Type: text/plain;
 name="arm_include_fixes_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm_include_fixes_patch.txt"

Index: linux-2.6.20-rc1/include/asm-arm/system.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-arm/system.h
+++ linux-2.6.20-rc1/include/asm-arm/system.h
@@ -173,23 +173,25 @@ static inline void set_copro_access(unsi
 extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
+#include <linux/irqflags.h>
+
 #ifndef CONFIG_SMP
 static inline void adjust_cr(unsigned long mask, unsigned long set)
 {
-	unsigned long flags, cr;
+	unsigned long flags;
 
 	mask &= ~CR_A;
 
 	set &= mask;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	cr_no_alignment = (cr_no_alignment & ~mask) | set;
 	cr_alignment = (cr_alignment & ~mask) | set;
 
 	set_cr((get_cr() & ~mask) | set);
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 #endif
 
@@ -248,8 +250,6 @@ static inline void sched_cacheflush(void
 {
 }
 
-#include <linux/irqflags.h>
-
 #ifdef CONFIG_SMP
 
 #define smp_mb()		mb()


--------------010201010500030006040809--
