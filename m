Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFEFC4742C
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88EE22252
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKMVJT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:09:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:39750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgKMVJT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Nov 2020 16:09:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5373DABD9;
        Fri, 13 Nov 2020 21:09:18 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 0/6] Move common code to helper libraries
Date:   Fri, 13 Nov 2020 22:09:04 +0100
Message-Id: <20201113210910.21807-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

These patches are left over from the last cleanup series[1]. The first
two move the parse_mem_string() to rt-utils.h. The rest move the NUMA
bits into a new helper library and udpate the existing code to use the
new helpers.

Thanks,
Daniel

[1] https://lore.kernel.org/linux-rt-users/20201007085653.11961-1-dwagner@suse.de/

Daniel Wagner (6):
  rt-utils: Introduce parse_mem_string()
  oslat: Use string parser utilies
  cyclictest: Remove deadcode checking for NUMA
  rt-numa: Introduce NUMA helpers
  cyclictest: Use parse_cpumask() from rt-numa.h
  oslat: Use parse_cpumask() from rt-numa.h

 Makefile                    |  18 +++---
 src/cyclictest/cyclictest.c |  75 +++++-----------------
 src/include/rt-numa.h       |   9 +++
 src/include/rt-utils.h      |   1 +
 src/lib/rt-numa.c           |  56 +++++++++++++++++
 src/lib/rt-utils.c          |  30 +++++++++
 src/oslat/oslat.c           | 122 ++++++------------------------------
 7 files changed, 138 insertions(+), 173 deletions(-)
 create mode 100644 src/include/rt-numa.h
 create mode 100644 src/lib/rt-numa.c

-- 
2.29.2

