Return-Path: <SRS0=pHM8=RH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB30C43381
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 23:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96E421019
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 23:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551742631;
	bh=hYpJ/QqCu2VPJ1ziJl6kJTmXakIcDvPOS/KFb9DFnU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=imLchGAiVklP3qkDjLFqxZs3LHsh8yY487KIzrkEYOYF0AwdGc9sPzwDxQbjJE3PE
	 RwIrlIKVWu6SUKkCV9YUW3OVDIMho1O0M2RoBy50HItt5tjBx7kCfpfSs6uDcMpI20
	 KLqxI8QAzh6z5yBJ8RW3Vh8G5KEkQZnLhjMUA/8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfCDXhG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:37:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbfCDXhE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Mar 2019 18:37:04 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1650C2087C;
        Mon,  4 Mar 2019 23:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551742623;
        bh=hYpJ/QqCu2VPJ1ziJl6kJTmXakIcDvPOS/KFb9DFnU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=J5BzDo7sQ75zBh3crU3/ND294/PUnyB203t6tWqe9oK+mZQdioBaTNS+YOc2GEQPj
         UeYHrWV6hikEEFTX5rpUjES0LFaMh43qUKc8GanKMTULGh5NE2Dsr0xz4s7CvLuNez
         Eq2d/akBguOaUE4SnU5lDi6f1mVNFP/eJlDm2vEU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH v3 5/5] tracing: Use tracing error_log with trace event filters
Date:   Mon,  4 Mar 2019 17:36:48 -0600
Message-Id: <a44c5a86c619d9c8b01edf59fe5f8290552f6006.1551741458.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1551741458.git.tom.zanussi@linux.intel.com>
References: <cover.1551741458.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1551741458.git.tom.zanussi@linux.intel.com>
References: <cover.1551741458.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Use tracing_log_err() from the new tracing error_log mechanism to send
filter parse errors to tracing/error_log.

With this change, users will be able to see filter errors by looking
at tracing/error_log.

The same errors will also be available in the filter file, as
expected.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_filter.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index ade606c33231..3a1ed8631aa0 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -66,7 +66,8 @@ static const char * ops[] = { OPS };
 	C(INVALID_FILTER,	"Meaningless filter expression"),	\
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
 	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
-	C(NO_FILTER,		"No filter found"),
+	C(ERRNO,		"Error"),				\
+	C(NO_FILTER,		"No filter found")
 
 #undef C
 #define C(a, b)		FILT_ERR_##a
@@ -76,7 +77,7 @@ enum { ERRORS };
 #undef C
 #define C(a, b)		b
 
-static char *err_text[] = { ERRORS };
+static const char *err_text[] = { ERRORS };
 
 /* Called after a '!' character but "!=" and "!~" are not "not"s */
 static bool is_not(const char *str)
@@ -947,8 +948,10 @@ static void append_filter_err(struct filter_parse_error *pe,
 	if (pe->lasterr > 0) {
 		trace_seq_printf(s, "\n%*s", pos, "^");
 		trace_seq_printf(s, "\nparse_error: %s\n", err_text[pe->lasterr]);
+		tracing_log_err("event filter parse error", filter->filter_string, err_text, pe->lasterr, pe->lasterr_pos);
 	} else {
 		trace_seq_printf(s, "\nError: (%d)\n", pe->lasterr);
+		tracing_log_err("event filter parse error", filter->filter_string, err_text, FILT_ERR_ERRNO, 0);
 	}
 	trace_seq_putc(s, 0);
 	buf = kmemdup_nul(s->buffer, s->seq.len, GFP_KERNEL);
-- 
2.14.1

