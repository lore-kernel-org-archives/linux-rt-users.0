Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A446DC43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0F720850
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553268927;
	bh=uBYA07B5yMhttZ1DGVCSoUwY09W7NkHo3Ak6lS5X/5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=hJo+5fK5fClAEFwBD2MwF/xVWh+XQV3X2rMrJHqAPzZucMy5d+Jx6AUSG3G2hEYYo
	 4gWsi5/++G6hUNN16DBn8+m8SkDsDxPbmhVkiblZahycS+qw20MlcjgT7PXnZ++bT2
	 MLLnC4re4thDTtYcMkv7xNreK+liiCRnT8mrL4N4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfCVPe7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfCVPe4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Mar 2019 11:34:56 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A3621939;
        Fri, 22 Mar 2019 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553268896;
        bh=uBYA07B5yMhttZ1DGVCSoUwY09W7NkHo3Ak6lS5X/5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PyD8PJe4DJjzN7ulAnMCIjJ6eeOkHbTb2q1BjUF8VNWzscykK7vFhwO3Rd37V/lcw
         edyuzXbihBvrrxX9ut0oBSqwQT41/KKFeYUfyQMqnvc6UrKCjlOG9dgQFmai3pw4tm
         ZPxPSi0nrz354c4PjBV17ZN1E/MNWwNsax5ltkwE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 07/11] tracing: Remove trigger-extended-error-support testcase
Date:   Fri, 22 Mar 2019 10:34:33 -0500
Message-Id: <064693880a99a7ac3cb43ee375c265a938402257.1553268041.git.tom.zanussi@linux.intel.com>
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

Error handling has been moved to the common tracing/error_log, so this
test is no longer valid.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../inter-event/trigger-extended-error-support.tc  | 28 ----------------------
 1 file changed, 28 deletions(-)
 delete mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
deleted file mode 100644
index 9912616a8672..000000000000
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# description: event trigger - test extended error support
-
-
-fail() { #msg
-    echo $1
-    exit_fail
-}
-
-if [ ! -f set_event ]; then
-    echo "event tracing is not supported"
-    exit_unsupported
-fi
-
-if [ ! -f synthetic_events ]; then
-    echo "synthetic event is not supported"
-    exit_unsupported
-fi
-
-echo "Test extended error support"
-echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
-! echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger 2> /dev/null
-if ! grep -q "ERROR:" events/sched/sched_wakeup/hist; then
-    fail "Failed to generate extended error in histogram"
-fi
-
-exit 0
-- 
2.14.1

