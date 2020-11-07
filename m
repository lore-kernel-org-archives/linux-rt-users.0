Return-Path: <SRS0=wP7i=EN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C65C388F7
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 10:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDD420888
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 10:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgKGKV2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 7 Nov 2020 05:21:28 -0500
Received: from wp003.webpack.hosteurope.de ([80.237.132.10]:54134 "EHLO
        wp003.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgKGKV2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 7 Nov 2020 05:21:28 -0500
Received: from p548daada.dip0.t-ipconnect.de ([84.141.170.218] helo=kmk0.Speedport_W_724V_09011603_06_006); authenticated
        by wp003.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kbL05-0003bK-Bd; Sat, 07 Nov 2020 10:59:13 +0100
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 2/4] rt-tests: rt-utils: Add function to close trace fds
Date:   Sat,  7 Nov 2020 10:58:41 +0100
Message-Id: <20201107095843.11909-3-kurt@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107095843.11909-1-kurt@linutronix.de>
References: <20201107095843.11909-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;kurt@linutronix.de;1604744487;0ad35b37;
X-HE-SMSGID: 1kbL05-0003bK-Bd
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Currently the trace fds are not closed. Add a function for it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/include/rt-utils.h |  1 +
 src/lib/rt-utils.c     | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 4ed1cbc53ece..c6fb220cdb0a 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -31,6 +31,7 @@ int parse_time_string(char *val);
 
 void enable_trace_mark(void);
 void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
+void disable_trace_mark(void);
 
 #define MSEC_PER_SEC		1000
 #define USEC_PER_SEC		1000000
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 85d41b9542a2..a30e1e4ce436 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -390,6 +390,15 @@ static void open_tracemark_fd(void)
 	}
 }
 
+static void close_tracemark_fd(void)
+{
+	if (tracemark_fd > 0)
+		close(tracemark_fd);
+
+	if (trace_fd > 0)
+		close(trace_fd);
+}
+
 static int trace_file_exists(char *name)
 {
 	struct stat sbuf;
@@ -437,3 +446,8 @@ void enable_trace_mark(void)
 	debugfs_prepare();
 	open_tracemark_fd();
 }
+
+void disable_trace_mark(void)
+{
+	close_tracemark_fd();
+}
-- 
2.26.2

