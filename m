Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A2CC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Apr 2022 10:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiD1Kkr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Apr 2022 06:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiD1Kkp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Apr 2022 06:40:45 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6106A073
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Apr 2022 03:37:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VBaOeT2_1651142247;
Received: from localhost(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0VBaOeT2_1651142247)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Apr 2022 18:37:27 +0800
From:   Yihao Wu <wuyihao@linux.alibaba.com>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 0/2] Add af_inet mode besides af_unix and pipe
Date:   Thu, 28 Apr 2022 18:37:24 +0800
Message-Id: <20220428103726.108597-1-wuyihao@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.604.gb1f3e1269
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Yihao Wu (2):
  hackbench: Fix negativity opt checking
  hackbench: Add af_inet mode besides af_unix and pipe

 src/hackbench/hackbench.c | 73 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 9 deletions(-)

-- 
2.18.2

