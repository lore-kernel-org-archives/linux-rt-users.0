Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC7BC2B9F4
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Jun 2021 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7286197C
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Jun 2021 16:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFYQLe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFYQLe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Jun 2021 12:11:34 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E9C061574;
        Fri, 25 Jun 2021 09:09:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o5so13141165iob.4;
        Fri, 25 Jun 2021 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=36ggmQ4tI+OtGXGakhOyfceWLv+royieh4bzkBLSgcA=;
        b=MPcazxvbedSKAHiw3HRnfPaIYcdxylc/tVc5IdYRP6gSpdDEdFh8QzC3FNGIiqHB9l
         B3cSfQSIvctIFWPUM4QqzWFu5bsOYdrPKwToIowJN+IEzA0P6/yAM3i0ng5x4Kxaa2uB
         /kYVhg5Kc46xN2s/R1cXkPLZpplA6TTsSvfmpeugU19aOHo5MHtGwpc58sm/j5sjrP01
         dOYLN5TCfcg6vRfAjsnnq2iaxegm9+3NzTvC3GmyAc+ZhQMZOtASboy1bQw+RxtQOXb0
         Xuv+BXXcVa19HCYdkQbKOcaPHblgYdPt9gcki4xVcHCC0AmCds9qO/VTIdHvx1l0TA8x
         BQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=36ggmQ4tI+OtGXGakhOyfceWLv+royieh4bzkBLSgcA=;
        b=hXDVIylH5sD2zePqUoCNSgxFIij1ts3CMEg9LySvcJ11TwbQXSkwZZSp4Q6/aTe81I
         UOFjkfOD6ai8a9PFXSkZ/3V41rYnZoGlvMSSTYjOhB3xonoJT6x2Ujq1F4bH695syDLW
         c/cdBjHhfPWxAYvdE4eNwM/GkBNjWuOGAygCcueY2tvHXqos4Q3vi4OCcaKR9miQEHCF
         3y2T1SzpGnEFo9K8BN9kFyHRgr5Q8H5N4MbFeQNXGGampkWewOtvIDhbAOMcBGL1mhVg
         Rkg6bn7iyCd1STXw2z1ZCVYLZ4VfnMnJWrA9b+KfJ5gAAdzQY1Z58w4ZEkFHoq57YfLk
         OxSQ==
X-Gm-Message-State: AOAM530IsyLVuionk+T4nLE0kqBWKOd5YrnAwNMp4y1DQjTwo8j2tV3z
        43RKFe1hHy6W2HOn37ubxYEXUhsivCmc1Q==
X-Google-Smtp-Source: ABdhPJzXBtlugblj7JrJQeQQu9Ye6ZhsIZFTMqGPFGblj385mgTTocy9u9ClbeIj+SsPPC9PkMrGzg==
X-Received: by 2002:a5e:980e:: with SMTP id s14mr9307720ioj.133.1624637351972;
        Fri, 25 Jun 2021 09:09:11 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-18.dsl.bell.ca. [184.147.142.18])
        by smtp.gmail.com with ESMTPSA id w7sm3930492ilu.74.2021.06.25.09.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:09:11 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Johnathan Schwender <schwenderjonathan@gmail.com>,
        Peter Xu <peterx@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.0
Date:   Fri, 25 Jun 2021 12:08:01 -0400
Message-Id: <20210625160801.9283-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm pleased to announce rt-tests-2.0

This release contains some interesting new features.

Daniel Wagner has been very busy doing more work to unify the various
programs in the rt-tests suite, and adding a feature to optionally
generate json output. Thanks for this great work Daniel

Jonathan Schwender added a cool new feature to specify the affinity of
the main thread separately from the measurement threads.

We had a few missteps too, we have long required libnuma for building
cyclictest but not at runtime. Unfortunately there were some patches
that broke the ability of cyclictest to run without libnuma, however I
am aware of the situtation and working to fix this.

Finally, the so called stable version branch has been dead a long time,
and the branch name unstable/devel/latest was the version that people
were using. That name was confusing though, "unstable"
meant that we were allowed to change the api, not that the code was
somehow unstable. In any case, in order to remove this confusion, I have
created a new default branch - main. I have deleted the "master" branch
which only contained a README file anyway as part of the community's
conscious language effort.

I decided that this new release was worthy of a bump-up to version v2.0
We could probably use a round of mostly testing and bug fixing for the
next release.

Bug reports, testing, patches are always appreaciated.

Enjoy!

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main

Tag: v2.0

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older


Daniel Wagner (77):
  cyclictest: Always use libnuma
  cyclictest: Use affinity_mask for steering thread placement
  pip_stress: De-constify prio_min
  ptsematest: Return correct exit code when showing help
  cyclictest: Remove libnuma API version 1 support
  cyclicdeadline: Add missing step command line argument
  cyclicdeadline: Remove unused struct thread_param
  cyclictest: Move verbose message into main
  signaltest: Always use libnuma
  rt-numa: Use error message helpers
  oslat: Use cpuset size as upper bound
  rt-tests: Rename error.h to rt-error.h
  rt-utils: Add JSON common header output helper
  cyclictest: Add JSON output feature
  cyclicdeadline: Add JSON output feature
  pmqtest: Add JSON output feature
  ptsematest: Add JSON output feature
  svsematest: Add JSON output feature
  oslat: Add JSON output feature
  rt-migrate-test: Add JSON output feature
  oslat: Add quiet command line option
  signaltest: Add JSON output feature
  sigwaittest: Add JSON output feature
  cyclictest: Fix printf format specifier
  cyclicdeadline.c: Fix printf format specifier
  cyclictest: Remove unused include header
  cyclicdeadline: Remove unused include header
  signaltest: Add missing --output usage info
  rt-util: Add rt_init function
  cyclictest: Initialize rt-util
  oslat: Initialize rt-util
  pmqtest: Initialize rt-util
  ptsematest: Initialize rt-util
  rt-migrate-test: Initialize rt-util
  cyclicdeadline: Initialize rt-util
  signaltest: Initialize rt-util
  sigwaittest: Initialize rt-util
  svematest: Initialize rt-util
  rt-util: Remove superfluous arguments from rt_write_json
  rt-util: Introduce rt_test_start()
  cyclictest: Record start of test execution
  oslat: Record start of test execution
  pmqtest: Record start of test execution
  ptesematest: Record start of test execution
  rt-migrate-test: Record start of test execution
  cyclicdeadline: Record start of test execution
  signaltest: Record start of test execution
  sigwaittest: Record start of test execution
  svsematest: Record start of test execution
  rt-util: Add return_code to common section of JSON output
  pi_stress: Prepare command line parser for long options only
  pi_stress: Add JSON output feature
  ssdd: Add quiet command line option
  ssdd: Add JSON output feature
  cyclicdeadline: Fix JSON output format
  cyclictest: Rename command line option --output to --json
  oslat: Rename command line option --output to --json
  pi_stress: Rename command line option --output to --json
  pmqtest: Rename command line option --output to --json
  ptsematest: Rename command line option --output to --json
  rt-migrate-test: Rename command line option --output to --json
  cyclicdeadline: Rename command line option --output to --json
  signaltest: Rename command line option --output to --json
  sigwaittest: Rename command line option --output to --json
  ssdd: Rename command line option --output to --json
  svsematest: Rename command line option --output to --json
  cyclictest: Add --json to man page
  oslat: Add --json to man page
  pi_stress: Add --json to man page
  pmqtest: Add --json to man page
  ptsematest: Add --json to man page
  rt-migrate-test: Add --json to man page
  cyclicdeadline: Add --json to man page
  signaltest: Add --json to man page
  sigwaittest: Add --json to man page
  ssdd: Add --json to man page
  svematest: Add --json to man page

John Kacur (11):
  rt-tests: rm scripts/do-git-push
  rt-tests: oslat: print version string
  rt-tests: oslat: Allocate memory for cpu_set
  Revert "cyclictest: Use affinity_mask for steering thread placement"
  Revert "cyclictest: Always use libnuma"
  Revert "signaltest: Always use libnuma"
  rt-tests: Don't assume numa is available at runtime
  rt-tests: remove rt_numa_bitmask_count in rt_numa.h
  rt-tests: cyclicdeadline.c: Remove dead code
  rt-tests: cyclictest: Add entry for mainaffinity in the manpage
  rt-tests: Change VERSION to 2.0

Jonathan Schwender (3):
  cyclictest: Fix --affinity when intermediate CPUs are offline
  cyclictest: Move main pid setaffinity handling into a function
  Subject: [PATCH v4 2/2] cyclictest: Add --mainaffinity=[CPUSET]
    option.

Peter Xu (1):
  oslat: Fix --cpu-list won't allow to schedule on all possible cores

 Makefile                              |   4 +-
 scripts/do-git-push                   | 115 --------------------
 src/cyclictest/cyclictest.8           |  10 +-
 src/cyclictest/cyclictest.c           | 110 ++++++++++++++++----
 src/cyclictest/rt_numa.h              |  14 +--
 src/include/pip_stress.h              |   5 +-
 src/include/{error.h => rt-error.h}   |   0
 src/include/rt-utils.h                |   8 ++
 src/lib/{error.c => rt-error.c}       |   2 +-
 src/lib/rt-numa.c                     |  23 ++--
 src/lib/rt-utils.c                    | 114 +++++++++++++++++++-
 src/oslat/oslat.8                     |   8 +-
 src/oslat/oslat.c                     | 143 +++++++++++++++++++------
 src/pi_tests/pi_stress.8              |   8 +-
 src/pi_tests/pi_stress.c              |  68 +++++++++---
 src/pi_tests/pip_stress.c             |   2 +-
 src/pmqtest/pmqtest.8                 |   5 +-
 src/pmqtest/pmqtest.c                 | 144 +++++++++++++++++++++-----
 src/ptsematest/ptsematest.8           |   5 +-
 src/ptsematest/ptsematest.c           | 130 +++++++++++++++++++----
 src/rt-migrate-test/rt-migrate-test.8 |   6 +-
 src/rt-migrate-test/rt-migrate-test.c | 122 ++++++++++++++++++----
 src/sched_deadline/cyclicdeadline.8   |   5 +-
 src/sched_deadline/cyclicdeadline.c   | 102 +++++++++++-------
 src/signaltest/signaltest.8           |   5 +-
 src/signaltest/signaltest.c           | 119 ++++++++++++++++-----
 src/sigwaittest/sigwaittest.8         |   5 +-
 src/sigwaittest/sigwaittest.c         | 121 ++++++++++++++++++----
 src/ssdd/ssdd.8                       |   5 +-
 src/ssdd/ssdd.c                       |  43 ++++++--
 src/svsematest/svsematest.8           |   5 +-
 src/svsematest/svsematest.c           | 129 +++++++++++++++++++----
 32 files changed, 1178 insertions(+), 407 deletions(-)
 delete mode 100755 scripts/do-git-push
 rename src/include/{error.h => rt-error.h} (100%)
 rename src/lib/{error.c => rt-error.c} (98%)

-- 
2.31.1

