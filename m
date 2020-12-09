Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B2BC433FE
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 18:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9287D23C92
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 18:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbgLISby (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 13:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbgLISbx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 13:31:53 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B10CC061793
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Dec 2020 10:31:13 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id bd6so1060202qvb.9
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Dec 2020 10:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kH//1x/qE3k01KxUgmZjvzMvjbjN/rwQSCxMSt8n5jw=;
        b=dffp8LILujEc0beNtZ1Ro42zIrodODM1jUGSi1CJB7czG0ak5DJVnNv6CxBhGl3Tp5
         zk+HifZJID9jT2dz/qTmRrNZycaZ1BIJ0sd+DtnL0LNkDEYBcPplnu3tNbfLct8rI0OP
         jaYU7TBb/DiJDtBYwvQ1Wpi5F85YZwMLkzilOlQPnJqPxeT4a6dVgJP8NHj1W4hgNZjk
         jWm/cENsXzZ9lDwDERI/R3D0e4t7YLbibHJh8PnzYnLzBofIu5quW/cv+A105VlGisQk
         BvIX34t/rahxBEpwi00RU1Ge1K4uYBYZhTxjbupFcYKfUNDdN+VrpVDw43t8o8zmcFN4
         KQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kH//1x/qE3k01KxUgmZjvzMvjbjN/rwQSCxMSt8n5jw=;
        b=Xb8CX4kCzNDE3abwT4gi8EbVeEZplxv7JYF1ZcTgi8vjGzg6zz1ViS+ePF585vJyvx
         X8JGIX/Dgza+JTedt8l6sv5LGsb5bkWEZ9LhfDV9fPUfjAQcjb5vjs6/h4e6Jpu+nMx7
         yWkd9IqO16KXFZf4Hc/8WC9h7A5Hs1HOI2fK7SJA0U0ZPvFFFcWgyciKO3UFOQsWTJau
         Wf/oU+UUWz1fZnKKXyerIiumZ10d/SHA93ULjgfOmjgo8gz4eiW1ZSKQPhNNjisgrPl3
         NnMs2LFfipcXoIYMKOrZQozscF8jl3m6LHHu5fMPuDA04Sga73XBYa0uNjIbgNiac1GL
         D53A==
X-Gm-Message-State: AOAM531lzRDaHj8BhQUGGg1KMvYkvlsG8+SmNUlZ4x2quXYSvTBx9SJR
        cXweYpQ85OITHcgUAoDs5OsFKHaG63tmZg==
X-Google-Smtp-Source: ABdhPJyLSaL6HzLQKiCBI7AitQiZrNImSAN614yN3AVI1mqy9wY59LmTcmuZ7TRx8OLNhr34nPDvWw==
X-Received: by 2002:a0c:b29b:: with SMTP id r27mr4463836qve.50.1607538672411;
        Wed, 09 Dec 2020 10:31:12 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id k41sm1674840qtc.23.2020.12.09.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:31:11 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] rt-tests: queuelat: Add a manpage for determine_maximum_mpps.sh
Date:   Wed,  9 Dec 2020 13:31:00 -0500
Message-Id: <20201209183100.16836-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201209183100.16836-1-jkacur@redhat.com>
References: <20201209183100.16836-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a manpage for determine_maximum_mpps.sh

Signed-off-by: John Kacur <jkacur@redhat.com>

diff --git a/Makefile b/Makefile
index d5b14991032d..fba4546ac50a 100644
--- a/Makefile
+++ b/Makefile
@@ -52,6 +52,7 @@ MANPAGES = src/cyclictest/cyclictest.8 \
 	   src/signaltest/signaltest.8 \
 	   src/pi_tests/pip_stress.8 \
 	   src/queuelat/queuelat.8 \
+	   src/queuelat/determine_maximum_mpps.8 \
 	   src/sched_deadline/deadline_test.8 \
 	   src/ssdd/ssdd.8 \
 	   src/sched_deadline/cyclicdeadline.8 \
diff --git a/src/queuelat/determine_maximum_mpps.8 b/src/queuelat/determine_maximum_mpps.8
new file mode 100644
index 000000000000..4a28f1a4e34a
--- /dev/null
+++ b/src/queuelat/determine_maximum_mpps.8
@@ -0,0 +1,62 @@
+.\"                                      Hey, EMACS: -*- nroff -*-
+.TH DETERMINE_MAXIMUM_MPPS 8 "Dec 4, 2020"
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
+determine_maximum_mpps \- Determine the maximum mpps the machine can handle
+.SH SYNOPSIS
+.LP
+determine_maximum_mpps [-c cpulist] [-m maxlat] [-n cycles] [-f | -r] [-p priority] [-h]
+.SH DESCRIPTION
+determine_maximum_mpps will find the maximum mpps parameter which can sustain
+.PP
+.RS
+1. 10 consecutive 30 second runs.
+.br
+2. 1 run of 10 minutes.
+.PP
+.RE
+Without violating the latency specified with $MAXLAT (default 20000)
+.PP
+.SH TERMINOLOGY
+mpps : million-packets-per-second
+.br
+.SH OPTIONS
+.TP
+.B \-c cpulist
+List of processors to run on. The default is processor 0
+.TP
+.B \-m maxlat
+Maximum latency in nanoseconds. The default is 20000. if the maximum is exceeded, that run of queuelat quits.
+.TP
+.B \-n cycles
+Extimated number of cycles it takes to process one packet. The default is 300
+.TP
+.B \-f
+Set the scheduling policy to SCHED_FIFO. This is the default if not specified.
+.TP
+.B \-r
+Set the scheduling policy to SCHED_RR.
+.TP
+.B \-p priority
+default priority = 1. Valid numbers are from 1 to 99
+.TP
+.B \-h
+help
+.LP
+.SH AUTHOR
+determine_maximum_mpps was written by
+.br
+Marcelo Tosatti <mtosatti@redhat.com>
+.PP
+This man page was written by John Kacur <jkacur@redhat.com>
-- 
2.26.2

