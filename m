Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA548EE4992
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Aug 2023 20:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379902AbjHRUJD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379921AbjHRUIs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2023 16:08:48 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366F3C24;
        Fri, 18 Aug 2023 13:08:44 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37IJVdo0026350;
        Fri, 18 Aug 2023 20:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PPS06212021; bh=PZp7L
        ufrasJQNiQkemIrcsEbftIiyJfMPDogWbOurYY=; b=CpchnLzMfqo5lRvEziHKg
        ysYyIJL021/39O80OOMOuyqkiVelNV989nzHM3rtS7/5F8X11pn6qBeDqjX4Onfg
        NYe4jLgRw3zgKN02K17PhcYMF3sZ9S4lbuc1wZBxlOnJzg9yO0hilWLjV4XOwMmI
        MISzqQ67mp1iKfE7Hk9sC2tlnBvaoOiW1CxKBJCcL/byZRr1yyIqglwIRf/7r/u2
        OiWaic6VjvQgU315X0XQUv8fezGH+687riEn5iZQsk182hG15ZuDXf7dsEsUmejI
        MoIiyA1pkN8RYxbZoOTVtjd2ORZYrHktm/uRoUW1wOzw3L0VKAkVBNAZ+jrsPBOf
        A==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sdy9web5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Aug 2023 20:08:13 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 13:08:10 -0700
Received: from yow-lpggp3.wrs.com (128.224.137.13) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 13:08:11 -0700
From:   <paul.gortmaker@windriver.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Wen Yang <wenyang.linux@foxmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] tick/rcu: fix false positive "softirq work is pending" messages on RT
Date:   Fri, 18 Aug 2023 16:07:57 -0400
Message-ID: <20230818200757.1808398-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sfP-upfq07t6pz0-UKhM7NbZrDexdzHU
X-Proofpoint-ORIG-GUID: sfP-upfq07t6pz0-UKhM7NbZrDexdzHU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_25,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=497
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308180183
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

In commit 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
the new function report_idle_softirq() was created by breaking code out
of the existing can_stop_idle_tick() for kernels v5.18 and newer.

In doing so, the code essentially went from a one conditional:

	if (a && b && c)
		warn();

to a three conditional:

	if (!a)
		return;
	if (!b)
		return;
	if (!c)
		return;
	warn();

However, it seems one of the conditionals didn't get a "!" removed.
Compare the instance of local_bh_blocked() in the old code:

-               if (ratelimit < 10 && !local_bh_blocked() &&
-                   (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
-                       pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
-                               (unsigned int) local_softirq_pending());
-                       ratelimit++;
-               }

...to the usage in the new (5.18+) code:

+       /* On RT, softirqs handling may be waiting on some lock */
+       if (!local_bh_blocked())
+               return false;

It seems apparent that the "!" should be removed from the new code.

This issue lay dormant until another fixup for the same commit was added
in commit a7e282c77785 ("tick/rcu: Fix bogus ratelimit condition").
This commit realized the ratelimit was essentially set to zero instead
of ten, and hence *no* softirq pending messages would ever be issued.

Once this commit was backported via linux-stable, both the v6.1 and v6.4
preempt-rt kernels started printing out 10 instances of this at boot:

  NOHZ tick-stop error: local softirq work is pending, handler #80!!!

Just to double check my understanding of things, I confirmed that the
v5.18-rt did print the pending-80 messages with a cherry pick of the
ratelimit fix, and then confirmed no pending softirq messages were
printed with a revert of mainline's 034569 on a v5.18-rt baseline.

Finally I confirmed it fixed the issue on v6.1-rt and v6.4-rt, and
also didn't break anything on a defconfig of mainline master of today.

Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
Cc: Wen Yang <wenyang.linux@foxmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2b865cb77feb..b52e1861b913 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1050,7 +1050,7 @@ static bool report_idle_softirq(void)
 		return false;
 
 	/* On RT, softirqs handling may be waiting on some lock */
-	if (!local_bh_blocked())
+	if (local_bh_blocked())
 		return false;
 
 	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",
-- 
2.40.0

