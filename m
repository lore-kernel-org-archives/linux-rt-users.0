From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] [RT] avoid preemption in memory controller code
Date: Mon,  8 Dec 2008 15:34:14 +0100
Message-ID: <1228746854-23875-1-git-send-email-tim@klingt.org>
Cc: linux-kernel@vger.kernel.org, Tim Blechmann <tim@klingt.org>
To: rostedt@goodmis.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:43717 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbYLHOqJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Dec 2008 09:46:09 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

the lru_lock of struct mem_group_per_zone is used to avoid preemption
during the __mem_cgroup_stat_add_safe function.
therefore, a raw_spinlock_t should be used.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 mm/memcontrol.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 517f945..8661732 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -95,9 +95,9 @@ enum mem_cgroup_zstat_index {
 
 struct mem_cgroup_per_zone {
 	/*
-	 * spin_lock to protect the per cgroup LRU
+	 * raw_spin_lock to protect the per cgroup LRU
 	 */
-	spinlock_t		lru_lock;
+	raw_spinlock_t		lru_lock;
 	struct list_head	active_list;
 	struct list_head	inactive_list;
 	unsigned long count[NR_MEM_CGROUP_ZSTAT];
-- 
1.5.6.3

