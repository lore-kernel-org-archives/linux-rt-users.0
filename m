Return-Path: <SRS0=4qQz=SU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9F4C10F0E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 15:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDC52183E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555600780;
	bh=US8dhk/bvxhoJlr1h1lgacAnZYxiusdSUPBLuV24eRE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YB73QUmAxG/Mnmh3GsFE6X5FWvecukDMqN0xUXUrgSsuycSsu1VVkzQNrB55cVWa5
	 9EPnVcDIiimw+9IW1glbnuUDPra+CilIqSmBnF4isRrmooQIH1fSDmuvG9xEBh/KMY
	 pE3WaWZ8PR8p3qDyF7kD73YegdRFr85sqRzgWqD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389381AbfDRPTQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388548AbfDRPTQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Apr 2019 11:19:16 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A71D204EC;
        Thu, 18 Apr 2019 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555600755;
        bh=US8dhk/bvxhoJlr1h1lgacAnZYxiusdSUPBLuV24eRE=;
        h=From:To:Cc:Subject:Date:From;
        b=JXD0rSpTJ8wEoqu4dL+EyxLIpNl167ZJyxt7WhLZWLgDnklXZL5xiKhFIcgYM2FHU
         acBoE9g6hB/DJEEpvjkiU2kn4oaIdw1/LyDZSOEO/h6+PhDR59cxTiZ4dZYArIh42A
         70qmWm1rGiSBpr+KKvJYaexClFydQ4IPxqo0469U=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     vincent@bernat.ch, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 0/3] A few hist trigger fixes
Date:   Thu, 18 Apr 2019 10:18:49 -0500
Message-Id: <cover.1555597045.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi Steve,

Here's a fix for a problem I found with the hist trigger snapshot
action related to the refactoring in the later versions of the
patchset ('[PATCH 3/3] tracing: Add a check_val() check before updating
cond_snapshot() track_val').

I also added v2 of 2 other patches that I previously submitted [1] but
realized hadn't gotten picked up. ('[PATCH v2 1/3] tracing: Prevent
hist_field_var_ref() from accessing NULL tracing_map_elts' and '[PATCH
v2 2/3] tracing: Check keys for variable references in expressions
too').

One of them I had to rebase ('[PATCH v2 2/3] tracing: Check keys for
variable references in expressions too') because of the error_log
changes since then, but the original ones still apply to versions
before that).

So in summary, all of these patches apply to current ftrace/core,
while only '[PATCH 3/3] tracing: Add a check_val() check before
updating cond_snapshot() track_val' and the previous 2 original
patches in [1] apply to mainline.

Thanks,

Tom

[1] https://lore.kernel.org/lkml/cover.1541687121.git.tom.zanussi@linux.intel.com/

The following changes since commit c8faaa4c594f55ddf903d61180029a3ea1da5286:

  rcu: validate arguments for rcu tracepoints (2019-04-03 08:26:38 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/key-ref-fix-v2

Tom Zanussi (3):
  tracing: Prevent hist_field_var_ref() from accessing NULL
    tracing_map_elts
  tracing: Check keys for variable references in expressions too
  tracing: Add a check_val() check before updating cond_snapshot()
    track_val

 kernel/trace/trace_events_hist.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.14.1

