Return-Path: <SRS0=wP7i=EN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F75C4741F
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 10:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7567D206E3
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 10:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgKGKV0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 7 Nov 2020 05:21:26 -0500
Received: from wp003.webpack.hosteurope.de ([80.237.132.10]:54122 "EHLO
        wp003.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgKGKVZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 7 Nov 2020 05:21:25 -0500
Received: from p548daada.dip0.t-ipconnect.de ([84.141.170.218] helo=kmk0.Speedport_W_724V_09011603_06_006); authenticated
        by wp003.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kbL05-0003bK-Jt; Sat, 07 Nov 2020 10:59:13 +0100
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 3/4] rt-tests: cyclictest: Close correct trace fds
Date:   Sat,  7 Nov 2020 10:58:42 +0100
Message-Id: <20201107095843.11909-4-kurt@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107095843.11909-1-kurt@linutronix.de>
References: <20201107095843.11909-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;kurt@linutronix.de;1604744485;b50f18b4;
X-HE-SMSGID: 1kbL05-0003bK-Jt
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove the last lefotovers from migrating cyclictest to rt-utils.

The rt-utils module is reponsible for handling the tracing code.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/cyclictest/cyclictest.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 34aa9be583f8..0ec0b235dba3 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -283,9 +283,6 @@ enum {
 	ERROR_NOTFOUND	= -2,
 };
 
-static int trace_fd     = -1;
-static int tracemark_fd = -1;
-
 /*
  * Raise the soft priority limit up to prio, if that is less than or equal
  * to the hard limit
@@ -2272,10 +2269,7 @@ int main(int argc, char **argv)
 	}
  out:
 	/* close any tracer file descriptors */
-	if (tracemark_fd >= 0)
-		close(tracemark_fd);
-	if (trace_fd >= 0)
-		close(trace_fd);
+	disable_trace_mark();
 
 	/* unlock everything */
 	if (lockall)
-- 
2.26.2

