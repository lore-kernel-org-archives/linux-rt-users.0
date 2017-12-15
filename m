From: Alex Shi <alex.shi@linaro.org>
Subject: a fixing patch for 4.15 sched change of cpu_ptr
Date: Fri, 15 Dec 2017 09:42:49 +0800
Message-ID: <17bc8f42-3047-52eb-a38c-815fefc733ac@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38583 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754538AbdLOBm6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Dec 2017 20:42:58 -0500
Received: by mail-pg0-f66.google.com with SMTP id f12so4714913pgo.5
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2017 17:42:57 -0800 (PST)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastain,

After rebase rt to 4.15, The following patch still need be fold into:
kernel: sched: Provide a pointer to the valid CPU mask

Regards
Alex

>From b61af268d8b731b7ffeffd2d588c4e8dcae18d44 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linaro.org>
Date: Tue, 12 Dec 2017 17:59:11 +0800
Subject: [PATCH] sched: replace new cpus_allowed member usage with cpus_ptr

4.15 commit 6fee85c
sched/fair: Fix usage of find_idlest_group() when no groups are allowed
reused cpus_allowed again. need to fix this to follow cpu_allowed to cpu_ptr
change on rt.


Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3136c11..2c5ab64 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5965,7 +5965,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 {
 	int new_cpu = cpu;
 
-	if (!cpumask_intersects(sched_domain_span(sd), &p->cpus_allowed))
+	if (!cpumask_intersects(sched_domain_span(sd), p->cpus_ptr))
 		return prev_cpu;
 
 	while (sd) {
-- 
2.7.4

