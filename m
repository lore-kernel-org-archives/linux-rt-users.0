Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF173C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB5861264
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhKKUpa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhKKUp3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:29 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E2C06127A
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:40 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v22so1866063qtx.8
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWlrA3TCJsqFgh70WFE36WVjk97XGy06Wwxsf7ne1Lk=;
        b=Ofkow4wLJEqFkypdd6dLkwweWqUHxqFfjAU486RkPydSLT0l51Uea/zzBexbSlY5h5
         ktNBUW1cM359JSmY1B/LyDnz7+SQ+GD4YTAyNWCKtL4UWmE4Ig0KgofccRtHGpUgLNfz
         BeOSnFOF1PlE2juiHgO1W+kT5ZEm1i2vcWBpfjtr1Ke7tt1RL8oCyXhFGdw3pNc3oqoL
         WzkZWBjKU6XeeNnIVUD2lPl6GyqsBF2Nc8a0C3FY5Se8EX1h23xWk9LJqCorx04aorHc
         Q4VKagoJ6CalDWF7N1m29ugdmgHm5nL1lQcLxU8ZPgCcLi5gxq574HTker3uPYt0OV1M
         Iq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kWlrA3TCJsqFgh70WFE36WVjk97XGy06Wwxsf7ne1Lk=;
        b=nHn029ar7khvmemL+Lv3ubC0RZH7BpER/2Egz7fQmSzeN8JY1PD+kz6tEaxxprfwI+
         gPWSY7ovocjacSpwZ9Ofnll/vadEMjI7LHVVvbN+gbS4qYegr25ZKS8uY7eutD1W4BLd
         2xQLPJTeU/DesD+QsZddn5WHrXgRiJFPMUeOM7VRVu/A/b+xdrE/686kntuv73vmiyje
         lcZ522SfJvyAcSNch/THV6j2c/Kb+bVAiXJyywdPooyt4OrPVKDsrvI5Ctvocrz4la99
         ytL6WsHqopUX862cCODfQIGJywubmRGobCNLYlF+9cxanwySDioPHBJM4GkbNTnkGR+R
         3k9Q==
X-Gm-Message-State: AOAM532U35/sTahE4il7fIumXyaofsdtFIFVkmshvdgtCOUuaXwNz5dY
        zn6mwheSiM+O36H/fEL8JZlINWy9B0g=
X-Google-Smtp-Source: ABdhPJyC43FYll0Ncrzzj0fXrskkhbryJzeSQv7jz1SuUxF0l6WCiY1dLSr+G7tDelz0Ml6MKriFfA==
X-Received: by 2002:ac8:4159:: with SMTP id e25mr10612247qtm.69.1636663359172;
        Thu, 11 Nov 2021 12:42:39 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:38 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 16/17] rt-tests: cyclictest: Simplify duplicate initialization of "stop"
Date:   Thu, 11 Nov 2021 15:42:06 -0500
Message-Id: <20211111204207.10167-16-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

The timespec structure "stop" is initialised whether it is used or not
as the compiler is not smart enough to figure out that it's use is
always guarded by the "duration" variable. As a result, "stop" needs
to be initialised whether it's used or not to avoid a compiler
warning.

Replace the duplicate memset statements by initializing "stop" using
structure initialiser.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 5758f88a24d0..73c5be972391 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -507,7 +507,7 @@ static void *timerthread(void *param)
 	struct sigevent sigev;
 	sigset_t sigset;
 	timer_t timer;
-	struct timespec now, next, interval, stop;
+	struct timespec now, next, interval, stop = { 0 };
 	struct itimerval itimer;
 	struct itimerspec tspec;
 	struct thread_stat *stat = par->stats;
@@ -516,8 +516,6 @@ static void *timerthread(void *param)
 	pthread_t thread;
 	unsigned long smi_now, smi_old = 0;
 
-	memset(&stop, 0, sizeof(stop));
-
 	/* if we're running in numa mode, set our memory node */
 	if (par->node != -1)
 		rt_numa_set_numa_run_on_node(par->node, par->cpu);
@@ -598,7 +596,6 @@ static void *timerthread(void *param)
 	tsnorm(&next);
 
 	if (duration) {
-		memset(&stop, 0, sizeof(stop)); /* grrr */
 		stop = now;
 		stop.tv_sec += duration;
 	}
-- 
2.31.1

