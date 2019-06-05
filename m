Return-Path: <SRS0=TVKX=UE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C62C28D19
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462A6206C3
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfFEQGg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:06:36 -0400
Received: from mail.monom.org ([188.138.9.77]:35618 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbfFEQGd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Jun 2019 12:06:33 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C2D1B50081F;
        Wed,  5 Jun 2019 18:06:31 +0200 (CEST)
Received: from localhost (ppp-93-104-174-142.dynamic.mnet-online.de [93.104.174.142])
        by mail.monom.org (Postfix) with ESMTPSA id 820745004BB;
        Wed,  5 Jun 2019 18:06:31 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 04/12] pi_stress: Allow short command line arguments
Date:   Wed,  5 Jun 2019 18:06:09 +0200
Message-Id: <20190605160617.22987-5-wagi@monom.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605160617.22987-1-wagi@monom.org>
References: <20190605160617.22987-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add optstring to getopt_long() command line parser to support the
short options as it documented in the man page and also in the usage
help text.

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/pi_tests/pi_stress.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index ac7646cd2613..543106be8e18 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1322,9 +1322,8 @@ int process_sched_line(const char *arg)
 void process_command_line(int argc, char **argv)
 {
 	int opt;
-	while ((opt = getopt_long(argc, argv, "+", options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+ht:vqi:g:rs:pdVum", options, NULL)) != -1) {
 		switch (opt) {
-		case '?':
 		case 'h':
 			usage();
 			exit(0);
-- 
2.20.1
