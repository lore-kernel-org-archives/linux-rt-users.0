Return-Path: <SRS0=qrdP=RI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C8C43381
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Mar 2019 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B003D208E4
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Mar 2019 14:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551794816;
	bh=e3Wr9HrogkL/ne2p57sdmRzwLACLzbdIpR5KTVjLh2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CY8LjOGO3OnMkYHW5wo0q9shpTeNfN0e+RMm8PATtQOi/sJ6Y/IChCT5bPdlZGH3U
	 jR+oalANhE/SGaW9JyCiM+SiPIt1cwuYXJoVIOomrO9uOMitCBZga/4PX1KgXEJU0I
	 ETOig0/WKz5NC1QZHGcGHmQEYK1s0CWfZnmgXa6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfCEOGv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:06:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfCEOGv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Mar 2019 09:06:51 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2FE20842;
        Tue,  5 Mar 2019 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551794809;
        bh=e3Wr9HrogkL/ne2p57sdmRzwLACLzbdIpR5KTVjLh2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oigU/+87daxe3Hg6DNcE40wBDm2YRhmsHHaxkTgm6y7/tjU+wcmOHoAwW6aP8Po/A
         eooaR2JnoQuXjS59lZrwZwtnlf4XSslB34Z2JwPTm43ztDteeKsi9out8gN4w1h4NB
         mND1NN52mbIABHnqQ+G9GCPylHsipJ/KSghxMrVI=
Date:   Tue, 5 Mar 2019 23:06:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] tracing: common error_log for ftrace
Message-Id: <20190305230646.e7f99c46f86c0e099ac0cd30@kernel.org>
In-Reply-To: <cover.1551741458.git.tom.zanussi@linux.intel.com>
References: <cover.1551741458.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon,  4 Mar 2019 17:36:43 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi,
> 
> This is v3 of the frace error_log RFC patchset, which is the same as
> the previous version but adds the numbering Masami suggested before
> each item in the log.  Masami also said he was going to take over the
> kprobe events patch, but I left it in for now for completeness as it
> still provides a useful example of possible usage, for evaluation of
> the overall scheme.  I'll remove it when it's no longer an RFC.

Ahh, sorry, I'm forcusing on fixing user-space access issue.
I'll take a look.

> 
> Changes from v2:
> 
>   - Added [n] numbering as suggested by Masami

That's very good too me, thank you!


Thank you,


> 
> 
> Text from original post:
> 
> Last April, I posted an RFC patchset [1] implementing a common
> error_log interface as suggested by Masami [2].  We were supposed to
> discuss it at Plumbers but that never happened, and Steve recently
> asked about patches for a follow-on discussion [3], so here they are.
> 
> I incorporated comments from the previous discussion, the most
> important of which are:
> 
>  - Incorporated Steve's suggestion of using static strings as in the
>    existing trace event filter code, along with err_info indexing into
>    the string arrays and a position for the error caret.
> 
>  - Converted all the hist trigger errors and the existing trace event
>    filter parse errors to use the new interface.
> 
>  - Converted a few kprobe_event errors to the new interface as
>    examples, but these will require more work - I didn't spend much
>    time figuring out how to get the full kprobe command into the error
>    info, for instance.
> 
>  - Got rid of the custom single-page ring buffer and used standard
>    lists instead.
> 
> For now, this is implemented on top of the latest 'hist trigger
> snapshot and onchange additions' patchset [4].
> 
> Below is an example session of a few failed commands and the
> corresponding error_log contents:
> 
>   # echo > /sys/kernel/debug/tracing/error_log
> 
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   -su: echo: write error: Invalid argument
> 
>   #  cat /sys/kernel/debug/tracing/error_log
>   [1] hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
> 
>   # echo 'hist:key=comm:p=prio:onchange($q).snapshot()' > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   [1] hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
>   [2] hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
> 
>   # echo 'hist:keys=pid' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   # echo 'hist:keys=pid' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   -su: echo: write error: File exists
>   # echo 'comm="cyclictest"' > /sys/kernel/debug/tracing/events/sched/sched_wakeup/filter
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   [1] hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
>   [2] hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
>   [3] hist:sched:sched_wakeup: error: Hist trigger already exists
>     Command: keys=pid
>              ^
>   [4] event filter parse error: error: Invalid operator
>     Command: comm="cyclictest"
>                   ^
> 
>   # echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" > /sys/kernel/debug/tracing/events/signal/signal_generate/filter
>   -su: echo: write error: Invalid argument
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   [1] hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
>   [2] hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
>   [3] hist:sched:sched_wakeup: error: Hist trigger already exists
>     Command: keys=pid
>              ^
>   [4] event filter parse error: error: Invalid operator
>     Command: comm="cyclictest"
>                   ^
>   [5] event filter parse error: error: Field not found
>     Command: ((sig >= 10 && sig < 15) || dsig == 17) && comm != bash
>                                               ^  
> 
> 
> Thanks,
> 
> Tom
> 
> [1] https://lore.kernel.org/lkml/cover.1523545519.git.tom.zanussi@linux.intel.com/
> [2] https://lore.kernel.org/lkml/20180406105309.b50ea1a21d2cbd9b0e39dbfd@kernel.org/
> [3] https://lore.kernel.org/lkml/e885d1fd02e76f121d6cc2bb28e58b523e2434a7.camel@linux.intel.com/
> [4] https://lore.kernel.org/lkml/cover.1549403369.git.tom.zanussi@linux.intel.com/
> 
> 
> The following changes since commit 9e5a36a3371f48fef0ebea6826d1d66f6201c522:
> 
>   tracing: Fix spelling mistake: "analagous" -> "analogous" (2019-02-20 13:51:08 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/error_log_v3
> 
> Tom Zanussi (5):
>   tracing: Add tracing error log
>   tracing: Save the last hist command's associated event name
>   tracing: Use tracing error_log with hist triggers
>   tracing: Use tracing error_log with kprobe events (incomplete)
>   tracing: Use tracing error_log with trace event filters
> 
>  kernel/trace/trace.c               | 217 ++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace.h               |   4 +
>  kernel/trace/trace_events_filter.c |   7 +-
>  kernel/trace/trace_events_hist.c   | 221 ++++++++++++++++++++-----------------
>  kernel/trace/trace_probe.c         |  24 +++-
>  5 files changed, 368 insertions(+), 105 deletions(-)
> 
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
