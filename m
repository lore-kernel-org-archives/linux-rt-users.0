Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50B8C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 10:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EE02171F
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 10:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfCMKgJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:36:09 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:38510 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfCMKgJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 06:36:09 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id x2DAa3Ah010539
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 11:36:03 +0100
Received: from localhost ([167.87.129.3])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x2DAa1Fk011419;
        Wed, 13 Mar 2019 11:36:02 +0100
From:   Daniel Wagner <daniel.wagner@siemens.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: [PATCH] cyclicdeadline: Add missing options in optstring
Date:   Wed, 13 Mar 2019 11:35:55 +0100
Message-Id: <20190313103555.18572-1-daniel.wagner@siemens.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

'-s' and '-i' are missing.

Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index e3cc3c74ef68..c88c3df1b2ac 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1065,7 +1065,7 @@ int main (int argc, char **argv)
 		exit(-1);
 	}
 
-	while ((c = getopt(argc, argv, "+hac:t:D:")) >= 0) {
+	while ((c = getopt(argc, argv, "+hac:t:D:i:s:")) >= 0) {
 		switch (c) {
 		case 'a':
 			all_cpus = 1;
-- 
2.20.1

