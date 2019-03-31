Return-Path: <SRS0=867U=SC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FB9C43381
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331E620879
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554076181;
	bh=gT72AO5XoeGnMxtO/2irPnOGf0q3YItK0tNLbtPQgyA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KIsK+4n7PwRowUqKnRgiySNbTU9M1qDD+RlfV3AdesaK6ICfqVjnM3JPtdAHNG26e
	 h5Kcx9oUR6yrR1XQ5HmEcfnLTfZWjAfYzRoUxAwXzwdVxtM4qhi3wuiLJsWHWIftFx
	 0m/6/rf2r7MetvbKFwCS/ZeWgRQrLaAhRl+uEafE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfCaXsd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731335AbfCaXsc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Mar 2019 19:48:32 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A80B2085A;
        Sun, 31 Mar 2019 23:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554076111;
        bh=gT72AO5XoeGnMxtO/2irPnOGf0q3YItK0tNLbtPQgyA=;
        h=From:To:Cc:Subject:Date:From;
        b=Xk+ydEQsmQdpJt+hVtz1ugHkxfrBL7MVGaeuAis2kNyhgpGWCtXLlKgS9GNQc8XZG
         g+2jwlQFg8pMFpCgKrLQSmxg46WI9wajk7Nxsp2Nxc1hDY4MO3p3Xb4Xn9UHmvvwp1
         IVBhhdPaNcxMJjC3nriWWS66DgWoc2NfohDfZaEk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v5 00/11] tracing: common error_log for ftrace
Date:   Sun, 31 Mar 2019 18:48:14 -0500
Message-Id: <cover.1554072478.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi,

This is v5 of the frace error_log patchset.  This version updates the
patches according to suggestions from Masami and Namhyung and moves
some of the selftest code from the kprobe/uprobe testcases to a common
function that can be reused by multiple testcases, including the new
error_log testcase.

Changes from v4:

  - Merged in the >& -> 2> redirection patch into '[PATCH v5 06/11]
    selftests/ftrace: Add error_log testcase for probe errors'
  - Added new patch, '[PATCH v5 07/11] selftests/ftrace: Move
    kprobe/uprobe check_error() to test.d/functions' that adds a new
    ftrace_errlog_check() to test.d/functions, which is based on
    check_error() from '[PATCH v5 06/11] selftests/ftrace: Add
    error_log testcase for probe errors'
  - Modified the kprobe/uprobe test cases to use the common
    ftrace_errlog_check()
  - Modified the error_log test cases to display the error position
    using the common ftrace_errlog_check()
  - Updated subject for '[PATCH v5 08/11] selftests/ftrace: Remove
    trigger-extended-error-support testcase
  - Streamlined the error_log open and write file operations as
    suggested by Masami
  - Fixed the long lines in '[PATCH v4 04/11] tracing: Use tracing
    error_log with trace event filters' as suggested by Namhyung

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


The following changes since commit 01c4e8042fc949018b70ded769f959bc3d80e8b6:

  tracing: initialize variable in create_dyn_event() (2019-03-22 15:19:34 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/error_log_v5

Masami Hiramatsu (2):
  tracing: Use tracing error_log with probe events
  selftests/ftrace: Add error_log testcase for probe errors

Tom Zanussi (9):
  tracing: Add tracing error log
  tracing: Save the last hist command's associated event name
  tracing: Use tracing error_log with hist triggers
  tracing: Use tracing error_log with trace event filters
  selftests/ftrace: Move kprobe/uprobe check_error() to test.d/functions
  selftests/ftrace: Remove trigger-extended-error-support testcase
  selftests/ftrace: Add tracing/error_log testcase
  tracing: Add tracing/error_log Documentation
  tracing: Add error_log to README

 Documentation/trace/ftrace.rst                     |  31 +++
 Documentation/trace/histogram.rst                  |  16 +-
 kernel/trace/trace.c                               | 219 ++++++++++++++++
 kernel/trace/trace.h                               |   4 +
 kernel/trace/trace_events_filter.c                 |  11 +-
 kernel/trace/trace_events_hist.c                   | 221 +++++++++--------
 kernel/trace/trace_kprobe.c                        |  77 +++---
 kernel/trace/trace_probe.c                         | 274 +++++++++++++++------
 kernel/trace/trace_probe.h                         |  77 +++++-
 kernel/trace/trace_uprobe.c                        |  44 +++-
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |  19 ++
 tools/testing/selftests/ftrace/test.d/functions    |  12 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  85 +++++++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |  23 ++
 .../inter-event/trigger-extended-error-support.tc  |  28 ---
 15 files changed, 874 insertions(+), 267 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
 delete mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc

-- 
2.14.1

