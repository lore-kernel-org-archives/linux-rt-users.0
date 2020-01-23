Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1798FC33CAF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE1A20684
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3hagN/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgAWUuo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:44 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42180 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgAWUun (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so3583987qtq.9
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2020 12:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CEwsRfjMS2Qaq+469FJeEHGfwUNXMQFPX3rJd2gY8Y=;
        b=m3hagN/FcEBePVBPk1WNcfV7CXNX9P0JbeYzXufSG2u/j7VRCQi0mVgvqyO+NiX7Qb
         oD0VT8hE71LhrdSAsphF38rrJN0URdMk54o2Z/1ENOh3VNIZ8Awmflp2/eQDgrkRWDLO
         VJo0WkEwmvKEpx196ZAHYvQIQfOodmdJF/CaZ7RvKsMzAKkU2CKRdZlPBylKGu0OcOSu
         IhWOpS+wg8UogD9DrRjgr+rDBhFACEwB8hDhWTGeB69vG9aQBS70gtxFLyVeetERXw0f
         4Zlv8JW3vf2uQg2OcjA2JZBjYCZIO6a3XVl6cZeSNNTrShdiwqjGfW8gTcffwEKzNrir
         096A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5CEwsRfjMS2Qaq+469FJeEHGfwUNXMQFPX3rJd2gY8Y=;
        b=TACYRcji9VlV8tSGLMaC+24XFFvg65/O5KWfajGtfFMPwZ1F2gZwL+qP7ponWrtekr
         6gCv6uwan3u5srl8lEFLIdjtXaT4jtgSAABKOG26rGaRswiHbXzapYHJo9+MecpsuDB/
         Ak7yWqKvMc9/a90MmfCeWH4Ql9BJHa4XdjLnmaKtqA5nC5AhPquWeH63mPCoJ1bitTGA
         rEpS1W+bvnewDNV9Qo+O8Qr+Q6EyWsb4oZBD8n2PEHGfRuN5kSz58JY4rQLS+aAVZ+BK
         tfk9szH7tXGVDNsDiDizeNblRZN/M7u6lIrjB4dJ+FRicv5LxZca6LRlktA0ngVPPxYa
         Jjjg==
X-Gm-Message-State: APjAAAUnaYz6oA15Ke17WTeQ4hyfS7+RodiT4ij4Ynz6RJcckRAHZWHw
        /cul7rxQtEM0/MZ8KInI1/LJNh/yiMI=
X-Google-Smtp-Source: APXvYqyhl0uySGmaWZCzIZfQBw6ouCZW/sGPPXkEF1LL1+vGi5AbtROliHyzxCEPDYX4BObdAKWG3A==
X-Received: by 2002:aed:2202:: with SMTP id n2mr72629qtc.4.1579812642713;
        Thu, 23 Jan 2020 12:50:42 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j185sm1518346qkc.96.2020.01.23.12.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:50:42 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/9] rt-tests: cyclicdeadline: Add a simple manpage for cyclicdeadline
Date:   Thu, 23 Jan 2020 21:50:22 +0100
Message-Id: <20200123205029.20176-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123205029.20176-1-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Add a simple manpage for cyclicdeadline
- Install it from the Makefile

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                            |  1 +
 src/sched_deadline/cyclicdeadline.8 | 53 +++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 src/sched_deadline/cyclicdeadline.8

diff --git a/Makefile b/Makefile
index 552b3fe885cc..e2142ba3f4e9 100644
--- a/Makefile
+++ b/Makefile
@@ -193,6 +193,7 @@ install: all install_hwlatdetect
 	gzip -c src/queuelat/queuelat.8 >"$(DESTDIR)$(mandir)/man8/queuelat.8.gz"
 	gzip -c src/sched_deadline/deadline_test.8 >"$(DESTDIR)$(mandir)/man8/deadline_test.8.gz"
 	gzip -c src/ssdd/ssdd.8 >"$(DESTDIR)$(mandir)/man8/ssdd.8.gz"
+	gzip -c src/sched_deadline/cyclicdeadline.8 >"$(DESTDIR)$(mandir)/man8/cyclicdeadline.8.gz"
 
 .PHONY: install_hwlatdetect
 install_hwlatdetect: hwlatdetect
diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
new file mode 100644
index 000000000000..91766fb391c4
--- /dev/null
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -0,0 +1,53 @@
+.\"                                      Hey, EMACS: -*- nroff -*-
+.TH CYCLICDEADLINE 8 "January 16, 2020"
+.\" Please adjust this date whenever revising the manpage.
+.\"
+.\" Some roff macros, for reference:
+.\" .nh        disable hyphenation
+.\" .hy        enable hyphenation
+.\" .ad l      left justify
+.\" .ad b      justify to both left and right margins
+.\" .nf        disable filling
+.\" .fi        enable filling
+.\" .br        insert line break
+.\" .sp <n>    insert n+1 empty lines
+.\" for manpage-specific macros, see man(7)
+.SH NAME
+cyclicdeadline \- This program is used to test the deadline scheduler (SCHED_DEADLINE) using a cyclictest style program
+.PP
+.SH SYNOPSIS
+.B cyclicdeadline
+.RI "[-ha] [-c cpulist] [-i interval] [-s step] [-t nr_threads] [-D duration]
+.PP
+.SH DESCRIPTION
+.B cyclicdeadline
+is a cyclictest style program for testing the deadline scheduler
+.PP
+.SH OPTIONS
+.TP
+.B \-h
+Show this help menu
+.TP
+.B \-a
+Use all CPUs
+.TP
+.B \-c cpulist
+Comma / hypen separated list of CPUs to run deadline tasks on
+.TP
+.B \-i interval
+The shortest deadline for the tasks in us. (default 1000us)
+.TP
+.B \-s step
+The amount to increase the deadline for each task in us. (default 500us)
+.TP
+.B \-t nr_threads
+The number of threads to run as deadline (default 1)
+.TP
+.B \-D time
+Specify a length for the test to run
+.br
+Append 'm', 'h', or 'd' to specify minutes, hours, or days
+.SH AUTHOR
+cyclicdeadline was written by Steven Rostedt <rostedt@goodmis.org>
+.PP
+This manual page was written by John Kacur <jkacur@redhat.com>
-- 
2.20.1

