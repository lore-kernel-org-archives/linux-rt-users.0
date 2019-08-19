Return-Path: <SRS0=6kRx=WP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B4C3A59B
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 06:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B4A2086C
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 06:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfHSGnM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:43:12 -0400
Received: from mail.monom.org ([188.138.9.77]:33096 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfHSGnM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 02:43:12 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id AD7E5500797;
        Mon, 19 Aug 2019 08:43:10 +0200 (CEST)
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id 93BED5007F3;
        Mon, 19 Aug 2019 08:43:10 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH rt-tests v1 v1 3/4] svsematest: Increase buffer to avoid overflow
Date:   Mon, 19 Aug 2019 08:43:03 +0200
Message-Id: <20190819064304.4676-4-wagi@monom.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819064304.4676-1-wagi@monom.org>
References: <20190819064304.4676-1-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Increase the size of the char buffer. gcc 9.1.1 reports:

rc/svsematest/svsematest.c:578:24: warning: ‘%d’ directive writing between 1 and 10 bytes into a region of size 5 [-Wformat-overflow=]
  578 |     sprintf(f_opt, "-fr%d", i);
      |                        ^~
src/svsematest/svsematest.c:606:5: note: ‘sprintf’ output between 5 and 14 bytes into a destination of size 8
  606 |     sprintf(f_opt, "-fs%d", i);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/svsematest/svsematest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 8f880786ec0f..15e36af76288 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -401,7 +401,7 @@ int main(int argc, char *argv[])
 	struct params *sender = NULL;
 	sigset_t sigset;
 	void *param = NULL;
-	char f_opt[8];
+	char f_opt[14];
 	struct timespec launchdelay, maindelay;
 
 	myfile = getenv("_");
-- 
2.21.0
