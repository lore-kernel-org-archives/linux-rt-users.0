Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B20C07E95
	for <linux-rt-users@archiver.kernel.org>; Sun,  4 Jul 2021 20:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A69613D8
	for <linux-rt-users@archiver.kernel.org>; Sun,  4 Jul 2021 20:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhGDUjG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 16:39:06 -0400
Received: from mail.monom.org ([188.138.9.77]:39736 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhGDUjG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 4 Jul 2021 16:39:06 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 507635005A1;
        Sun,  4 Jul 2021 22:36:28 +0200 (CEST)
Received: from localhost (unknown [94.31.98.41])
        by mail.monom.org (Postfix) with ESMTPSA id 182275002BC;
        Sun,  4 Jul 2021 22:36:28 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 0/3] Fix a few fallouts
Date:   Sun,  4 Jul 2021 22:36:18 +0200
Message-Id: <20210704203621.5612-1-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Daniel Wagner <dwagner@suse.de>

Another round of small cleanups and fixes.

The first one fixes static builds for armhf host. Patch two is another
of the printf format specifier which I got wrong. No idea why we
didn't see this earlier. Anyway gcc on armhf was not happy. The same
for the third fix. Why the gcc on armhf complains and not on anything
else, is dubios to me.

Daniel Wagner (3):
  rt-numa: Use sched_getaffinity() instead of pthread_getaffinity_np()
  signaltest: Fix printf format specifier
  cyclicdeadline: Fix buffer allocation

 src/lib/rt-numa.c                   | 4 +---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 src/signaltest/signaltest.c         | 6 +++---
 3 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.32.0
