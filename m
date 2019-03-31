Return-Path: <SRS0=867U=SC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614DAC43381
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C142085A
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554076162;
	bh=FgcTbD89gsHRynUu7jrmrWTI5GdOfxYPnMFFFW2nWVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=HOgYV7mHhy/HPIThXQwBffrnAknr1rHbyD5CGeEUrWEt6fFmc0piPW9GmavFHqdwa
	 cWDRqVw3obCETcPWmeuyOw2C8sjvB2IaHdZO/5Y/9CuEaPT2FFBrhCfP1rQxqAB5ht
	 Jmkqwp++e2dWeYi8HkImu+1VvuvD7Tku8+HWEADg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfCaXsm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbfCaXsl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Mar 2019 19:48:41 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 098A62183F;
        Sun, 31 Mar 2019 23:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554076120;
        bh=FgcTbD89gsHRynUu7jrmrWTI5GdOfxYPnMFFFW2nWVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ByYXWff4sOj33UseaxPcfe9dWPpgC0YmGg/9cP8eTs3WqZttK+myMl6kSWgvhlpEA
         kk9Sb7RjHMAi7Gcr6yxf+pU0Qxo165NWyr2nKjVWgX4ZnLB/OgcQKJtj1UFSAtRPM2
         gJHhq4AxvOB6eqqENE94lW+ApL2p9ykIG2IUUMpY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v5 06/11] selftests/ftrace: Add error_log testcase for probe errors
Date:   Sun, 31 Mar 2019 18:48:20 -0500
Message-Id: <63d695b74e0965988fa54ffa12beeb2c3475250d.1554072478.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554072478.git.tom.zanussi@linux.intel.com>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554072478.git.tom.zanussi@linux.intel.com>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add error_log testcase for error logs on probe events.
This tests most of error cases and checks the error position
is correct.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
[tom.zanussi@linux.intel.com: changed >& redirection to 2>]
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   | 93 ++++++++++++++++++++++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   | 31 ++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
new file mode 100644
index 000000000000..7eb577b1d222
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -0,0 +1,93 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event parser error log check
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+[ -f error_log ] || exit_unsupported
+
+check_error() { # command-with-error-pos-by-^
+pos=$(echo -n "${1%^*}" | wc -c) # error position
+command=$(echo "$1" | tr -d ^)
+echo "Test command: $command"
+echo > error_log
+(! echo "$command" > kprobe_events ) 2> /dev/null
+grep "trace_kprobe: error:" -A 3 error_log
+N=$(tail -n 1 error_log | wc -c)
+# "  Command: " and "^\n" => 13
+test $(expr 13 + $pos) -eq $N
+}
+
+if grep -q 'r\[maxactive\]' README; then
+check_error 'p^100 vfs_read'		# MAXACT_NO_KPROBE
+check_error 'r^1a111 vfs_read'		# BAD_MAXACT
+check_error 'r^100000 vfs_read'		# MAXACT_TOO_BIG
+fi
+
+check_error 'p ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
+check_error 'p ^hoge-fuga'		# BAD_PROBE_ADDR (bad syntax)
+check_error 'p ^hoge+1000-1000'		# BAD_PROBE_ADDR (bad syntax)
+check_error 'r ^vfs_read+10'		# BAD_RETPROBE
+check_error 'p:^/bar vfs_read'		# NO_GROUP_NAME
+check_error 'p:^12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read'	# GROUP_TOO_LONG
+
+check_error 'p:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
+check_error 'p:foo/^ vfs_read'		# NO_EVENT_NAME
+check_error 'p:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
+check_error 'p:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
+
+check_error 'p vfs_read ^$retval'	# RETVAL_ON_PROBE
+check_error 'p vfs_read ^$stack10000'	# BAD_STACK_NUM
+
+if grep -q '$arg<N>' README; then
+check_error 'p vfs_read ^$arg10000'	# BAD_ARG_NUM
+fi
+
+check_error 'p vfs_read ^$none_var'	# BAD_VAR
+
+check_error 'p vfs_read ^%none_reg'	# BAD_REG_NAME
+check_error 'p vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
+check_error 'p vfs_read ^@+10'		# FILE_ON_KPROBE
+
+check_error 'p vfs_read ^+0@0)'		# DEREF_NEED_BRACE
+check_error 'p vfs_read ^+0ab1(@0)'	# BAD_DEREF_OFFS
+check_error 'p vfs_read +0(+0(@0^)'	# DEREF_OPEN_BRACE
+
+if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
+check_error 'p vfs_read +0(^$comm)'	# COMM_CANT_DEREF
+fi
+
+check_error 'p vfs_read ^&1'		# BAD_FETCH_ARG
+
+
+# We've introduced this limitation with array support
+if grep -q ' <type>\\\[<array-size>\\\]' README; then
+check_error 'p vfs_read +0(^+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))'	# TOO_MANY_OPS?
+check_error 'p vfs_read +0(@11):u8[10^'		# ARRAY_NO_CLOSE
+check_error 'p vfs_read +0(@11):u8[10]^a'	# BAD_ARRAY_SUFFIX
+check_error 'p vfs_read +0(@11):u8[^10a]'	# BAD_ARRAY_NUM
+check_error 'p vfs_read +0(@11):u8[^256]'	# ARRAY_TOO_BIG
+fi
+
+check_error 'p vfs_read @11:^unknown_type'	# BAD_TYPE
+check_error 'p vfs_read $stack0:^string'	# BAD_STRING
+check_error 'p vfs_read @11:^b10@a/16'		# BAD_BITFIELD
+
+check_error 'p vfs_read ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_LOG
+check_error 'p vfs_read ^=@11'			# NO_ARG_NAME
+check_error 'p vfs_read ^var.1=@11'		# BAD_ARG_NAME
+check_error 'p vfs_read var1=@11 ^var1=@12'	# USED_ARG_NAME
+check_error 'p vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
+check_error 'p vfs_read arg1=^'			# NO_ARG_BODY
+
+# instruction boundary check is valid on x86 (at this moment)
+case $(uname -m) in
+  x86_64|i[3456]86)
+    echo 'p vfs_read' > kprobe_events
+    if grep -q FTRACE ../kprobes/list ; then
+	check_error 'p ^vfs_read+3'		# BAD_INSN_BNDRY (only if function-tracer is enabled)
+    fi
+    ;;
+esac
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
new file mode 100644
index 000000000000..ec7389b7934b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Uprobe event parser error log check
+
+[ -f uprobe_events ] || exit_unsupported # this is configurable
+
+[ -f error_log ] || exit_unsupported
+
+check_error() { # command-with-error-pos-by-^
+pos=$(echo -n "${1%^*}" | wc -c) # error position
+command=$(echo "$1" | tr -d ^)
+echo "Test command: $command"
+echo > error_log
+(! echo "$command" > uprobe_events ) 2> /dev/null
+grep "trace_uprobe: error:" -A 3 error_log
+N=$(tail -n 1 error_log | wc -c)
+# "  Command: " and "^\n" => 13
+test $(expr 13 + $pos) -eq $N
+}
+
+check_error 'p ^/non_exist_file:100'	# FILE_NOT_FOUND
+check_error 'p ^/sys:100'		# NO_REGULAR_FILE
+check_error 'p /bin/sh:^10a'		# BAD_UPROBE_OFFS
+check_error 'p /bin/sh:10(^1a)'		# BAD_REFCNT
+check_error 'p /bin/sh:10(10^'		# REFCNT_OPEN_BRACE
+check_error 'p /bin/sh:10(10)^a'	# BAD_REFCNT_SUFFIX
+
+check_error 'p /bin/sh:10 ^@+ab'	# BAD_FILE_OFFS
+check_error 'p /bin/sh:10 ^@symbol'	# SYM_ON_UPROBE
+
+exit 0
-- 
2.14.1

