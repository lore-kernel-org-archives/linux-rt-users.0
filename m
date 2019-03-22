Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8748C43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCDD20850
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553268932;
	bh=FOzyFw9Nzdn6GLTWdR5w5+Ass3PSwX4ef7DVQBm1HRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=X4lL/5xQvNwxFh1JWey4e+/hOEAD/3btKburNQLPSpA4qz/LM8/ScOsnvrbJ+ozYS
	 wc562F9aCQHnuENYIC7t7QdNpSKph7rOoNk/30h2dnmIK50hvIXBFtT++AD/asICAe
	 OSS4Sk+wjS2PPeAglXynHIpu89s7v2qxP6xzUnrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfCVPf2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCVPe5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Mar 2019 11:34:57 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEB7F21934;
        Fri, 22 Mar 2019 15:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553268897;
        bh=FOzyFw9Nzdn6GLTWdR5w5+Ass3PSwX4ef7DVQBm1HRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NyKROxOsmOb0voFGCTg1siYssih3agrvXkZJXdiVZ5B4uhM386+4aiF9TssX8lbav
         yFVEPYY7XSFiA7k2aPjtd/DadfZrOBLxISxEaL4aSjNs0HCcxJDcpWvOQRO2lTNyhb
         W5QM+JVuAHYAg/KlPYeF5EwvebECSKZHNTj7QnzA=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 08/11] selftests/ftrace: Add tracing/error_log testcase
Date:   Fri, 22 Mar 2019 10:34:34 -0500
Message-Id: <a0b936b8ba26b6c55bddc7d5ec22fc40e49a77b9.1553268041.git.tom.zanussi@linux.intel.com>
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

Add a testcase verifying basic tracing/error_log functionality.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../ftrace/test.d/ftrace/tracing-error-log.tc      | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
new file mode 100644
index 000000000000..601ffebfbb9f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
@@ -0,0 +1,23 @@
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
+echo "Test tracing error log support"
+! echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" > events/signal/signal_generate/filter 2> /dev/null
+if ! grep "error:" error_log; then
+    fail "Failed to generate tracing error log error"
+fi
+
+exit 0
-- 
2.14.1

