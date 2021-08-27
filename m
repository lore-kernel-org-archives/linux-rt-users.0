Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2772C4320E
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99B060FD8
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhH0WDx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhH0WDw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:52 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7EC0613D9
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s15so3155019qta.10
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cP6N1VaiptIb9vw6Af18mwruH8OZKwMeAZ6m8vHjhms=;
        b=gBrS3jVykkX/2KvjfEcCRCLe75q5j6wi0PFdEoZhrOwWMIvdkXEvDsPURizsYibFzT
         Bf6RNMeH6lg0bpwFpvRrshANtw/n5KT4PnZmadO/pTf7ZhjsHSJQwpFRzIy9X+s/ZpG+
         XBUb91nT91HfSnaHjUP8H55+zA0i5VpPBemu4jJP3qlQ/Ocjad9LVpXuRCiHOTr8hsIF
         iLwKfEz5nV1ASFQnU9R5DFt5ztX0TFxksknkRvQKcdEP/6j0ATbsx917uRtF1/66AmHT
         FlzlrxgtxR2tv4h+FOoL2wQ4vnmgH/m89la5UMPSQqjlgSDI3ruC2htX3fQzY+Kv9SB9
         /5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cP6N1VaiptIb9vw6Af18mwruH8OZKwMeAZ6m8vHjhms=;
        b=Ad/Syi/xkckMAP8+73XWdyK89ZdN6dXX8DphnYSgKeWRtYim0by/iiNenGq17Unlij
         FGMUXIXVsidmNT7plZrZEHNtjIEIwbYF21UfwknPAnNeDo7xn7+gZN4oFz8leypduBBE
         GL5Kb8ehvmr9UG2wOqfgSQ6B3iORqm4z3nCpVlLTxjuAjxiFA5R+LEc7a06DDKvKXjvM
         KdF3Xx4YSJv2EUbBapJC6f7tubjMSwq02Of/06S6hf3GMDS6NKoWtPYKdKm4TLa7C9rS
         tCPIN8FqhjfDBo0O7mZh7m0Ipa3xCuO0qnoT12xYVFRjFDmrG80t+cH9weTWJY6+1Mj9
         vbpw==
X-Gm-Message-State: AOAM533zMF+ezCovfda9tAIXa/6bZU64WkaDyABy3dpQptwfdSZPjavB
        aL5KTqwrVntKOLWyqUnV/BA+URABmlY2Jw==
X-Google-Smtp-Source: ABdhPJzSmECvYx75Z0xBS+PXiKylZgljhcw8fjkVQohyjqYuvPsQCNa+DRTT/+QlgW5EnOSyMRehLw==
X-Received: by 2002:ac8:4b43:: with SMTP id e3mr10527532qts.312.1630101782209;
        Fri, 27 Aug 2021 15:03:02 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id t64sm5659209qkd.71.2021.08.27.15.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 15:03:02 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/8] rt-tests: deadline_test: Move va_start forward
Date:   Fri, 27 Aug 2021 18:02:37 -0400
Message-Id: <20210827220244.24210-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827220244.24210-1-jkacur@redhat.com>
References: <20210827220244.24210-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If open_cpuset fails then we return without calling va_end
Fixing this by moving the call to va_start after that.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/deadline_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index a48c231c1281..e89654d976f2 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -728,12 +728,12 @@ static const char *make_cpuset(const char *name, const char *cpus,
 		int *pids;
 		int i;
 
-		va_start(ap, flags);
-
 		fd = open_cpuset(path, "tasks");
 		if (fd < 0)
 			return "open tasks";
 
+		va_start(ap, flags);
+
 		ret = 0;
 		pids = va_arg(ap, int *);
 
-- 
2.31.1

