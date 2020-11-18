Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFD3C56202
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D594A21D1A
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgKRTGs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:49942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgKRTGs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03714BB06;
        Wed, 18 Nov 2020 19:06:47 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 00/12] Add quiet command line option
Date:   Wed, 18 Nov 2020 20:06:30 +0100
Message-Id: <20201118190642.16006-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Silence the terminal output for automated tested. I think I got all
tests udpated which are pretty load.

This series is ontop of "Teach signaltest affinity" series [1]

[1] https://lore.kernel.org/linux-rt-users/20201115184059.7286-1-dwagner@suse.de/

Daniel Wagner (12):
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

 compare.py                            |  12 ++
 src/pmqtest/pmqtest.8                 |   5 +-
 src/pmqtest/pmqtest.c                 |  77 +++++-----
 src/ptsematest/ptsematest.8           |   5 +-
 src/ptsematest/ptsematest.c           |  79 +++++-----
 src/rt-migrate-test/rt-migrate-test.c |  12 +-
 src/sched_deadline/cyclicdeadline.8   |   6 +-
 src/sched_deadline/cyclicdeadline.c   | 200 ++++++++++----------------
 src/sigwaittest/sigwaittest.c         | 110 +++++++-------
 src/svsematest/svsematest.8           |   5 +-
 src/svsematest/svsematest.c           | 113 ++++++++-------
 11 files changed, 304 insertions(+), 320 deletions(-)
 create mode 100644 compare.py

-- 
2.29.2

