Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84650C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 02:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A3576102A
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 02:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbhHaC3J (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbhHaC3I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Aug 2021 22:29:08 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E091C061575
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Aug 2021 19:28:14 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bk29so18003429qkb.8
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Aug 2021 19:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iZaupMfVbIAy3LE/9Qboh7lDKVLEiZWe8sxAEsALsUc=;
        b=quL/Iwmx4yUtpNGD4GXu9B/JAlePsWhhVznFaPkaB64s1O4be30UW5qndmTtSJlSkH
         au7e0AB4yjzTBwY1qtY4MrzYl7OL0RvnZQ3LTjfXX7igZP5Ydrd8VBiZBoPNLorgl3V9
         6dQZ7kZZ/pCSPvyljh/CH3/HuYbF7sQSMLdxFq3qiSUwEOtFpjBy6uKokdaRZFoAqAtk
         8Rw7rhClIkTSL6XM+We9srtE0wqaPKKK6aiK0PAJs8qz60rxJBAUnjv2QjprIhvji87p
         oMP3LnMsLwXO/k8mnPZTkQcsBVpGvKiw3xCkxPFjWsNeMdA0s9L6sTpzec6dQsJfTV5d
         oKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=iZaupMfVbIAy3LE/9Qboh7lDKVLEiZWe8sxAEsALsUc=;
        b=ptIKMYuQIw8/Y9KfM3Cd4FiyBC0RNQrORu74st9F7+3Ug1+adbuN11atzw+NWjgpVB
         vONiuxACIKRqP73NR6k14TvgLVx5Fpp3OEUx9eODqRns6Aazp51hLSnNaAxl+SWElh7B
         daArivJzDwRL2QNJqC7GQiKPSyuH2u7hyLlfSxAAElGlWv7HLXg/KfCvrVieZH6EvfgU
         WB5AMjlFPbqUVf31WifHPbFSwb2F/MrwiSlJa9ZEaLZZTFgOmxntKtr2be2f9VGVHGcB
         vjYfChfs2crI4faC7jkk+xCwUJYVZ9gMjk3332w2z0myfTcMNhBtmwf5/pO58enoDxPz
         P/Bg==
X-Gm-Message-State: AOAM5306njq9o3Li4cfAOQX/P3mRNH/iXHUr4Kj0Yy9M2tNO+ewJZzPv
        VMt6NffPljOFWIZ+n5MJK59rc8wVTCPmWA==
X-Google-Smtp-Source: ABdhPJzQatMOeKsPkkT9J0zeCU4WFtCVLyW5xAoG5CLcUAJwfn6sbaHCUOQAR4AhHlqlVWwsTDyjgA==
X-Received: by 2002:a37:db0a:: with SMTP id e10mr780564qki.259.1630376893310;
        Mon, 30 Aug 2021 19:28:13 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id p187sm12417527qkd.101.2021.08.30.19.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 19:28:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.2
Date:   Mon, 30 Aug 2021 22:27:47 -0400
Message-Id: <20210831022747.26140-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm pleased to announce rt-tests-2.2

v2.2 mostly contains some small fixes.

There is also Daniel Wagner's change to use sched_getaffinity to help with static compiling for the LAVA project.

I made a few changes in the deadline tests (sched_deadline and
deadline_test) to accomodate the new location of the HRTICK file and to
use the HRTICK_DL feature if available, based on some changes in stalld

Finally there is a patch from Nicolas Saenz Julienne for oslat to ensure
that CPUS are out of idle and running at max frequency before starting
test measurements of latencies.

Bug reports and patches are always welcome.

Enjoy!

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main

Tag: v2.2

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older


Daniel Wagner (3):
  signaltest: Fix printf format specifier
  cyclicdeadline: Fix buffer allocation
  rt-numa: Use sched_getaffinity() instead of pthread_getaffinity_np()

John Kacur (10):
  sched_deadline: Accommodate new location of HRTICK file in kernel
  sched_deadline: Use HRTICK_DL for sched_deadline tests
  rt-tests: deadline_test: Move va_start forward
  rt-tests: deadline_test: Remove deadcode
  rt-tests: ptsematest: Remove deadcode
  rt-tests: pi_stress: Don't call free on alloca
  rt-tests: pip_stress: Add missing paramater in error message
  rt-tests: pi_stress: Add missing parameter and fix types
  rt-tests: deadline_test: Exit with message if threads less than 1
  rt-tests: Change VERSION to 2.2

Nicolas Saenz Julienne (2):
  oslat: Remove redundant include
  oslat: Don't take trace_threshold into account during preheat

 Makefile                            |   2 +-
 src/lib/rt-numa.c                   |   6 +-
 src/oslat/oslat.c                   |  12 ++--
 src/pi_tests/pi_stress.c            |  12 ++--
 src/pi_tests/pip_stress.c           |   2 +-
 src/ptsematest/ptsematest.c         |   6 --
 src/sched_deadline/cyclicdeadline.c |  94 +++++++++++++++++++------
 src/sched_deadline/deadline_test.c  | 102 +++++++++++++++++++++-------
 src/signaltest/signaltest.c         |   6 +-
 9 files changed, 171 insertions(+), 71 deletions(-)

-- 
2.31.1

