Return-Path: <SRS0=ADFb=AR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A9C433E2
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1770206B6
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUY8Fel7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgGFURq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgGFURg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jul 2020 16:17:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8698C061755
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jul 2020 13:17:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 145so33620951qke.9
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jul 2020 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txZtV8aZ0HBnn1ImNyvfEh2nyZ7tETx3pPLmwby6/+8=;
        b=AUY8Fel7gAl42DqayAs/wwRz7BI/+oxv1NjACnmeGL7lMbN921ZHMmw7DiWH1hZbWw
         1y+BoQ0Y9kHJXr4UoAPJCMEcErQimtoHCwbaVJMDp8SH0Pq7ErutDycWlvLDO1CYy3tL
         +/nHTQ5vOQaL6y7FXXkRGdydJbQrijep05ZF2lvg4yiAwDo6QnWMnwe3Mo71YB8J07XU
         PpiZ6luJU4EbLBo/mWadlCZkDM3PgLjpAF+cEFP1rrTD5HS6gImo3swVudZlnGr0++O2
         dLE3Wi7+PES4JB7VgmNMIK/UfgFZiLOa7KokWer/mduphX8BAEwLNreG3M29R1mU4Al3
         5n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=txZtV8aZ0HBnn1ImNyvfEh2nyZ7tETx3pPLmwby6/+8=;
        b=E/hGH23ci5YQi/Q4vf0FJG+6hASbV7ikzhk2S7kE75a8iC6dcYLP1IsHD6Y0Y1IEPx
         klSl2NApybGlOC24mrqSWzEkIrmsdpE+cAEJrZZMLz5yc1QVRXDRBrPrWRLQGeZIhFl4
         w1BlTW1JUYJ3xer8iYZOyZo92Rr5IiTB2xsuiawB4YZdRaJ2QKmB/ULzg5EOyUlAC1kq
         jpB6+nERweVYbOK22/W6eKBFdhWCWK2CXQtdikndFd7g+XYwOSs6c0zelssuyDBSi71Z
         Wk55bdmtXSmbt5Lk0bAW4i5JPOPw1m1UrnhAwIyzthq7CGOkLlp42lCj7uOpkCHY1HT8
         9LPA==
X-Gm-Message-State: AOAM5307aZ/ruM2d/asDeAle2I3XinUor7uqB19wmRE04YB/2Fcipkil
        Zu8uGRiFBo/h7K/L5tkT1KrXFyfnPNc=
X-Google-Smtp-Source: ABdhPJz2MuEz2u9W3Bumc9yu3zIhctojrW9zsueOq3joXwJgLAUooW0nNkMj38wQx4O8KFp9/pK05A==
X-Received: by 2002:a37:a507:: with SMTP id o7mr46091369qke.406.1594066655895;
        Mon, 06 Jul 2020 13:17:35 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id 73sm21551692qkk.38.2020.07.06.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:17:35 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/7] rt-tests: ptsematest.8: Update the ptsematest man page
Date:   Mon,  6 Jul 2020 16:17:18 -0400
Message-Id: <20200706201722.13400-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200706201722.13400-1-jkacur@redhat.com>
References: <20200706201722.13400-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The smp option should be a capital (-S)
Also fix the update synopsis to include missing and options

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ptsematest/ptsematest.8 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
index 8f76bca4b6a8..5ee7d694d50d 100644
--- a/src/ptsematest/ptsematest.8
+++ b/src/ptsematest/ptsematest.8
@@ -2,9 +2,9 @@
 .SH "NAME"
 .LP
 \fBptsematest\fR \- Start two threads and measure the latency of interprocess communication with POSIX mutex.
-.SH "SYNTAX"
+.SH "SYNOPSIS"
 .LP
-ptsematest [-a|-a PROC] [-b USEC] [-d DIST] [-i INTV] [-l loops] [-p PRIO] [-t|-t NUM]
+ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME][-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-S|--smp] [-t|--threads [NUM]]
 .br
 .SH "DESCRIPTION"
 .LP
@@ -35,7 +35,7 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
 .B \-p, \-\-prio=PRIO
 Set the priority of the process.
 .TP
-.B \-s, \-\-smp
+.B \-S, \-\-smp
 SMP testing: options -a -t and same priority
 .TP
 .B \-t, \-\-threads[=NUM]
-- 
2.21.3

