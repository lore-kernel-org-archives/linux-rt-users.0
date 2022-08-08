Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8757EC25B08
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Aug 2022 12:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbiHHM4q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiHHM4k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Aug 2022 08:56:40 -0400
Received: from mail.infraroot.at (mail.infraroot.at [54.37.73.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD9C273D
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Aug 2022 05:56:38 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id 80CA34169D;
        Mon,  8 Aug 2022 14:56:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 80CA34169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1659963395;
        bh=DhPN7weyQjmj15xvQ18fmASiGvEpFtfU/y3t7RmmEe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UI+2InPLF0mUN5gksNv+kARLY2g28SpqE47sgMl1wbw9k2fu1jx7zqdi7seb7Ghbe
         L1Vmi5E9d/xH71f81r5WRux0mn/YX10hIuKGC0uEpnt0ykXOJntCwTUnMNtTNstKDI
         9/+c1l2PDBqbvOlJ+00/aQ44vq0XWgVa1XyGg+as=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        joseph.salisbury@canonical.com, Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH v2 02/10] mm/memcg: Disable threshold event handlers on PREEMPT_RT
Date:   Mon,  8 Aug 2022 14:55:54 +0200
Message-Id: <20220808125602.97747-3-goliath@infraroot.at>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125602.97747-1-goliath@infraroot.at>
References: <20220808125602.97747-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

During the integration of PREEMPT_RT support, the code flow around
memcg_check_events() resulted in `twisted code'. Moving the code around
and avoiding then would then lead to an additional local-irq-save
section within memcg_check_events(). While looking better, it adds a
local-irq-save section to code flow which is usually within an
local-irq-off block on non-PREEMPT_RT configurations.

The threshold event handler is a deprecated memcg v1 feature. Instead of
trying to get it to work under PREEMPT_RT just disable it. There should
be no users on PREEMPT_RT. From that perspective it makes even less
sense to get it to work under PREEMPT_RT while having zero users.

Make memory.soft_limit_in_bytes and cgroup.event_control return
-EOPNOTSUPP on PREEMPT_RT. Make an empty memcg_check_events() and
memcg_write_event_control() which return only -EOPNOTSUPP on PREEMPT_RT.
Document that the two knobs are disabled on PREEMPT_RT.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
[do: backported to v5.15]
Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |  2 ++
 mm/memcontrol.c                                | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 41191b5fb69d..c45291ac9ffb 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -64,6 +64,7 @@ Brief summary of control files.
 				     threads
  cgroup.procs			     show list of processes
  cgroup.event_control		     an interface for event_fd()
+				     This knob is not available on CONFIG_PREEMPT_RT systems.
  memory.usage_in_bytes		     show current usage for memory
 				     (See 5.5 for details)
  memory.memsw.usage_in_bytes	     show current usage for memory+Swap
@@ -75,6 +76,7 @@ Brief summary of control files.
  memory.max_usage_in_bytes	     show max memory usage recorded
  memory.memsw.max_usage_in_bytes     show max memory+Swap usage recorded
  memory.soft_limit_in_bytes	     set/show soft limit of memory usage
+				     This knob is not available on CONFIG_PREEMPT_RT systems.
  memory.stat			     show various statistics
  memory.use_hierarchy		     set/show hierarchical account enabled
                                      This knob is deprecated and shouldn't be
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a07e068989b4..6078d57aee0f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -909,6 +909,9 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
  */
 static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return;
+
 	/* threshold event is triggered in finer grain than soft limit */
 	if (unlikely(mem_cgroup_event_ratelimit(memcg,
 						MEM_CGROUP_TARGET_THRESH))) {
@@ -3777,8 +3780,12 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		}
 		break;
 	case RES_SOFT_LIMIT:
-		memcg->soft_limit = nr_pages;
-		ret = 0;
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			ret = -EOPNOTSUPP;
+		} else {
+			memcg->soft_limit = nr_pages;
+			ret = 0;
+		}
 		break;
 	}
 	return ret ?: nbytes;
@@ -4754,6 +4761,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	char *endp;
 	int ret;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return -EOPNOTSUPP;
+
 	buf = strstrip(buf);
 
 	efd = simple_strtoul(buf, &endp, 10);
-- 
2.37.1

