Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CF8C11F67
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Jun 2021 03:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0B461D07
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Jun 2021 03:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhF3D0b (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 23:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhF3D03 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Jun 2021 23:26:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0159C061760;
        Tue, 29 Jun 2021 20:24:00 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f13so491598qtb.6;
        Tue, 29 Jun 2021 20:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IzYfIbSH+BtK6NX8sZPey5wWb+kKK+4WjltH9j9ILrU=;
        b=fCvY0xuDWPHkB9aAw6vN6eSm2JCrKCHZwc+GewZFFA8/oe4Hqwovjg2Unji/GvVUSD
         81flcHqj339pGWfhSvLUt/TifoBJiOVpZgFCnhbEpEoJ5IUiPQjF+5qndZTsMZAZOAKX
         B989y/q/kSoZClNMXn+FRnTzNWmhgi/NsXcNYF3j5vf5q5yOps2Ku2GedQVq8ROmjkRa
         +I/BwzDTJf4kEpFGebB56nWEze1RSCZjbc+THNNl8jXgPqcqOMJzdumuDV10SMEp3Z8i
         y2FrPiOjOha47EGk+P9pEPuP8GfoLYfOVQpYDWlPzltoVVl2h2Ht+bUuVYFGovvW8Rok
         3qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IzYfIbSH+BtK6NX8sZPey5wWb+kKK+4WjltH9j9ILrU=;
        b=F8lqjBZC6S9YSJVtoOYmZIzQDMPBbvzTcssnc+N/TUKgapJG8zkzYNuTPCTdFXeyVn
         Gb+46X/Gs50h4Zpvt0SN+Gm0VdoKkedoSjBkywtD1NZ0Z6sYGSWTuZv9+KaNGOQxI++s
         uzU7CwcBupGqcvroBKPjyaI8naXL3AhzfFnKXiwOBU5d7wvqjzgL2uGkRwToaggu2ZsG
         Pc7xqb042D2mfRqO9nI1Bh1TLOAnxoY+JpG8tHzT3gFcJv990U8N9eUtxhwTHXptRvZC
         kCrTFey/T8tNKHiDMjpqvdnJwV71aQxBLVSHG5Ec0cZJxvMlAqbKPAsGJFbkEETbZzVT
         9y+Q==
X-Gm-Message-State: AOAM533NWi+rmyhTkLuIUGCFS57lJqmboKmtiTvE0kCxP/CrdrUO+hOd
        ARX5dkYccjwHg/TK/n/WM/ibIF9I18ntuQ==
X-Google-Smtp-Source: ABdhPJyNnjXL70B3iyOdbm3RNMcb5ZGqvt9LRsfETveKuAQXFLDsycsDQZvZ4NFaXSjwU7ZHSh5nXQ==
X-Received: by 2002:ac8:5784:: with SMTP id v4mr25533183qta.29.1625023439645;
        Tue, 29 Jun 2021 20:23:59 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-10-174-88-120-156.dsl.bell.ca. [174.88.120.156])
        by smtp.gmail.com with ESMTPSA id e6sm8106457qkg.12.2021.06.29.20.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 20:23:59 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.1
Date:   Tue, 29 Jun 2021 23:23:30 -0400
Message-Id: <20210630032330.17973-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This release just contains the fix for the problem reported and
investigated by Mike Galbraith. Thanks Mike

The solution was to move the get_timestamp() call to the ramp up phase
before the actual benchmark starts.

Bug reports, testing, patches are always appreciated.

Enjoy!

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main

Tag: v2.1

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Daniel Wagner (2):
  rt-utils: Call get_timestmap() in rt_init()
  rt-utils: Remove empty rt_test_start()

John Kacur (1):
  rt-tests: Change VERSION to 2.1


 Makefile                              |  2 +-
 src/cyclictest/cyclictest.c           |  1 -
 src/include/rt-utils.h                |  2 --
 src/lib/rt-utils.c                    | 29 ++++++++++++---------------
 src/oslat/oslat.c                     |  1 -
 src/pi_tests/pi_stress.c              |  1 -
 src/pmqtest/pmqtest.c                 |  1 -
 src/ptsematest/ptsematest.c           |  1 -
 src/rt-migrate-test/rt-migrate-test.c |  1 -
 src/sched_deadline/cyclicdeadline.c   |  1 -
 src/signaltest/signaltest.c           |  1 -
 src/sigwaittest/sigwaittest.c         |  1 -
 src/ssdd/ssdd.c                       |  1 -
 src/svsematest/svsematest.c           |  1 -
 14 files changed, 14 insertions(+), 30 deletions(-)

-- 
2.31.1

