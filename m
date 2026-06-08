Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCEB3E0230
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943660; cv=none; b=j1wN2YliH8gDfPF5X9/gtb4vALUwZEY9bg8QwpcpCuvt1PPb+SBa+mVhWDLgUSANwUzT8Fc0wxB7UYks1Bioe+rqCg7WSfwj8OaSqhg+4HHBVFcNnY7FcCblkJ4isSOpnaPillp6o5ct4hyxDJeEtzghnGcU+qvTa10+81RwBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943660; c=relaxed/simple;
	bh=S0j0QXVd1EJZjADdgNRqd0148a2iEZMXk0MmZdQbyNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQFDBLmNNgK/5JSjiM9OG7ZY0kZjUq4vhaTFam4fU6qdLCtTODqWLh5fyR5M3zbdktcbkYs5mK3f7uwumzfjJZiv3FwL0Dp7ku34sBRefgFt2UGZYmjIFbZek8VXRZ7Ck+/J6D1ZBFw5e6hwqoPao/FgLn5u9Bgs/tui+xwAw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ij6fq9wg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ij6fq9wg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOYSAOW2w4iVzgbl05fSV3nu2w4VJwd1KIxwhRNMrzE=;
	b=ij6fq9wgTyqFhhSlmMDduCDZiOKAwA5O/HgPeW3cFE8ofSeW+j2QfjGHdv0eR/Ln02Cn/j
	YeZMWv1w2Krm65GW8iThpa2it6lHF3+gAKOojTWTL5ljsisOMfe9iGe1uPPZLm+Ear7y+I
	7liVJKVRUSvZ9srHntWt3opfWyqdx8Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-9ADydUA-NImzZAGxjIHQbw-1; Mon,
 08 Jun 2026 14:34:14 -0400
X-MC-Unique: 9ADydUA-NImzZAGxjIHQbw-1
X-Mimecast-MFC-AGG-ID: 9ADydUA-NImzZAGxjIHQbw_1780943653
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7036195DE3D;
	Mon,  8 Jun 2026 18:34:13 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7B0C36927;
	Mon,  8 Jun 2026 18:34:11 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 44/52] stalld: use CLOCK_MONOTONIC for starvation detection
Date: Mon,  8 Jun 2026 15:31:54 -0300
Message-ID: <20260608183206.140526-45-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Starvation detection relies on time(NULL) to track how long tasks
have been waiting. Wall-clock time is subject to NTP adjustments, so
a backward clock step can make elapsed durations appear negative and
prevent the daemon from ever boosting legitimately starving tasks.

Replace all time(NULL) calls with a get_monotonic_time() helper that
reads CLOCK_MONOTONIC via clock_gettime(). Monotonic time only moves
forward, making starvation tracking immune to external clock changes.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/queue_track.c |  2 +-
 src/sched_debug.c |  2 +-
 src/stalld.c      | 16 ++++++++--------
 src/stalld.h      |  8 ++++++++
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/src/queue_track.c b/src/queue_track.c
index 6089277..2c1a11b 100644
--- a/src/queue_track.c
+++ b/src/queue_track.c
@@ -195,7 +195,7 @@ static int queue_track_parse(struct cpu_info *cpu_info, char *buffer, size_t buf
 
 		task->ctxsw = qtask.ctxswc;
 
-		task->since = time(NULL);
+		task->since = get_monotonic_time();
 
 		nr_running++;
 
diff --git a/src/sched_debug.c b/src/sched_debug.c
index 5e9a9e8..25a11ce 100644
--- a/src/sched_debug.c
+++ b/src/sched_debug.c
@@ -478,7 +478,7 @@ static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_en
 			task->tgid = get_tgid(task->pid);
 			task->ctxsw = ctxsw;
 			task->prio = prio;
-			task->since = time(NULL);
+			task->since = get_monotonic_time();
 			/* increment the count of tasks processed */
 			tasks++;
 		}
diff --git a/src/stalld.c b/src/stalld.c
index a9e98ff..1762033 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -326,7 +326,7 @@ void print_waiting_tasks(struct cpu_info *cpu_info)
 	if (!config_verbose)
 		return;
 
-	now = time(NULL);
+	now = get_monotonic_time();
 	printf("CPU %d has %d waiting tasks\n", cpu_info->id, cpu_info->nr_waiting_tasks);
 	if (!cpu_info->nr_waiting_tasks)
 		return;
@@ -646,12 +646,12 @@ int check_starving_tasks(struct cpu_info *cpu)
 		task = &tasks[i];
 
 		/* Skip tasks that haven't been starving long enough */
-		if ((time(NULL) - task->since) < config_starving_threshold)
+		if ((get_monotonic_time() - task->since) < config_starving_threshold)
 			continue;
 
 		log_msg("%s-%d starved on CPU %d for %d seconds\n",
 			task->comm, task->pid, cpu->id,
-			(time(NULL) - task->since));
+			(get_monotonic_time() - task->since));
 
 		/*
 		 * Check if this task needs to be ignored from being boosted
@@ -659,7 +659,7 @@ int check_starving_tasks(struct cpu_info *cpu)
 		 * getting reported as being starved.
 		 */
 		if (config_ignore && !(check_task_ignore(task))) {
-			task->since = time(NULL);
+			task->since = get_monotonic_time();
 			continue;
 		}
 
@@ -670,7 +670,7 @@ int check_starving_tasks(struct cpu_info *cpu)
 		 * after logging.
 		 */
 		if (config_log_only) {
-			task->since = time(NULL);
+			task->since = get_monotonic_time();
 			continue;
 		}
 
@@ -693,11 +693,11 @@ int check_might_starve_tasks(struct cpu_info *cpu)
 	for (i = 0; i < cpu->nr_waiting_tasks; i++) {
 		task = &tasks[i];
 
-		if ((time(NULL) - task->since) >= config_starving_threshold/2) {
+		if ((get_monotonic_time() - task->since) >= config_starving_threshold/2) {
 
 			log_msg("%s-%d might starve on CPU %d (waiting for %d seconds)\n",
 				task->comm, task->pid, cpu->id,
-				(time(NULL) - task->since));
+				(get_monotonic_time() - task->since));
 
 			starving = 1;
 		}
@@ -933,7 +933,7 @@ int boost_cpu_starving_vector(struct cpu_starving_task_info *vector, int nr_cpus
 	int ret;
 	int i;
 
-	now = time(NULL);
+	now = get_monotonic_time();
 
 	/* Boost phase. */
 	for (i = 0; i < nr_cpus; i++) {
diff --git a/src/stalld.h b/src/stalld.h
index 8b6ab8b..2df6f94 100644
--- a/src/stalld.h
+++ b/src/stalld.h
@@ -13,6 +13,7 @@
 #include <sched.h>
 #include <stdatomic.h>
 #include <signal.h>
+#include <time.h>
 
 #define BUFFER_PAGES		10
 #define MAX_WAITING_PIDS	30
@@ -49,6 +50,13 @@
  */
 #define DAEMON_UMASK  0022
 
+static inline time_t get_monotonic_time(void)
+{
+	struct timespec ts;
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec;
+}
+
 /*
  * Informnation about running tasks on a CPU.
  */
-- 
2.54.0

