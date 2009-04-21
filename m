From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: [PATCH][RT] - Mismatching declaration and export
Date: Tue, 21 Apr 2009 11:23:25 -0700
Message-ID: <1240338205.13601.17.camel@quadrophenia.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:35107 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZDUSX3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Apr 2009 14:23:29 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Subject: Make function declaration match EXPORT()

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>

Index: b/kernel/spinlock.c
===================================================================
--- a/kernel/spinlock.c
+++ b/kernel/spinlock.c
@@ -354,7 +354,7 @@ void __lockfunc _spin_lock_nest_lock(spi
 }
 EXPORT_SYMBOL(_spin_lock_nest_lock);
 
-unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
+unsigned long __lockfunc __spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
 {
 	unsigned long flags;
 


