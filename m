Return-Path: <SRS0=wP7i=EN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F51FC388F7
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 10:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD019208E4
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 10:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgKGKVb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 7 Nov 2020 05:21:31 -0500
Received: from wp003.webpack.hosteurope.de ([80.237.132.10]:54146 "EHLO
        wp003.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgKGKVa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 7 Nov 2020 05:21:30 -0500
Received: from p548daada.dip0.t-ipconnect.de ([84.141.170.218] helo=kmk0.Speedport_W_724V_09011603_06_006); authenticated
        by wp003.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kbL05-0003bK-3L; Sat, 07 Nov 2020 10:59:13 +0100
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 1/4] rt-tests: rt-utils: Mark internal functions static
Date:   Sat,  7 Nov 2020 10:58:40 +0100
Message-Id: <20201107095843.11909-2-kurt@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107095843.11909-1-kurt@linutronix.de>
References: <20201107095843.11909-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;kurt@linutronix.de;1604744490;7dbe7c7a;
X-HE-SMSGID: 1kbL05-0003bK-3L
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There are some helper functions which shouldn't be exported. Mark them static.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/lib/rt-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 54a201661786..85d41b9542a2 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -362,7 +362,7 @@ int parse_time_string(char *val)
 	return t;
 }
 
-void open_tracemark_fd(void)
+static void open_tracemark_fd(void)
 {
 	char path[MAX_PATH];
 
@@ -390,7 +390,7 @@ void open_tracemark_fd(void)
 	}
 }
 
-int trace_file_exists(char *name)
+static int trace_file_exists(char *name)
 {
 	struct stat sbuf;
 	char *tracing_prefix = get_debugfileprefix();
@@ -399,7 +399,7 @@ int trace_file_exists(char *name)
 	return stat(path, &sbuf) ? 0 : 1;
 }
 
-void debugfs_prepare(void)
+static void debugfs_prepare(void)
 {
 	if (mount_debugfs(NULL))
 		fatal("could not mount debugfs");
-- 
2.26.2

