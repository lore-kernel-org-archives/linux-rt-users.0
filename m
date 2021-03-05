Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B21C43381
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C7764FE6
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCEHfJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:35:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:43782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhCEHfI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:35:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD991ADCD;
        Fri,  5 Mar 2021 07:35:06 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 08/14] pip_stress: Return failure code if test fails
Date:   Fri,  5 Mar 2021 08:34:54 +0100
Message-Id: <20210305073500.17926-9-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305073500.17926-1-dwagner@suse.de>
References: <20210305073500.17926-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Let the test return a failure code when the test fails.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/pi_tests/pip_stress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 2c3288984202..ed034799da66 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -160,11 +160,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (statep->inversion)
-		printf("Successfully used priority inheritance to handle an inversion\n");
-	else
+	if (!statep->inversion) {
 		printf("No inversion incurred\n");
-
+		exit(1);
+	}
+	printf("Successfully used priority inheritance to handle an inversion\n");
 	exit(0);
 }
 
-- 
2.30.1

