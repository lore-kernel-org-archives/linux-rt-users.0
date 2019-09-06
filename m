Return-Path: <SRS0=NMSW=XB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACEEC00307
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Sep 2019 19:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ADD2070C
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Sep 2019 19:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2NNJJIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfIFTtK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:49:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41389 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfIFTtK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Sep 2019 15:49:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id o11so6844590qkg.8
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Sep 2019 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mj6Idgqj9LXqrC0cCrItrKDET6WlvCBOxiteUZ9Vioo=;
        b=i2NNJJItDAr3jYtO7nRzYG/s7UaQe2CXcT5NzV4/g1fG7deP//6x9vrYgfpys0JExs
         ZOC4/djOxggDYcYxfEkjv+iq3FHgbV8CAU38KuL/GK5Bu163I9UbCUaObOUlTnqXPLDL
         FreNXKWhjq/LQFMfXzMpuo6Llbzkv/u5WkSgO46LPZ4gOP0g6eERdTfvzBCRVCOGfjRv
         +G7F5/FqHmYtZQhhs3t11tf1J4w25XJnwDSx8yNW72diqzLyt85gFOcgpQxUYImu7BMv
         QGB0GqLq0gEtodbW0MstpDsNjfJgKddobi8ImaWivS1CPqUqSY4M6JyomDEJWtdJcATd
         ynWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Mj6Idgqj9LXqrC0cCrItrKDET6WlvCBOxiteUZ9Vioo=;
        b=nXx2TPibORqumgclHe/W3KsF637mR8MGfSsgAbE4lQjqpEIxtgB2K0QBC/3dYm9lKZ
         8EpQyq1V6HkIqJwA/BqDkPS0nf9Atbtu97+nybEQZ4sYy2xpDArVCoiW3yXVs/ReVaOs
         Bnh9Xqcbsg0bjEHKwt3j2CWeIvirMN59rz/qaVR6ssnI7p0fkzbqoVgEWcni6ocrukD0
         zS57cDDoqV7zA4k5T4A0Xv5Ug2vKMxLjBF1t9igkUZj+18O4BuQCbnxBj9dN+v+DaCu0
         FImzDpjCQHtwY8NKNbPZIiAdwaSE+smWwwJaHdS8BPTWVLQKz6bnS1f2lhJu/gaxTNXk
         lNfQ==
X-Gm-Message-State: APjAAAXHXqXcCerbLWC9ItFKHt/b/dxSszvdFDjQp79npWh/acTqHi37
        RyB/2hHRpYl6jIYR8vafdAKVVrHT
X-Google-Smtp-Source: APXvYqxswzHYF1ABb0CK7Mv8IyoqLzD+UY+Zl0WpGzx+a5s589SoBfkRj8rYAZM3aEXi+UWFm+pMpw==
X-Received: by 2002:a37:e40f:: with SMTP id y15mr10437141qkf.233.1567799349313;
        Fri, 06 Sep 2019 12:49:09 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id c64sm2985135qkb.21.2019.09.06.12.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 12:49:08 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rt-tests: cyclictest: RFC - Get a snapshot of cyclictest without interuppting it
Date:   Fri,  6 Sep 2019 21:48:59 +0200
Message-Id: <20190906194859.24316-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906194859.24316-1-jkacur@redhat.com>
References: <20190906194859.24316-1-jkacur@redhat.com>
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

I haven't cleaned this up yet, but I thought it was kind of neat, so I
wanted to share it with you a little before it is ready for prime time.

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
 src/cyclictest/cyclictest.c | 141 ++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 52f93da7d074..4d3fc25347b0 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -230,10 +230,13 @@ static struct thread_param **parameters;
 static struct thread_stat **statistics;
 
 static void print_stat(FILE *fp, struct thread_param *par, int index, int verbose, int quiet);
+static void rstat_print_stat(struct thread_param *par, int index, int verbose, int quiet);
 
 static int latency_target_fd = -1;
 static int32_t latency_target_value = 0;
 
+static int rstat_fd = -1;
+
 /* Latency trick
  * if the file /dev/cpu_dma_latency exists,
  * open it and write a zero into it. This will tell
@@ -1461,6 +1464,22 @@ static void sighand(int sig)
 		fprintf(stderr, "#---------------------------\n");
 		quiet = oldquiet;
 		return;
+	} else if (sig == SIGUSR2) {
+		int i;
+		int oldquiet = quiet;
+
+		quiet = 0;
+		if (rstat_fd == -1) {
+			fprintf(stderr, "ERROR: rstat_fd not valid\n");
+			return;
+		}
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
@@ -1628,6 +1647,62 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
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
@@ -1715,6 +1790,63 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts)
 	pthread_mutex_unlock(&trigger_lock);
 }
 
+/* Running status shared memory open */
+static int rstat_shm_open(void)
+{
+	int fd;
+	shm_unlink("/cyclictest_shm");
+
+	errno = 0;
+	fd = shm_open("/cyclictest_shm", O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
+
+	if (fd == -1) {
+		fprintf(stderr, "ERROR: shmopen %s\n", strerror(errno));
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
+static void rstat_mlock(void *mptr)
+{
+	int err;
+
+	err = mlock(mptr, _SC_PAGE_SIZE);
+
+	errno = 0;
+	if (err == -1) {
+		fprintf(stderr, "ERROR, mlock %s\n", strerror(errno));
+	}
+}
+
 int main(int argc, char **argv)
 {
 	sigset_t sigset;
@@ -1855,6 +1987,7 @@ int main(int argc, char **argv)
 
 	}
 
+
 	mode = use_nanosleep + use_system;
 
 	sigemptyset(&sigset);
@@ -1864,6 +1997,14 @@ int main(int argc, char **argv)
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
 	signal(SIGUSR1, sighand);
+	signal(SIGUSR2, sighand);
+
+	/* Set-up shm */
+	int sfd = rstat_shm_open();
+	void *mptr;
+	rstat_ftruncate(sfd);
+	mptr = rstat_mmap(sfd);
+	rstat_mlock(mptr);
 
 	parameters = calloc(num_threads, sizeof(struct thread_param *));
 	if (!parameters)
-- 
2.20.1

