Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618AF201004
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667888; cv=none; b=GHJFXjPP4Qd7rEsJtLVKc9XK+OrdIe/G/iRxoCLgddwMhDt77g3/N6pXEwBDXO/W8aLlJsn4ZksIDrYjR9fKr7p5/QXyyxYZQ0YK77VVdsPeXv6Envh73CIE+FoNqMsM63MkLsqhKJ2a8/Lk6sveJDY3ErkO4drrYoSY7nopm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667888; c=relaxed/simple;
	bh=0RPHcxA/N1QfBmjtlVJeCvq+1CvedEXB41KEdnsoKt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-type; b=TYIVX0io1t3mYdBzyNs6tISDq5IDuK1EkbnZiZwpMJkw58NiqKRLstaIxbyD5FWiisJMTBDn/f+R+8j+dsvnq283FSui5nxgnHWchlfX/IXP7WX2VOKvj7EjctpTqnZzuX6E5cXNwjiJyBukbMI0HDbXUKnQQPvA6Poz/g2a+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR2fAoMf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR2fAoMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB35C4CEF1;
	Fri, 17 Oct 2025 02:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667887;
	bh=0RPHcxA/N1QfBmjtlVJeCvq+1CvedEXB41KEdnsoKt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lR2fAoMf+y6qtaZbG5X13WsS/ACLhsbLWF/2iwtgA38ktHrtyOOLy+K2q/z4dJyJD
	 cz9lBIUckN0oxFxNuH8cLUbfn+pNIuLGYzgNfhqFaxlbzREVYAg8frwEPpc5uWmG6i
	 KBnsKCqXgd4K7gNa7eCPXVM312/mpWlxA7x7REjIRzfdO3jAzulYEg8tQQBlzh+G2G
	 yEuXWXe7bzeyJ+9rkeYgp2FALEO+QU4QZa1D0OOjPtHrwxAjAkX3Ed2FhOhift/bKa
	 bRB32sm9Ba8rERJhLmelT19Re59xAwoDdKXwRhDuYZ2eeB6hpHVA9/yEr8VRH8L5Ea
	 e4yto+EImQJug==
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Claude <noreply@anthropic.com>,
	Clark Williams <clrkwllms@kernel.org>,
	wander@redhat.com,
	debarbos@redhat.com,
	marco.chiappero@suse.com,
	chris.friesen@windriver.com,
	luochunsheng@ustc.edu
Subject: [PATCH 02/12] sched_debug: Fix runqueue task parsing logic and state filtering
Date: Thu, 16 Oct 2025 21:24:34 -0500
Message-ID: <20251017022444.118802-2-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017022444.118802-1-clrkwllms@kernel.org>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Clark Williams <williams@redhat.com>

Refactor parse_task_lines() to correctly parse runnable tasks from
sched_debug output with improved state filtering and iteration.

Key fixes:
- Rename skipwords() to skip2word() and fix logic to position pointer
  at the start of the target word (not after whitespace)
- Fix NEW_TASK_FORMAT detection to account for 'S' column offset in
  task field positions
- Add proper state filtering for NEW_TASK_FORMAT: skip '>R' (running),
  non-'R', and non-'X' states
- Fix loop termination: iterate to (nr_entries-1) since running task
  is excluded
- Fix buffer allocation size to include null terminator (+1)
- Add comprehensive comments explaining parsing state machine
- Initialize ptr=NULL to prevent uninitialized use warnings

This resolves task parsing failures where stalld was incorrectly
reading task fields or missing runnable tasks on newer kernels.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/sched_debug.c | 89 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 23 deletions(-)

diff --git a/src/sched_debug.c b/src/sched_debug.c
index 180932ca7aa3..04a12ef2a7c2 100644
--- a/src/sched_debug.c
+++ b/src/sched_debug.c
@@ -122,7 +122,8 @@ static char *alloc_and_fill_cpu_buffer(int cpu, char *sched_dbg, int sched_dbg_s
 	if (!next_cpu_start)
 		next_cpu_start = sched_dbg + sched_dbg_size;
 
-	size = next_cpu_start - cpu_start;
+	/* add one for the null terminator */
+	size = next_cpu_start - cpu_start + 1;
 
 	if (size <= 0)
 		return NULL;
@@ -171,12 +172,13 @@ static inline char *nextline(char *str)
  * skip a specified number of words on a task line
  */
 
-static inline char *skipwords(char *ptr, int nwords)
+static inline char *skip2word(char *ptr, int nwords)
 {
 	int i;
-	for (i=0; i < nwords; i++) {
-		ptr = skipspaces(ptr);
+	ptr = skipspaces(ptr);
+	for (i=1; i < nwords; i++) {
 		ptr = skipchars(ptr);
+		ptr = skipspaces(ptr);
 	}
 	return ptr;
 }
@@ -228,12 +230,14 @@ static int detect_task_format(void)
 	config_buffer_size = bufsiz;
 	log_msg("initial config_buffer_size set to %zu\n", config_buffer_size);
 
+	/* find the delimiter for task information */
 	ptr = strstr(buffer, TASK_MARKER);
 	if (ptr == NULL) {
 		die("unable to find 'runnable tasks' in buffer, invalid input\n");
 		exit(-1);
 	}
 
+	/* move to the column header line */
 	ptr = nextline(ptr);
 	i = 0;
 
@@ -245,6 +249,8 @@ static int detect_task_format(void)
 	if (strncmp(ptr, "S", strlen("S")) == 0) {
 		log_msg("detect_task_format: NEW_TASK_FORMAT detected\n");
 		retval = NEW_TASK_FORMAT;
+		/* move the word offset by one */
+		i++;
 	}
 	else {
 		log_msg("detect_task_format: OLD_TASK_FORMAT detected\n");
@@ -357,45 +363,81 @@ static int is_runnable(int pid)
 static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_entries)
 {
 	int pid, ctxsw, prio, comm_size;
-	char *ptr, *line, *end;
+	char *ptr=NULL, *line = buffer, *end;
+	char *buffer_end = buffer + strlen(buffer);
 	struct task_info *task;
 	char comm[COMM_SIZE];
 	int tasks = 0;
 
-	if ((ptr = strstr(buffer, TASK_MARKER)) == NULL)
-		die ("no runnable task section found!\n");
-
 	/*
 	 * If we have less than two tasks on the CPU there is no
 	 * possibility of a stall.
-	 */
+ 	 */
 	if (nr_entries < 2)
 		return 0;
+
+
+	/* search for the task marker header */
+	ptr = strstr(buffer, TASK_MARKER);
+	if (ptr == NULL)
+		die ("no runnable task section found!\n");
+
 	line = ptr;
 
-	/* skip header and divider */
+	/* skip "runnable tasks:" */
+ 	line = nextline(line);
+
+	/* skip header lines */
 	line = nextline(line);
+
+	/* skip divider line */
 	line = nextline(line);
-	
-	/* now loop over the task info */
-	while (tasks < nr_entries) {
+	/* at this point, line should point to the start of a task line */
+
+	/* now loop over the task info
+	 * note that we always discount the task that's on the cpu, so the
+	 * number of waiting tasks will always be at least one less than
+	 * nr_entries.
+	 */
+	while ((line < buffer_end) && tasks < (nr_entries-1)) {
 		task = &task_info[tasks];
 
+		/* move ptr to the first word of the line */
+		ptr = skipspaces(line);
+
 		/*
 		 * In 3.X kernels, only the singular RUNNING task receives
 		 * a "running state" label. Therefore, only care about
-		 * tasks that are not R (running on a CPU).
+		 * tasks that are not R (runnable on a CPU).
 		 */
 		if ((config_task_format == OLD_TASK_FORMAT) &&
 			(*ptr == 'R')) {
 			/* Go to the end of the line and ignore this task. */
-			ptr = strchr(ptr, '\n');
-			ptr++;
+			line = nextline(line);
 			continue;
 		}
 
+		/*
+		 * in newer kernels (>=4.x) every task info line has a state
+		 * but the actual running tasks has a '>R' to denote it.
+		 * since we don't care about the currently running tasks
+		 * skip it.
+		 * Also, we don't care about any states other than 'R' (runnable)
+		 * and 'X' (dying)
+		 */
+		if (config_task_format == NEW_TASK_FORMAT) {
+			if (*ptr == '>' || (*ptr != 'R' && *ptr != 'X')) {
+				line = nextline(line);
+				continue;
+			}
+		}
+
+		/*
+		 * At this point we have a task line to record
+		 */
+		
 		/* get the task field */
-		ptr = skipwords(line, config_task_format_offsets.task);
+		ptr = skip2word(line, config_task_format_offsets.task);
 
 		/* Find the end of the task field */
 		end = skipchars(ptr);
@@ -408,20 +450,21 @@ static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_en
 		}
 		strncpy(comm, ptr, comm_size);
 		comm[comm_size] = '\0';
-		ptr = end;
 
 		/* get the PID field */
-		ptr = skipwords(line, config_task_format_offsets.pid);
+		ptr = skip2word(line, config_task_format_offsets.pid);
 		pid = strtol(ptr, NULL, 10);
 
 		/* get the context switches field */
-		ptr = skipwords(line, config_task_format_offsets.switches);
+		ptr = skip2word(line, config_task_format_offsets.switches);
 		ctxsw = strtol(ptr, NULL, 10);
 
 		/* get the prio field */
-		ptr = skipwords(line, config_task_format_offsets.prio);
+		ptr = skip2word(line, config_task_format_offsets.prio);
 		prio = strtol(ptr, NULL, 10);
 
+		/*log_msg("DEBUG: task%d comm:%s pid:%d ctxsw:%d prio:%d\n", tasks, comm, pid, ctxsw, prio);*/
+
                 /*
                  * In older formats, we must check to
                  * see if the process is runnable prior to storing header
@@ -437,10 +480,10 @@ static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_en
 			task->since = time(NULL);
 			/* increment the count of tasks processed */
 			tasks++;
-		} else {
-			continue;
 		}
 
+		/* move our line pointer to the next availble line */
+		line = nextline(line);
 	}
 	return tasks;
 }
-- 
2.51.0

