Return-Path: <SRS0=Dbld=RP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9125C43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8604321734
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfCLRZI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:25:08 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:52194 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfCLRZB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Mar 2019 13:25:01 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id x2CHOuEp031355
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 18:24:56 +0100
Received: from localhost ([139.25.69.33])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x2CHOuaG015833;
        Tue, 12 Mar 2019 18:24:56 +0100
From:   Daniel Wagner <daniel.wagner@siemens.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: [PATCH 3/4] deadline_test: Free allocated resources at exit
Date:   Tue, 12 Mar 2019 18:24:35 +0100
Message-Id: <20190312172436.18314-4-daniel.wagner@siemens.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312172436.18314-1-daniel.wagner@siemens.com>
References: <20190312172436.18314-1-daniel.wagner@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
---
 src/sched_deadline/deadline_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 1b72c6097a87..04984d997f58 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -2092,8 +2092,12 @@ int main (int argc, char **argv)
 		printf("\n");
 	}
 
-	if (!setcpu_buf)
+	if (setcpu_buf)
 		free(setcpu_buf);
+	free(thread);
+	free(sched_data);
+
+	CPU_FREE(cpusetp);
 
 	return 0;
 }
-- 
2.20.1

