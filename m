Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C69C4727E
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3812420797
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgJGI46 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:56:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:57516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgJGI46 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:56:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A82ADAC7D;
        Wed,  7 Oct 2020 08:56:56 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 00/18] Streamline command line
Date:   Wed,  7 Oct 2020 10:56:35 +0200
Message-Id: <20201007085653.11961-1-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Here the second round getting the some more consistency into the code
base. With this all the commands should at least look the same and use
an consistent option name. I've tried to make it backwards compatible,
except for oslat (--duration).

Thanks,
Daniel

changes since v1:
  - updated all existing tools

Daniel Wagner (18):
  rt-util: Move parse_cpumask from cyclictest
  cyclictest: Use numa library helpers in get_available_cpus()
  cyclicdeadline: Streamline usage output and man page
  cyclicdeadline: Add long command line options
  deadline_test: Streamline usage output and man page
  oslat: Streamline usage output and man page
  oslat: Use string parser utilies
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

 Makefile                              |  12 +--
 src/cyclictest/cyclictest.c           |  90 +++-------------
 src/hackbench/hackbench.8             |  70 +++++++------
 src/hackbench/hackbench.c             | 102 +++++++++---------
 src/include/rt-utils.h                |   3 +
 src/lib/rt-utils.c                    |  76 ++++++++++++++
 src/oslat/oslat.8                     |   2 +-
 src/oslat/oslat.c                     | 145 +++++++-------------------
 src/pi_tests/pi_stress.8              |  79 +++++++-------
 src/pi_tests/pi_stress.c              | 144 +++++++++++++------------
 src/pi_tests/pip_stress.c             |  34 +++++-
 src/pmqtest/pmqtest.8                 |   5 +-
 src/pmqtest/pmqtest.c                 |  88 ++++++++--------
 src/ptsematest/ptsematest.8           |   5 +-
 src/ptsematest/ptsematest.c           |  76 +++++++-------
 src/queuelat/queuelat.8               |  41 +++-----
 src/queuelat/queuelat.c               |  99 +++++++++---------
 src/rt-migrate-test/rt-migrate-test.8 |  41 ++++----
 src/rt-migrate-test/rt-migrate-test.c |  82 +++++++--------
 src/sched_deadline/cyclicdeadline.8   |  25 ++---
 src/sched_deadline/cyclicdeadline.c   |  67 +++++++-----
 src/sched_deadline/deadline_test.8    |  37 ++++---
 src/sched_deadline/deadline_test.c    |  47 ++++-----
 src/signaltest/signaltest.8           |  13 +--
 src/signaltest/signaltest.c           |  47 +++++----
 src/sigwaittest/sigwaittest.8         |   4 +-
 src/sigwaittest/sigwaittest.c         |  76 ++++++++------
 src/ssdd/ssdd.8                       |  35 +++----
 src/ssdd/ssdd.c                       |  50 +++++----
 src/svsematest/svsematest.8           |   6 +-
 src/svsematest/svsematest.c           |  83 ++++++++-------
 31 files changed, 854 insertions(+), 830 deletions(-)

-- 
2.28.0

