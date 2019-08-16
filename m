Return-Path: <SRS0=9Pks=WM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423B2C3A59C
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 06:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145422133F
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 06:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfHPGmW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:42:22 -0400
Received: from mail.monom.org ([188.138.9.77]:52468 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPGmW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Aug 2019 02:42:22 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 9F9DB5006D2;
        Fri, 16 Aug 2019 08:42:20 +0200 (CEST)
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id 79A34500665;
        Fri, 16 Aug 2019 08:42:20 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH rt-tests v0 1/4] pmqtest: Increase buffer to avoid overflow
Date:   Fri, 16 Aug 2019 08:42:01 +0200
Message-Id: <20190816064204.6339-2-wagi@monom.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816064204.6339-1-wagi@monom.org>
References: <20190816064204.6339-1-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Increase the size of the char buffer. gcc 9.1.1 reports:

src/pmqtest/pmqtest.c: In function ‘main’:
src/pmqtest/pmqtest.c:46:21: warning: ‘%d’ directive writing between 1 and 10 bytes into a region of size 8 [-Wformat-overflow=]
   46 | #define SYNCMQ_NAME "/syncmsg%d"
      |                     ^~~~~~~~~~~~

src/pmqtest/pmqtest.c:445:3: note: ‘sprintf’ output between 10 and 19 bytes into a destination of size 16
  445 |   sprintf(mqname, SYNCMQ_NAME, i);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/pmqtest/pmqtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index a04fc49872bf..20164c8d547f 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -440,7 +440,7 @@ int main(int argc, char *argv[])
 		goto nomem;
 
 	for (i = 0; i < num_threads; i++) {
-		char mqname[16];
+		char mqname[32];
 
 		sprintf(mqname, SYNCMQ_NAME, i);
 		receiver[i].syncmq = mq_open(mqname, oflag, 0777, &mqstat);
@@ -567,7 +567,7 @@ int main(int argc, char *argv[])
 	}
 	nanosleep(&maindelay, NULL);
 	for (i = 0; i < num_threads; i++) {
-		char mqname[16];
+		char mqname[32];
 
 		mq_close(receiver[i].syncmq);
 		sprintf(mqname, SYNCMQ_NAME, i);
-- 
2.21.0
