Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3A2C43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 15:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D13218FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553268886;
	bh=yE23CXSgMZVJk/f6Xgdzvhp7ReeofiFb/vufFYHaYOo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=E7D7MukgLtA/5d9kqjfWtbUKRtloc0gtTjajpwlJbmWOP7J+dvdEpEGXCpMi8FGv/
	 kjvT+Mjot4P7c8wXLiQj9pSUakOiDm6dG2a9EI3CwkBbOanAsvzpt9eA7wBftJuH00
	 VUQB9ehbXgGunneukfPZNEW7H3YSX7Fb7wBVUyqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfCVPeq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfCVPep (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Mar 2019 11:34:45 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDDE720850;
        Fri, 22 Mar 2019 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553268883;
        bh=yE23CXSgMZVJk/f6Xgdzvhp7ReeofiFb/vufFYHaYOo=;
        h=From:To:Cc:Subject:Date:From;
        b=A8Ii8knK1fvXuNsb8A0aBKZkW8If53PxpHoJReFLDIZkBzHGUkFCMqTWfV/3M23Ix
         sMlvBcVei2FW3IO5UmgW9d02vTcn8NcNNI9ZGNfkzk1rp3noMT65SJb3OIVxbTu8x8
         SrVkcfCDW8oKec+jvpKmqdnogBs7prlSqCwTE5y4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 00/11] tracing: common error_log for ftrace
Date:   Fri, 22 Mar 2019 10:34:26 -0500
Message-Id: <cover.1553268040.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi,

This is v4 of the frace error_log patchset.  This version adds
Masami's probe events error_log patches and removes the previous
placeholder for that.  It also removes the hist trigger extended error
err testcase and replaces it with a basic error_log functionality
testcase, and replaces the error numbering with timestamps, also as
suggested by Masami.  Finally, the Documentation and README are both
updated to describe the error_log.

Note: The probe event error_log test cases failed on my Ubuntu system,
due to the >& redirection operator that dash doesn't understand, so I
tacked on a final patch that fixes it for me.  If acceptable, feel
free to just merge it with Masami's patch.

Changes from v3:

  - Added Masami's [PATCH 05/11] tracing: Use tracing error_log with probe events
  - Added Masami's [PATCH 06/11] selftests/ftrace: Add error_log testcase for probe
  - Added [PATCH 11/11] to fix [PATCH 06/11]
  - Removed [RFC PATCH v3 4/5] tracing: Use tracing error_log with kprobe events
  - Added [PATCH 08/11] selftests/ftrace: Add tracing/error_log testcase
  - Removed trigger-extended-error-support testcase
  - Changed [n] numbering to [timestamp] numbering as suggested by Masami
  - Updated Documentation and README

Changes from v2:

  - Added [n] numbering as suggested by Masami


Text from original post:

Last April, I posted an RFC patchset [1] implementing a common
error_log interface as suggested by Masami [2].  We were supposed to
discuss it at Plumbers but that never happened, and Steve recently
asked about patches for a follow-on discussion [3], so here they are.

I incorporated comments from the previous discussion, the most
important of which are:

 - Incorporated Steve's suggestion of using static strings as in the
   existing trace event filter code, along with err_info indexing into
   the string arrays and a position for the error caret.

 - Converted all the hist trigger errors and the existing trace event
   filter parse errors to use the new interface.

 - Converted a few kprobe_event errors to the new interface as
   examples, but these will require more work - I didn't spend much
   time figuring out how to get the full kprobe command into the error
   info, for instance.

 - Got rid of the custom single-page ring buffer and used standard
   lists instead.

For now, this is implemented on top of the latest 'hist trigger
snapshot and onchange additions' patchset [4].

Below is an example session of a few failed commands and the
corresponding error_log contents:

  # echo > /sys/kernel/debug/tracing/error_log

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  -su: echo: write error: Invalid argument

  #  cat /sys/kernel/debug/tracing/error_log
  [  217.431858] hist:sched:sched_wakeup: error: Variable already defined
    Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
                      ^

  # echo 'hist:key=comm:p=prio:onchange($q).snapshot()' > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
  -su: echo: write error: Invalid argument

  # cat /sys/kernel/debug/tracing/error_log
  [  217.431858] hist:sched:sched_wakeup: error: Variable already defined
    Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
                      ^
  [  311.554978] hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
    Command: key=comm:p=prio:onchange($q).snapshot()
                                       ^

  # echo 'hist:keys=pid' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  # echo 'hist:keys=pid' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  -su: echo: write error: File exists
  # echo 'comm="cyclictest"' > /sys/kernel/debug/tracing/events/sched/sched_wakeup/filter
  -su: echo: write error: Invalid argument

  # cat /sys/kernel/debug/tracing/error_log
  [  217.431858] hist:sched:sched_wakeup: error: Variable already defined
    Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
                      ^
  [  311.554978] hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
    Command: key=comm:p=prio:onchange($q).snapshot()
                                       ^
  [  715.626153] hist:sched:sched_wakeup: error: Hist trigger already exists
    Command: keys=pid
             ^
  [  730.480310] event filter parse error: error: Invalid operator
    Command: comm="cyclictest"
                  ^

  # echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" > /sys/kernel/debug/tracing/events/signal/signal_generate/filter
  -su: echo: write error: Invalid argument

  # cat /sys/kernel/debug/tracing/error_log
  [  217.431858] hist:sched:sched_wakeup: error: Variable already defined
    Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
                      ^
  [  311.554978] hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
    Command: key=comm:p=prio:onchange($q).snapshot()
                                       ^
  [  715.626153] hist:sched:sched_wakeup: error: Hist trigger already exists
    Command: keys=pid
             ^
  [  730.480310] event filter parse error: error: Invalid operator
    Command: comm="cyclictest"
                  ^
  [  800.548673] event filter parse error: error: Field not found
    Command: ((sig >= 10 && sig < 15) || dsig == 17) && comm != bash
                                              ^


Thanks,

Tom

[1] https://lore.kernel.org/lkml/cover.1523545519.git.tom.zanussi@linux.intel.com/
[2] https://lore.kernel.org/lkml/20180406105309.b50ea1a21d2cbd9b0e39dbfd@kernel.org/
[3] https://lore.kernel.org/lkml/e885d1fd02e76f121d6cc2bb28e58b523e2434a7.camel@linux.intel.com/
[4] https://lore.kernel.org/lkml/cover.1549403369.git.tom.zanussi@linux.intel.com/


The following changes since commit a039480e9e93896cadc5a91468964febb3c5d488:

  tracing/probe: Verify alloc_trace_*probe() result (2019-03-14 19:54:21 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/error_log_v4

Masami Hiramatsu (2):
  tracing: Use tracing error_log with probe events
  selftests/ftrace: Add error_log testcase for probe errors

Tom Zanussi (9):
  tracing: Add tracing error log
  tracing: Save the last hist command's associated event name
  tracing: Use tracing error_log with hist triggers
  tracing: Use tracing error_log with trace event filters
  tracing: Remove trigger-extended-error-support testcase
  selftests/ftrace: Add tracing/error_log testcase
  tracing: Add tracing/error_log Documentation
  tracing: Add error_log to README
  selftests/ftrace: Change stderr redirection for probe error_log
    testcase

 Documentation/trace/ftrace.rst                     |  31 +++
 Documentation/trace/histogram.rst                  |  16 +-
 kernel/trace/trace.c                               | 224 +++++++++++++++++
 kernel/trace/trace.h                               |   4 +
 kernel/trace/trace_events_filter.c                 |   7 +-
 kernel/trace/trace_events_hist.c                   | 221 +++++++++--------
 kernel/trace/trace_kprobe.c                        |  77 +++---
 kernel/trace/trace_probe.c                         | 274 +++++++++++++++------
 kernel/trace/trace_probe.h                         |  77 +++++-
 kernel/trace/trace_uprobe.c                        |  44 +++-
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |  23 ++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  93 +++++++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |  31 +++
 .../inter-event/trigger-extended-error-support.tc  |  28 ---
 14 files changed, 883 insertions(+), 267 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
 delete mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc

-- 
2.14.1

