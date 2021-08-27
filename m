Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8EBC432BE
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E4B60EFE
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhH0WDw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0WDv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:51 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED34C0613D9
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:02 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 2so1971531qtw.1
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwcXYVFxK3XO039RVzLpjw3OVk33r+HbM1M41mi0niE=;
        b=Hw5NSpcEU1d2FfKJP4Cftd/ovwHvv9cbmbkXz8sPwJ4vFVBW8tDyyMbo9pPpYPaTAI
         ajsU9LBEHpl/HQTJdFuw0mc3DAuEImBq6VfLFn/0/w1nb7nPIJfWvJacVP6W0C+ene82
         rBf9f0AGaxeBFKKoRI/WZNVzxf+vDZJB0gMZ7gYnZgz8F8RpXI/LJZp2tG3z3+ed5dSC
         7amkZaXTmlNp/VwjgddV9PYiAyDugz7G20i0re7KfjUyMHcdq9rSepeJ7iGAVyuti1Ne
         2lvHgZMcdSDBwvu1GywmdUqXwz1oNGO+csNo/TntLxglkWCD9Qsup7Oa2vJ6gp5whA9X
         Keow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NwcXYVFxK3XO039RVzLpjw3OVk33r+HbM1M41mi0niE=;
        b=pzOuBtBvVpgYpDfkfjohA8Rj3xIKqICH63e6RCCrF8EJ1YKsgHz0Py52JgzAffzgGU
         xGR6+VDvWyJuzBToSpdlf99/M2N1kpWe/4WCKXSCDGXoFlL1adeOnqQzdFbKYtoRlB7E
         mBjtb67da3DwAvpaxUkqq5xbvsFEy+VaFhMHj6ql2KBRmeDE7mPCIXo9etkHJKdwpyvT
         kIb+G5p6mF6uXIlzB7E39I3Izwly9Im+h03iOtz1eqhtvPKlpvjsshcKt/BPZ1MKaNWg
         FTpLO1wPkzLPKsxug0ZuFSNwLpUosun9pEH5Yy5FWTcvj2zFP+yPQkiWmw/GbD0aaCwr
         3TIA==
X-Gm-Message-State: AOAM532dZaCXea7HPpjxOloQQizf5nL+HWXlV+kWTS2RSfef0vo2L2U0
        lzT3K2lTLEKLF4Bhv54prjP0NRyGttMyXA==
X-Google-Smtp-Source: ABdhPJxJHVWLZGxug6LJn0YqkLTm7m8SyDbBIyQJpYZmGyiqf0/LZ5VQFcYxOuxES+ynJkkPNNB0AA==
X-Received: by 2002:ac8:44aa:: with SMTP id a10mr10237737qto.63.1630101781623;
        Fri, 27 Aug 2021 15:03:01 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id t64sm5659209qkd.71.2021.08.27.15.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 15:03:01 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/8] Some miscellanous fixes
Date:   Fri, 27 Aug 2021 18:02:36 -0400
Message-Id: <20210827220244.24210-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Just a few miscellanous fixes here, nothing big.

Daniel Wagner (1):
  rt-numa: Use sched_getaffinity() instead of pthread_getaffinity_np()

John Kacur (7):
  rt-tests: deadline_test: Move va_start forward
  rt-tests: deadline_test: Remove deadcode
  rt-tests: ptsematest: Remove deadcode
  rt-tests: pi_stress: Don't call free on alloca
  rt-tests: pip_stress: Add missing paramater in error message
  rt-tests: pi_stress: Add missing parameter and fix types
  rt-tests: deadline_test: Exit with message if threads less than 1

 src/lib/rt-numa.c                  |  6 ++----
 src/pi_tests/pi_stress.c           | 12 ++++--------
 src/pi_tests/pip_stress.c          |  2 +-
 src/ptsematest/ptsematest.c        |  6 ------
 src/sched_deadline/deadline_test.c | 13 +++++++------
 5 files changed, 14 insertions(+), 25 deletions(-)

-- 
2.31.1

