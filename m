Return-Path: <SRS0=6AJS=3U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F110C33CB7
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55D6217BA
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 21:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580507744;
	bh=viAoTCaO1m1Vo5Q7sqWuitqv5fTLllyjBX3fssC4RdA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lTQLKUZIuFu+Zr0Z6RXKljcMDaaRYJnw7iZXQ/zb2Hv+8colI104KyiDsOOjHUJMb
	 lLTvVwN/euUWXloDhQkFBuTMmbWLhO4Fu+BFZygTJ2CJDbPcKwhUAXHCdTJ3YGjBfk
	 iMMm3zsVvqFtlcmQpb3xXb7DyOO+MZyu6OrH4How=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgAaVzl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:55:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgAaVzl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Jan 2020 16:55:41 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630FF20705;
        Fri, 31 Jan 2020 21:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580507740;
        bh=viAoTCaO1m1Vo5Q7sqWuitqv5fTLllyjBX3fssC4RdA=;
        h=From:To:Cc:Subject:Date:From;
        b=wMFTLciLpsYEXBipuTJBv1Oww9EdprlwI64E9qzQSCrqPxP56U47INM16eMMxgXHn
         qSfcw1JNb08O1CIkZeLAONrKiBAaqyxM7QU01GexnuBBL+T2bvoPRESAtxmgFwzFYp
         TWAKwDhYH87GmR0Rivpct1QTYTolpmK78e2UmKr4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 0/4] tracing: Updates to dynamic event API
Date:   Fri, 31 Jan 2020 15:55:30 -0600
Message-Id: <cover.1580506712.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

This patchset adds some updates to the 'tracing: Add support for
in-kernel dynamic event API', on top of ftrace/core, addressing the
comments from v4 of that:

  - Consolidate the very similar functions
    synth_event_add_val/next_val() and inline find_synth_field(), as
    suggested by Steve

  - Replace the command-building code in dynevent_cmd with equivalent
    seq_buf functionality, as suggested by Steve

  - Move the check_arg callbacks from the arg objects and explicitly
    pass them to the add functions, as suggested by Masami

  - Get rid of a useless bit of code in dynevent_add_arg_pair() as
    suggested by Masami

With these changes the dynamic event test modules work fine and the
trigger selftests all pass.

Thanks,

Tom


The following changes since commit d380dcde9a07ca5de4805dee11f58a98ec0ad6ff:

  tracing: Fix now invalid var_ref_vals assumption in trace action (2020-01-31 12:59:26 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-event-gen-updates-v1

Tom Zanussi (4):
  tracing: Consolidate some synth_event_trace code
  tracing: Remove check_arg() callbacks from dynevent args
  tracing: Remove useless code in dynevent_arg_pair_add()
  tracing: Use seq_buf for building dynevent_cmd string

 include/linux/trace_events.h     |   4 +-
 kernel/trace/trace_dynevent.c    | 110 ++++++++++-----------------
 kernel/trace/trace_dynevent.h    |  11 ++-
 kernel/trace/trace_events_hist.c | 157 ++++++++++++++++-----------------------
 kernel/trace/trace_kprobe.c      |  12 +--
 5 files changed, 118 insertions(+), 176 deletions(-)

-- 
2.14.1

