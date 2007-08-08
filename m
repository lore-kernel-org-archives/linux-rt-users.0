From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] Add missing semicolon in percpu_list.h
Date: Wed, 08 Aug 2007 15:03:12 -0400
Message-ID: <1186599792.29097.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:47268 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674AbXHHTDz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Aug 2007 15:03:55 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo,

This patch adds a missing semicolon in the percpu_list.h under 
!CONFIG_SMP.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.23-rc2-rt2/include/linux/percpu_list.h
===================================================================
--- linux-2.6.23-rc2-rt2.orig/include/linux/percpu_list.h
+++ linux-2.6.23-rc2-rt2/include/linux/percpu_list.h
@@ -84,7 +84,7 @@ void percpu_list_fold(struct percpu_list
 
 struct percpu_list {
 	struct lock_list_head list;
-}
+};
 
 static inline
 void percpu_list_init(struct percpu_list *pcl)
