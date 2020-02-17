Return-Path: <SRS0=Nlir=4F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A231C7619F
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 09:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2921D20726
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581933164;
	bh=N1gr0iMUdKSKGadZk62888X+xl8+EVRCijheJf6zyig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VhMf+vy0SAiDzLNTcdBXlawxp2ammEIhYGwJEWX3DMUA1fdQtlx78N8hLFGjLwXnD
	 ftOxlLCIPGX4ie6Ix6nnSc11TBpj+6tigCg5yxzxUW0pBmkdU0ljPQHTRLZKcyECge
	 4HwQNJJ6a0xB4XQi5mbYm+0g344yvBlzNnpkHFK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgBQJwn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:52:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgBQJwn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Feb 2020 04:52:43 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9907020732;
        Mon, 17 Feb 2020 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581933163;
        bh=N1gr0iMUdKSKGadZk62888X+xl8+EVRCijheJf6zyig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSqNSJAev+4OWmSIkFgBRMXMJVtkHkNGm/ytg+n6zprERR0pVkXKRniyBm+l0zUio
         VnmPGbbw6SSuEuj43HcFAz7zjr4sPUWEmYuqcz63+rtUBZObtUAXSXknFyyDfMejX+
         S3Euear2STNX4u8JPvOM0WedZtllE4HDaeY4J1H4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 2/2] tracing: Clear trace_state when starting trace
Date:   Mon, 17 Feb 2020 18:52:39 +0900
Message-Id: <158193315899.8868.1781259176894639952.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158193313870.8868.10793333111731425487.stgit@devnote2>
References: <158193313870.8868.10793333111731425487.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Clear trace_state data structure when starting trace
in __synth_event_trace_start() internal function.

Currently trace_state is initialized only in the
synth_event_trace_start() API, but the trace_state
in synth_event_trace() and synth_event_trace_array()
are on the stack without initialization.
This means those APIs will see wrong parameters and
wil skip closing process in __synth_event_trace_end()
because trace_state->disabled may be !0.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7f0e5cdf17ae..9ec0a7551d62 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1798,6 +1798,8 @@ __synth_event_trace_start(struct trace_event_file *file,
 	int entry_size, fields_size = 0;
 	int ret = 0;
 
+	memset(trace_state, '\0', sizeof(*trace_state));
+
 	/*
 	 * Normal event tracing doesn't get called at all unless the
 	 * ENABLED bit is set (which attaches the probe thus allowing
@@ -1993,8 +1995,6 @@ int synth_event_trace_start(struct trace_event_file *file,
 	if (!trace_state)
 		return -EINVAL;
 
-	memset(trace_state, '\0', sizeof(*trace_state));
-
 	ret = __synth_event_trace_start(file, trace_state);
 	if (ret == -ENOENT)
 		ret = 0; /* just disabled, not really an error */

