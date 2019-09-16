Return-Path: <SRS0=2ve0=XL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C5AC49ED7
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC72E214AF
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2J6bFnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfIPVvY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:51:24 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:41537 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732078AbfIPVvY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Sep 2019 17:51:24 -0400
Received: by mail-qt1-f182.google.com with SMTP id x4so1774842qtq.8
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Sep 2019 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaUd9HcUUGA6aLRu+biQBbaLydM6P5e/3FkRJP/2v2s=;
        b=s2J6bFnbV172uaIt8uVP88WxLE9clFsu3Nx09z108kO0RPbULpNzgFNqGC7YTvdScz
         hKBfrw65kc4v9jhGmw6/qlClcV7mDolDURVEcE3nqA1U6j9hglFlKNINZPgaYwZC3Jcq
         6yxB3EKsSkHmWrcb1cEd739FS6OUcKzY5YbbLmGusfsjGsmi9A2fUs3Me+XGWmLKt3sA
         Xo1F14A7cb5var65lYw17EPT++P57shVIPnf4ahu1ItgACZq7L2wONLLX50DEBQW9+Rx
         sLXejRKv3d+QUOxeJkgBYvqxXR7lBB3so34vvhN7jfNxQ108eBEhtotsU0lLwtljW7p2
         kmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KaUd9HcUUGA6aLRu+biQBbaLydM6P5e/3FkRJP/2v2s=;
        b=YlpV/T4e9DGHgI+RpIlFNjph0oAKUVEHKGISo5GOV08NHXdAneZwfx9cdR1HIWS4oh
         BP1cbE7PON4rwUkDAs+vmBWS3W3GONP2CeLDLSMNvtVTdjw5aALK8fy3hqhBsQ4Syldv
         GbMcJAMsZkuViBKEnIhIY8Ikd/mOScY3+C3dkUcc+085PD/b8QkF8xOKoh9/mMTZlATW
         pkbLh0S6Z5CQuV6ZLEUQGJa0v+z5vbAXAoFzwVu1QlZsqlIG5QBX/b1qQudyib4n8VUq
         oiOe1+N9jLBBuqW5D7ayg0EP9xfwibzG09hzVYF2mAgsRUG/gyAUayzq3kR/DURGFeAx
         y9lw==
X-Gm-Message-State: APjAAAWVsAlbMusBU0e51+vbTcC26xQEPm48IJ4gWZtz17iOn4hKHbM5
        iVCFS643mkFIM9paap28Kb6185/8Q2A=
X-Google-Smtp-Source: APXvYqxhS9qTr4x9O9Hd5DIrCjS2DMydSOPmK3hKH5Ve6dDPadwlKtyz2n0qqEcSM1K4mEhNGbFX3A==
X-Received: by 2002:ac8:192d:: with SMTP id t42mr610612qtj.358.1568670682678;
        Mon, 16 Sep 2019 14:51:22 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id q126sm120156qkf.47.2019.09.16.14.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:51:22 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, Tom Rix <trix@redhat.com>
Subject: [PATCH 1/4] rt-tests: cyclictest.8: Remove invalid tracing options from the manpage
Date:   Mon, 16 Sep 2019 23:51:08 +0200
Message-Id: <20190916215111.10193-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Most tracing options have been removed from cyclictest since the
user can now use trace-cmd together with cyclictest to get the same
functionality. Update the manpage to reflect this.

Reported-by: Tom Rix <trix@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.8 | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index a05d1f4c9d4a..b64a16ae8bbb 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -52,9 +52,6 @@ Align thread wakeups to a specific offset in microseconds
 .B \-b, \-\-breaktrace=USEC
 Send break trace command when latency > USEC
 .TP
-.B \-B, \-\-preemptirqs
-Both preempt and irqsoff tracing (used with -b)
-.TP
 .B \-c, \-\-clock=CLOCK
 select clock
 .br
@@ -62,9 +59,6 @@ select clock
 .br
 1 = CLOCK_REALTIME
 .TP
-.B \-C, \-\-context
-context switch tracing (used with \-b)
-.TP
 .B \-d, \-\-distance=DIST
 Distance of thread intervals in us, default = 500
 .TP
@@ -73,12 +67,6 @@ Specify a length for the test run.
 .br
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .TP
-.B \-E, \-\-event
-event tracing (used with \-b)
-.TP
-.B \-f, \-\-ftrace
-Enable function tracing using ftrace as tracer. This option is available only with \-b.
-.TP
 .B \-F, \-\-fifo=<path>
 Create a named pipe at path and write stats to it
 .TP
@@ -94,9 +82,6 @@ Dump the latency histogram to <path> instead of stdout.
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also \-d.
 .TP
-.B \-I, \-\-irqsoff
-Irgsoff tracing (used with \-b)
-.TP
 .B \-l, \-\-loops=LOOPS
 Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. Cyclictest is stopped once the number of timer intervals has been reached.
 .TP
@@ -113,26 +98,16 @@ running cyclictest on low-bandwidth connections)
 .B \-n, \-\-nanosleep
 Use clock_nanosleep instead of posix interval timers. Setting this option runs the tests with clock_nanosleep instead of posix interval timers.
 .TP
-.B \-\-notrace
-suppress tracing
-.TP
 .B \-N, \-\-nsecs
 Show results in nanoseconds instead of microseconds, which is the default unit.
 .TP
 .B \-o, \-\-oscope=RED
 Oscilloscope mode, reduce verbose output by RED.
 .TP
-.B \-O, \-\-traceopt=TRACING_OPTION
-Used to pass tracing options to ftrace tracers. May be invoked multiple
-times for multiple trace options. For example trace options look at /sys/kernel/debug/tracing/trace_options
-.TP
 .B \-p, \-\-prio=PRIO
 Set the priority of the first thread. The given priority is set to the first test thread. Each further thread gets a lower priority:
 Priority(Thread N) = max(Priority(Thread N\-1) \- 1, 0)
 .TP
-.B \-P, \-\-preemptoff
-Preempt off tracing (used with -b)
-.TP
 .B \-\-policy=NAME
 set the scheduler policy of the measurement threads
 where NAME is one of: other, normal, batch, idle, fifo, rr
@@ -178,10 +153,6 @@ the number of available CPUs. See \-d, \-i and \-p for further information.
 .B \-\-tracemark
 write a trace mark when \-b latency is exceeded.
 .TP
-.B \-T, \-\-tracer=TRACEFUNC
-set the ftrace tracer function. Used with the \-b option. Must be one
-of the trace functions available from <debugfs-mountpoint>/kernel/debug/tracing/available_tracers
-.TP
 .B \-u, \-\-unbuffered
 force unbuffered output for live processing
 .TP
@@ -192,12 +163,6 @@ n:c:v
 
 where n=task number c=count v=latency value in us.
 .TP
-.B \\-w, \-\-wakeup
-task wakeup tracing (used with \-b)
-.TP
-.B \\-W, \-\-wakeuprt
-rt-task wakeup tracing (used with \-b)
-.TP
 .B \-\-dbg_cyclictest
 Print info userful for debugging cyclictest
 
-- 
2.20.1

