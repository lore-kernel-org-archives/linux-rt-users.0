Return-Path: <SRS0=LbvN=6S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD06C3A5A9
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 16:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16329206A4
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 16:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4ZXvMz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgEDQNr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 May 2020 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgEDQNr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 May 2020 12:13:47 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBF0C061A0E
        for <linux-rt-users@vger.kernel.org>; Mon,  4 May 2020 09:13:47 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ck5so8567269qvb.11
        for <linux-rt-users@vger.kernel.org>; Mon, 04 May 2020 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXM+F3ajLg+Li0n19Y1x+Eg3ztxE4wgD1+bf83gsUfs=;
        b=u4ZXvMz3avo1mur0qulh1C0QVC7yCqO66HXqIPlcUVQX3z6EbwmHKYAgWztzL/+nTg
         aluAhpuMMJawg436IGVPmaPjzB7cGDma06B5KQyyODwwwvnkEY+4ZIeK/jGFPnloKVtZ
         rBilVKCNzz81vDNBAtgJAT8uMDI44LZ4mNuK9l14SVrDZv1puai+0l7PD7dpOp3Eoy3B
         0h06iPIWlq5fXJNxOp9J2+lOS2Dq/EPRT4aUuC1XA53NSomJrAX7MEbKJGw6i1iVAxw1
         r55OxvSyGYGCBv2zMcUzeOBueYX46ZLnH8LyPqtmWhYlFG71Eyt7DsAXf3LlKtTc+qif
         NSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NXM+F3ajLg+Li0n19Y1x+Eg3ztxE4wgD1+bf83gsUfs=;
        b=kjjzHonqVpKWW+x7dHkCMvQiM4X22gOEFflS7jyH5A3symsg9H9o791RsFESPAYwJ7
         ZFE/A/AphRtqxOjhmRH2jVw/0wB1zr5EYpKVkJL5JoFVQu6XxVcTDICWQgHxUtUp6+6F
         2/fkukMBDrCExTLca8dmwIbZg7oI2kGQqRUn7n2zcGOFib4/AFdlacaHViwMJn8UN2oz
         +q67zrpqigCYLn+KmInJ146nVxzWRTh+0N8Pq/ninRPJIot+Bsl2y5KD3xVcmSv31iH2
         VjhpxH4shdkCc4eq1WusMWBCGUj01YgrNXx3zHQeZ5qF6Ac8K6cufcFKtB+dJVg0pBP6
         76Ag==
X-Gm-Message-State: AGi0PuatwDcL9hG9tVGzFRsXbo3tl7lGFe4E3+JbI+065l9i3ujXDl0t
        qWKKw6G1kMRM0jmcQhAc+4uu8C/b3L0=
X-Google-Smtp-Source: APiQypLY1RCoeySAN2jqa5VoeuqL+yD87W/Q6Fqne2iQOFT8QJa8H/ZXDTx4T9aV/rkTwsFaTBHUbA==
X-Received: by 2002:a0c:8324:: with SMTP id j33mr17379376qva.23.1588608826006;
        Mon, 04 May 2020 09:13:46 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id s8sm11499583qtb.0.2020.05.04.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:13:45 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Kate Carcia <kcarcia@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] cyclictest: Fix setaffinity error on large NUMA machines
Date:   Mon,  4 May 2020 12:12:58 -0400
Message-Id: <20200504161258.4447-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On large NUMA machines still getting the following error
WARN: Couldn't setaffinity in main thread: Invalid argument

Instead of calling numa_bitmask_alloc() with max_cpus, use
numa_allocate_cpumask() to fix this.

Also, make sure numa_available() is called before any other calls to the
numa library. Depending on how the options were invoked this could
happen in parse_cpumask for example. Note, this did not seem to cause
any problems in practice, but let's adhere to the library contract.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 989113fb3483..79bb1cb71c68 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1135,7 +1135,7 @@ static void use_current_cpuset(const int max_cpus)
 
 	pid = getpid();
 
-	curmask = numa_bitmask_alloc(max_cpus);
+	curmask = numa_allocate_cpumask();
 	numa_sched_getaffinity(pid, curmask);
 
 	/* Clear bits that are not set in both the cpuset from the environment,
@@ -1225,6 +1225,20 @@ enum option_values {
 	OPT_TRACEMARK, OPT_POSIX_TIMERS,
 };
 
+/* numa_available() must be called before any other calls to the numa library */
+static void numa_initialize(void)
+{
+	static int is_initialized;
+
+	if (is_initialized == 1)
+		return;
+
+	if (numa_available() != -1)
+		numa = 1;
+
+	is_initialized = 1;
+}
+
 /* Process commandline options */
 static void process_options (int argc, char *argv[], int max_cpus)
 {
@@ -1288,6 +1302,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			/* smp sets AFFINITY_USEALL in OPT_SMP */
 			if (smp)
 				break;
+			numa_initialize();
 			if (optarg != NULL) {
 				parse_cpumask(optarg, max_cpus);
 				setaffinity = AFFINITY_SPECIFIED;
@@ -1460,12 +1475,9 @@ static void process_options (int argc, char *argv[], int max_cpus)
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
 #ifdef NUMA
-		if (numa_available() != -1) {
-			numa = 1;
-			if (setaffinity == AFFINITY_UNSPECIFIED) {
-				setaffinity = AFFINITY_USEALL;
-			}
-		}
+		numa_initialize();
+		if (setaffinity == AFFINITY_UNSPECIFIED)
+			setaffinity = AFFINITY_USEALL;
 #else
 		warn("cyclictest was not built with the numa option\n");
 		numa = 0;
-- 
2.21.3

