Return-Path: <SRS0=pvg0=6T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C5C47247
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 May 2020 16:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA0920746
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 May 2020 16:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2Ksybbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgEEQkP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 5 May 2020 12:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgEEQkP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 May 2020 12:40:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92A1C061A0F
        for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2020 09:40:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b6so2925734qkh.11
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2020 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgkCrECtWSOjQMawdgX8zOzxEAToakZCSsCZJDI6wwA=;
        b=N2KsybbghQlJVTvDvAD4GYKrIVokSBow7p8n/47RwA2SG2JTBSLR0F0e/lQmfdOUnu
         Z72+jUv4Td7ELHDLAZs/Iyk++1kugzi0hrAP/Tuy8OkMFw46YMMegPMT2MJsQQ0QIy9k
         yVXLaDKqNqPl7pTan91NX2JlvlFt+OfthB4CS5OlK5miHjStSHR3MHb0QtElBLBh5CT7
         cykF4t48TulHrfSx8UrQNJpJ2/XQEyGUY5vOMynEg2dT6fmfbFFTKxlkZgPlI/qINB9b
         2PuIVzGLzsONRRw1sZsjb0ofCr/xy+qtJ+dlIYHSTY06TQLYVWqcnYaTaKzVt6E8Gwk+
         eivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=cgkCrECtWSOjQMawdgX8zOzxEAToakZCSsCZJDI6wwA=;
        b=W8n39NboUox/8QgseeJIUj++QbuwpOKkG9wNBsNK/3Da77JoISic4nWD9EuhnDypLm
         1TD6/crmaof3NePzm2BZkHjJgGBcTSzIKKRgdlK67SQvogrO9msykKtpLkBfUmxoF0mw
         cgeFsypbpgH5WTIz7S3D9XLDSR0VDNrn3xUcHmVgN6BVTOkrbdJsL48vBkWuFMoCbCvu
         PSHsX0FjnKHvtzWw8J7EbCX0ztcM3XIXvFR0UHi4NxZjVlRJwNkcnqiRE1C3WOscHueL
         q9WWlSNRB06Ae/95KV7H/eTHcpXVE3Hu7Ce2JSIitjIarDaZ2uhp3a69GwYTg/jx83aU
         5K4w==
X-Gm-Message-State: AGi0Pubg0j2gCfsrZpM1FkJJEmkzFdU37R/WOXc5HSviLLdHmUDJCNVO
        4sLr9+TyamWVw/R4fm5eyFR05nRlA3A=
X-Google-Smtp-Source: APiQypJ1xVNlqyy5gDpvDKuwe1OXT/klO7riAzlKw9OT9YifDorSLzBvSkO8vxEHR4e+ep7EIPUG0g==
X-Received: by 2002:a05:620a:69a:: with SMTP id f26mr4531730qkh.430.1588696812480;
        Tue, 05 May 2020 09:40:12 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j8sm2238490qtk.85.2020.05.05.09.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:40:11 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: hachbench: Update the usage and man page for -F|--fifo option
Date:   Tue,  5 May 2020 12:40:01 -0400
Message-Id: <20200505164001.5705-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

The commit 6c0c79b5152a ("hackbench mods to work better under stress")
add -F|--fifo option, but not update the usage and man page, so this
patch fix it.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Signed-off-by: John Kacur <jkacur@redhat.com>
- Fixed-up rejected patch hunk in man page
- Changed the wording in the man page
---
 src/hackbench/hackbench.8 | 6 +++++-
 src/hackbench/hackbench.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/hackbench/hackbench.8 b/src/hackbench/hackbench.8
index d86c52f27a2e..aaf572359704 100644
--- a/src/hackbench/hackbench.8
+++ b/src/hackbench/hackbench.8
@@ -7,7 +7,7 @@ hackbench \- scheduler benchmark/stress test
 .RI "[\-l|\-\-loops " <num\-loops> "] "
 .RI "[\-g|\-\-groups "<num\-groups> "] "
 .RI "[\-f|\-\-fds <num\-fds>] "
-.RI "[\-T|\-\-threads] [\-P|\-\-process] [\-\-help]"
+.RI "[\-T|\-\-threads] [\-P|\-\-process] [\-F|\-\-fifo] [\-\-help]"
 
 .SH "DESCRIPTION"
 Hackbench is both a benchmark and a stress test for the Linux kernel
@@ -45,6 +45,10 @@ Each sender/receiver child will be a POSIX thread of the parent.
 .TP 
 .B \-P, \-\-process
 Hackbench will use fork() on all children (default behaviour)
+.TP
+.B \-F,\-\-fifo
+Change the main thread to SCHED_FIFO after creating workers.
+This allows the management thread to run after many workers are created.
 .TP 
 .B \-\-help
 .br 
diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 5a883d341f2e..2cddff654df6 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -92,7 +92,7 @@ static void print_usage_exit()
 {
 	printf("Usage: hackbench [-p|--pipe] [-s|--datasize <bytes>] [-l|--loops <num loops>]\n"
 	       "\t\t [-g|--groups <num groups] [-f|--fds <num fds>]\n"
-	       "\t\t [-T|--threads] [-P|--process] [--help]\n");
+	       "\t\t [-T|--threads] [-P|--process] [-F|--fifo] [--help]\n");
 	exit(1);
 }
 
-- 
2.21.3

