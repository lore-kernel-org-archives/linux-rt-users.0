From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 3/5] [POWERPC] Match __rw_yeild function declaration to prototype.
Date: Tue, 04 Sep 2007 17:09:02 +1000
Message-ID: <20070904070902.52E9832CA0C@thor>
References: <1188889742.376.642108109551.qpush@thor>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pythia.bakeyournoodle.com ([203.82.209.197]:35379 "EHLO
	pythia.bakeyournoodle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbXIDHV3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Sep 2007 03:21:29 -0400
Received: from thor (localhost [127.0.0.1])
	by pythia.bakeyournoodle.com (Postfix) with ESMTP id C635513C31
	for <linux-rt-users@vger.kernel.org>; Tue,  4 Sep 2007 15:09:02 +0800 (WST)
In-Reply-To: <1188889742.376.642108109551.qpush@thor>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 arch/powerpc/lib/locks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: working/arch/powerpc/lib/locks.c
===================================================================
--- working.orig/arch/powerpc/lib/locks.c	2007-09-04 16:46:40.000000000 +1000
+++ working/arch/powerpc/lib/locks.c	2007-09-04 16:46:58.000000000 +1000
@@ -55,7 +55,7 @@ void __spin_yield(__raw_spinlock_t *lock
  * This turns out to be the same for read and write locks, since
  * we only know the holder if it is write-locked.
  */
-void __rw_yield(raw_rwlock_t *rw)
+void __rw_yield(__raw_rwlock_t *rw)
 {
 	int lock_value;
 	unsigned int holder_cpu, yield_count;
