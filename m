Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86945C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5720364F59
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCEHfG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:35:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:43656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEHfF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:35:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70355ACBF;
        Fri,  5 Mar 2021 07:35:04 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 00/14] JSON cleanups and more tests updated
Date:   Fri,  5 Mar 2021 08:34:46 +0100
Message-Id: <20210305073500.17926-1-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v2:
  - added 'return_code' to the common section of the JSON output
  - dropped 'inversion' as we have 'return_code' in pip_stress
  - dropped 'success' as we have 'return code in ssdd

The first two patches fixes the format string issue. Then there are a
couple of patches which fixes the common JSON entries (command line,
start_time, end_time).

Then there are patches which add the --output parameter to the missing
rt-tests programs.

All patches are also available at:

  https://github.com/igaw/rt-tests/tree/json-output-2021-03-05

Daniel Wagner (14):
  cyclictest: Fix printf format specifier
  cyclicdeadline.c: Fix printf format specifier
  signaltest: Add missing --output usage info
  rt-util: Copy command line before getopt_long() is called
  rt-util: Add start time of test execution for JSON output
  rt-util: Add return_code to common section of JSON output
  pip_stress: Move test result output to main
  pip_stress: Return failure code if test fails
  pip_stress: Prepare arg parser to accept only long options
  pip_stress: Add JSON output feature
  pi_stress: Prepare command line parser for long options only
  pi_stress: Add JSON output feature
  ssdd: Add quiet command line option
  ssdd: Add JSON output feature

 src/cyclictest/cyclictest.c           | 13 ++--
 src/include/rt-utils.h                |  9 ++-
 src/lib/rt-utils.c                    | 86 ++++++++++++++++-----------
 src/oslat/oslat.c                     |  6 +-
 src/pi_tests/pi_stress.c              | 65 ++++++++++++++++----
 src/pi_tests/pip_stress.c             | 40 +++++++++----
 src/pmqtest/pmqtest.c                 |  4 +-
 src/ptsematest/ptsematest.c           |  4 +-
 src/rt-migrate-test/rt-migrate-test.c |  4 +-
 src/sched_deadline/cyclicdeadline.c   | 12 ++--
 src/signaltest/signaltest.c           |  5 +-
 src/sigwaittest/sigwaittest.c         |  4 +-
 src/ssdd/ssdd.c                       | 43 +++++++++++---
 src/svsematest/svsematest.c           |  4 +-
 14 files changed, 207 insertions(+), 92 deletions(-)

-- 
2.30.1

