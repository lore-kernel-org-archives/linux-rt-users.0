Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3qgThFD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8C1BD
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Dec 2023 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701896111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fclv/ZuHtOJoo+bMezgxLqoIVU0EVLzB+sIfersxKu0=;
	b=G3qgThFDDCRHO9Uos64HoMsjKMXIsaWc898IDULunRRfbN0r/E3oL7OX+X9hoL5J+WWGmE
	GXpVlrYIKo+oKRFp9dicRjGtSXxbnJOYANzlprOis9WyWRqCOAktmbvSPLeGYLjppXwqi/
	8W7l1moefYQ+a/vGDNDCZJ408jGrQqo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-55O6dvWpObG3sFAfAquYsg-1; Wed, 06 Dec 2023 15:55:10 -0500
X-MC-Unique: 55O6dvWpObG3sFAfAquYsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC6FF848539
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Dec 2023 20:55:09 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.17.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A9B032026D66;
	Wed,  6 Dec 2023 20:55:09 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 1/4] rt-tests: Fix warnings
Date: Wed,  6 Dec 2023 14:55:05 -0600
Message-ID: <20231206205508.17148-2-crwood@redhat.com>
In-Reply-To: <20231206205508.17148-1-crwood@redhat.com>
References: <20231206205508.17148-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Numerous places threw sign comparison warnings; we could fix them but
it's kind of an obnoxious warning that requires casts to deal with things
such as ARRAY_SIZE() while still being able to check for the user
entering a negative number.

-Wunused-parameter is another obnoxious warning as it flags perfectly
reasonable code that takes unneeded parameters in order to comply with
a function pointer interface or similar; however, all of the instances
that were flagged here were actual dead parameters, so just fix them.

Add volatile to timer_started in hackbench so that it doesn't get
clobbered by longjmp().

Signed-off-by: Crystal Wood <crwood@redhat.com>
--
Let me know if you'd rather I fix the sign warnings.
---
 Makefile                            |  2 +-
 src/hackbench/hackbench.c           |  2 +-
 src/sched_deadline/cyclicdeadline.c |  6 +++---
 src/sched_deadline/deadline_test.c  | 10 +++++-----
 src/sigwaittest/sigwaittest.c       |  6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 2808c212058a..ad481a73cf93 100644
--- a/Makefile
+++ b/Makefile
@@ -31,7 +31,7 @@ prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 
-CFLAGS ?= -Wall -Wno-nonnull -Wextra
+CFLAGS ?= -Wall -Wno-nonnull -Wextra -Wno-sign-compare
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=
 
diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 69dd5f087fb6..4430db0e4ed6 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -494,7 +494,7 @@ int main(int argc, char *argv[])
 	struct timeval start, stop, diff;
 	int readyfds[2], wakefds[2];
 	char dummy;
-	int timer_started = 0;
+	volatile int timer_started = 0;
 	struct sched_param sp;
 
 	process_options (argc, argv);
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 9bdc4b5deaf1..097e2e5d4580 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -750,7 +750,7 @@ static void print_stat(FILE *fp, struct sched_data *sd, int index, int verbose,
 	}
 }
 
-static u64 do_runtime(long tid, struct sched_data *sd, u64 period)
+static u64 do_runtime(struct sched_data *sd, u64 period)
 {
 	struct thread_stat *stat = &sd->stat;
 	u64 next_period = period + sd->deadline_us;
@@ -833,7 +833,7 @@ void *run_deadline(void *data)
 	period = get_time_us();
 
 	while (!shutdown) {
-		period = do_runtime(tid, sd, period);
+		period = do_runtime(sd, period);
 		if (tracelimit && (stat->max > tracelimit)) {
 			shutdown++;
 			pthread_mutex_lock(&break_thread_id_lock);
@@ -1266,7 +1266,7 @@ int main(int argc, char **argv)
 
 		/* Make sure that we can make our deadlines */
 		start_period = get_time_us();
-		do_runtime(gettid(), sd, start_period);
+		do_runtime(sd, start_period);
 		end_period = get_time_us();
 		if (end_period - start_period > sd->runtime_us)
 			fatal("Failed to perform task within runtime: Missed by %lld us\n",
diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index cd8ef01f7d68..ca2da476ec95 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -1181,7 +1181,7 @@ static int read_ctx_switches(int *vol, int *nonvol, int *migrate)
  *  @data->total_time - Total time it took to complete all loops
  *  @data->nr_periods - Number of periods that were executed.
  */
-static u64 do_runtime(long tid, struct sched_data *data, u64 period)
+static u64 do_runtime(struct sched_data *data, u64 period)
 {
 	u64 next_period = period + data->deadline_us;
 	u64 now = get_time_us();
@@ -1354,7 +1354,7 @@ void *run_deadline(void *data)
 	period = get_time_us();
 
 	while (!done) {
-		period = do_runtime(tid, sched_data, period);
+		period = do_runtime(sched_data, period);
 		sched_yield();
 	}
 	ret = sched_getattr(0, &attr, sizeof(attr), 0);
@@ -1714,7 +1714,7 @@ static u64 calculate_loops_per_ms(u64 *overhead)
 	do_sleep(1000);
 
 	start = get_time_us();
-	do_runtime(0, &sd, start + sd.deadline_us);
+	do_runtime(&sd, start + sd.deadline_us);
 	end = get_time_us();
 
 	diff = end - start;
@@ -1743,7 +1743,7 @@ static u64 calculate_loops_per_ms(u64 *overhead)
 	do_sleep(1000);
 
 	start = get_time_us();
-	do_runtime(0, &sd, start + sd.deadline_us);
+	do_runtime(&sd, start + sd.deadline_us);
 	end = get_time_us();
 
 	odiff = end - start;
@@ -1962,7 +1962,7 @@ int main(int argc, char **argv)
 
 		/* Make sure that we can make our deadlines */
 		start_period = get_time_us();
-		do_runtime(gettid(), sd, start_period);
+		do_runtime(sd, start_period);
 		end_period = get_time_us();
 		if (end_period - start_period > sd->runtime_us) {
 			printf("Failed to perform task within runtime: Missed by %lld us\n",
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 55855769c63b..8c1c16fb3081 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -375,7 +375,7 @@ static void sighand(int sig __attribute__ ((unused)))
 	mustshutdown = 1;
 }
 
-static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
+static void print_stat(struct params *receiver, struct params *sender,
 		       int verbose __attribute__ ((unused)), int quiet)
 {
 	int i;
@@ -644,7 +644,7 @@ int main(int argc, char *argv[])
 			    sender[i].shutdown;
 
 		if (receiver[0].samples > oldsamples || mustshutdown) {
-			print_stat(stdout, receiver, sender, 0, quiet);
+			print_stat(receiver, sender, 0, quiet);
 			if (!quiet)
 				printf("\033[%dA", num_threads*2);
 		}
@@ -664,7 +664,7 @@ int main(int argc, char *argv[])
 	if (!quiet)
 		printf("\033[%dB", num_threads*2 + 2);
 	else
-		print_stat(stdout, receiver, sender, 0, 0);
+		print_stat(receiver, sender, 0, 0);
 
 	for (i = 0; i < num_threads; i++) {
 		receiver[i].shutdown = 1;
-- 
2.43.0

