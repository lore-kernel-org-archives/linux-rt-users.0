Return-Path: <SRS0=Nlir=4F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197FEC7619F
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 09:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D6E20732
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581933148;
	bh=2J/z8SFQiV7BNjm9mq9AFuHAMTcQSCIvvA+sulJo2RA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lMwjvPolnPDPZqDa5DwERBM0N5rLdBI17YXzKYu8MwVvG7YA59oKq1qBwUAjnMlU6
	 MLoV/zXL80dP0ta8101isFm6vOKn7QAfPI5tMKA1rMOemIFYLxCouYelid7APaIk0L
	 cxoMTruNz3sQwYlrMP3iSOTG+HWR9GNFmWHzZdJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgBQJwY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgBQJwY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Feb 2020 04:52:24 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6817D206F4;
        Mon, 17 Feb 2020 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581933143;
        bh=2J/z8SFQiV7BNjm9mq9AFuHAMTcQSCIvvA+sulJo2RA=;
        h=From:To:Cc:Subject:Date:From;
        b=z//xCx6A1WFNprJGSbo/mCq2nPQik0eNEr1zjSxF8LpwZOEqhUyWofL38R4pfA/TK
         KGxJXPA5Edp3wp5n8GcHUuj2egIPd5Wt2N8mf+r/Wmu2ec+fiovW+eWAU5YxeG5Hkz
         US+45+nrU47mqb2twn6Zj0zscsvn8NcD+/7+G66g=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 0/2] tracing: Fix synthetic event generation API and test
Date:   Mon, 17 Feb 2020 18:52:18 +0900
Message-Id: <158193313870.8868.10793333111731425487.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Here is a couple of patches to fix 2 issues LKP and I found on
synthetic event generation test.

[1/2] is for fixing warnings on smp_processor_id() without
disabling preemption, and [2/2] is for fixing a bug on the API
itself which LKP reported.

Thank you,

---

Masami Hiramatsu (2):
      tracing: Fix synth event test to avoid using smp_processor_id()
      tracing: Clear trace_state when starting trace


 kernel/trace/synth_event_gen_test.c |   23 +++++++++++++++++------
 kernel/trace/trace_events_hist.c    |    4 ++--
 2 files changed, 19 insertions(+), 8 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
