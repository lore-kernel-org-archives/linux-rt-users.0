Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133FEC432C3
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 19:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB55564F69
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 19:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhCDTXd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:23:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:51196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233786AbhCDTXG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Mar 2021 14:23:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA6F3AC24;
        Thu,  4 Mar 2021 19:22:24 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 00/13] JSON cleanups and more tests updated
Date:   Thu,  4 Mar 2021 20:22:07 +0100
Message-Id: <20210304192220.11272-1-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The first two patches fixes the format string issue. Then there are a
couple of patches which fixes the common JSON entries (command line,
start_time, end_time).

Then there are patches which add the --output parameter to the missing
rt-tests programs.

All patches are also available at:

  https://github.com/igaw/rt-tests/tree/json-output-2021-03-04

Daniel Wagner (13):
  cyclictest: Fix printf format specifier
  cyclicdeadline.c: Fix printf format specifier
  signaltest: Add missing --output usage info
  rt_util: Copy command line before getopt_long() is called
  rt-util: Add start time of test execution for JSON output
  pip_stress: Move test result output to main
  pip_stress: Return failure code if test fails
  pip_stress: Prepare arg parser to accept only long options
  pip_stress: Add JSON output feature
  pi_stress: Prepare command line parser for long options only
  pi_stress: Add JSON output feature
  ssdd: Add quiet command line option
  ssdd: Add JSON output feature

 src/cyclictest/cyclictest.c           | 13 ++---
 src/include/rt-utils.h                |  9 ++--
 src/lib/rt-utils.c                    | 77 +++++++++++++++------------
 src/oslat/oslat.c                     |  6 ++-
 src/pi_tests/pi_stress.c              | 65 +++++++++++++++++-----
 src/pi_tests/pip_stress.c             | 47 +++++++++++-----
 src/pmqtest/pmqtest.c                 |  4 +-
 src/ptsematest/ptsematest.c           |  4 +-
 src/rt-migrate-test/rt-migrate-test.c |  4 +-
 src/sched_deadline/cyclicdeadline.c   | 12 +++--
 src/signaltest/signaltest.c           |  5 +-
 src/sigwaittest/sigwaittest.c         |  4 +-
 src/ssdd/ssdd.c                       | 50 +++++++++++++----
 src/svsematest/svsematest.c           |  4 +-
 14 files changed, 214 insertions(+), 90 deletions(-)

-- 
2.30.1

