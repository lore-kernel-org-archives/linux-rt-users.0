Return-Path: <SRS0=9Pks=WM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1C5C3A59E
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 06:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FA420644
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 06:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfHPGmX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:42:23 -0400
Received: from mail.monom.org ([188.138.9.77]:52482 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfHPGmX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Aug 2019 02:42:23 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 45C8E5006DE;
        Fri, 16 Aug 2019 08:42:21 +0200 (CEST)
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id 05F1150093C;
        Fri, 16 Aug 2019 08:42:20 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH rt-tests v0 2/4] sigwaittest: Increase buffer to avoid overflow
Date:   Fri, 16 Aug 2019 08:42:02 +0200
Message-Id: <20190816064204.6339-3-wagi@monom.org>
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

src/sigwaittest/sigwaittest.c:494:5: note: ‘sprintf’ output between 5 and 14 bytes into a destination of size 8
  494 |     sprintf(f_opt, "-fr%d", i);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
src/sigwaittest/sigwaittest.c:522:24: warning: ‘%d’ directive writing between 1 and 10 bytes into a region of size 5 [-Wformat-overflow=]
  522 |     sprintf(f_opt, "-fs%d", i);
      |                        ^~

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/sigwaittest/sigwaittest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 59f28a5babcb..a98332f13e38 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -352,7 +352,7 @@ int main(int argc, char *argv[])
 	struct params *sender = NULL;
 	sigset_t sigset;
 	void *param = NULL;
-	char f_opt[8];
+	char f_opt[32];
 	struct timespec launchdelay, maindelay;
 
 	process_options(argc, argv);
-- 
2.21.0
