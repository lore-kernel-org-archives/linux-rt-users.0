Return-Path: <SRS0=867U=SC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2D5C43381
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048B92085A
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Mar 2019 23:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554076151;
	bh=1sghl0iriX1Cf7j2sUdMTGLEcn2RRoLaMdAsb45m0BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=gw1iSF99/Rf+ERjgVQhnnWfNEm8muZSjtYZruj541P8feAJKSZ0OfEJwd/Umo4HXD
	 3xls21vrQTjUrtFG3OBoi/gAWsNF8uXLxnU2G4UO9/B+B9qN6cfL3sN1f9M0pjQTqG
	 vIB2HppBYRWVLNgv6exIMRb9k/bZL/TPf2IavmU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfCaXsq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731742AbfCaXso (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Mar 2019 19:48:44 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE1521841;
        Sun, 31 Mar 2019 23:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554076124;
        bh=1sghl0iriX1Cf7j2sUdMTGLEcn2RRoLaMdAsb45m0BA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=QJUbTqKDS9h9D25iwW8/ZKXFTT+HIUtCDrWt2cLRKvSyM0+r6/ULbBtRHP08uOFYi
         vYdJfeQYKblQYsmnx5a9R3PaMeIeDlKs+dB9r4LdeXmYgSkkw0fd38L/24HVP+WUJT
         EPu2XR97plPvAVQVZmdjcrfPvhIeea8CCOdGORFk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v5 08/11] selftests/ftrace: Remove trigger-extended-error-support testcase
Date:   Sun, 31 Mar 2019 18:48:22 -0500
Message-Id: <876a98b21018814cbf46f0a3605ae0906c51d53c.1554072478.git.tom.zanussi@linux.intel.com>
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

Error handling has been moved to the common tracing/error_log, so this
test is no longer valid.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

