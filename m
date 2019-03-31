Return-Path: <SRS0=867U=SC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D67C43381
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645C92085A
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554076148;
	bh=YhEMJ7aEkbCuWq+dYZzEC2y6MWe+PZvx4ANaniT35/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=iy+awuV1UKiKSTcUweFZJyMnKbGB1FIOJXzXapPyZFld9ypR20usX0vLeYMAJgi7m
	 ycwpkCp3KiOIjtup+VrkBa6VIq1JWpEUwAIRxVW1CLZcOxWnwcXccnTL3SR0NfsXMj
	 YqZo7pAjWx8j/z5Jt18dS6eCLKRMCKfdqvPEyc40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfCaXtD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731779AbfCaXst (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Mar 2019 19:48:49 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2683C218FC;
        Sun, 31 Mar 2019 23:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554076128;
        bh=YhEMJ7aEkbCuWq+dYZzEC2y6MWe+PZvx4ANaniT35/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=hmFe/5HBCl2q/CfvmV9OoLqhBq+aHakeMrVjqpgpYtnSNI3UEVZy3nHZ41k7c679k
         afgsvKLPta8yQ4KzUnzzjmiF0Wwzoly3N3YTc7pwUFsO3PXCsqTUrkgxJaC+lTOayD
         XgyVHLl594QJoHwdF2kSHfSFsVvsqG2xDZrkIAOk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v5 11/11] tracing: Add error_log to README
Date:   Sun, 31 Mar 2019 18:48:25 -0500
Message-Id: <c81e60f9aded495081231a32d2d1023c4d043a7a.1554072478.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554072478.git.tom.zanussi@linux.intel.com>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554072478.git.tom.zanussi@linux.intel.com>
References: <cover.1554072478.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add brief blurb about error_log to the 'Important files' section.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f9f9e7e2f0d9..ef5a2778ce3d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4700,6 +4700,7 @@ static const char readme_msg[] =
 	"  trace_pipe\t\t- A consuming read to see the contents of the buffer\n"
 	"  current_tracer\t- function and latency tracers\n"
 	"  available_tracers\t- list of configured tracers for current_tracer\n"
+	"  error_log\t- error log for failed commands (that support it)\n"
 	"  buffer_size_kb\t- view and modify size of per cpu buffer\n"
 	"  buffer_total_size_kb  - view total size of all cpu buffers\n\n"
 	"  trace_clock\t\t-change the clock used to order events\n"
-- 
2.14.1

