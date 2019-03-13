Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF364C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4402184E
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552480135;
	bh=1S3N2c00aY7uDhBXmte227+GI1rLmi+xUGRQ8BG3AB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=frfoCRwjVFqyIh56cOxHG9r19cJOTJyqGIgrznvBXDH/kyLegpXeAxtq0Jf/KiZt4
	 eL8PK7IEmrfzdVRpFxUrp+feF9vXyufMkJdjx6rTZkpz/H5ZjzoVQGrdv7dxBvWaov
	 V1Xqql06VZvn7hE73ixWOXc/a7X5yNLsOQoqbeL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCMM2s (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfCMM2r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 08:28:47 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24459214AE;
        Wed, 13 Mar 2019 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552480126;
        bh=1S3N2c00aY7uDhBXmte227+GI1rLmi+xUGRQ8BG3AB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0BQDNsFEP5jCqTYWszdJ5s/+VXjmucumB8EllYDnSZ6S365caGRnL4pl6J/pvIky
         dMMTdX/Tz7ES/pUCtQZshLP2arrjo4FW5cNF9YjCYwT7mO8cx7sF/K2Naom3BbP4E4
         +ZRpVg4ZUR8cgsMUN+ISEwVxxwBLqsaSjPPNR+Kc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH 7/7] selftests/ftrace: Add error_log testcase for kprobe errors
Date:   Wed, 13 Mar 2019 21:28:41 +0900
Message-Id: <155248012180.10815.9684996376860674672.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155248005229.10815.334731901778152247.stgit@devnote2>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add error_log testcase for error logs on kprobe events.
This tests most of error cases and checks the error position
is correct.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   91 ++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
new file mode 100644
index 000000000000..5796e258747c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -0,0 +1,91 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event parser error log check
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+[ -f error_log ] || exit_unsupported
+
+check_error() { # command expected_pos
+echo "$1"
+(! echo "$1" > kprobe_events ) >& /dev/null
+grep "trace_kprobe: error:" -A 3 error_log
+N=$(tail -n 1 error_log | wc -c)
+# "  Command: " and "^" => 12
+test $(expr 12 + $2) -eq $N
+echo > error_log
+}
+
+if grep -q 'r\[maxactive\]' README; then
+check_error 'p100 vfs_read' 2		# MAXACT_NO_KPROBE
+check_error 'r1a111 vfs_read' 2		# BAD_MAXACT
+check_error 'r100000 vfs_read' 2	# MAXACT_TOO_BIG
+fi
+
+check_error 'p non_exist_func' 3	# BAD_PROBE_ADDR (enoent)
+check_error 'p hoge-fuga' 3		# BAD_PROBE_ADDR (bad syntax)
+check_error 'p hoge+1000-1000' 3	# BAD_PROBE_ADDR (bad syntax)
+check_error 'r vfs_read+10' 3		# BAD_RETPROBE
+check_error 'p:/bar vfs_read' 3		# NO_GROUP_NAME
+check_error 'p:12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read' 3	# GROUP_TOO_LONG
+
+check_error 'p:foo.1/bar vfs_read' 3	# BAD_GROUP_NAME
+check_error 'p:foo/ vfs_read' 7		# NO_EVENT_NAME
+check_error 'p:foo/12345678901234567890123456789012345678901234567890123456789012345 vfs_read' 7	# EVENT_TOO_LONG
+check_error 'p:foo/bar.1 vfs_read' 7	# BAD_EVENT_NAME
+
+check_error 'p vfs_read $retval' 12	# RETVAL_ON_PROBE
+check_error 'p vfs_read $stack10000' 12	# BAD_STACK_NUM
+
+if grep -q '$arg<N>' README; then
+check_error 'p vfs_read $arg10000' 12	# BAD_ARG_NUM
+fi
+
+check_error 'p vfs_read $none_var' 12	# BAD_VAR
+
+check_error 'p vfs_read %none_reg' 12	# BAD_REG_NAME
+check_error 'p vfs_read @12345678abcde' 12	# BAD_MEM_ADDR
+check_error 'p vfs_read @+10' 12	# FILE_ON_KPROBE
+
+check_error 'p vfs_read +0@0)' 12	# DEREF_NEED_BRACE
+check_error 'p vfs_read +0ab1(@0)' 12	# BAD_DEREF_OFFS
+check_error 'p vfs_read +0(+0(@0)' 17	# DEREF_OPEN_BRACE
+
+if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
+check_error 'p vfs_read +0($comm)' 15	# COMM_CANT_DEREF
+fi
+
+check_error 'p vfs_read &1' 12		# BAD_FETCH_ARG
+
+
+# We've introduced this limitation with array support
+if grep -q ' <type>\\\[<array-size>\\\]' README; then
+check_error 'p vfs_read +0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))' 15	# TOO_MANY_OPS?
+check_error 'p vfs_read +0(@11):u8[10' 22	# ARRAY_NO_CLOSE
+check_error 'p vfs_read +0(@11):u8[10]a' 26	# BAD_ARRAY_SUFFIX
+check_error 'p vfs_read +0(@11):u8[10a]' 23	# BAD_ARRAY_NUM
+check_error 'p vfs_read +0(@11):u8[256]' 23	# ARRAY_TOO_BIG
+fi
+
+check_error 'p vfs_read @11:unknown_type' 16	# BAD_TYPE
+check_error 'p vfs_read $stack0:string' 20	# BAD_STRING
+check_error 'p vfs_read @11:b10@a/16' 16	# BAD_BITFIELD
+
+check_error 'p vfs_read arg123456789012345678901234567890=@11' 12	# ARG_NAME_TOO_LOG
+check_error 'p vfs_read =@11' 12		# NO_ARG_NAME
+check_error 'p vfs_read var.1=@11' 12		# BAD_ARG_NAME
+check_error 'p vfs_read var1=@11 var1=@12' 21	# USED_ARG_NAME
+check_error 'p vfs_read +1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))' 12	# ARG_TOO_LONG
+check_error 'p vfs_read arg1=' 17		# NO_ARG_BODY
+
+# instruction boundary check is valid on x86 (at this moment)
+case $(uname -m) in
+  x86_64|i[3456]86)
+    echo 'p vfs_read' > kprobe_events
+    if grep -q FTRACE ../kprobes/list ; then
+	check_error 'p vfs_read+3' 3		# BAD_INSN_BNDRY (only if function-tracer is enabled)
+    fi
+    ;;
+esac
+
+exit 0

