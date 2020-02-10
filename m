Return-Path: <SRS0=+Dnv=36=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6AAC352A4
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Feb 2020 23:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE443214DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Feb 2020 23:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581376033;
	bh=v4MWXkBpT97z2HJ+pp8eynX39nXyP1+HXNlEmVtHIdI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=k4c0EmuvDqzBDnIJXRWoyT8O/emHkWiQXk1SxPkYqYyplusdmDNydo6Gpccx2cOBI
	 TnkxySBDNAJBmVq9BfEz/QitCst/noihsoHHcwRLCLisVwlI1V9I99SWF6dAMLmhm8
	 sWcagc2UwcGi6X9u3CUs8NGesdE/jGKQqgs9lXxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBJXG5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBJXG5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Feb 2020 18:06:57 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A39120733;
        Mon, 10 Feb 2020 23:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581376016;
        bh=v4MWXkBpT97z2HJ+pp8eynX39nXyP1+HXNlEmVtHIdI=;
        h=From:To:Cc:Subject:Date:From;
        b=jUk8ystgpZdvQuU6x6LqjpbRk0btFuT84cFVc5DQvJaoe/tvGcwJr5H74OL+2F5PN
         /Fi6nt/4yODkk33RexhL4sqNnFUNCaYhtzHlW2Afc68zQMvQWhreA4jGT6r/piR1YE
         hpzCSlRRqMxoqRavjemPM5z6hP0AH6mBQXmd1LFE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 0/3] tracing: Synthetic event fixes and updates
Date:   Mon, 10 Feb 2020 17:06:47 -0600
Message-Id: <cover.1581374549.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

I noticed a couple bugs while creating a patch consolidating the
synthetic event trace() functions.  Here are the two bugfixes along
with the consolidated trace patch.

The first patch adds a missing ring_buffer_nest_end() in an error
case, and the second removes unnecessary error returns when an event
is soft disabled.

The third patch consolidates the common code in synth_event_trace_array(),
synth_event_trace() and synth_event_trace_start().

Thanks,

Tom


The following changes since commit 7a1f8097178832627261a16e32973b12a0355dad:

  bootconfig: Use parse_args() to find bootconfig and '--' (2020-02-07 20:51:08 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-event-gen-fixes-v1

Tom Zanussi (3):
  tracing: Add missing nest end to synth_event_trace_start() error case
  tracing: Don't return -EINVAL when tracing soft disabled synth events
  tracing: Consolidate trace() functions

 include/linux/trace_events.h     |   2 +-
 kernel/trace/trace_events_hist.c | 227 +++++++++++++++------------------------
 2 files changed, 87 insertions(+), 142 deletions(-)

-- 
2.14.1

