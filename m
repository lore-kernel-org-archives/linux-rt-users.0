Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48BCC33CA3
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714C8205F4
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578688562;
	bh=xZh8yhYWXh+K+lp/zb3r1Mpp67+Bz4LntTd28p89qKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=HHDUc+Jd7dXT7kCc1yedPfj6axGSmc39vRHtW8w1lQ/+PzHrzVO6tEfFennC3BEmm
	 OctT9ahC6XOYeQJggJ8N3ISfoMQB+RuUkQgHU35xxM+BwMb13QBPgEfKQePPEveRBY
	 r2mxPIY0XwiATqEvc1XH63n4O8sfKdINArxxBYtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgAJUfj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:35:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbgAJUfi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:38 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF95321744;
        Fri, 10 Jan 2020 20:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688538;
        bh=xZh8yhYWXh+K+lp/zb3r1Mpp67+Bz4LntTd28p89qKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=lBiVX0toKXsF+nqRyR4NP46TNFm7HLpueK1x8bsPTD/RPXS5U9v8XpIexC0kI69Kj
         v+8RcklIoIgGimpVoJd7sZDvHr8LxtQ5ofwXOt9puOqED0RfMNfDvJi8vlhIJHCSUC
         8z0kkOgMFx/EBHmsyxGVhVem+E40sOL8ivoR13Nc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 09/12] tracing: Add trace_kprobe_run_command()
Date:   Fri, 10 Jan 2020 14:35:15 -0600
Message-Id: <ef45e0180fdf6c8ff9456a6ac3f4e184dcfd0c22.1578688120.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

This snippet was taken from v4 of Masami's 'tracing/boot: Add kprobe
event support' patch.

trace_kprobe_run_command() provides the means to execute the kprobe
event create command using the kprobe event command string, from
kernel code.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_kprobe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7f890262c8a3..25dac3745afb 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -902,6 +902,11 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
+int trace_kprobe_run_command(const char *command)
+{
+	return trace_run_command(command, create_or_delete_trace_kprobe);
+}
+
 static int trace_kprobe_release(struct dyn_event *ev)
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
-- 
2.14.1

