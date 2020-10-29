Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5116EC2D0A3
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A2C2076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBeausy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgJ2Rlb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgJ2Rla (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B9AC0613D2
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s1so1652271qvm.13
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5bN3fTEDh6SRMsSqk7UvuemikyoYaMQVwzoLeA/KQI=;
        b=aBeausy+SHC5py9i2uW0VxxMPSH1kj9Lbx8E7JU8XQiOTLt1+e3IQLCw8ytOoTvQA6
         9+woMUeJxsjYo4r2GJtPwehCVLgOsAcLlyGN79iBuD3mpvp7DbXNPICfuEXGQE4aphgj
         Qjx4tg9oY/OSqZoB+jp08JwIssRISgQIDY06LkW3fsGVW/e3HNOGV2AYzupVd2Z9Zf+F
         erMp3wNCsRS+SemKkX8wpzrEW1diVcm92LdkreYNiMhv7EJlOLIc2T13kJhyPpg7qI5U
         xkJnFtnkZnF7/FpIr2b8N9GPjrpkECi0c4pfsmHaAYGBej1oCE1g5VvHpsrVDjua7Nzt
         nPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=m5bN3fTEDh6SRMsSqk7UvuemikyoYaMQVwzoLeA/KQI=;
        b=qr6fccQ0QXes1RrRKOxixwv5n9+qopCh8kxZOEx5Pd8cMJtheqayP5CbxErGqPTByg
         jx88ajkrz+JEJGeMiaa/PmPJmNKPRy3uaC1EW/hIX1T5WYMXrVD644v8RrLI14DrTxtW
         N/p0n0jkruX1xvOLtEfNEWoZsC/2sngl6h42LlN6NjDYeY+nDAXHBSXXBWqsbpSWdcBt
         KO6wiRTlsarOOoAJB43fn7a0rdS8oTTfNFZyJMNJjm63dyCKdTme4OGfEDqK0sBxjcfC
         5x1DRHX5QV0w62QMeh8vzvR2pn9PBchJWUNlfshNmtGNA79fwh9WCVsAkK7WpAgJIPyh
         IHkw==
X-Gm-Message-State: AOAM531OJpiocY/xw/bg/LT4Qj4Retk4iK3SypsC3m+aZDSiJfXgKZLD
        GZrBdk3iICoYX0tKvuL99J+8pzDqpkQRXw==
X-Google-Smtp-Source: ABdhPJx9D0xnzz8kbXjTN9rFU6SAQqEA2HgDTMztSNg5B66grflogAgh5K7Q7NrzrXenBXX115qvCA==
X-Received: by 2002:a05:6214:1507:: with SMTP id e7mr5320740qvy.18.1603993289091;
        Thu, 29 Oct 2020 10:41:29 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:27 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 16/16] rt-tests: svsematest.c: Fix various style problems
Date:   Thu, 29 Oct 2020 13:40:57 -0400
Message-Id: <20201029174057.20033-17-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix various style problems as reported by checkpatch.pl
For example, spacing around "<", indentation of a lable, and so on.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/svsematest/svsematest.c | 50 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 7412168bd98a..98efd930e63f 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -94,16 +94,16 @@ void *semathread(void *param)
 	if (par->cpu != -1) {
 		CPU_ZERO(&mask);
 		CPU_SET(par->cpu, &mask);
-		if(sched_setaffinity(0, sizeof(mask), &mask) == -1)
+		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
 			snprintf(par->error, sizeof(par->error),
 			    "WARNING: Could not set CPU affinity "
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
 
@@ -112,8 +112,8 @@ void *semathread(void *param)
 
 	while (!par->shutdown) {
 		if (par->sender) {
- 			sb.sem_num = SEM_WAIT_FOR_SENDER;
- 			sb.sem_op = SEM_UNLOCK;
+			sb.sem_num = SEM_WAIT_FOR_SENDER;
+			sb.sem_op = SEM_UNLOCK;
 			/*
 			 * Unlocking the semaphore:
 			 *   Start of latency measurement ...
@@ -121,29 +121,29 @@ void *semathread(void *param)
 			gettimeofday(&par->unblocked, NULL);
 			semop(par->semid, &sb, 1);
 			par->samples++;
-			if(par->max_cycles && par->samples >= par->max_cycles)
+			if (par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 
 			if (mustgetcpu)
 				par->cpu = get_cpu();
 
- 			sb.sem_num = SEM_WAIT_FOR_RECEIVER;
- 			sb.sem_op = SEM_LOCK;
+			sb.sem_num = SEM_WAIT_FOR_RECEIVER;
+			sb.sem_op = SEM_LOCK;
 			semop(par->semid, &sb, 1);
 
- 			sb.sem_num = SEM_WAIT_FOR_SENDER;
+			sb.sem_num = SEM_WAIT_FOR_SENDER;
 			sb.sem_op = SEM_LOCK;
 			semop(par->semid, &sb, 1);
 		} else {
 			/* Receiver */
 			struct params *neighbor;
 
- 			if (wasforked)
+			if (wasforked)
 				neighbor = par + par->num_threads;
 			else
 				neighbor = par->neighbor;
 
- 			sb.sem_num = SEM_WAIT_FOR_SENDER;
+			sb.sem_num = SEM_WAIT_FOR_SENDER;
 			sb.sem_op = SEM_LOCK;
 			semop(par->semid, &sb, 1);
 
@@ -185,13 +185,13 @@ void *semathread(void *param)
 				neighbor->shutdown = 1;
 			}
 
- 			sb.sem_num = SEM_WAIT_FOR_RECEIVER;
+			sb.sem_num = SEM_WAIT_FOR_RECEIVER;
 			sb.sem_op = SEM_UNLOCK;
 			semop(par->semid, &sb, 1);
 
 			nanosleep(&par->delay, NULL);
 
- 			sb.sem_num = SEM_WAIT_FOR_SENDER;
+			sb.sem_num = SEM_WAIT_FOR_SENDER;
 			sb.sem_op = SEM_UNLOCK;
 			semop(par->semid, &sb, 1);
 		}
@@ -211,10 +211,10 @@ void *semathread(void *param)
 
 
 union semun {
-       int		val;	/* Value for SETVAL */
-       struct semid_ds *buf;	/* Buffer for IPC_STAT, IPC_SET */
-       unsigned short  *array;	/* Array for GETALL, SETALL */
-       struct seminfo  *__buf;	/* Buffer for IPC_INFO (Linux-specific) */
+	int		val;	/* Value for SETVAL */
+	struct semid_ds *buf;	/* Buffer for IPC_STAT, IPC_SET */
+	unsigned short  *array;	/* Array for GETALL, SETALL */
+	struct seminfo  *__buf;	/* Buffer for IPC_INFO (Linux-specific) */
 };
 
 
@@ -293,7 +293,7 @@ static void process_options(int argc, char *argv[])
 			if (optarg != NULL) {
 				affinity = atoi(optarg);
 				setaffinity = AFFINITY_SPECIFIED;
-			} else if (optind<argc && atoi(argv[optind])) {
+			} else if (optind < argc && atoi(argv[optind])) {
 				affinity = atoi(argv[optind]);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
@@ -330,7 +330,7 @@ static void process_options(int argc, char *argv[])
 			}
 			if (optarg != NULL)
 				num_threads = atoi(optarg);
-			else if (optind<argc && atoi(argv[optind]))
+			else if (optind < argc && atoi(argv[optind]))
 				num_threads = atoi(argv[optind]);
 			else
 				num_threads = max_cpus;
@@ -386,7 +386,7 @@ int main(int argc, char *argv[])
 	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	int oldsamples = 1;
 	key_t key;
-        union semun args;
+	union semun args;
 	struct params *receiver = NULL;
 	struct params *sender = NULL;
 	sigset_t sigset;
@@ -421,7 +421,7 @@ int main(int argc, char *argv[])
 		totalsize = num_threads * sizeof(struct params) * 2;
 
 		shm_unlink("/sigwaittest");
-  		shmem = shm_open("/sigwaittest", O_CREAT|O_EXCL|O_RDWR,
+		shmem = shm_open("/sigwaittest", O_CREAT|O_EXCL|O_RDWR,
 		    S_IRUSR|S_IWUSR);
 		if (shmem < 0) {
 			fprintf(stderr, "Could not create shared memory\n");
@@ -696,11 +696,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	nosem:
+nosem:
 	for (i = 0; i < num_threads; i++)
 		semctl(receiver[i].semid, -1, IPC_RMID);
 
- 	nomem:
+nomem:
 	if (mustfork) {
 		munmap(param, totalsize);
 		shm_unlink("/sigwaittest");
-- 
2.26.2

