Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3178FC83004
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 19:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112D221707
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 19:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588103582;
	bh=oG2f6dzmEz7bbUybEdJ/ooqWsbcgtbdAv/rK9Fjh02w=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=iS4n3R05izaec7w69WFQBLq3jhSqAosNBkHvWK84UpxPmAoi40YL8ZVTN49+VzT8S
	 gVWMeyCRYhLXuPItZKeP+7gXqYIukaG7EyH4SnoUP8/WDajuJED3OPdi5odnWH9tIy
	 3ZKW1Tc07YhBXN9VRsDdiZs7gsHN600UfJmsnL8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgD1TxB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgD1TxA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 15:53:00 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CC621835;
        Tue, 28 Apr 2020 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588103579;
        bh=oG2f6dzmEz7bbUybEdJ/ooqWsbcgtbdAv/rK9Fjh02w=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Ec1KqX0ioPkp27bIb69l4pde6SJkVsCF1BOFWz+RagSv5xYq/G2hLFv10J6eIGrZl
         baWLHICSLj3O4miCOcaFgH9dN6W7k2rNHG6swWM6VsLMo1Sik4QeRFDPAwJq1vnZeE
         +/BdbMZ2RnSEbqqHQiL+MA48J2/57Ua7Fps3V2Ys=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH RT 1/2] hrtimer: fix logic for when grabbing softirq_expiry_lock can be elided
Date:   Tue, 28 Apr 2020 14:52:55 -0500
Message-Id: <e342baf3a1e01475391e9171b45ef5a09e85ed9e.1588103561.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1588103561.git.zanussi@kernel.org>
References: <cover.1588103561.git.zanussi@kernel.org>
In-Reply-To: <cover.1588103561.git.zanussi@kernel.org>
References: <cover.1588103561.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

v4.19.115-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Commit

  hrtimer: Add a missing bracket and hide `migration_base' on !SMP

which is 47b6de0b7f22 in 5.2-rt and 40aae5708e7a in 4.19-rt,
inadvertently changed the logic from base != &migration_base to base
== &migration_base.

On !CONFIG_SMP, the effect was to effectively always elide this
lock/unlock pair (since is_migration_base() is unconditionally false),
which for me consistently causes lockups during reboot, and reportedly
also often causes a hang during boot.

Adding this logical negation (or, what is effectively the same thing
on !CONFIG_SMP, reverting the above commit as well as "hrtimer:
Prevent using hrtimer_grab_expiry_lock() on migration_base") fixes
that lockup.

Fixes: 40aae5708e7a (hrtimer: Add a missing bracket and hide `migration_base' on !SMP) # 4.19-rt
Fixes: 47b6de0b7f22 (hrtimer: Add a missing bracket and hide `migration_base' on !SMP) # 5.2-rt
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e54a95de8b79..c3966c090246 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -953,7 +953,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (timer->is_soft && is_migration_base(base)) {
+	if (timer->is_soft && !is_migration_base(base)) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
-- 
2.17.1

