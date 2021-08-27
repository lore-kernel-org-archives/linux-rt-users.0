Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D1AC4320A
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953D260FD8
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhH0WDy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhH0WDx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:53 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39FBC0613D9
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:03 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id g11so4855682qvd.2
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ki5gKanHc/6SrH1KESGFA/4Q+WIhVq9LGnfQW4Yox30=;
        b=IiHt/e561u7FEOsHFoD8zzIrNGXQPATq1gaFhrZ+nO6wPHHW2ItmQ458sHczqiu3JF
         dBLNC//4SwGRbO2xWjY191P9x239pILUKHOZSCvblQkxktf4bcV/KhbTmvHJiyhrW8mZ
         BGC5685L0CeFJyMXudr1z4Jzno1CmQF3ahk1TD9aEYZD+cLEEPbWBkCMNMq4H9qAa2jM
         AbZYkj9UOQOCEAA8EDZkDeqmLKbon+f31k8J5s9SrcrvsB0s+vhWKo2GG7wdypPfE5aO
         RgAq87LMeHkkKaJtX4ZLDiYeh3dGD96UnSOeICdzCSKj1192LIq8bpSs9jKuOp9eVAMw
         lS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ki5gKanHc/6SrH1KESGFA/4Q+WIhVq9LGnfQW4Yox30=;
        b=WO7FNGKsmktjYwQWE1EY2RqnGwrayJqNIUQ6q44LQTBvECg4DH/firG8ZEICOXraSF
         IzThs5QPCKptjonj0e6SjKZLJX+CbGD+EMQ0J91sJbHoJpoxhNrG4v96jETCHqenjUtc
         p6FAL/SCPbhmGkF3s36REW8igg/PJPRtwkg1U4+VUvSAq2tz0Z/CXGlVdNWT0mlL70TJ
         UJ56/uBhLL1Kk+RgIrsAAIjBtrhI5/0ssZVJ2i5IiIPNv5L1J0xu2sOB6hOxIxGH+E+p
         70+oPyZ9j8HT76j2WkcT3Zo9GrBQGOIG9O+C1jf01jzvd2o7DGG7DxkqdkipiJyxWkYR
         X1eA==
X-Gm-Message-State: AOAM531VFU/LiAR5mrR+lCccg94Z4P4eLMFFg8bLBtrJYjwH0BXUVXqe
        tv01sqpgjAyK5Kdy92TQh6icJANkryXpnQ==
X-Google-Smtp-Source: ABdhPJxYGtt45LNTuTn00HZ37W9VR+NPz+LKMthg7YeWpGVI5RFxtTP67BzO4vooAWt5VjEg+Gc9bw==
X-Received: by 2002:a0c:9c4d:: with SMTP id w13mr10818625qve.43.1630101782771;
        Fri, 27 Aug 2021 15:03:02 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id t64sm5659209qkd.71.2021.08.27.15.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 15:03:02 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/8] rt-tests: deadline_test: Remove deadcode
Date:   Fri, 27 Aug 2021 18:02:38 -0400
Message-Id: <20210827220244.24210-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827220244.24210-1-jkacur@redhat.com>
References: <20210827220244.24210-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove deadcode that was probably accidently left in during development.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/deadline_test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index e89654d976f2..1763c71486a9 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -873,10 +873,6 @@ static void destroy_cpuset(const char *name, int print)
 			goto again;
 		fprintf(stderr, "Failed to remove %s\n", path);
 		perror("rmdir");
-		if (retry++ < 5) {
-			fprintf(stderr, "Trying again\n");
-			goto again;
-		}
 	}
 }
 
-- 
2.31.1

