From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/3] compat_rwsem: fix compile failure for when PREEMPT_RT is disabled.
Date: Mon, 29 Sep 2008 10:32:51 -0400
Message-ID: <1fcdb5cc884c1e226bcdc40e8a9918c9f80be027.1222698507.git.paul.gortmaker@windriver.com>
References: <1222698773-5920-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44152 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbYI2Oc6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Sep 2008 10:32:58 -0400
In-Reply-To: <1222698773-5920-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

If you disable PRREMPT_RT, you will get a compile failure on a missing
compat prototype.  This change should be considered for folding into
rt-mutex-i386.patch

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/asm-x86/rwsem.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86/rwsem.h b/include/asm-x86/rwsem.h
index b60eb18..4e4f94a 100644
--- a/include/asm-x86/rwsem.h
+++ b/include/asm-x86/rwsem.h
@@ -257,7 +257,7 @@ static inline int rwsem_atomic_update(int delta, struct compat_rw_semaphore *sem
 	return tmp + delta;
 }
 
-static inline int rwsem_is_locked(struct compat_rw_semaphore *sem)
+static inline int compat_rwsem_is_locked(struct compat_rw_semaphore *sem)
 {
 	return (sem->count != 0);
 }
-- 
1.6.0

