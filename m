Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DECC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F234A61267
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhKKUpU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbhKKUpT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:19 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415EBC061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:30 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id j17so6527471qtx.2
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46vtULk9l03ohV75J2qJG7sIz/1R6e6jU3tG3Bv73cE=;
        b=HhsmqLBQ1tx6rrnnh0oP1PX2FN0dJMO5OJ+y+Yjz1ck6Xcos0/iHc3dt1BGagpHia0
         hJbIBLC3e4sD6q4WVKZbBlkoiMDEMJj0HsWVw3UBWR3HKioLrSx42RZlcmWm2kYwDe0c
         rbi913SRx95CJXwGDO65sQQ0hpDhx3IzT9sShmzde1AtpUoZKYKT9ut18w9/OJUONPGT
         rJaIH+bwqxYa83nMbbXyrFyt+Q18ALkGAx41adxrv5tmQ0KIiVBOwa4hAtgW2D1tGYx2
         E1YF+pmopj09oL4iyPSFquAYl47KJw3K9TRWEDWaGnCW4TdTWBcnCVsJrAj3SFgzcwmE
         rNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=46vtULk9l03ohV75J2qJG7sIz/1R6e6jU3tG3Bv73cE=;
        b=yVfNSwpiwp/hCSTPQCPmhuXoAQlnko6rdk49NcGoGI5r4An1Vn02Y5ud+PAFBRbx24
         iFIkMG9eNyUwuEcrzeuoNXBJ7RhgiOK54bx3XcpyVXwowynzmZRIibi8udeGCMyC0mlJ
         Obat5rsLjoj5FdGuMzafmxZLjXn4scnGeeC01UW2eA1KIkxXqyrYGXMGrknvepTWaH3y
         uuYXlY9OxVODfh3jioQqeYNvDvwHegklPkJK1NC/cK0YGxMtYALFwLQBMRO4gjDUg2OP
         wT82SZ+BbrR5c6TZTihSTn4ck+1DCaY0pE2mIunr5TVa5bgTuCePBG5oV+NnybCtAa5m
         ERXw==
X-Gm-Message-State: AOAM531F78LORlnwU/yGXlrntrTT7DzzWR+1erMXgtxVM92BvK7YYVii
        9lKLIflwNxFoq21zg2jpwL2lBGcZHao=
X-Google-Smtp-Source: ABdhPJx7hgAIUE2QVttZtP1EtRh5EvSaXPk9fPUXzgo8DH+dJX4JlXdwRlXXXYFGPWOzD7OlzEQWMw==
X-Received: by 2002:ac8:5f53:: with SMTP id y19mr11028659qta.97.1636663349133;
        Thu, 11 Nov 2021 12:42:29 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:28 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 04/17] rt-tests: deadline_tests: Null check to prevent floating point exception
Date:   Thu, 11 Nov 2021 15:41:54 -0500
Message-Id: <20211111204207.10167-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix a floating point exception that can occur if sd->nr_adjust is 0
by checking it before performing a division by zero.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/deadline_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 53abd4d2ca6b..b7e1e045b57c 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -2050,8 +2050,10 @@ int main(int argc, char **argv)
 		printf("missed deadlines  = %d\n", sd->missed_deadlines);
 		printf("missed periods    = %d\n", sd->missed_periods);
 		printf("Total adjustments = %lld us\n", sd->total_adjust);
-		printf("# adjustments = %lld avg: %lld us\n",
-		       sd->nr_adjust, sd->total_adjust / sd->nr_adjust);
+		if (sd->nr_adjust) {
+			printf("# adjustments = %lld avg: %lld us\n",
+			sd->nr_adjust, sd->total_adjust / sd->nr_adjust);
+		}
 		printf("deadline   : %lld us\n", sd->deadline_us);
 		printf("runtime    : %lld us\n", sd->runtime_us);
 		printf("nr_periods : %lld\n", sd->nr_periods);
-- 
2.31.1

