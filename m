Return-Path: <SRS0=867U=SC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3179AC43381
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FC72085A
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554076160;
	bh=gxPLx0XZc3Ohp7zLYHZ2cKwOGhsKv8tdHrxFr0/XUok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=g9A5UR0r+C1WShzBzzDHdhKIxcQFnaqfC5cqDJGwhKVihAUyQDV7K3U9pbVvdhYdT
	 TCT9nC+clKkXrHJQQimYpR8OfElbKkKAGGzTNeqMbcTZL0ARyvrx2UV29IJoV0p0of
	 fw6WDx2P5eJzxjQyll3FTSXU2QI61OvxO1KjHz+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfCaXsn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731700AbfCaXsn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Mar 2019 19:48:43 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B37521873;
        Sun, 31 Mar 2019 23:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554076122;
        bh=gxPLx0XZc3Ohp7zLYHZ2cKwOGhsKv8tdHrxFr0/XUok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=m+4ttfZJm6uATJfo29AJhbN8fXcjhWJy2avGAyL7wGntAKMWX/Vu6hmD/u7KNbZ67
         rOMChzflCgcb1MnjLhZj7l0eLz4W9lD97XyuLnXp+/IjEa+MV1I3KQBNxgXMQlkmlt
         mUpaTIZE0GmRcvMxjePwobzDZ8xmERNx5kn4ZWGA=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v5 07/11] selftests/ftrace: Move kprobe/uprobe check_error() to test.d/functions
Date:   Sun, 31 Mar 2019 18:48:21 -0500
Message-Id: <9f88080a06f1755811f69081926afe7e5cb53178.1554072478.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554072478.git.tom.zanussi@linux.intel.com>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554072478.git.tom.zanussi@linux.intel.com>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

The k/uprobe_sytax_errors test case defines a check_error() function
used to run a command and check the position of the caret in the
output.

This would be useful for other ftrace facilities too, so move it to
test.d/functions for use by anyone.  In the process, rename it to
ftrace_errlog_check() and parametrize it for general use.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 tools/testing/selftests/ftrace/test.d/functions              | 12 ++++++++++++
 .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc   | 10 +---------
 .../selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc   | 10 +---------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 7b96e80e6b8a..779ec11f61bd 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -109,3 +109,15 @@ LOCALHOST=127.0.0.1
 yield() {
     ping $LOCALHOST -c 1 || sleep .001 || usleep 1 || sleep 1
 }
+
+ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
+    pos=$(echo -n "${2%^*}" | wc -c) # error position
+    command=$(echo "$2" | tr -d ^)
+    echo "Test command: $command"
+    echo > error_log
+    (! echo "$command" > "$3" ) 2> /dev/null
+    grep "$1: error:" -A 3 error_log
+    N=$(tail -n 1 error_log | wc -c)
+    # "  Command: " and "^\n" => 13
+    test $(expr 13 + $pos) -eq $N
+}
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 7eb577b1d222..29faaec942c6 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -7,15 +7,7 @@
 [ -f error_log ] || exit_unsupported
 
 check_error() { # command-with-error-pos-by-^
-pos=$(echo -n "${1%^*}" | wc -c) # error position
-command=$(echo "$1" | tr -d ^)
-echo "Test command: $command"
-echo > error_log
-(! echo "$command" > kprobe_events ) 2> /dev/null
-grep "trace_kprobe: error:" -A 3 error_log
-N=$(tail -n 1 error_log | wc -c)
-# "  Command: " and "^\n" => 13
-test $(expr 13 + $pos) -eq $N
+    ftrace_errlog_check 'trace_kprobe' "$1" 'kprobe_events'
 }
 
 if grep -q 'r\[maxactive\]' README; then
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
index ec7389b7934b..14229d5778a0 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -7,15 +7,7 @@
 [ -f error_log ] || exit_unsupported
 
 check_error() { # command-with-error-pos-by-^
-pos=$(echo -n "${1%^*}" | wc -c) # error position
-command=$(echo "$1" | tr -d ^)
-echo "Test command: $command"
-echo > error_log
-(! echo "$command" > uprobe_events ) 2> /dev/null
-grep "trace_uprobe: error:" -A 3 error_log
-N=$(tail -n 1 error_log | wc -c)
-# "  Command: " and "^\n" => 13
-test $(expr 13 + $pos) -eq $N
+    ftrace_errlog_check 'trace_uprobe' "$1" 'uprobe_events'
 }
 
 check_error 'p ^/non_exist_file:100'	# FILE_NOT_FOUND
-- 
2.14.1

