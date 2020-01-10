Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F88C282DD
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BBC20842
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578688576;
	bh=mqMuLstO9IN15kdVeatC4X9CqY4cuP2Br2vC0GqNusY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=Xb84ViTlLBVD5wOMVFYOyUVx58WeuuM5KVSZBr6TxoEubWU+inxNHWtozK6WFKz8j
	 3BuK/UMAU4uW7tfDiRjSLydyJ5kfdBqDvIm39j/cERgxQcHun5jVQcFxMhHki50yJb
	 Gwc+FuNYI4fU9Q3C2VAAkxavgo4NuFfkftOrybxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgAJUfe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgAJUfd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:33 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76682084D;
        Fri, 10 Jan 2020 20:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688533;
        bh=mqMuLstO9IN15kdVeatC4X9CqY4cuP2Br2vC0GqNusY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CAzFhu/0N84idg6tdkOH71CGTBVal3Vwfwn1DXAD4EPlY5OMovjXFD/RHaQ5uoZ0o
         MHm7HBhxflCUGm6ITOZSgopOJyuNMoNrkZnHDxiZnXcIVln5Zzt8tV8dtc2WqJQWA3
         RWu9QfzeN8BEQ5VPC5G4MbSlTEZ1+BUwxnQQJfBU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 05/12] tracing: Add synth_event_run_command()
Date:   Fri, 10 Jan 2020 14:35:11 -0600
Message-Id: <646c7f37227e20f3084695aca341892a5ee95fa8.1578688120.git.zanussi@kernel.org>
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

This snippet was taken from v4 of Masami's 'tracing/boot: Add
synthetic event support' patch.

From the original: 'The synthetic node requires "fields" string
arraies, which defines the fields as same as tracing/synth_events
interface.'

synth_event_run_command() provides the means to execute the synthetic
event create command using the synthetic event command string.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8c9894681100..0886ca6da255 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1390,6 +1390,11 @@ static int create_or_delete_synth_event(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
+int synth_event_run_command(const char *command)
+{
+	return trace_run_command(command, create_or_delete_synth_event);
+}
+
 static int synth_event_create(int argc, const char **argv)
 {
 	const char *name = argv[0];
-- 
2.14.1

