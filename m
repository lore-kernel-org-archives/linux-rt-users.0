Return-Path: <SRS0=867U=SC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825AAC43381
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB622085A
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554076169;
	bh=AIeQGK6cgxA0DoFZUEAZu64UTMCZ2SqX+AVtfvSklYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=AT1csMoGvoQOe8+uf77oL/Chi9bIM4QpwB3M7eaEm845dOMx3H0km8bOwcScH5gEg
	 a/pl8JMqa0MESqABGYez7B3NaI4ibX5FDeYG0LlcjLG4W9+jEj++Uh3J2vj3BQI+RB
	 fo4BTeezVTP+mjlwuGcPvgm1J17uRnlfRnVPrA6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbfCaXsi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbfCaXsi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Mar 2019 19:48:38 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A9B620882;
        Sun, 31 Mar 2019 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554076117;
        bh=AIeQGK6cgxA0DoFZUEAZu64UTMCZ2SqX+AVtfvSklYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=zC8foOoyRMYULFM2faIzs3lV1i6Vwsne5porRsmxIXzRShdLyTJV060BuButb3VYU
         Vw9oy56CYNXPLkkWnp+8UCCyfeQx5+/xsX5x4cEorK7U/s/jQjb4qvqT5Tpbc7u3jL
         IB9vd0MCsE3mcThqHCPpFlwqbs5K3X7q7bhv4ZWo=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v5 04/11] tracing: Use tracing error_log with trace event filters
Date:   Sun, 31 Mar 2019 18:48:18 -0500
Message-Id: <1d942c419941539a11d78a6810fc5740a99b2974.1554072478.git.tom.zanussi@linux.intel.com>
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

Use tracing_log_err() from the new tracing error_log mechanism to send
filter parse errors to tracing/error_log.

With this change, users will be able to see filter errors by looking
at tracing/error_log.

The same errors will also be available in the filter file, as
expected.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/trace/trace_events_filter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 05a66493a164..290d42c59101 100644
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
@@ -947,8 +948,14 @@ static void append_filter_err(struct filter_parse_error *pe,
 	if (pe->lasterr > 0) {
 		trace_seq_printf(s, "\n%*s", pos, "^");
 		trace_seq_printf(s, "\nparse_error: %s\n", err_text[pe->lasterr]);
+		tracing_log_err("event filter parse error",
+				filter->filter_string, err_text,
+				pe->lasterr, pe->lasterr_pos);
 	} else {
 		trace_seq_printf(s, "\nError: (%d)\n", pe->lasterr);
+		tracing_log_err("event filter parse error",
+				filter->filter_string, err_text,
+				FILT_ERR_ERRNO, 0);
 	}
 	trace_seq_putc(s, 0);
 	buf = kmemdup_nul(s->buffer, s->seq.len, GFP_KERNEL);
-- 
2.14.1

