Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE7C43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 03:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEA1218FC
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 03:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfCVDVZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:21:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbfCVDVZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Mar 2019 23:21:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6591B4E938;
        Fri, 22 Mar 2019 03:21:25 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-118-18.phx2.redhat.com [10.3.118.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B7EA19C5A;
        Fri, 22 Mar 2019 03:21:21 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT 4.19] rcutorture: Fix oops when selecting non-default torture_type
Date:   Thu, 21 Mar 2019 22:21:21 -0500
Message-Id: <20190322032121.23948-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 22 Mar 2019 03:21:25 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rcu_bh is disabled on PREEMPT_RT via a stub ops that has no name.  Thus,
if a torture_type other than "rcu" is used, rcu_torture_init() will
pass NULL to strcmp() when iterating over torture_ops[], and oops.

Signed-off-by: Scott Wood <swood@redhat.com>
---
With this applied to 4.19.25-rt16 and specifying torture_type=sched,
similar rcutorture failures are seen as with 5.0.3-rt1 (in which standard
torture_cype=rcu no longer has .extendables=0 and thus stresses similar
paths).

 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7d2a615601e7..408d03048911 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -479,6 +479,7 @@ static struct rcu_torture_ops rcu_bh_ops = {
 #else
 static struct rcu_torture_ops rcu_bh_ops = {
 	.ttype		= INVALID_RCU_FLAVOR,
+	.name		= "rcu_bh"
 };
 #endif
 
-- 
2.18.1

