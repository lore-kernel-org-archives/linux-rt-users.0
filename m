Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECA5C433DB
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0C06192F
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCTSjE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:51808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCTSic (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 821E3AAB8;
        Sat, 20 Mar 2021 18:38:31 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 00/33] JSON cleanups and more tests updated
Date:   Sat, 20 Mar 2021 19:37:56 +0100
Message-Id: <20210320183829.1318-1-dwagner@suse.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v3:
  - rebase
  - two patches splitted into per test program change
  - commit messsage added
  
v2:
  - added 'return_code' to the common section of the JSON output
  - dropped 'inversion' as we have 'return_code' in pip_stress
  - dropped 'success' as we have 'return code in ssdd

All patches are also available at:

  https://github.com/igaw/rt-tests/tree/json-output-2021-03-20

Daniel Wagner (33):
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
  pip_stress: Move test result output to main
  pip_stress: Return failure code if test fails
  pip_stress: Prepare arg parser to accept only long options
  pip_stress: Add JSON output feature
  pi_stress: Prepare command line parser for long options only
  pi_stress: Add JSON output feature
  ssdd: Add quiet command line option
  ssdd: Add JSON output feature

 src/cyclictest/cyclictest.c           |  5 +-
 src/include/rt-utils.h                |  6 +-
 src/lib/rt-utils.c                    | 85 ++++++++++++++++-----------
 src/oslat/oslat.c                     |  6 +-
 src/pi_tests/pi_stress.c              | 65 ++++++++++++++++----
 src/pi_tests/pip_stress.c             | 40 +++++++++----
 src/pmqtest/pmqtest.c                 |  4 +-
 src/ptsematest/ptsematest.c           |  4 +-
 src/rt-migrate-test/rt-migrate-test.c |  4 +-
 src/sched_deadline/cyclicdeadline.c   |  6 +-
 src/signaltest/signaltest.c           |  5 +-
 src/sigwaittest/sigwaittest.c         |  4 +-
 src/ssdd/ssdd.c                       | 43 +++++++++++---
 src/svsematest/svsematest.c           |  4 +-
 14 files changed, 199 insertions(+), 82 deletions(-)

-- 
2.30.2

