Return-Path: <SRS0=+Dnv=36=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8365FC352A4
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Feb 2020 23:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DB220870
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Feb 2020 23:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581376029;
	bh=48qkNtFtbLUcRrd7NZuaEhL1NqKHTa0Qin9utPL3mMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=aNqlOThDK4Ecd1fj+FQB2GC0hvEEWyq1KdS1GhePdpP5R4ukOgL8sPIxANwYLmTP/
	 LMyMFKp/myAySxhxq+4ntWfJFV57H8n4fpgiOIi0mUCeX4cIb/BBSInNLjjNb3eIqn
	 7GIBm9GMwaC2+IoK1U45vhWHvQiFRsjVsbhhVV4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgBJXHB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:07:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbgBJXHA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Feb 2020 18:07:00 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C417820838;
        Mon, 10 Feb 2020 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581376019;
        bh=48qkNtFtbLUcRrd7NZuaEhL1NqKHTa0Qin9utPL3mMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=zKlSMROhkBi/WxyLku/EJybSA3DF2H5CUVIEX8rE78S4i4MUTYFEy7d0Js6+I6+fH
         Lo4/r/AaF+67jbQgemScCN1e9qcZ+I3ei5RHDX1OLB4Pjey6JVZc2jBye5eW7FE0R5
         wIvRTZcKw75OecXue2ymvw7Ynr/XN7ROdnf2zgGg=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 2/3] tracing: Don't return -EINVAL when tracing soft disabled synth events
Date:   Mon, 10 Feb 2020 17:06:49 -0600
Message-Id: <df5d02a1625aff97c9866506c5bada6a069982ba.1581374549.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1581374549.git.zanussi@kernel.org>
References: <cover.1581374549.git.zanussi@kernel.org>
In-Reply-To: <cover.1581374549.git.zanussi@kernel.org>
References: <cover.1581374549.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There's no reason to return -EINVAL when tracing a synthetic event if
it's soft disabled - treat it the same as if it were hard disabled and
return normally.

Have synth_event_trace() and synth_event_trace_array() just return
normally, and have synth_event_trace_start set the trace state to
disabled and return.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a546ffa14785..99a02168599b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1828,7 +1828,8 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 	 * called directly by the user, we don't have that but we
 	 * still need to honor not logging when disabled.
 	 */
-	if (!(file->flags & EVENT_FILE_FL_ENABLED))
+	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
+	    trace_trigger_soft_disabled(file))
 		return 0;
 
 	event = file->event_call->data;
@@ -1836,9 +1837,6 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 	if (n_vals != event->n_fields)
 		return -EINVAL;
 
-	if (trace_trigger_soft_disabled(file))
-		return -EINVAL;
-
 	fields_size = event->n_u64 * sizeof(u64);
 
 	/*
@@ -1918,7 +1916,8 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 	 * called directly by the user, we don't have that but we
 	 * still need to honor not logging when disabled.
 	 */
-	if (!(file->flags & EVENT_FILE_FL_ENABLED))
+	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
+	    trace_trigger_soft_disabled(file))
 		return 0;
 
 	event = file->event_call->data;
@@ -1926,9 +1925,6 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 	if (n_vals != event->n_fields)
 		return -EINVAL;
 
-	if (trace_trigger_soft_disabled(file))
-		return -EINVAL;
-
 	fields_size = event->n_u64 * sizeof(u64);
 
 	/*
@@ -2017,7 +2013,8 @@ int synth_event_trace_start(struct trace_event_file *file,
 	 * trace case, we save the enabed state upon start and just
 	 * ignore the following data calls.
 	 */
-	if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
+	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
+	    trace_trigger_soft_disabled(file)) {
 		trace_state->enabled = false;
 		goto out;
 	}
@@ -2026,11 +2023,6 @@ int synth_event_trace_start(struct trace_event_file *file,
 
 	trace_state->event = file->event_call->data;
 
-	if (trace_trigger_soft_disabled(file)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	fields_size = trace_state->event->n_u64 * sizeof(u64);
 
 	/*
-- 
2.14.1

