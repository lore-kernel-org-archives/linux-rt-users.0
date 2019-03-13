Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6971C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6342183F
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552480063;
	bh=I9t5tejiHd9/lcIsk8SWy6NnurkuYArSRJZW8bqXfOs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=md1F3TX0FZfD2pgSGbfn2+FCWfHOCnOQ12qiKov4b7OjbT7bFyAxC8PDtelUn1bCd
	 2VK3z4sy49VkkeLVt+yOdcp/wsc0jOoIQYCAJQy+5Heb4uPi1Yx5hQzn8M6EGSOFrv
	 nIt8gB1ElkzMsi4GrWE6htzeeBxj/T+KCJEz1V/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCMM1i (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfCMM1i (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 08:27:38 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1734D214AE;
        Wed, 13 Mar 2019 12:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552480057;
        bh=I9t5tejiHd9/lcIsk8SWy6NnurkuYArSRJZW8bqXfOs=;
        h=From:To:Cc:Subject:Date:From;
        b=iMfTr9cMsl2rFtJOiXmJbYRh4LS+utU0tAshLuc94ZvZrCvKAIIUkPc86khO4iF8E
         7/iNpw7+r9MLtzr14VptT/ky+TXwTKbx/bTSGzKO7Lzc63KHB+mKMvHfNJKP8wBeSf
         7h3RsPOtCpS8yi9DR4gvqXkgTx0N3BzzNPkyQu40=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH 0/7] tracing: Use common error_log with probe events
Date:   Wed, 13 Mar 2019 21:27:32 +0900
Message-Id: <155248005229.10815.334731901778152247.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

Here is a series of patches which applies common error_log framework to
probe events. While applying it, I found I missed to check some errors
in parser. Also, I made a testcase for this feature (only for kprobe
event side, please make your test for the hist errors too).
Thus I made this as a series which contains some bugfixes (a kind of
hardening), cleanups, and a test besides of the main patch.

Please feel free to pick this series to your series. I think some
bugfixes might be better to push Steve's urgent branch.
Let's talk with Steve.

Oh, note that this series can be applied on your v3 series, except
for [4/5] :)

Thank you,

---

Masami Hiramatsu (7):
      tracing/probe: Check maxactive error cases
      tracing/probe: Check event name length correctly
      tracing/probe: Check the size of argument name and body
      tracing/probe: Check event/group naming rule at parsing
      tracing/probe: Verify alloc_trace_*probe() result
      tracing: Use tracing error_log with probe events
      selftests/ftrace: Add error_log testcase for kprobe errors


 kernel/trace/trace_kprobe.c                        |   90 ++++--
 kernel/trace/trace_probe.c                         |  280 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   76 +++++
 kernel/trace/trace_uprobe.c                        |   43 ++-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   91 +++++++
 5 files changed, 449 insertions(+), 131 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc

--
Masami Hiramatsu <mhiramat@kernel.org>
