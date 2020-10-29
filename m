Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A1AC55179
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8952076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI6mU9bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgJ2Rlb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgJ2Rla (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCA9C0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id f6so1431442qtc.7
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOEdj5PFeldJ8EvZKOASBZF7Us66jWBNYr/vvztJQf8=;
        b=FI6mU9buzw/kXk734xBc5CGOxHEmKcw+cEV7zUyTmhWVCp8CxMNORKXCmXY4idvvOU
         tUoEH5FichvqmmLot+q70QT5Q3IfVdzZeKh5Nz/9Qqq9bJSMlfZPbAxw3IvjeJVa74fa
         nXA61LRBPVVqL36oUylV8tKsEu7/kSzQa6DxIGiXchDpe7OCt32YSzHRYuLrYjUFALzA
         F92xmZYZhoyvDN+o3G0/hx9eRe/t0UytAnJ9Ng3fvPy8J1YAfejDbuFOQ31YvmscXj52
         3rXInPAJjm16Ot5EmdR+/Q8PMGlgYGFiqhg0izqh6kjyaOLJZ/xoiWVgug6FJcctss9O
         j6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yOEdj5PFeldJ8EvZKOASBZF7Us66jWBNYr/vvztJQf8=;
        b=Go/KHsCFy+Jxsbs2q3dfPNaxF1kcs68pYmPyiTkPSRPH6SSwp1E1g2jcpFE35+lRBe
         HMx+6+ExhJH2lPzXP2M61bktYEXmIVScyjGaxpcWCOkeMkMROI+564xY0vljychpU+m/
         heY5EQKsTeHGBuwUcCM2Itr/+Jkz778EuKI/+UvQ3VOOci4nNWfv3jon5zQEfyhHhGGU
         dJBenb02k6B/NqWvuaFBakv4z8avgopLkFVzevRS7DjHXmHB2UkQOkGoxhCqfZcGWFMG
         rJblX2hXn1dUPpc65VsT4AnJ+pcg+Feh9YJLl7v8WGSfdq+7sqeyojHPpT/PNJ4oMPwD
         Y49Q==
X-Gm-Message-State: AOAM533wri8Smn+WITbR/WIkwAaIa6OMW03Lq1iFRhIr9ec6KYp8PHJE
        8H27MJgzzZuZrQyQkR0q2a9rzgWh/JBkvA==
X-Google-Smtp-Source: ABdhPJzhgmeyuZys979ekQBk6uK5oq4l1AEwW4wr9bcmKvTursUDE7YxnFV6jJj9p8611jTJcmwITQ==
X-Received: by 2002:aed:3147:: with SMTP id 65mr4800835qtg.295.1603993286488;
        Thu, 29 Oct 2020 10:41:26 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:25 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 14/16] rt-tests: sigwaittest.c: Fix spacing around brackets
Date:   Thu, 29 Oct 2020 13:40:55 -0400
Message-Id: <20201029174057.20033-15-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix spacing around brackets, Fix indented lable, etc

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sigwaittest/sigwaittest.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 12b55e901ce5..8a5d73b14fc2 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -93,15 +93,15 @@ void *semathread(void *param)
 	if (par->cpu != -1) {
 		CPU_ZERO(&mask);
 		CPU_SET(par->cpu, &mask);
-		if(sched_setaffinity(0, sizeof(mask), &mask) == -1)
+		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
 			fprintf(stderr,	"WARNING: Could not set CPU affinity "
 				"to CPU #%d\n", par->cpu);
 	} else {
-        	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+		int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
-        	if (max_cpus > 1)
-		        mustgetcpu = 1;
-	        else
+		if (max_cpus > 1)
+			mustgetcpu = 1;
+		else
 			par->cpu = 0;
 	}
 
@@ -133,12 +133,11 @@ void *semathread(void *param)
 			else
 				pthread_kill(neighbor->threadid, SIGUSR2);
 			par->samples++;
-			if(par->max_cycles && par->samples >= par->max_cycles)
+			if (par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 
-			if (mustgetcpu) {
+			if (mustgetcpu)
 				par->cpu = get_cpu();
-			}
 			sigwait(&sigset, &sig);
 		} else {
 			/* Receiver */
@@ -160,9 +159,8 @@ void *semathread(void *param)
 			if (par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 
-			if (mustgetcpu) {
+			if (mustgetcpu)
 				par->cpu = get_cpu();
-		        }
 			/*
 			 * Latency is the time spent between sending and
 			 * receiving the signal.
@@ -242,7 +240,7 @@ static int duration;
 static int interval = 1000;
 static int distance = 500;
 
-static void process_options (int argc, char *argv[])
+static void process_options(int argc, char *argv[])
 {
 	int error = 0;
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
@@ -273,7 +271,7 @@ static void process_options (int argc, char *argv[])
 			if (optarg != NULL) {
 				affinity = atoi(optarg);
 				setaffinity = AFFINITY_SPECIFIED;
-			} else if (optind<argc && atoi(argv[optind])) {
+			} else if (optind < argc && atoi(argv[optind])) {
 				affinity = atoi(argv[optind]);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
@@ -304,7 +302,7 @@ static void process_options (int argc, char *argv[])
 		case 't':
 			if (optarg != NULL)
 				num_threads = atoi(optarg);
-			else if (optind<argc && atoi(argv[optind]))
+			else if (optind < argc && atoi(argv[optind]))
 				num_threads = atoi(argv[optind]);
 			else
 				num_threads = max_cpus;
@@ -339,7 +337,7 @@ static void process_options (int argc, char *argv[])
 		tracelimit = thistracelimit;
 	}
 	if (error)
-		display_help (error);
+		display_help(error);
 }
 
 
@@ -386,7 +384,7 @@ int main(int argc, char *argv[])
 		totalsize = num_threads * sizeof(struct params) * 2;
 
 		shm_unlink("/sigwaittest");
-  		shmem = shm_open("/sigwaittest", O_CREAT|O_EXCL|O_RDWR,
+		shmem = shm_open("/sigwaittest", O_CREAT|O_EXCL|O_RDWR,
 		    S_IRUSR|S_IWUSR);
 		if (shmem < 0) {
 			fprintf(stderr, "Could not create shared memory\n");
@@ -629,7 +627,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
- 	nomem:
+nomem:
 	if (mustfork) {
 		munmap(param, totalsize);
 		shm_unlink("/sigwaittest");
-- 
2.26.2

