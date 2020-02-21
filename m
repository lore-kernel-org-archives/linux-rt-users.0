Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D325C3566F
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A1D24694
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320337;
	bh=i0N2MrNKZHuX++taw3rFk2nCgTfZGw2eHHT1CJg4TdY=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=z2sTDi4cYM/SoDx+bfOIFkGr7mKi0e0sJ7K+kXsrKyh5OVBa0q6W43yOE0pj9U04H
	 yMxPna5JzKQdWNSwDsZZCKETWfdk+EY54tLUhI8abpm3FtPpDxLGmLqHnHurCj+9kp
	 yLZTATdZe62e5z4tW1/prRoWzDQ+9BX9tT27mlVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgBUVZh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbgBUVZf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:35 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD4A12468E;
        Fri, 21 Feb 2020 21:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320334;
        bh=i0N2MrNKZHuX++taw3rFk2nCgTfZGw2eHHT1CJg4TdY=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=loBbQsujoFNjW1nPPgpnThgEU8tmhdQ1wXas44PHwBj+Sxo410qVrrE0AniRmz3OG
         4g/GjLhatI3Bdekhkp63NakEpEbpIjUGpMhPp8r/EFO/LS++ijDZqgNa7xCpXO3wpE
         T72oVIIJm/ZSCR6USjLz3/OHO2CeRd0OymwKx7DI=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 20/25] kmemleak: Cosmetic changes
Date:   Fri, 21 Feb 2020 15:24:48 -0600
Message-Id: <c3cf47877f79afa92634bf376488c8aa71378a26.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 65a387a0b45cdd6844b7c6269e6333c9f0113410 ]

Align with the patch, that got sent upstream for review. Only cosmetic
changes.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 mm/kmemleak.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 17718a11782b..d7925ee4b052 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -26,7 +26,7 @@
  *
  * The following locks and mutexes are used by kmemleak:
  *
- * - kmemleak_lock (raw spinlock): protects the object_list modifications and
+ * - kmemleak_lock (raw_spinlock_t): protects the object_list modifications and
  *   accesses to the object_tree_root. The object_list is the main list
  *   holding the metadata (struct kmemleak_object) for the allocated memory
  *   blocks. The object_tree_root is a red black tree used to look-up
@@ -35,13 +35,13 @@
  *   object_tree_root in the create_object() function called from the
  *   kmemleak_alloc() callback and removed in delete_object() called from the
  *   kmemleak_free() callback
- * - kmemleak_object.lock (spinlock): protects a kmemleak_object. Accesses to
- *   the metadata (e.g. count) are protected by this lock. Note that some
- *   members of this structure may be protected by other means (atomic or
- *   kmemleak_lock). This lock is also held when scanning the corresponding
- *   memory block to avoid the kernel freeing it via the kmemleak_free()
- *   callback. This is less heavyweight than holding a global lock like
- *   kmemleak_lock during scanning
+ * - kmemleak_object.lock (raw_spinlock_t): protects a kmemleak_object.
+ *   Accesses to the metadata (e.g. count) are protected by this lock. Note
+ *   that some members of this structure may be protected by other means
+ *   (atomic or kmemleak_lock). This lock is also held when scanning the
+ *   corresponding memory block to avoid the kernel freeing it via the
+ *   kmemleak_free() callback. This is less heavyweight than holding a global
+ *   lock like kmemleak_lock during scanning.
  * - scan_mutex (mutex): ensures that only one thread may scan the memory for
  *   unreferenced objects at a time. The gray_list contains the objects which
  *   are already referenced or marked as false positives and need to be
@@ -197,7 +197,7 @@ static LIST_HEAD(object_list);
 static LIST_HEAD(gray_list);
 /* search tree for object boundaries */
 static struct rb_root object_tree_root = RB_ROOT;
-/* rw_lock protecting the access to object_list and object_tree_root */
+/* protecting the access to object_list and object_tree_root */
 static DEFINE_RAW_SPINLOCK(kmemleak_lock);
 
 /* allocation caches for kmemleak internal data */
-- 
2.14.1

