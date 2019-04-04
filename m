Return-Path: <SRS0=J2Xz=SG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F284C10F0E
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 09:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5816920855
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 09:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfDDJuD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:50:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44508 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbfDDJuC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Apr 2019 05:50:02 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hBz0R-0006RE-LW; Thu, 04 Apr 2019 11:49:59 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH] rt-tests: cyclicdeadline: fix segmentation fault on close
Date:   Thu,  4 Apr 2019 11:49:48 +0200
Message-Id: <20190404094948.3516-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The setcpu_buf is unconditionally freed at the end of the program. However,
there are code paths in which it is not allocated:

  $ sudo ./cyclicdeadline
  Using all CPUS
  /sys/kernel/debug/sched_features: Success
  interval: 600:1000
    Tested at 5us of 600us
  deadline thread 2963
  thread[2963] runtime=600us deadline=1000us
  main thread 2962
  fail 2 0
  T: 0 ( 2963) I:1000 C:   1268 Min:      7 Act:   55 Avg:   56 Max:     256
  [1]    2961 segmentation fault  sudo ./cyclicdeadline

Fix it by adding the NULL check.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 08460107c464..614ad54c171f 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1261,6 +1261,7 @@ int main (int argc, char **argv)
 		}
 	}
 
-	free(setcpu_buf);
+	if (setcpu_buf)
+		free(setcpu_buf);
 	return 0;
 }
-- 
2.11.0

