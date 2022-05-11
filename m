Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40272C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 May 2022 08:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbiEKIWj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 May 2022 04:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243583AbiEKIWg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 May 2022 04:22:36 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E63DA5A;
        Wed, 11 May 2022 01:22:30 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 24B8LfE9037644
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Wed, 11 May 2022 16:21:42 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 11 May 2022 16:21:42 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <linux-kernel@vger.kernel.org>, <xuewen.yan@unisoc.com>,
        <ke.wang@unisoc.com>, <ben.dai@unisoc.com>,
        <shian.wang@unisoc.com>, <linux-rt-users@vger.kernel.org>
Subject: [RFC PATCH] kernel: locking: rwsem optimization for rtlinux
Date:   Wed, 11 May 2022 16:21:21 +0800
Message-ID: <1652257281-11494-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 24B8LfE9037644
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

With regard to rtlinux, releasing the lock to RT waiter could be helpful to
increase its responding time even if cfs writer listed at the head of the
wait_list.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 kernel/locking/rwsem-xadd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index e795908..1b3f836 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -138,6 +138,18 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	waiter = list_first_entry(&sem->wait_list, struct rwsem_waiter, list);
 
 	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
+		if ((waiter->task->policy != SCHED_NORMAL)
+			&&(waiter->task->policy != SCHED_BATCH))
+			;
+		else {
+			list_for_each_entry(tmp, sem->wait_list.next, list) {
+				if ((tmp->task->policy != SCHED_NORMAL)
+					&&(tmp->task->policy != SCHED_BATCH)) {
+					wake_q_add(wake_q, tmp->task);
+					return;
+				}
+			}
+		}
 		if (wake_type == RWSEM_WAKE_ANY) {
 			/*
 			 * Mark writer at the front of the queue for wakeup.
-- 
1.9.1

