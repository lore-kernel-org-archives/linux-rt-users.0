Return-Path: <SRS0=wP7i=EN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE90EC388F7
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 10:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA73206B7
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 10:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgKGKVY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 7 Nov 2020 05:21:24 -0500
Received: from wp003.webpack.hosteurope.de ([80.237.132.10]:54114 "EHLO
        wp003.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgKGKVX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 7 Nov 2020 05:21:23 -0500
Received: from p548daada.dip0.t-ipconnect.de ([84.141.170.218] helo=kmk0.Speedport_W_724V_09011603_06_006); authenticated
        by wp003.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kbL04-0003bK-RD; Sat, 07 Nov 2020 10:59:12 +0100
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 0/4] rt-tests: rt-utils: Close trace fds
Date:   Sat,  7 Nov 2020 10:58:39 +0100
Message-Id: <20201107095843.11909-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;kurt@linutronix.de;1604744483;8349b288;
X-HE-SMSGID: 1kbL04-0003bK-RD
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

while using cyclictest with tracing (-b, --tracemark), I've noticed some minor
issues...

Thanks,
Kurt

Kurt Kanzenbach (4):
  rt-tests: rt-utils: Mark internal functions static
  rt-tests: rt-utils: Add function to close trace fds
  rt-tests: cyclictest: Close correct trace fds
  rt-tests: oslat: Close trace fds

 src/cyclictest/cyclictest.c |  8 +-------
 src/include/rt-utils.h      |  1 +
 src/lib/rt-utils.c          | 20 +++++++++++++++++---
 src/oslat/oslat.c           |  2 ++
 4 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.26.2

