Return-Path: <SRS0=qZJ4=ZR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC539C432C0
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A769C20836
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDaLryig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfKYORF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:17:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40122 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfKYORF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Nov 2019 09:17:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id 4so14963248wro.7
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Nov 2019 06:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hsx39ajFKCU3HdOwwuNicof0QMPK7qFv7hLA8JZjxsg=;
        b=EDaLryigQulqdU+MV5URI1eMjPd8jKuwbnbQBJ1hvL2Cis6Dmc8yTn773DTzssTBPt
         vv2e0EAUkpdjIpYEZEfyHOO1Zl9PlhPU1t1NfkP72r7KxcFiXKy77z1vFSSsTHumdViK
         ifNmqTDMuyPin7TnXXraeRi43gPVevCMlQYfvuaDCjTh4tVRifllWW9lctDpLcNVIYPS
         pm8krirrmcszC01QNv3rN9dkNhIwlIbqI/abkE3C5zGPGEUDuwt63Fi/pUUiX2sX7jUg
         mi1IxswZz4MrRad8kDrpiqsDO2m8qyC/xhZdwwdMMyevjCkKw6XcZpP7WM1PrOHVCQ2J
         YTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Hsx39ajFKCU3HdOwwuNicof0QMPK7qFv7hLA8JZjxsg=;
        b=Cz237FKd3UCnMgxF6HqGbsHy69gbs7Qxk6L+zEQ2Ts5fdc2lsJlGvnIWyGmmCUPZPN
         cTir/WLeRhO0w1xYEFCBfU0uxBlQo2NSJfDYtVGCRRru1+AZ/PPZ/MqygsSAFFy0Y3AI
         OXBnmu2BBxRA08ymJaJn9iTAfNwJ8ZAFgSO/ChJy5fCE6IsKlHEFy7D4OgrcGDUUD/rB
         +kexmrhT7Y4lxv8sejMFvTdtMckrE4lK4jej/4qJBaSpfi1C6SHhw5/PFsV8N2+XF4Hk
         VELBuZg0dSXCo5bWh5e0GRBqe2dCpISUOPjfiq0vk4ErhPPRbgjQ2h0e54RHaG4YwPhe
         Ayww==
X-Gm-Message-State: APjAAAW+UNA+qxuX8F7HRk/djMD7JKjcoMuWKoFFMFUxa+03edMFQmSP
        I1Xtbl8Uw57zH8z7IusUwQk02L4vdOY=
X-Google-Smtp-Source: APXvYqzt8g24a5+UcYxvL/pT20322w9UJ5McQvQIE7mpt5LzqqVaB/Pe5HKpQ4zkdY90xBC+NR9B1w==
X-Received: by 2002:adf:e312:: with SMTP id b18mr33530685wrj.203.1574691421329;
        Mon, 25 Nov 2019 06:17:01 -0800 (PST)
Received: from planxty.redhat.com (ip1f122014.dynamic.kabel-deutschland.de. [31.18.32.20])
        by smtp.gmail.com with ESMTPSA id q5sm8463456wmc.27.2019.11.25.06.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:17:00 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/8] rt-tests: cyclictest: Get a snapshot of cyclictest without interuppting it
Date:   Mon, 25 Nov 2019 15:16:41 +0100
Message-Id: <20191125141644.4429-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191125141644.4429-1-jkacur@redhat.com>
References: <20191125141644.4429-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Right now if you are running cyclictest you can send it SIGUSR1
and it will spill out the data at a moment in time, and keep running.

However, this can be problematic if you are using another program such
as rteval to consume the data.

This feature here lets you send SIGUSR2 to cyclictest and it dumps
status to shared memory so you can read it without interrupting
cyclictest and without interferring with the data it is outputing.

To use it, start cyclictest in one term, then in another term send it
SIGUSR2, and then you can just cat the results like this:

    [jkacur@planxty rt-tests]$ ps ax | tail
    14083 ?        I      0:00 [kworker/1:0-events]
    14108 ?        I      0:01 [kworker/u16:3-events_unbound]
    14150 ?        I      0:00 [kworker/7:0-mm_percpu_wq]
    14287 pts/9    SLl+   0:14 ./cyclictest -t
    14324 ?        I      0:00 [kworker/1:2]
    14341 ?        I      0:00 [kworker/0:2]
    14342 ?        I      0:00 [kworker/2:1]
    14363 ?        I      0:00 [kworker/u16:0-events_unbound]
    14381 pts/2    R+     0:00 ps ax
    14382 pts/2    S+     0:00 tail

    [jkacur@planxty rt-tests]$ cat /dev/shm/cyclictest_shm
    [jkacur@planxty rt-tests]$ kill -s USR2 14287
    [jkacur@planxty rt-tests]$ cat /dev/shm/cyclictest_shm
    #---------------------------
    # cyclictest current status:
    T: 0 (14288) P: 0 I:1000 C: 124852 Min:     20 Act:   65 Avg:  104 Max:     354
    T: 1 (14289) P: 0 I:1500 C:  83235 Min:      6 Act:   77 Avg:   82 Max:     330
    T: 2 (14290) P: 0 I:2000 C:  62426 Min:      9 Act:   71 Avg:  110 Max:     358
    T: 3 (14291) P: 0 I:2500 C:  49940 Min:      9 Act:   77 Avg:  111 Max:     453
    T: 4 (14292) P: 0 I:3000 C:  41617 Min:     14 Act:   68 Avg:   69 Max:     815
    T: 5 (14293) P: 0 I:3500 C:  35672 Min:     15 Act:   68 Avg:  105 Max:     360
    T: 6 (14294) P: 0 I:4000 C:  31212 Min:     15 Act:   64 Avg:  103 Max:     372
    T: 7 (14295) P: 0 I:4500 C:  27744 Min:     20 Act:  118 Avg:   93 Max:     681
    #---------------------------

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 184 ++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index bca028fedffd..1c515ae1354c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -231,10 +231,14 @@ static struct thread_param **parameters;
 static struct thread_stat **statistics;
 
 static void print_stat(FILE *fp, struct thread_param *par, int index, int verbose, int quiet);
+static void rstat_print_stat(struct thread_param *par, int index, int verbose, int quiet);
+static void rstat_setup(void);
 
 static int latency_target_fd = -1;
 static int32_t latency_target_value = 0;
 
+static int rstat_fd = -1;
+
 /* Latency trick
  * if the file /dev/cpu_dma_latency exists,
  * open it and write a zero into it. This will tell
@@ -1475,6 +1479,22 @@ static void sighand(int sig)
 		fprintf(stderr, "#---------------------------\n");
 		quiet = oldquiet;
 		return;
+	} else if (sig == SIGUSR2) {
+		int i;
+		int oldquiet = quiet;
+
+		if (rstat_fd == -1) {
+			fprintf(stderr, "ERROR: rstat_fd not valid\n");
+			return;
+		}
+		quiet = 0;
+		dprintf(rstat_fd, "#---------------------------\n");
+		dprintf(rstat_fd, "# cyclictest current status:\n");
+		for (i = 0; i < num_threads; i++)
+			rstat_print_stat(parameters[i], i, 0, 0);
+		dprintf(rstat_fd, "#---------------------------\n");
+		quiet = oldquiet;
+		return;
 	}
 	shutdown = 1;
 	if (refresh_on_max)
@@ -1642,6 +1662,62 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
 	}
 }
 
+static void rstat_print_stat(struct thread_param *par, int index, int verbose, int quiet)
+{
+	struct thread_stat *stat = par->stats;
+	int fd = rstat_fd;
+
+	if (!verbose) {
+		if (quiet != 1) {
+			char *fmt;
+			if (use_nsecs)
+				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
+				        "Min:%7ld Act:%8ld Avg:%8ld Max:%8ld";
+			else
+				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
+				        "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld";
+
+			dprintf(fd, fmt, index, stat->tid, par->prio,
+				par->interval, stat->cycles, stat->min,
+				stat->act, stat->cycles ?
+				(long)(stat->avg/stat->cycles) : 0, stat->max);
+
+			if (smi)
+				dprintf(fd," SMI:%8ld", stat->smi_count);
+
+			dprintf(fd, "\n");
+		}
+	} else {
+		while (stat->cycles != stat->cyclesread) {
+			unsigned long diff_smi;
+			long diff = stat->values
+			    [stat->cyclesread & par->bufmsk];
+
+			if (smi)
+				diff_smi = stat->smis
+				[stat->cyclesread & par->bufmsk];
+
+			if (diff > stat->redmax) {
+				stat->redmax = diff;
+				stat->cycleofmax = stat->cyclesread;
+			}
+			if (++stat->reduce == oscope_reduction) {
+				if (!smi)
+					dprintf(fd, "%8d:%8lu:%8ld\n", index,
+						stat->cycleofmax, stat->redmax);
+				else
+					dprintf(fd, "%8d:%8lu:%8ld%8ld\n",
+						index, stat->cycleofmax,
+						stat->redmax, diff_smi);
+
+				stat->reduce = 0;
+				stat->redmax = 0;
+			}
+			stat->cyclesread++;
+		}
+	}
+}
+
 
 /*
  * thread that creates a named fifo and hands out run stats when someone
@@ -1729,6 +1805,105 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts)
 	pthread_mutex_unlock(&trigger_lock);
 }
 
+/* Running status shared memory open */
+static int rstat_shm_open(void)
+{
+	int fd;
+
+	errno = 0;
+	fd = shm_unlink("/cyclictest_shm");
+
+	if ((fd == -1) && (errno != ENOENT)) {
+		fprintf(stderr, "ERROR: shm_unlink %s\n", strerror(errno));
+		return fd;
+	}
+
+	errno = 9;
+	fd = shm_open("/cyclictest_shm", O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
+	if (fd == -1) {
+		fprintf(stderr, "ERROR: shm_open %s\n", strerror(errno));
+	}
+
+	rstat_fd = fd;
+
+	return fd;
+}
+
+static int rstat_ftruncate(int fd)
+{
+	int err;
+
+	errno = 0;
+	err = ftruncate(fd, _SC_PAGE_SIZE);
+	if (err) {
+		fprintf(stderr, "ftruncate error %s\n", strerror(errno));
+	}
+
+	return err;
+}
+
+static void *rstat_mmap(int fd)
+{
+	void *mptr;
+
+	errno = 0;
+	mptr = mmap(0, _SC_PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	if (mptr == (void*)-1) {
+		fprintf(stderr, "ERROR: mmap, %s\n", strerror(errno));
+	}
+
+	return mptr;
+}
+
+static int rstat_mlock(void *mptr)
+{
+	int err;
+
+	err = mlock(mptr, _SC_PAGE_SIZE);
+
+	errno = 0;
+	if (err == -1) {
+		fprintf(stderr, "ERROR, mlock %s\n", strerror(errno));
+	}
+
+	return err;
+}
+
+static void rstat_setup(void)
+{
+	int res;
+	void *mptr = NULL;
+
+	int sfd = rstat_shm_open();
+	if (sfd < 0)
+		goto rstat_err;
+
+	res = rstat_ftruncate(sfd);
+	if (res)
+		goto rstat_err1;
+
+	mptr = rstat_mmap(sfd);
+	if (mptr == MAP_FAILED)
+		goto rstat_err1;
+
+	res = rstat_mlock(mptr);
+	if (res)
+		goto rstat_err2;
+
+	return;
+
+rstat_err2:
+	munmap(mptr, _SC_PAGE_SIZE);
+rstat_err1:
+	close(sfd);
+	shm_unlink("/cyclictest_shm");
+rstat_err:
+	rstat_fd = -1;
+	return;
+}
+
+
 int main(int argc, char **argv)
 {
 	sigset_t sigset;
@@ -1869,6 +2044,7 @@ int main(int argc, char **argv)
 
 	}
 
+
 	mode = use_nanosleep + use_system;
 
 	sigemptyset(&sigset);
@@ -1878,6 +2054,10 @@ int main(int argc, char **argv)
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
 	signal(SIGUSR1, sighand);
+	signal(SIGUSR2, sighand);
+
+	/* Set-up shm */
+	rstat_setup();
 
 	parameters = calloc(num_threads, sizeof(struct thread_param *));
 	if (!parameters)
@@ -2138,5 +2318,9 @@ int main(int argc, char **argv)
 	if (affinity_mask)
 		rt_bitmask_free(affinity_mask);
 
+	/* Remove running status shared memory file if it exists */
+	if (rstat_fd >= 0)
+		shm_unlink("/cyclictest_shm");
+
 	exit(ret);
 }
-- 
2.20.1

