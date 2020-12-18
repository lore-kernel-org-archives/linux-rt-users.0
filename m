Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B501FC2BBCF
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 14:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D56723AC1
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 14:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgLROU3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:20:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:37638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbgLROU2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 09:20:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51E68AF6B;
        Fri, 18 Dec 2020 14:19:47 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 0/6] libnuma cleanups for cyclictest
Date:   Fri, 18 Dec 2020 15:19:29 +0100
Message-Id: <20201218141935.24151-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

As we have a hard dependency on libnuma we can simplify the code in
cyclictest. This allows remove all the small helpers in rt_numa.h. And
with this we can remove the header and reduce the confusion with
rt-numa.h

While at it, I simplified the --smp vs --affinity vs --threads
logic. There is no need for additional variables to keep state. With
this we also make --affinity to behave as with the rest of
rt-tests. That is a plan -a will be the same as with -S. There is no
need for -S anymore but I think we should leave it in place for
backwards compatibility. I suspect, there must be a lot of muscle
memory out there :)

Daniel Wagner (6):
  cyclictest: Always use libnuma
  cyclictest: Use numa API directly
  cyclictest: Use affinity_mask for stearing thread placement
  cyclictest: Mimik --smp behavior with --affinity
  cyclictest: Simplify --smp vs --affinity vs --threads argument logic
  cyclictest: Move verbose message into main

 src/cyclictest/cyclictest.c | 154 ++++++++++++++----------------------
 src/cyclictest/rt_numa.h    |  98 -----------------------
 2 files changed, 58 insertions(+), 194 deletions(-)
 delete mode 100644 src/cyclictest/rt_numa.h

-- 
2.29.2

