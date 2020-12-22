Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE8C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Dec 2020 22:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71DF22AAF
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Dec 2020 22:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgLVWIS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 22 Dec 2020 17:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgLVWIS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 Dec 2020 17:08:18 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE73C0613D6;
        Tue, 22 Dec 2020 14:07:37 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id h4so13402499qkk.4;
        Tue, 22 Dec 2020 14:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVsqnRWq5YVDyYM+9ouMmzNX+6gKBrIxdO9dwgcVlc0=;
        b=VKJ/hKsV7L80oATwiEzh781xkwXQrn95cwNJzp62RS8cSUtg6xsa6Po8Fs9MQ8AUiA
         dR7tT3JGUje99Bx6/zM6L5rgtK6+BptIhYLl2/Sg+8cyiYR0Qb8DQAngK/FCbwk/T+pT
         KGBblgOEWChiWFNvsP3cDHkwTQFXF0wjeP66m3P30fvpdP9vwa//4JeKttj+GjG+ySTr
         7S3fiibv6xdGRmS0bvoTHnhoJBMUUGjiNzurv2HwDzqeddSWtX1qBO2SOO6YNKYePJU+
         MSlgKQzscULlI+5AGkVGfgyJf7mU3MJsUA39ZENwgIIURadzH0eCOcDALu+Yw8blCEt3
         Yaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wVsqnRWq5YVDyYM+9ouMmzNX+6gKBrIxdO9dwgcVlc0=;
        b=kTV9H9CNng1FdK1LpMO24Wd8huo/pap0240MXFvgXi64omcfldB6WgOFwZohcUz9Sj
         Nv/Mc249dCii4P9NcKpG0rD3GvqIb0rusBz8H32mSof702lgWe5lD+G24I0L3c5wms+I
         aYKrL8rVf/BqCndGWk+l1PmSYo8PXpMAtKbJyApnp5M3Gd0R0PRSXyAIywfPKR/jk4mM
         8M/qNaHznMTGzLEOnsFL+G8FfvKKcpFV5dwSDO8S9I3ELrK/Voc1wXkI02n0oWmESlOA
         ctlRVn7jGlyXtdELdLA7c3A4CLatPNedqTd/l2X14WxlxGh4xMAZOoO1E2dTXL26abgo
         MJTA==
X-Gm-Message-State: AOAM532Kr+4IpaJygh9R6G+2n4WdOFYriprHPLU1CdRcaDRlhOyjqvjm
        fuLK+tPnxCUhJtisUZOnEvfrqBPEat4OnIqI
X-Google-Smtp-Source: ABdhPJxlD7C7mj1kU68NXtnVAVmbbVhc3DaEcqcv5NF5KhElG8Q6d1Eie7Eb1gMAZsce75mxvKlNZA==
X-Received: by 2002:a37:8481:: with SMTP id g123mr23269087qkd.173.1608674856866;
        Tue, 22 Dec 2020 14:07:36 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id l24sm14133716qkl.46.2020.12.22.14.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 14:07:36 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-1.10
Date:   Tue, 22 Dec 2020 17:07:24 -0500
Message-Id: <20201222220724.13052-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT Folks,

I'm pleased to announce rt-tests-1.10

To download rt-tests:
using git, clone one of the following
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

The latest tag is v1.10
The correct branch is unstable/devel/latest

Tarballs are also available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Your fixes, development patches, comment and bug reports are always welcome!

Enjoy!

John Kacur

Anders Roxell (1):
  Makefile: manpages: only add get_cyclictest_snapshot if PYLIB

Daniel Wagner (36):
  cyclictest: Use numa library helpers in get_available_cpus()
  cyclicdeadline: Streamline usage output and man page
  cyclicdeadline: Add long command line options
  deadline_test: Streamline usage output and man page
  oslat: Streamline usage output and man page
  pip_stress: Add command line parser
  pi_stress: Streamline usage output and man page
  pmqtest: Streamline usage output and man page
  ptsematest: Streamline usage output and man page
  queuelat: Streamline usage and man page
  rt-migrate-test: Streamline usage and man page
  signaltest: Streamline usage and man page
  sigwaittest: Streamline usage and man page
  ssdd: Streamline usage and man page
  svsematest: Streamline usage and man page
  hackbench: Streamline usage and man page
  rt-utils: Introduce parse_mem_string()
  oslat: Use string parser utilies
  cyclictest: Remove deadcode checking for NUMA
  rt-numa: Introduce NUMA helpers
  cyclictest: Use parse_cpumask() from rt-numa.h
  oslat: Use parse_cpumask() from rt-numa.h
  rt-numa: Move thread placement code to rt-numa library
  signaltest: Implement thread placing
  cyclicdeadline: Remove dead code
  cyclicdeadline: Use common error handlers
  cyclicdeadline: Add quiet command line option
  pmqtest: Move statictic output into print_stat()
  pmqtest: Add quiet command line option
  ptsematest: Move statictic output into print_stat()
  ptsematest: Add quiet command line option
  svsematest: Move statictic output into print_stat()
  svsematest: Add quiet command line option
  sigwaittest: Move statictic output into print_stat()
  sigwaittest: Add quiet command line option
  rt-migrate-test: Add quiet command line option

John Kacur (24):
  rt-tests: makefile: undefine PYLIB if empty
  rt-tests: queuelat: Remove unused variable 'index'
  rt-tests: remove pi_tests.spec
  rt-tests: cyclictest: A few style changes from checkpatch.pl
  rt-tests: rt-sched.c: Style change
  rt-tests: rt-utils.c: Correct mix of spaces and tabs in code
    indentation
  rt-tests: pi_stress.c: Change unsigned to unsigned int
  rt-tests: pip_stress.c: Remove unnecessary brackets
  rt-tests: pmqtest.c: Fix spacing around parentheses
  rt-tests: ptsematest.c: Fix spacing around parentheses
  rt-tests: queuelat.c: Fix various style problems
  rt-tests: rt-migrate-test.c: Fix spacing around parentheses
  rt-tests: cyclicdeadline.c: Fix spacing around commas
  rt-tests: deadline_test.c: Fix spacing around commas
  rt-tests: signaltest.c: Fix various style problems
  rt-tests: sigwaittest.c: Fix spacing around brackets
  rt-tests: ssdd.c: Remove unncessary "else"
  rt-tests: svsematest.c: Fix various style problems
  rt-tests: Don't compress man pages by default
  rt-tests: determine_maximum_mpps.sh: Add a menu to get user settings.
  rt-tests: queuelat: Remove get_cpuinfo_mhz.sh and old Makefile
  rt-tests: queuelat: Add a manpage for determine_maximum_mpps.sh
  rt-tests: determine_maximum_mpps.sh: Change the -c option to -a
  rt-tests: Makefile - update version to v1.10

Kurt Kanzenbach (4):
  rt-tests: rt-utils: Mark internal functions static
  rt-tests: rt-utils: Add function to close trace fds
  rt-tests: cyclictest: Close correct trace fds
  rt-tests: oslat: Close trace fds

Peter Xu (1):
  rt-tests: oslat: Allow build for not supported archs

Sebastian Andrzej Siewior (4):
  cyclictest: Only report the first incident
  signaltest: Remove drunk code
  signaltest: Don't expect trace interface at /proc
  signaltest: Fix break value argument

 Makefile                               |  36 ++--
 src/cyclictest/cyclictest.c            | 276 +++++-------------------
 src/hackbench/hackbench.8              |  70 +++---
 src/hackbench/hackbench.c              | 102 +++++----
 src/include/rt-numa.h                  |  21 ++
 src/include/rt-utils.h                 |   2 +
 src/lib/rt-numa.c                      | 135 ++++++++++++
 src/lib/rt-sched.c                     |   2 +-
 src/lib/rt-utils.c                     |  60 +++++-
 src/oslat/oslat.8                      |   2 +-
 src/oslat/oslat.c                      | 210 ++++++------------
 src/pi_tests/pi_stress.8               |  79 ++++---
 src/pi_tests/pi_stress.c               | 152 +++++++------
 src/pi_tests/pi_tests.spec             |  81 -------
 src/pi_tests/pip_stress.c              |  40 +++-
 src/pmqtest/pmqtest.8                  |   8 +-
 src/pmqtest/pmqtest.c                  | 190 ++++++++--------
 src/ptsematest/ptsematest.8            |   8 +-
 src/ptsematest/ptsematest.c            | 167 ++++++++-------
 src/queuelat/Makefile                  |   9 -
 src/queuelat/determine_maximum_mpps.8  |  64 ++++++
 src/queuelat/determine_maximum_mpps.sh |  90 +++++++-
 src/queuelat/get_cpuinfo_mhz.sh        |   7 -
 src/queuelat/queuelat.8                |  41 ++--
 src/queuelat/queuelat.c                | 158 +++++++-------
 src/rt-migrate-test/rt-migrate-test.8  |  41 ++--
 src/rt-migrate-test/rt-migrate-test.c  |  92 ++++----
 src/sched_deadline/cyclicdeadline.8    |  27 +--
 src/sched_deadline/cyclicdeadline.c    | 286 +++++++++++--------------
 src/sched_deadline/deadline_test.8     |  37 ++--
 src/sched_deadline/deadline_test.c     |  72 +++----
 src/signaltest/signaltest.8            |  31 ++-
 src/signaltest/signaltest.c            | 219 ++++++++++++-------
 src/sigwaittest/sigwaittest.8          |   4 +-
 src/sigwaittest/sigwaittest.c          | 212 +++++++++---------
 src/ssdd/ssdd.8                        |  35 ++-
 src/ssdd/ssdd.c                        |  54 ++---
 src/svsematest/svsematest.8            |   9 +-
 src/svsematest/svsematest.c            | 244 ++++++++++-----------
 39 files changed, 1747 insertions(+), 1626 deletions(-)
 create mode 100644 src/include/rt-numa.h
 create mode 100644 src/lib/rt-numa.c
 delete mode 100644 src/pi_tests/pi_tests.spec
 delete mode 100644 src/queuelat/Makefile
 create mode 100644 src/queuelat/determine_maximum_mpps.8
 delete mode 100755 src/queuelat/get_cpuinfo_mhz.sh

-- 
2.26.2

