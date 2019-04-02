Return-Path: <SRS0=WXxn=SE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF1C4360F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 09:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58CC207E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 09:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfDBJn2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:43:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34329 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfDBJn2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Apr 2019 05:43:28 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hBFx0-0001Xd-44; Tue, 02 Apr 2019 11:43:26 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH] rt-tests: cyclicdeadline: fix getopt string
Date:   Tue,  2 Apr 2019 11:42:39 +0200
Message-Id: <20190402094239.21482-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is code to parse the interval and step parameters from the command
line. However, these options cannot be set, because the getopt string is
incomplete. Adjust it accordingly to make '-i' and '-s' work.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 761f8d7d7483..08460107c464 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1062,7 +1062,7 @@ int main (int argc, char **argv)
 		exit(-1);
 	}
 
-	while ((c = getopt(argc, argv, "+hac:t:")) >= 0) {
+	while ((c = getopt(argc, argv, "+hac:i:s:t:")) >= 0) {
 		switch (c) {
 		case 'a':
 			all_cpus = 1;
-- 
2.11.0

