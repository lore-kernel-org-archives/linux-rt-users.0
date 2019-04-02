Return-Path: <SRS0=WXxn=SE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BECC4360F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 18:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4422147C
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 18:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDBSez (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfDBSey (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Apr 2019 14:34:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2881E2084B;
        Tue,  2 Apr 2019 18:34:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBOFJ-0008It-7y; Tue, 02 Apr 2019 14:34:53 -0400
Message-Id: <20190402182951.130809543@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 02 Apr 2019 14:29:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC][PATCH 0/3] tracing: Make error_log per instance
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

I noticed that you created an error_log file in every instance, but
they all show the same errors. These three patches make it so that
the errors appear in the instance directory that they happened in.
If you write a bad error to

   /sys/kernel/tracing/instance/foo/events/sched/sched_switch/hist

It appears only in

  /sys/kernel/tracing/instances/foo/error_log

Which I think is the proper approach, especially instances should not
affect the top directory or other instances.

For those errors that do not have an associated instance (creating a
kprobe/uprobe event or perf), a NULL passed to tracing_log_err() will
result in the error message in the top level error message.

Do you (or Masami) have any issues with this patch set?

If not, please add a "reviewed-by" or "acked-by" and I'll add it
to your patch series and push them to for-next (after more testing).

If this isn't obvious, this patch series is on top of:

  http://lkml.kernel.org/r/cover.1554072478.git.tom.zanussi@linux.intel.com

Actually, I added it right after patch 5 of that series (before the
selftests and documentation).

Thanks!

-- Steve



Steven Rostedt (VMware) (3):
      tracing: Add trace_array parameter to create_event_filter()
      tracing: Have histogram code pass around trace_array for error handling
      tracing: Have the error logs show up in the proper instances

----
 kernel/trace/trace.c                |  55 +++++++++-----
 kernel/trace/trace.h                |   8 +-
 kernel/trace/trace_events_filter.c  |  25 ++++---
 kernel/trace/trace_events_hist.c    | 145 ++++++++++++++++++++----------------
 kernel/trace/trace_events_trigger.c |   3 +-
 kernel/trace/trace_probe.c          |   2 +-
 6 files changed, 142 insertions(+), 96 deletions(-)
