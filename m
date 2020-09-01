Return-Path: <SRS0=uG0Q=CK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E4AC433E6
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Sep 2020 15:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D19206EB
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Sep 2020 15:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbgIAPxY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:53:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:48248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731819AbgIAPrG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Sep 2020 11:47:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF235AC19;
        Tue,  1 Sep 2020 15:47:05 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests 0/4] Fix signaltest output when quiet
Date:   Tue,  1 Sep 2020 17:46:53 +0200
Message-Id: <20200901154657.30198-1-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When the quiet option is used don't print all threads stats. The first
thread will pause every 16 cycles for 10000us. This will show up in
the max values for all other threads when the final results are
printed:

 # signaltest -q  -D 2s
 T: 0 ( 4517) P: 0 C:   3121 Min:      5 Act:    8 Avg:    8 Max:      19
 T: 1 ( 4518) P: 0 C:   3121 Min:      5 Act:10065 Avg:  639 Max:   10073

We could also remove the sleep but then the system gets fully loaded
by the test. Furthermore, we would keep the path pretty hot and that's
not ideal if one wants to test the eratic signal behavior. So only
consider the first thread for the stats.

Daniel Wagner (4):
  rt-utils: Move timestamp calc helper to common header
  rt-utils: Move time defininitions to common header
  rt-utils: Move ARRAY_SIZE to common header
  signaltest: Only print from the first thread stats when quiet

 src/backfire/sendme.c         |  3 ---
 src/cyclictest/cyclictest.c   | 42 ------------------------------
 src/include/rt-utils.h        | 48 +++++++++++++++++++++++++++++++++++
 src/pi_tests/pi_stress.c      | 17 -------------
 src/pmqtest/pmqtest.c         |  4 ---
 src/ptsematest/ptsematest.c   |  2 --
 src/queuelat/queuelat.c       |  2 +-
 src/signaltest/signaltest.c   | 22 +---------------
 src/sigwaittest/sigwaittest.c |  2 --
 src/svsematest/svsematest.c   |  2 --
 10 files changed, 50 insertions(+), 94 deletions(-)

-- 
2.28.0

