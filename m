Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241B9C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 07:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B3823130
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 07:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLPHRf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgLPHRe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Dec 2020 02:17:34 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A0C061793
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Dec 2020 23:16:54 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i18so23022190ioa.1
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Dec 2020 23:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axTZX9pkrXQQRyyZ9FafYGJ6ge90d6cmjtn6cjwuEhM=;
        b=AIqWDqDP0Ap2GcIN5qC3mKFBeVpq0sYijYVkOptQ9ONCEMFVNuUzz1kOyFERy6Mfla
         4st5+/L7/grs2S7Yxbn+NKtqREORVPuZ5uQumEZWcSZYjSz3wO01RbyHE78VN9fw+R0l
         WVUWHxhXjzvCSqPFagE4v7OzsHj8bK9aul5zCjE/seyMXyLMFw7OkFYm58SXAorJpKi5
         khehzkAG3ahF6PG1Q5QNH9gYeAeDkUqZ+c7ZTWSYvtJOmT9LRzi+EY0jMHp5SNYvq9Ts
         XZdWLvQGz5PRz9D7054vbfYxQ4nRVYqzkmiU5L79OJ9HPhyp8GDRXFHS2DSYBxh1dEUh
         jbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=axTZX9pkrXQQRyyZ9FafYGJ6ge90d6cmjtn6cjwuEhM=;
        b=lYsjclJ7Tq/i1nxSrtYeEZUbjHZSyFFVa3fT1iPQdtIdRYtHTa3onHwljHcfGj/GOg
         ZOo7ennVL8anidZ3kFiWC9SWNYlIe+zMHW8OetKsYJoDe2v3lNC8yJnf0l6PYQ4gSBxJ
         Aof+aVPegttOUSKy0xEqn3CN60C8drzx5w2swqymYH+7WM6yYN9UjBUJBvOrq5c73g0q
         KR0seY4ff17QcmwtuEdJ6tg+OqDOrRUJu/4Rnf9UTc9C6E3vEdE2tYoTYz3/y29RW/rC
         5HPO5EEg2QehdMFwOhDzZdIppuoLgcpb4NSXtmfwnIPuoT1Gklxmb1aECLQKZX/7CwwC
         wAxQ==
X-Gm-Message-State: AOAM533mltw/CwLVsIyEB676g6DmiNLDVtxBProwGkECxvSttosWxKIF
        lYD6zZKBkSILldpALZRbqoA=
X-Google-Smtp-Source: ABdhPJw7kND10XS/ufXy0GwBeX8iuXFEuvziUl4p2jGr9QFvMOgyCn9Ql+G4XT6I0yYAIgj1vw1gkQ==
X-Received: by 2002:a02:c7d1:: with SMTP id s17mr42142597jao.142.1608103013920;
        Tue, 15 Dec 2020 23:16:53 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id q5sm615829ile.48.2020.12.15.23.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 23:16:53 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: determine_maximum_mpps.sh: Change the -c option to -a
Date:   Wed, 16 Dec 2020 02:16:42 -0500
Message-Id: <20201216071642.24466-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Change -c to -a so that the options in this program match the options
of the other programs in the rt-tests suite as much as possible

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/determine_maximum_mpps.8  | 8 +++++---
 src/queuelat/determine_maximum_mpps.sh | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/queuelat/determine_maximum_mpps.8 b/src/queuelat/determine_maximum_mpps.8
index 4a28f1a4e34a..c48a651160d3 100644
--- a/src/queuelat/determine_maximum_mpps.8
+++ b/src/queuelat/determine_maximum_mpps.8
@@ -16,7 +16,7 @@
 determine_maximum_mpps \- Determine the maximum mpps the machine can handle
 .SH SYNOPSIS
 .LP
-determine_maximum_mpps [-c cpulist] [-m maxlat] [-n cycles] [-f | -r] [-p priority] [-h]
+determine_maximum_mpps [-a cpulist] [-m maxlat] [-n cycles] [-f | -r] [-p priority] [-h]
 .SH DESCRIPTION
 determine_maximum_mpps will find the maximum mpps parameter which can sustain
 .PP
@@ -33,11 +33,13 @@ mpps : million-packets-per-second
 .br
 .SH OPTIONS
 .TP
-.B \-c cpulist
+.B \-a cpulist
 List of processors to run on. The default is processor 0
+.br
+Numbers are separated by commas and may include ranges. Eg. 0,3,7\-11
 .TP
 .B \-m maxlat
-Maximum latency in nanoseconds. The default is 20000. if the maximum is exceeded, that run of queuelat quits.
+Maximum latency in nanoseconds. The default is 20000. If the maximum is exceeded, that run of queuelat quits.
 .TP
 .B \-n cycles
 Extimated number of cycles it takes to process one packet. The default is 300
diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
index fdede472728c..86fffd8bb617 100755
--- a/src/queuelat/determine_maximum_mpps.sh
+++ b/src/queuelat/determine_maximum_mpps.sh
@@ -56,9 +56,9 @@ check_sched()
 }
 
 # Process command line options
-while getopts ":c:frp:m:n:h" opt; do
+while getopts ":a:frp:m:n:h" opt; do
 	case ${opt} in
-		c ) CPULIST="${OPTARG}" ;;
+		a ) CPULIST="${OPTARG}" ;;
 		m ) MAXLAT="${OPTARG}" ;;
 		n ) CYCLES_PER_PACKET="${OPTARG}" ;;
 		f ) check_sched; SCHED="-f" ;;
-- 
2.26.2

