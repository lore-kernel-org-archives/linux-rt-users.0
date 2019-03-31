Return-Path: <SRS0=867U=SC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F2EC4360F
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399432085A
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554076152;
	bh=AY9LwWVy9qsxNsGInicmtsogusByWl3DHQdLPQSAYJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=yvbhVqxrKPzSS76x+JTkPkqBbMT25t7GcBE+hiu9Fkvp/+GCfTo4DS8iSMfDiHo50
	 VSoNWGXRJmF5gaWdYtGep3p/HNoaLiLDB3ESKzQHIYLi1tQnbl+MhGpUlGaW3bAARM
	 1zaXvKS6kVmNeSfqPyhs26gZqYes/3is0jNQ5eo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbfCaXtL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731749AbfCaXsq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Mar 2019 19:48:46 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AADE218E2;
        Sun, 31 Mar 2019 23:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554076125;
        bh=AY9LwWVy9qsxNsGInicmtsogusByWl3DHQdLPQSAYJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Nu1XsTyJqHDh8VaoV6qXmfSVXzsoQCsNH7DFvCaz5J2FeECIshA5K7StDXAgJm4CM
         IeQ3Mh1ffAGOFzbFgPhqvIoiMmZmPbsVTYA/9FdRHPTGp4g8CZ2Nstavs6rVFTfqKi
         /NqahskYNgLct/ABxFjxmqMf6mcD2piPz10n1bts=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v5 09/11] selftests/ftrace: Add tracing/error_log testcase
Date:   Sun, 31 Mar 2019 18:48:23 -0500
Message-Id: <bf1c0d47a24672df945331462682d96296d1ab28.1554072478.git.tom.zanussi@linux.intel.com>
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

Add a testcase verifying basic tracing/error_log functionality.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 .../ftrace/test.d/ftrace/tracing-error-log.tc         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
new file mode 100644
index 000000000000..021c03fd885d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - test tracing error log support
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+# event tracing is currently the only ftrace tracer that uses the
+# tracing error_log, hence this check
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || dsig ^== 17) && comm != bash' 'events/signal/signal_generate/filter'
+
+exit 0
-- 
2.14.1

