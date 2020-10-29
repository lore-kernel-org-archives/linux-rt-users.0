Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A05C56201
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF4F2076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t41UqbsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgJ2Rl1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgJ2Rl0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:26 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE0C0613D2
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:26 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id m65so2335199qte.11
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdjtEk3nn8F0l2g2DtdutdgqcBcSGgIp8MPmdqIbjpY=;
        b=t41UqbsV87+FQrw3nNMtdDKj2kQNLKF8QsIdZDrOPzqcbv1xCaN5jsNiYUXmQXCzu8
         pVAF3T+s1F1fy9WI+sZcgFDMsD27A185v4Twmeb0fiRIZcctdEiNwB0a6sf8lpuYsTLr
         S2eStQnCeOqIHDUNH/MwaONanYAxBR043dpQvl6gF/AKd//1ton3WYy9sAIivS2bSNGb
         As6dBn7752Der6o1UquIhtRCuzFaazb/HGQadQTIOaIkHtn7VzhgKbXapKiJgGRG8Xma
         QF/xEQVQQYiXrF5JGlN2r8haXCnXxnVHDzQT7M2BOoAhvAjAefdWRRY5iSjAsMR4/ixz
         yWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EdjtEk3nn8F0l2g2DtdutdgqcBcSGgIp8MPmdqIbjpY=;
        b=pKEqazyJvJMgWetR8VcSpuOMtBTUc1ZkKEa+iuiGuEez9qC0uP02RCVhZqy4bj1Na5
         PyJThFXOCGP5X0sfnXnD04rkgm/TUDE9onvmL1V3OsX5q03SOnK6qvmX5U76Zbh8DFz5
         VYUtCkdABAD63chXF2/64phuQWcgj7EIZ0Wcb8vNjG73MkKkkVjwr4mhRo0dqCBBiVOl
         5olKo5oiXIPDCht8UDiijXu0W0K1pz9tGyFPC9gKhEN+fFkK+8doKAWYqV+LfGgiaC93
         VfqIGqXIvgSXfJY6OqVt2q5IRVuhUFVzne4chflIiSeEkgjXeCXWqBLejGfKNHMheVtZ
         Q0lA==
X-Gm-Message-State: AOAM531aorjTn4jkBeametyKkerCGk3kc93cTq5Lt2BjhZ7ntCUJFaZ8
        MOKRdk/yTfPhxP2v8XuwVH0TtsodP/XUkw==
X-Google-Smtp-Source: ABdhPJyd4+aomcwAmecYc88Tzw9kjGtJSyy+ghppJ7hH2ttUcnyH3vNhxi/3vCuBhbr6ljNFlfHCcQ==
X-Received: by 2002:aed:3ae9:: with SMTP id o96mr4847521qte.226.1603993285145;
        Thu, 29 Oct 2020 10:41:25 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:24 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 13/16] rt-tests: signaltest.c: Fix various style problems
Date:   Thu, 29 Oct 2020 13:40:54 -0400
Message-Id: <20201029174057.20033-14-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix various style problems suggested by checkpatch.pl

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/signaltest/signaltest.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index c718f8676b9f..1cc3236a8f37 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -61,8 +61,8 @@ struct thread_stat {
 };
 
 static int shutdown;
-static int tracelimit = 0;
-static int oldtrace = 0;
+static int tracelimit;
+static int oldtrace;
 
 
 /*
@@ -107,7 +107,7 @@ void *signalthread(void *param)
 
 	if (tracelimit) {
 		if (oldtrace)
-			gettimeofday(0,(struct timezone *)1);
+			gettimeofday(0, (struct timezone *)1);
 		else
 			prctl(0, 1);
 	}
@@ -153,7 +153,7 @@ void *signalthread(void *param)
 		if (!stopped && tracelimit && (diff > tracelimit)) {
 			stopped++;
 			if (oldtrace)
-				gettimeofday(0,0);
+				gettimeofday(0, 0);
 			else
 				prctl(0, 0);
 			shutdown++;
@@ -207,12 +207,13 @@ static int max_cycles;
 static int duration;
 static int verbose;
 static int quiet;
-static int lockall = 0;
+static int lockall;
 
 /* Process commandline options */
 static void process_options(int argc, char *argv[])
 {
 	int error = 0;
+
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
@@ -326,7 +327,7 @@ int main(int argc, char **argv)
 
 	sigemptyset(&sigset);
 	sigaddset(&sigset, signum);
-	sigprocmask (SIG_BLOCK, &sigset, NULL);
+	sigprocmask(SIG_BLOCK, &sigset, NULL);
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
@@ -400,7 +401,7 @@ int main(int argc, char **argv)
 		}
 
 		print_stat(&par[0], 0, verbose);
-		if(max_cycles && stat[0].cycles >= max_cycles)
+		if (max_cycles && stat[0].cycles >= max_cycles)
 			allstopped++;
 
 		usleep(10000);
-- 
2.26.2

