Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C0BC43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D5820850
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553268925;
	bh=SeKsOx9h98EvRNRpLwegzeiH+IYcCAkSPebyWmD4JDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=mYydiR2FlMis4NvhKfiinABnZsvU3N6EBUkDyb2DtChjxgkekQgSmVyvySZXWhDvA
	 5g2ebXOTFOrYKgGQ31Dh0hUMSlNm9gD3CproddI+zGN49xDYAb0aAjamV546BrQL25
	 5F/KaiZonN/RJjm3FdgNIBvX9uyYw9+xqFnODgog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfCVPfC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfCVPfB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Mar 2019 11:35:01 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE22B2195D;
        Fri, 22 Mar 2019 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553268900;
        bh=SeKsOx9h98EvRNRpLwegzeiH+IYcCAkSPebyWmD4JDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=L6nwk0D+DKeNmYHxjyWXBPwN/dZQ0dvv4Rzia6AMWjdD5G8vvQoy9kXo/o1/pcEIS
         KrpmPU2rkEbLl2+PXbRSE0WDNeaERnkTDIoehq/AIlrz2+OhfAny2Rv2WQ+7PsJnMQ
         tytgdo8BQz1OWLrtFF6HCqRzOIdn2BUHNPe3yilM=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 10/11] tracing: Add error_log to README
Date:   Fri, 22 Mar 2019 10:34:36 -0500
Message-Id: <23fce220973091216e42aad6c05d8e0db2ea4eae.1553268041.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1553268040.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1553268040.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add brief blurb about error_log to the 'Important files' section.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0388038a9253..f6ba2c87572a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4698,6 +4698,7 @@ static const char readme_msg[] =
 	"  trace_pipe\t\t- A consuming read to see the contents of the buffer\n"
 	"  current_tracer\t- function and latency tracers\n"
 	"  available_tracers\t- list of configured tracers for current_tracer\n"
+	"  error_log\t- error log for failed commands (that support it)\n"
 	"  buffer_size_kb\t- view and modify size of per cpu buffer\n"
 	"  buffer_total_size_kb  - view total size of all cpu buffers\n\n"
 	"  trace_clock\t\t-change the clock used to order events\n"
-- 
2.14.1

