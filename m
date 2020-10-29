Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64500C56201
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D0120790
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn2n4dw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgJ2RlV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbgJ2RlU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E251C0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b18so2638111qkc.9
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mi+/N2uCj4XVGJnBMRNdtlMByj5z3SKzYsNwhngjxnI=;
        b=Tn2n4dw3G5GnUi5KF69Hob8kYzQnraaPenjfc9KP/s7tNccU6uSviUdPGizM0V+Tm0
         dsLjr9QdG3tQZi82HCCdZ9czEceHHdbk3QlSrlUDYCodrl7RwuiP1ihgPIhOQmcLKTY9
         1ub8fKwCunfKn8M8ZWkWDCtsvPVx3kAmHo/yDearJUVSGHtpDODLvGUMo7yqbx3nOjVM
         /cNojcSvt//g8+aJ0GouaD5PoJONvfirn745CUlb3vC+aS52OPS3XrwW488QvhFrd+1U
         Ivg7vmcVZV1YWenP6DVsQEfgL0uLBE8slkB8A3Evue8oVDui00lpUB1H4XKP0km5elH/
         FBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Mi+/N2uCj4XVGJnBMRNdtlMByj5z3SKzYsNwhngjxnI=;
        b=UjL/N95HqxgPBQwJip7gwv4+fSHXqtTO57ydAOVsOoFjJ7kTNOjbpHsvHR+qPrJtWG
         M/uYWJTI/panNv4t1ybem5QvbzgcTp/SpqRu6qZP9Xjuw+XM+JDU5gHazqqYrmYOajG2
         e+ynwuVYufuY2zTXlIpi9PAYKj0EKt9WJTq0jYGf+wkjAM7GvEojT4RaIl7P7SERNzGS
         slxjOlEgdyHz9pEEN/hNRZxkfAbKiGjZqm55SlmSS3ktbQmYQpf5zJ6bfAGNjdBFgTqX
         Z25LQGUSoXpBdwEmyLRLjFX8EYZ6OCLD6CSqIdqUJSlVOkU/ATjjEUBoxbdWeqI3MDhR
         fHjQ==
X-Gm-Message-State: AOAM532zweDkFLM+2nu4XENQbi5b5DwtmKUE/HawfpXxTDzxOzf7MUGJ
        xagBS+QHJxP68PvsRku45SFKGIc2ukzQvA==
X-Google-Smtp-Source: ABdhPJyrNVpDEc966OySphMNRWxhA7lEgxh+YMaJGiDUHlvSF5jLhN0jcC0gwCOTiM+t4ukK5A2Ctg==
X-Received: by 2002:a05:620a:99d:: with SMTP id x29mr4959766qkx.415.1603993279678;
        Thu, 29 Oct 2020 10:41:19 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:18 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 07/16] rt-tests: pmqtest.c: Fix spacing around parentheses
Date:   Thu, 29 Oct 2020 13:40:48 -0400
Message-Id: <20201029174057.20033-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix spacing around parentheses as suggestsed by checkpatch.pl

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pmqtest/pmqtest.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 938dc8d93c3f..a1e487b85d2c 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -83,7 +83,7 @@ void *pmqthread(void *param)
 	if (par->cpu != -1) {
 		CPU_ZERO(&mask);
 		CPU_SET(par->cpu, &mask);
-		if(sched_setaffinity(0, sizeof(mask), &mask) == -1)
+		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
 			fprintf(stderr,	"WARNING: Could not set CPU affinity "
 				"to CPU #%d\n", par->cpu);
 	} else
@@ -97,7 +97,7 @@ void *pmqthread(void *param)
 			/* Optionally force receiver timeout */
 			if (par->forcetimeout) {
 				struct timespec senddelay;
-				
+
 				senddelay.tv_sec = par->forcetimeout;
 				senddelay.tv_nsec = 0;
 				clock_nanosleep(CLOCK_MONOTONIC, 0, &senddelay, NULL);
@@ -110,7 +110,7 @@ void *pmqthread(void *param)
 				par->shutdown = 1;
 			}
 			par->samples++;
-			if(par->max_cycles && par->samples >= par->max_cycles)
+			if (par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 			if (mustgetcpu)
 				par->cpu = get_cpu();
@@ -118,17 +118,17 @@ void *pmqthread(void *param)
 			if (par->timeout) {
 				clock_gettime(CLOCK_REALTIME, &ts);
 				ts.tv_sec += par->timeout;
-	
+
 				if (mq_timedreceive(par->syncmq, par->recvsyncmsg, MSG_SIZE, NULL, &ts)
 				    != strlen(syncmsg)) {
 					fprintf(stderr, "could not receive sync message\n");
-					par->shutdown = 1;				
+					par->shutdown = 1;
 				}
-			} 
+			}
 			if (mq_receive(par->syncmq, par->recvsyncmsg, MSG_SIZE, NULL) !=
 			    strlen(syncmsg)) {
 				perror("could not receive sync message");
-				par->shutdown = 1;				
+				par->shutdown = 1;
 			}
 			if (!par->shutdown && strcmp(syncmsg, par->recvsyncmsg)) {
 				fprintf(stderr, "ERROR: Sync message mismatch detected\n");
@@ -156,8 +156,7 @@ void *pmqthread(void *param)
 						}
 					} else
 						break;
-				}
-				while (1);
+				} while (1);
 			} else {
 				if (mq_receive(par->testmq, par->recvtestmsg, MSG_SIZE, NULL) !=
 				    strlen(testmsg)) {
@@ -261,7 +260,7 @@ static int sameprio;
 static int timeout;
 static int forcetimeout;
 
-static void process_options (int argc, char *argv[])
+static void process_options(int argc, char *argv[])
 {
 	int error = 0;
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
@@ -297,7 +296,7 @@ static void process_options (int argc, char *argv[])
 			if (optarg != NULL) {
 				affinity = atoi(optarg);
 				setaffinity = AFFINITY_SPECIFIED;
-			} else if (optind<argc && atoi(argv[optind])) {
+			} else if (optind < argc && atoi(argv[optind])) {
 				affinity = atoi(argv[optind]);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
@@ -325,7 +324,7 @@ static void process_options (int argc, char *argv[])
 			}
 			if (optarg != NULL)
 				num_threads = atoi(optarg);
-			else if (optind<argc && atoi(argv[optind]))
+			else if (optind < argc && atoi(argv[optind]))
 				num_threads = atoi(argv[optind]);
 			else
 				num_threads = max_cpus;
@@ -366,7 +365,7 @@ static void process_options (int argc, char *argv[])
 		sameprio = 1;
 
 	if (error)
-		display_help (error);
+		display_help(error);
 }
 
 
@@ -523,7 +522,7 @@ int main(int argc, char *argv[])
 			if (minsamples < 1)
 				printf("Collecting ...\n\033[1A");
 		}
-		
+
 		fflush(NULL);
 
 		oldsamples = 0;
@@ -564,7 +563,7 @@ int main(int argc, char *argv[])
 		mq_unlink(mqname);
 	}
 
-	nomem:
+nomem:
 
 	return 0;
 }
-- 
2.26.2

