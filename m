Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67522C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24EA064F5F
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhCDTYE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:24:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:51442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhCDTXr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Mar 2021 14:23:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32DEFAF6F;
        Thu,  4 Mar 2021 19:22:27 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 08/13] pip_stress: Prepare arg parser to accept only long options
Date:   Thu,  4 Mar 2021 20:22:15 +0100
Message-Id: <20210304192220.11272-9-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304192220.11272-1-dwagner@suse.de>
References: <20210304192220.11272-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Introduce the option value enums to be able to parse only long
options.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/pi_tests/pip_stress.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index ed034799da66..0831f698ff1d 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -77,6 +77,10 @@ static void usage(int error)
 	exit(error);
 }
 
+enum option_values {
+	OPT_HELP=1
+};
+
 int main(int argc, char *argv[])
 {
 	void *mptr;	/* memory pointer */
@@ -87,14 +91,15 @@ int main(int argc, char *argv[])
 
 	for (;;) {
 		struct option long_options[] = {
-			{ "help",	no_argument,		NULL,	'h' },
-			{ NULL,		0,			NULL,	0 },
+			{"help",	no_argument,		NULL, OPT_HELP},
+			{NULL,		0,			NULL, 0}
 		};
 
-		int c = getopt_long(argc, argv, "s:h", long_options, NULL);
+		int c = getopt_long(argc, argv, "h", long_options, NULL);
 		if (c == -1)
 			break;
 		switch (c) {
+		case OPT_HELP:
 		case 'h':
 			usage(0);
 			break;
-- 
2.30.1

