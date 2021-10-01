Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF442C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 17:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A3861A85
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 17:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355418AbhJARbk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhJARbj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Oct 2021 13:31:39 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE30C061775
        for <linux-rt-users@vger.kernel.org>; Fri,  1 Oct 2021 10:29:55 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id a14so6015877qvb.6
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Oct 2021 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uxtRXViKf7zUd2IOOx2rcp+U75CZVGXRXMGGkOlCeuQ=;
        b=nC3f0f3Jl0nTIBLtss8T5W7m0Gwr0vfyJ+nym+CYPwivWW0AukptPPhWBSSl5hjhn8
         xgayjeJJNJaYbpeeBCDMzPu4jWWP24bOYp4VydDWQYHi8aKp5AKfGVkqpeSWy2CSo2JI
         CSIYI4YhF2TrvGlHEsffJAoq5N1zEm69O8S9o57nUPP/2O4eedE8ow1PhaV5qc4AtECE
         dtoFQEQajKMdU8D0p/kZeFlZuGo64vqR1fOhe3lDTvb9hTV6Y0YLxslaICDEr1BBqyPp
         yhKdclo3kIf4xYbgtZ/kXJIlQJVNF+rwAwcNZ3WAcnOXklzIgLAZuNu7hWYX1Sxo4Yc4
         1s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uxtRXViKf7zUd2IOOx2rcp+U75CZVGXRXMGGkOlCeuQ=;
        b=vjldUsYueEGDsD6bhaMbASaKUkbrLlX/1HavErKr6pojyxbK9sxxAKDY9B844pAU49
         3ESud0N213pjOxjhoHSOKBLSQhZ/Wc5l2ChGwczH8HDC9j3KWAfuhPSQvT43ZcD4k1I5
         E6awK5pUVa+RHiigeiDd00SeH6/eoW3MpA8/LLIPIzPSyDJ5fzoJceiCXCCzVOEh1ISc
         rMb0yieZGAmjpCiEiPNlrzw7lRZsN7/D7M0v5O/P/tzcFcnqThK4fspRg9cEgwIfqhg4
         jbezGKp9dZSQKSid0+wVsnbZHxsLGpm3WAC/Suqil6+dIVP6IjT4p0b5oiU0d4oQDZSY
         SE8Q==
X-Gm-Message-State: AOAM5327OKm1waRJx+TxXNsnGWYz9XqqQysEIShXtvxr8/1tfWutDDkK
        08lVjAtxRjflgtVbTS5b082/yDL8xbI=
X-Google-Smtp-Source: ABdhPJzcqskVpiIeupzDYtvsg2hW47OOjWJ1NTUo701z4+oAxYeDV0Op9lkqyxUWfu53kOCE8izvQA==
X-Received: by 2002:ad4:496d:: with SMTP id p13mr11539030qvy.52.1633109394466;
        Fri, 01 Oct 2021 10:29:54 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id o23sm3741131qtl.74.2021.10.01.10.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:29:54 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pierre FICHEUX <pierre.ficheux@smile.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Punit Agrawal <punitagrawal@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] rt-tests: Update the help and man page for --latency
Date:   Fri,  1 Oct 2021 13:29:36 -0400
Message-Id: <20211001172937.13060-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001172937.13060-1-jkacur@redhat.com>
References: <20211001172937.13060-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Update the help and man page for --latency
- Fix some sorting of --latency and --loops

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.8 | 12 ++++++------
 src/cyclictest/cyclictest.c |  6 ++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index abc56e8e4970..dc0a278f3d30 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -67,9 +67,6 @@ Specify a length for the test run.
 .br
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .TP
-.B \-\-latency=PM_Q0S
-write PM_Q0S to /dev/cpu_dma_latency
-.TP
 .B \-F, \-\-fifo=<path>
 Create a named pipe at path and write stats to it
 .TP
@@ -88,12 +85,15 @@ Set the base interval of the thread(s) in microseconds (default is 1000us). This
 .B \-\-json=FILENAME
 Write final results into FILENAME, JSON formatted.
 .TP
-.B \-l, \-\-loops=LOOPS
-Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. Cyclictest is stopped once the number of timer intervals has been reached.
-.TP
 .B \-\-laptop
 Save battery when running cyclictest. This will give you poorer realtime results, but will not drain your battery so quickly.
 .TP
+.B \-\-latency=PM_Q0S
+power management latency target value. This value is written to /dev/cpu_dma_latency and affects c-states. The default is 0
+.TP
+.B \-l, \-\-loops=LOOPS
+Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. Cyclictest is stopped once the number of timer intervals has been reached.
+.TP
 .B \-\-mainaffinity=CPUSET
 Run the main thread on CPU #N. This only affects the main thread and not the measurement threads
 .TP
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f8f7dbc7e43d..067b75317c9a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -823,7 +823,6 @@ static void display_help(int error)
 	       "-d DIST  --distance=DIST   distance of thread intervals in us, default=500\n"
 	       "-D       --duration=TIME   specify a length for the test run.\n"
 	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
-	       "	 --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
 	       "-F       --fifo=<path>     create a named pipe at path and write stats to it\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
 	       "                           US is the max latency time to be tracked in microseconds\n"
@@ -832,10 +831,13 @@ static void display_help(int error)
 	       "	 --histfile=<path> dump the latency histogram to <path> instead of stdout\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
-	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "	 --laptop	   Save battery when running cyclictest\n"
 	       "			   This will give you poorer realtime results\n"
 	       "			   but will not drain your battery so quickly\n"
+	       "         --latency=PM_QOS  power management latency target value\n"
+	       "                           This value is written to /dev/cpu_dma_latency\n"
+	       "                           and affects c-states. The default is 0\n"
+	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "         --mainaffinity=CPUSET\n"
 	       "			   Run the main thread on CPU #N. This only affects\n"
 	       "                           the main thread and not the measurement threads\n"
-- 
2.31.1

