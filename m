Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED82C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Nov 2020 18:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319BE22409
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Nov 2020 18:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgKOSlJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 15 Nov 2020 13:41:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:54418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgKOSlJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 15 Nov 2020 13:41:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BED3AC2F;
        Sun, 15 Nov 2020 18:41:08 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 0/3] Teach signaltest affinity
Date:   Sun, 15 Nov 2020 19:40:56 +0100
Message-Id: <20201115184059.7286-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This series relies on the "Move common code to helper libraries"
series [1]. After the recent debugging session I think it would be a
good thing to change the default behavior of signaltest and set the
affinity on default.

One thing I also was tempted to change is the default priority to
let's say 98, so that the default settings are useful. It's so easy to
forget to set something and get bad numbers. Obviously, if we agree on
this, we should go over all the tests and try to come of usable defaults.

Thanks,
Daniel

[1] https://lore.kernel.org/linux-rt-users/20201113210910.21807-1-dwagner@suse.de/


Daniel Wagner (3):
  rt-numa: Move thread placement code to rt-numa library
  signaltest: Implement thread placing
  signaltest: Set affintiy on default

 Makefile                    |   4 +-
 src/cyclictest/cyclictest.c |  98 +++----------------------------
 src/include/rt-numa.h       |  13 ++++
 src/lib/rt-numa.c           | 100 +++++++++++++++++++++++++++++++
 src/signaltest/signaltest.8 |  22 ++++++-
 src/signaltest/signaltest.c | 114 ++++++++++++++++++++++++++++++++++--
 6 files changed, 252 insertions(+), 99 deletions(-)

-- 
2.29.2

