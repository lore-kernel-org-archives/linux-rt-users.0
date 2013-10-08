From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] rt-v3.10-devel: fix mangled mm/slab patch
Date: Tue, 8 Oct 2013 13:35:47 -0400
Message-ID: <1381253747-26753-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:40105 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676Ab3JHRgK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Oct 2013 13:36:10 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Delete obviously duplicated content.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 mm-slab-wrap-functions.patch | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm-slab-wrap-functions.patch b/mm-slab-wrap-functions.patch
index c8830f3..acb2397 100644
--- a/mm-slab-wrap-functions.patch
+++ b/mm-slab-wrap-functions.patch
@@ -162,7 +162,7 @@ Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
  			int force, int node);
  
 -static void do_drain(void *arg)
-+static void __do_drain(void *arg, unsigned int cpu)+static void __do_drain(void *arg, unsigned int cpu)
++static void __do_drain(void *arg, unsigned int cpu)
  {
  	struct kmem_cache *cachep = arg;
  	struct array_cache *ac;
-- 
1.8.1.2

