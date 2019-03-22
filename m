Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E3AC43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B50320850
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553268923;
	bh=gMKhnL4aWWxWcVOJDcUS68XZUpr0F7OT31KkhUVdgok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=uhOTZ4aFhrB0W8fIKlkdNpI8x03UYvLNMbT65kfhlnmrTZ0QaaAdUi0GT4Up4BUUQ
	 54xhjIi2TRW0UeTeOlOP4l9/e754OqSJuFQXn6HmbOmvzXt4OHek7Yhv//dyh3+77r
	 FaDlU9YcHICT+Oy4qGM18hYM/xgESSCDYAlGieeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCVPfJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfCVPfC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Mar 2019 11:35:02 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 824182196F;
        Fri, 22 Mar 2019 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553268902;
        bh=gMKhnL4aWWxWcVOJDcUS68XZUpr0F7OT31KkhUVdgok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=U/kqQwws7XXZWcGbjzfyt33aS0rhbVTjjqWveiSKTTnSTJ+prQjSKk0r8niA1vCpB
         Vcyxk6BCyIfuynPAobtPec9Jg9MjAOPNF1FVqjLUtI8/gFD5eUAD+vTJM8eTIMVTwJ
         StjFg84pnQ4wQHcNQNyJax1pJ9zUki2JQP51Z48I=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 11/11] selftests/ftrace: Change stderr redirection for probe error_log testcase
Date:   Fri, 22 Mar 2019 10:34:37 -0500
Message-Id: <ce51abd8585b775fd98e31e5feb1b1505483312f.1553268041.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1553268040.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1553268040.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

On my system, /bin/sh is symlinked to dash, which doesn't understand
the >& syntax, so the kprobe and uprobe error cases fail, with this in
the log:

./ftracetest: 26: tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc:
Syntax error: Bad fd number

Changing >& to 2> does work though, and should work in any shell.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc | 2 +-
 tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 281665b1348c..7eb577b1d222 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -11,7 +11,7 @@ pos=$(echo -n "${1%^*}" | wc -c) # error position
 command=$(echo "$1" | tr -d ^)
 echo "Test command: $command"
 echo > error_log
-(! echo "$command" > kprobe_events ) >& /dev/null
+(! echo "$command" > kprobe_events ) 2> /dev/null
 grep "trace_kprobe: error:" -A 3 error_log
 N=$(tail -n 1 error_log | wc -c)
 # "  Command: " and "^\n" => 13
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
index 957011300bb7..ec7389b7934b 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -11,7 +11,7 @@ pos=$(echo -n "${1%^*}" | wc -c) # error position
 command=$(echo "$1" | tr -d ^)
 echo "Test command: $command"
 echo > error_log
-(! echo "$command" > uprobe_events ) >& /dev/null
+(! echo "$command" > uprobe_events ) 2> /dev/null
 grep "trace_uprobe: error:" -A 3 error_log
 N=$(tail -n 1 error_log | wc -c)
 # "  Command: " and "^\n" => 13
-- 
2.14.1

