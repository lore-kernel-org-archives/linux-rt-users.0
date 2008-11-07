From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: [PATCH][RT] Trivial: Correctly dereference when clearing unused
	variable
Date: Fri, 07 Nov 2008 13:19:42 -0800
Message-ID: <1226092782.5685.11.camel@dd>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <Linux-kernel@vger.kernel.org>, Tony Jones <tonyj@suse.de>
To: RT Users List <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:59978 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYKGVZP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Nov 2008 16:25:15 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1458989rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2008 13:25:15 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



From: Sven-Thorsten Dietrich <sdietrich@suse.de>
Subject:  Correctly dereference flags when clearing unused variable.

Its probably unsafe to set the flags pointer to 0, since this will oops,
if it is dereferenced elsewhere for some odd reason. 

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>

---
 mm/page_alloc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -170,7 +170,7 @@ static inline void __lock_cpu_pcp(unsign
 {
 #ifdef CONFIG_PREEMPT_RT
 	spin_lock(&__get_cpu_lock(pcp_locks, cpu));
-	flags = 0;
+	*flags = 0;
 #else
 	local_irq_save(*flags);
 #endif
@@ -180,7 +180,7 @@ static inline void lock_cpu_pcp(unsigned
 {
 #ifdef CONFIG_PREEMPT_RT
 	(void)get_cpu_var_locked(pcp_locks, this_cpu);
-	flags = 0;
+	*flags = 0;
 #else
 	local_irq_save(*flags);
 	*this_cpu = smp_processor_id();


