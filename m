Return-Path: <SRS0=Dbld=RP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D6FC43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C521734
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfCLRZG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:25:06 -0400
Received: from thoth.sbs.de ([192.35.17.2]:49719 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729790AbfCLRZC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Mar 2019 13:25:02 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x2CHOtNk002448
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 18:24:55 +0100
Received: from localhost ([139.25.69.33])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x2CHOthu015808;
        Tue, 12 Mar 2019 18:24:55 +0100
From:   Daniel Wagner <daniel.wagner@siemens.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: [PATCH 0/4] rt-tests bug fixes
Date:   Tue, 12 Mar 2019 18:24:32 +0100
Message-Id: <20190312172436.18314-1-daniel.wagner@siemens.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I found a couple of bugs in cyclicdeadline and deadline_test.

Thanks,
Daniel

Daniel Wagner (4):
  cyclicdeadline: Fix stack corruption
  deadline_test: Fix stack corruption
  deadline_test: Free allocated resources at exit
  cyclicdeadline: Free allocated resources at exit

 src/sched_deadline/cyclicdeadline.c | 8 ++++++--
 src/sched_deadline/deadline_test.c  | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.20.1

