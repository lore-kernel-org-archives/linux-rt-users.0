Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C82C433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F4F610CC
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 17:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347425AbhESRLN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 13:11:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240245AbhESRLM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 13:11:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1CDBAB17F;
        Wed, 19 May 2021 17:09:52 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 00/23] Rename --output to --json
Date:   Wed, 19 May 2021 19:09:22 +0200
Message-Id: <20210519170945.21941-1-dwagner@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is the final cleanup for the JSON output feature. As agreed on
IRC rename the very generic --output command line option to a more
specific one --json.

Update the man pages accordingly.

Daniel Wagner (23):
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

 src/cyclictest/cyclictest.8           |  7 +++++--
 src/cyclictest/cyclictest.c           | 20 ++++++++++----------
 src/oslat/oslat.8                     |  8 ++++++--
 src/oslat/oslat.c                     | 18 +++++++++---------
 src/pi_tests/pi_stress.8              |  8 +++++++-
 src/pi_tests/pi_stress.c              | 18 +++++++++---------
 src/pmqtest/pmqtest.8                 |  5 ++++-
 src/pmqtest/pmqtest.c                 | 21 ++++++++++-----------
 src/ptsematest/ptsematest.8           |  5 ++++-
 src/ptsematest/ptsematest.c           | 18 +++++++++---------
 src/rt-migrate-test/rt-migrate-test.8 |  6 +++++-
 src/rt-migrate-test/rt-migrate-test.c | 20 ++++++++++----------
 src/sched_deadline/cyclicdeadline.8   |  5 ++++-
 src/sched_deadline/cyclicdeadline.c   | 18 +++++++++---------
 src/signaltest/signaltest.8           |  5 ++++-
 src/signaltest/signaltest.c           | 20 ++++++++++----------
 src/sigwaittest/sigwaittest.8         |  5 ++++-
 src/sigwaittest/sigwaittest.c         | 18 +++++++++---------
 src/ssdd/ssdd.8                       |  5 ++++-
 src/ssdd/ssdd.c                       | 16 ++++++++--------
 src/svsematest/svsematest.8           |  5 ++++-
 src/svsematest/svsematest.c           | 18 +++++++++---------
 22 files changed, 153 insertions(+), 116 deletions(-)

-- 
2.31.1

