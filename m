Return-Path: <SRS0=hc4Q=CM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE42C433E2
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 17:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5783A206C0
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 17:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgICRde (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:33:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICRdb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Sep 2020 13:33:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48F4AABC1;
        Thu,  3 Sep 2020 17:33:31 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 4/4] signaltest: Only print from the first thread stats when quiet
Date:   Thu,  3 Sep 2020 19:33:26 +0200
Message-Id: <20200903173326.3393-1-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When the quiet option is used don't print all threads stats. The first
thread will pause every 16 cycles for 10000us. This will show up in
the max values for all other threads when the final results are
printed:

 # signaltest -q  -D 2s
 T: 0 ( 4517) P: 0 C:   3121 Min:      5 Act:    8 Avg:    8 Max:      19
 T: 1 ( 4518) P: 0 C:   3121 Min:      5 Act:10065 Avg:  639 Max:   10073

We could also remove the sleep but then the system gets fully loaded
by the test. Furthermore, we would keep the path pretty hot and that's
not ideal if one wants to test the eratic signal behavior. So only
consider the first thread for the stats.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v2: add brackets to make it easier to read

 src/signaltest/signaltest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 0bf075456ab6..a67eddaf8420 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -417,7 +417,7 @@ int main(int argc, char **argv)
 			pthread_kill(stat[i].thread, SIGTERM);
 		if (stat[i].threadstarted) {
 			pthread_join(stat[i].thread, NULL);
-			if (quiet)
+			if (quiet && (i == 0))
 				print_stat(&par[i], i, 0);
 		}
 		if (stat[i].values)
-- 
2.28.0

