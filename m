Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F8C4363A
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D4D2076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1bPtWfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgJ2RlX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgJ2RlX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C8CC0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l2so2687799qkf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ax36DC/SPSj1/R84bC1Ge1yWykBae+YQVmAE2OMh4es=;
        b=Y1bPtWfjWHIWBmxq3OH2Li/xCDOc7KJW+CBirUs52MzuV6C4RoySAkFV30/FVDTdYV
         UHzI1PdsEVcNIO/fKdgJ8NRoeIVCkOgLZzgrsHltXE5vf96kj65u+iaUgDAV0cpaCJEk
         oZVP8Gajm3xwyBzFu0dAPvF0xdwg+ssXxTju7e8Dz5ivkyUQ9dzLdJM2x0flTcZID4m2
         KBkhXkz9++3xbyT412HymEuflXq3rjvtIDuR2SMkxVH8vQDl+l/i2pRxkRhBZAIWKpBf
         VX42vGpn8VkRHKwFSc2vd8LGlNldkL8Audsj73XZP33FplCwclkGHYg4wW9ho86PN95p
         OGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ax36DC/SPSj1/R84bC1Ge1yWykBae+YQVmAE2OMh4es=;
        b=L3fYsmbkdm4p0SMFeto+Fy7Xww6snTGF0v//HYZpgC9n0ixnopW3N6XorNaOPdgtbi
         twr7l3tnmZEe1bBQOSWN1pZ9tKwFpFis0ON5c4RExqYndHnd13+sSiVRFL7j/hX/Qiya
         sJ1AiS7/L2Vk/NcT5QiYeZEqKKv7gbPHyOGBrZJYI7ChmD6B2jywexAUriBv0QHOhAPt
         +7qXM/KftNJjzQYKhX78W01ZlUWjkIw30w0G8g2paW3h8TZ60IMeuZUqexNOfB+VZ+St
         fbGx4+et0l8DDPPUFPBDzKL6VYblGGTZbuqILyRxudjQX149feB93pqpJpcF9RruwUAJ
         pXCw==
X-Gm-Message-State: AOAM532S6C5sPOvhkwLp67Gnkh4GELcy02cHWtFjeXmmeDm3s+tYQSzQ
        IkcdaBaPNBTuSpU5WihlXMCnMEbFiMblfQ==
X-Google-Smtp-Source: ABdhPJwuzUNGuzbQN65PFvjj0EbbrTY1Azl6E+O1bjlHspwhp/aelpNLbcuXE3sm5tWa9d7OpvQWNg==
X-Received: by 2002:a37:8b42:: with SMTP id n63mr4217922qkd.297.1603993280577;
        Thu, 29 Oct 2020 10:41:20 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:20 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 08/16] rt-tests: ptsematest.c: Fix spacing around parentheses
Date:   Thu, 29 Oct 2020 13:40:49 -0400
Message-Id: <20201029174057.20033-9-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix spacing around parentheses as suggested by checkpatch.pl

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ptsematest/ptsematest.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 02919e3f5eef..9cd5f34509a8 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -71,7 +71,7 @@ void *semathread(void *param)
 	if (par->cpu != -1) {
 		CPU_ZERO(&mask);
 		CPU_SET(par->cpu, &mask);
-		if(sched_setaffinity(0, sizeof(mask), &mask) == -1)
+		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
 			fprintf(stderr,	"WARNING: Could not set CPU affinity "
 				"to CPU #%d\n", par->cpu);
 	} else
@@ -87,7 +87,7 @@ void *semathread(void *param)
 			gettimeofday(&par->unblocked, NULL);
 			pthread_mutex_unlock(&testmutex[par->num]);
 			par->samples++;
-			if(par->max_cycles && par->samples >= par->max_cycles)
+			if (par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 			if (mustgetcpu)
 				par->cpu = get_cpu();
@@ -181,7 +181,7 @@ static int distance = 500;
 static int smp;
 static int sameprio;
 
-static void process_options (int argc, char *argv[])
+static void process_options(int argc, char *argv[])
 {
 	int error = 0;
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
@@ -215,7 +215,7 @@ static void process_options (int argc, char *argv[])
 			if (optarg != NULL) {
 				affinity = atoi(optarg);
 				setaffinity = AFFINITY_SPECIFIED;
-			} else if (optind<argc && atoi(argv[optind])) {
+			} else if (optind < argc && atoi(argv[optind])) {
 				affinity = atoi(argv[optind]);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
@@ -242,7 +242,7 @@ static void process_options (int argc, char *argv[])
 			}
 			if (optarg != NULL)
 				num_threads = atoi(optarg);
-			else if (optind<argc && atoi(argv[optind]))
+			else if (optind < argc && atoi(argv[optind]))
 				num_threads = atoi(argv[optind]);
 			else
 				num_threads = max_cpus;
@@ -436,7 +436,7 @@ int main(int argc, char *argv[])
 		pthread_mutex_destroy(&syncmutex[i]);
 	}
 
- 	nomem:
+nomem:
 
 	return 0;
 }
-- 
2.26.2

