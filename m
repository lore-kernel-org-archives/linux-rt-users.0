Return-Path: <SRS0=WKTr=4A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B8C2BA83
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 05:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C05420848
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 05:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581486867;
	bh=ZrjcmZM12h0EldXJ8Giqwii9I5qf6RI9hpKRyNmH38c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=v+z/gCa+/s95T6DDbQrunXQuIsiHK23YxnbyRPZq11AIINgmrND3S5VqSGF6ZfsY6
	 cAFrpRGMJ4IvwZLxVDAP47Jv78bo3PSbvgCeVR0wjiqXFhLSfYanR6DFa3hSTsaIU1
	 B2l+kzWeKn6vmcSnIrBDJenWC7Dv1sZ66buv5y6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgBLFyY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:54:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgBLFyX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Feb 2020 00:54:23 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB642073C;
        Wed, 12 Feb 2020 05:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581486863;
        bh=ZrjcmZM12h0EldXJ8Giqwii9I5qf6RI9hpKRyNmH38c=;
        h=From:To:Cc:Subject:Date:From;
        b=wAcKbsEWkDj0E5NJtwA78tMBkG+1OLa+YNG7fY/00SBwbIyHXVJSQFAe+HKihrXsp
         JwX+6QyW5N5aH+24AfRh4lx+C+qYTe2KK8vQ6CWGYWl2wt674ghTWY44eTtj/jqo2I
         qImC+7bjwHY32BNBEpJIx4U/eybys6k19YZjpR4g=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH] tracing: Skip software disabled event at __synth_event_trace_end()
Date:   Wed, 12 Feb 2020 14:54:19 +0900
Message-Id: <158148685911.20407.3538292497442671878.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When the synthetic event is software disabled,
__synth_event_trace_start() does not allocate an event buffer.
In this case __synth_event_trace_end() also should not commit
the buffer.

Check the trace_state->disabled at __synth_event_trace_end()
and if it is disabled, skip it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 483b3fd1094f..781e4b55e117 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1847,6 +1847,9 @@ __synth_event_trace_start(struct trace_event_file *file,
 static inline void
 __synth_event_trace_end(struct synth_event_trace_state *trace_state)
 {
+	if (trace_state->disabled)
+		return;
+
 	trace_event_buffer_commit(&trace_state->fbuffer);
 
 	ring_buffer_nest_end(trace_state->buffer);

