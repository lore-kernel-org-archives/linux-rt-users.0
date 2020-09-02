Return-Path: <SRS0=5+M/=CL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820A1C433E2
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Sep 2020 08:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63EA720709
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Sep 2020 08:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIBI1f (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:27:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:43770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIBI1e (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Sep 2020 04:27:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0BA51B56F;
        Wed,  2 Sep 2020 08:27:34 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests 0/4] Streamlining code base?
Date:   Wed,  2 Sep 2020 10:27:21 +0200
Message-Id: <20200902082725.20037-1-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Clark and John,

I'd like to streamline all tools, so that the usage, command arguments
and the output is more consistent. Every tool seems to be a bit
different which makes all automatization around the tools more complex
than needed.

Eventually, I'd like to add an easy machine parseable output from all
tools. So what do you think? Stupid effort, go away?

Here are a bunch of patches to illustrate what I mean. Before invest
too much time I'd like to discuss it, e.g. format.

Cheers,
Daniel

Daniel Wagner (4):
  cyclicdeadline: Streamline usage output and man page
  deadline_test: Streamline usage output and man page
  oslat: Streamline usage output and man page
  oslat: Use string parser utilies

 src/include/rt-utils.h              |   1 +
 src/lib/rt-utils.c                  |  30 ++++++
 src/oslat/oslat.8                   |   2 +-
 src/oslat/oslat.c                   | 143 ++++++++--------------------
 src/sched_deadline/cyclicdeadline.8 |  24 ++---
 src/sched_deadline/cyclicdeadline.c |  41 ++++----
 src/sched_deadline/deadline_test.8  |  37 ++++---
 src/sched_deadline/deadline_test.c  |  47 +++++----
 8 files changed, 145 insertions(+), 180 deletions(-)

-- 
2.28.0

