Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863A3E716D
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285769; cv=none; b=MbCJH2ps0LE1+gwcdf0Qi93jGK3LO4LNJOovKIl/r5elbANW9f1AO1frm73+3qvODPLrQwA7XVRZ0rSTIug9VN8vVkrRbrNNhdcRMEYZ6NXGtpNcTKKKIwHo9tq8FtYgLA70yb2GOossvsy6EMDuN0MGm7m4ABVzDFJVq9ru5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285769; c=relaxed/simple;
	bh=eMgJe0DBfOWoBM6UR44ONhewiANdnHi+D92QUmu2K8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvKuRvKlxVzE/P02zMFtACTfvMLvMFKJluMtFtkci2BKzsKMEo3MX/teawMbIjSjV7igSlrdRSkJnG/7uU1rbcHxzTBiH94xh6Pr2pWqr9ul9S41I/Ox5ntyL6EHiQ5WsSiphhUKttABRDGJT3vgWJvpqu249YpXTDjtVPs/9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIfkq194; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIfkq194"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5v9qmHAJnMq+aeNvOXAUu8OzzqCG4zDvWDath38Ex5Q=;
	b=FIfkq194KQhLOgLQdCHNMXz4oUFfLCvDsTzPfOiK/+9dn15AHUjhd5/nhCzdiKa/Flr4LN
	EV5/E+ujkfWo+MmaySD8xp6mcrrUlfxt23/GBhaN0immRHOdDStpP/LvZuMpK3ORqdGrxf
	rTLrBVVNS7E3ANy2FKmZDakvxV7TlUQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-Ma35GUgFPue8YKZrHEVpsg-1; Wed,
 20 May 2026 10:02:43 -0400
X-MC-Unique: Ma35GUgFPue8YKZrHEVpsg-1
X-Mimecast-MFC-AGG-ID: Ma35GUgFPue8YKZrHEVpsg_1779285762
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B25219560BF;
	Wed, 20 May 2026 14:02:42 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02DAB1800465;
	Wed, 20 May 2026 14:02:39 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 33/33] bpf: Replace linear task scan with hash map
Date: Wed, 20 May 2026 11:01:00 -0300
Message-ID: <20260520140104.112142-34-wander@redhat.com>
In-Reply-To: <20260520140104.112142-1-wander@redhat.com>
References: <20260520140104.112142-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The BPF queue_track backend previously utilized an O(2048) linear array
scan within find_queued_task() on every sched_wakeup event. This design
introduced a ~2us latency penalty, which is highly problematic for Telco
workloads where it consumed 20% of the stringent 10us real-time latency
budget.

Resolve this bottleneck by replacing the per-CPU array with a new BPF
hash map, stalld_task_map, keyed by a composite of CPU and PID to
enable O(1) task lookups. Consequently, the stalld_cpu_data structure
shrinks from approximately 65KB down to 12 bytes. The enqueue_task,
dequeue_task, and update_or_add_task routines are rewritten to utilize
standard BPF map helpers. In userspace, queue_track.c now iterates
through the hash map using bpf_map_get_next_key while applying CPU
filtering.

Initialize the legacy pointer in task_running() to avoid use of
uninitialized variable.

Verification on a real-time system confirms that thread latency dropped
from 5-6us down to 3us. This improvement completely eliminates the
overhead, returning performance to the baseline established when stalld
is not running.

Assisted-by: Claude Code:claude-opus-4-6 [PAL]
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 bpf/stalld.bpf.c  | 206 ++++++++++++++++------------------------------
 src/queue_track.c |  95 +++++++++++----------
 src/queue_track.h | 107 ++----------------------
 3 files changed, 131 insertions(+), 277 deletions(-)

diff --git a/bpf/stalld.bpf.c b/bpf/stalld.bpf.c
index bf55f5b..4df9211 100644
--- a/bpf/stalld.bpf.c
+++ b/bpf/stalld.bpf.c
@@ -33,6 +33,14 @@ struct {
 	__type(value, struct stalld_cpu_data);
 } stalld_per_cpu_data SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	/* resized at load time to MAX_QUEUE_TASK * nr_cpus */
+	__uint(max_entries, MAX_QUEUE_TASK);
+	__type(key, struct task_map_key);
+	__type(value, struct queued_task);
+} stalld_task_map SEC(".maps");
+
 #if DEBUG_STALLD
 #define log(msg, ...) bpf_printk("%s: " msg, __func__, ##__VA_ARGS__)
 #else
@@ -82,15 +90,6 @@ struct task_struct___legacy {
  * task_is_rt - Check if a task is a real-time task.
  * @p: A pointer to the kernel's `task_struct` for the task.
  *
- * This function determines if a task belongs to a real-time (RT) scheduling
- * class based on its priority. In the Linux kernel, static priorities from
- * 0 to 99 are reserved for RT tasks (SCHED_FIFO and SCHED_RR), while
- * priorities from 100 to 139 are used for normal tasks (SCHED_NORMAL,
- * SCHED_BATCH, etc.).
- *
- * This check is essential for `stalld` to distinguish between high-priority
- * RT tasks that have strict scheduling deadlines and normal tasks.
- *
  * Return: `true` if the task has a real-time priority (0-99),
  *         `false` otherwise.
  */
@@ -103,13 +102,6 @@ static inline bool task_is_rt(const struct task_struct *p)
  * task_cpu - Get the CPU number that a task is currently running on.
  * @p: A pointer to the kernel's `task_struct` for the task.
  *
- * This function retrieves the CPU identifier where the task is currently
- * scheduled.
- *
- * The CPU number is crucial for `stalld` to associate a task with the
- * correct per-CPU data map, ensuring that task tracking and starvation
- * analysis are performed in the right context.
- *
  * Return: The integer ID of the CPU the task is running on.
  */
 static inline int task_cpu(const struct task_struct *p)
@@ -126,23 +118,6 @@ static inline int task_cpu(const struct task_struct *p)
  * compute_ctxswc - Compute the total context switch count for a task.
  * @p: A pointer to the `task_struct` (process descriptor) of the task.
  *
- * This function calculates the total number of context switches a task
- * has undergone by summing its voluntary and involuntary context switch
- * counts.
- *
- * The `nvcsw` (number of voluntary context switches) increments when a task
- * explicitly yields the CPU (e.g., waiting for I/O, sleeping, or blocking
- * on a lock).
- *
- * The `nivcsw` (number of involuntary context switches) increments when a task
- * is preempted by the scheduler (e.g., its timeslice expires, or a higher
- * priority task becomes runnable).
- *
- * The sum of these two counters provides a comprehensive measure of how many
- * times the task has been context-switched in and out of the CPU. This value
- * is crucial for tools like `stalld` to detect if a task has made progress
- * (i.e., has run at least once) since a previous observation.
- *
  * Return: The total context switch count (nvcsw + nivcsw) for the given task.
  */
 static inline long compute_ctxswc(const struct task_struct *p)
@@ -152,7 +127,8 @@ static inline long compute_ctxswc(const struct task_struct *p)
 
 static inline unsigned int task_running(const struct task_struct *p)
 {
-	const struct task_struct___legacy *lp;
+	const struct task_struct___legacy *lp = (const void *) p;
+
 	const unsigned int state = bpf_core_field_exists(p->__state)
 					? BPF_CORE_READ(p, __state)
 					: BPF_CORE_READ(lp, state);
@@ -178,52 +154,52 @@ static struct stalld_cpu_data *get_cpu_data(int cpu)
 	return NULL;
 }
 
-static int enqueue_task(const struct task_struct *p, struct stalld_cpu_data *cpu_data)
+static int enqueue_task(const struct task_struct *p, int cpu)
 {
-	struct queued_task *task;
-	const long pid = p->pid;
-
-	for_each_task_entry(cpu_data, task) {
-		if (task->pid == 0 || task->pid == pid) {
-			task->ctxswc = compute_ctxswc(p);
-			task->prio = p->prio;
-			task->is_rt = task_is_rt(p);
-			task->tgid = p->tgid;
-
-			/*
-			 * User reads pid to know that there is no data here.
-			 * Update it last.
-			 */
-			barrier();
-			task->pid = pid;
-			log_task(p);
-			return 0;
-		}
-	}
+	struct task_map_key key;
+	struct queued_task task;
 
-	log_task_error(p);
+	/*
+	 * pid 0 (idle/swapper) must not enter the hash map: userspace
+	 * uses pid 0 as "no task" in cpu_starving_vector, so a real
+	 * entry with pid 0 would be silently skipped.
+	 */
+	if (!p->pid)
+		return 0;
+
+	key.cpu = cpu;
+	key.pid = p->pid;
 
+	task.pid = p->pid;
+	task.tgid = p->tgid;
+	task.is_rt = task_is_rt(p);
+	task.prio = p->prio;
+	task.ctxswc = compute_ctxswc(p);
+
+	if (bpf_map_update_elem(&stalld_task_map, &key, &task, BPF_ANY) < 0) {
+		log_task_error(p);
+		return -1;
+	}
+
+	log_task(p);
 	return 0;
 }
 
 /**
  * dequeue_task - Removes a task from a CPU's queue.
- * @p:        Pointer to the task_struct of the task to remove.
- * @cpu_data: Pointer to the per-CPU data structure.
- *
- * This function finds and removes a task from the specified CPU's run queue.
- * It updates the appropriate counter (RT or non-RT) for the queued tasks.
+ * @p:   Pointer to the task_struct of the task to remove.
+ * @cpu: The CPU number to dequeue from.
  *
  * Return: 1 if the task was found and removed, 0 otherwise.
  */
-static int dequeue_task(const struct task_struct *p, struct stalld_cpu_data *cpu_data)
+static int dequeue_task(const struct task_struct *p, int cpu)
 {
-	struct queued_task *task;
-	long pid = p->pid;
+	struct task_map_key key;
 
-	task = find_queued_task(cpu_data, pid);
-	if (task) {
-		task->pid = 0;
+	key.cpu = cpu;
+	key.pid = p->pid;
+
+	if (bpf_map_delete_elem(&stalld_task_map, &key) == 0) {
 		log_task(p);
 		return 1;
 	}
@@ -233,85 +209,55 @@ static int dequeue_task(const struct task_struct *p, struct stalld_cpu_data *cpu
 }
 
 /*
- * update_or_add_task - Manages a task's lifecycle within a per-CPU tracking queue.
- *
- * This function handles the logic for managing individual task entries within
- * stalld's BPF program. It dynamically adds, updates, or removes a task from a
- * specific CPU's tracking array based on its current state. This ensures the
- * array provides an accurate, real-time view of tasks on the run queue.
- *
- * The function's logic is organized into three primary scenarios:
- * 1.  Update: If a task is already tracked and is still in the TASK_RUNNING
- * state, its dynamic properties (context switch count, priority) are
- * refreshed.
- * 2.  Remove: If a tracked task is no longer in the TASK_RUNNING state
- * (e.g., it has gone to sleep or terminated), it is removed from the queue
- * by invalidating its entry (setting pid to 0).
- * 3.  Add: If a new, previously unseen task is encountered and is in the
- * TASK_RUNNING state, it is added to the first available empty slot in
- * the queue.
+ * update_or_add_task - Manages a task's lifecycle within the hash map.
  *
- * Parameters:
- * cpu_data: A pointer to the `stalld_cpu_data` structure for the target CPU.
- * p:        A pointer to the kernel's `task_struct` for the task to be processed.
+ * Three scenarios:
+ * 1. Update: task exists and is TASK_RUNNING -> refresh fields in-place.
+ * 2. Remove: task exists but not TASK_RUNNING -> delete from map.
+ * 3. Add:    task not found and is TASK_RUNNING -> insert into map.
  */
-static void update_or_add_task(struct stalld_cpu_data *cpu_data,
-			       const struct task_struct *p)
+static void update_or_add_task(const struct task_struct *p, int cpu)
 {
+	struct task_map_key key;
 	struct queued_task *task_entry;
 
-	/* Try to find the task first */
-	task_entry = find_queued_task(cpu_data, p->pid);
+	key.cpu = cpu;
+	key.pid = p->pid;
+
+	task_entry = bpf_map_lookup_elem(&stalld_task_map, &key);
 	if (task_entry) {
 		if (task_running(p)) {
-			/* Task found: Update its dynamic fields */
 			task_entry->ctxswc = compute_ctxswc(p);
 			task_entry->prio = p->prio;
 			task_entry->is_rt = task_is_rt(p);
 		} else {
-			/* Task is not running. Remove it. */
 			log_task_prefix("dequeue ", p);
-			task_entry->pid = 0;
+			bpf_map_delete_elem(&stalld_task_map, &key);
 		}
 
 		return;
 	}
 
-	/*
-	 * If we reach here, the task was NOT found, so it's new.
-	 * Check if the new task is in the `TASK_RUNNING` state before adding to queue.
-	 */
 	if (!task_running(p))
 		return;
 
-	/*
-	 * Task not found and is running: find an empty slot to add it
-	 * We iterate through all slots to find the first empty one.
-	 */
-	enqueue_task(p, cpu_data);
+	enqueue_task(p, cpu);
 }
 
 /**
  * __sched_wakeup - Common handler for task wakeup tracepoints.
  * @ctx: A pointer to the tracepoint context.
  *
- * This function serves as the common implementation for handling both
- * `sched_wakeup` and `sched_wakeup_new` tracepoints. It extracts the
- * task_struct from the context, determines its target CPU, and if that
- * CPU is being monitored, enqueues the task for tracking.
- *
- * This centralized approach avoids code duplication and provides a
- * single point of logic for task wakeup events.
- *
  * Return: Always returns 0.
  */
 static int __sched_wakeup(u64 *ctx)
 {
 	const struct task_struct *p = (void *) ctx[0];
-	struct stalld_cpu_data *cpu_data = get_cpu_data(task_cpu(p));
+	int cpu = task_cpu(p);
+	struct stalld_cpu_data *cpu_data = get_cpu_data(cpu);
 
 	if (cpu_data)
-		update_or_add_task(cpu_data, p);
+		update_or_add_task(p, cpu);
 
 	return 0;
 }
@@ -332,10 +278,11 @@ SEC("tp_btf/sched_process_exit")
 int handle__sched_process_exit(u64 *ctx)
 {
 	const struct task_struct *p = (void *) ctx[0];
-	struct stalld_cpu_data *cpu_data = get_cpu_data(task_cpu(p));
+	int cpu = task_cpu(p);
+	struct stalld_cpu_data *cpu_data = get_cpu_data(cpu);
 
 	if (cpu_data)
-		dequeue_task(p, cpu_data);
+		dequeue_task(p, cpu);
 
 	return 0;
 }
@@ -343,7 +290,8 @@ int handle__sched_process_exit(u64 *ctx)
 SEC("tp_btf/sched_switch")
 int handle__sched_switch(u64 *ctx)
 {
-	struct stalld_cpu_data *cpu_data = get_cpu_data(bpf_get_smp_processor_id());
+	int cpu = bpf_get_smp_processor_id();
+	struct stalld_cpu_data *cpu_data = get_cpu_data(cpu);
 	const struct task_struct *prev = (void *) ctx[1];
 	const struct task_struct *next = (void *) ctx[2];
 
@@ -353,9 +301,8 @@ int handle__sched_switch(u64 *ctx)
 
 	cpu_data->nr_rt_running = task_is_rt(next);
 
-	// update the context switch count of the tasks
-	update_or_add_task(cpu_data, next);
-	update_or_add_task(cpu_data, prev);
+	update_or_add_task(next, cpu);
+	update_or_add_task(prev, cpu);
 
 	return 0;
 }
@@ -373,17 +320,15 @@ int handle__sched_migrate_task(u64 *ctx)
 	/*
 	 * Dequeue the task from its original CPU and re-enqueue it on the
 	 * destination CPU. This ensures its run queue state is tracked
-	 * correctly across migrations. If the task was not found on the
-	 * original CPU, there is no need to enqueue it on the new one, as
-	 * it was not being monitored.
+	 * correctly across migrations.
 	 */
 	if (cpu_data) {
 		log("task=%s(%ld) orig=%d dest=%d",
 		    p->comm, p->tgid, orig_cpu, dest_cpu);
-		if (dequeue_task(p, cpu_data)) {
+		if (dequeue_task(p, orig_cpu)) {
 			cpu_data = get_cpu_data(dest_cpu);
 			if (cpu_data)
-				enqueue_task(p, cpu_data);
+				enqueue_task(p, dest_cpu);
 		}
 	}
 
@@ -393,29 +338,24 @@ int handle__sched_migrate_task(u64 *ctx)
 /**
  * iter_task - BPF iterator program for task enumeration
  * @ctx: Iterator context containing the current task
- *
- * This BPF iterator program walks through all tasks in the system and
- * provides visibility into their scheduling state. It's useful for getting
- * a system-wide snapshot of task states, complementing the event-driven
- * tracepoint programs that track dynamic task state changes.
  */
 SEC("iter/task")
 int iter_task(struct bpf_iter__task *ctx)
 {
 	const struct task_struct *p = ctx->task;
-	struct stalld_cpu_data *cpu_data;
+	int cpu;
 
 	if (!p)
 		return 0;
 
-	cpu_data = get_cpu_data(task_cpu(p));
-	if (!cpu_data)
+	cpu = task_cpu(p);
+	if (!get_cpu_data(cpu))
 		return 0;
 
 	log_task(p);
 
 	if (task_running(p))
-		enqueue_task(p, cpu_data);
+		enqueue_task(p, cpu);
 
 	return 0;
 }
diff --git a/src/queue_track.c b/src/queue_track.c
index 167e8ce..6089277 100644
--- a/src/queue_track.c
+++ b/src/queue_track.c
@@ -65,10 +65,11 @@ static int bump_memlock_rlimit(void)
 	return setrlimit(RLIMIT_MEMLOCK, &rlim_new);
 }
 
-static void print_queued_tasks(struct stalld_cpu_data *stalld_data, int cpu)
+static void print_queued_tasks(int cpu)
 {
-	struct queued_task *task;
-	int is_current;
+	struct task_map_key key, next_key;
+	struct queued_task task;
+	int fd;
 
 	if (!DEBUG_STALLD)
 		return;
@@ -76,10 +77,22 @@ static void print_queued_tasks(struct stalld_cpu_data *stalld_data, int cpu)
 	if (!config_verbose)
 		return;
 
-	for_each_queued_task(stalld_data, task) {
-		is_current = (stalld_data->current == task->pid);
-		log_msg("cpu: %-3d pid: %-8d ctx: %-8lu %s\n", cpu,
-			task->pid, task->ctxswc, is_current ? "R" : "");
+	fd = bpf_map__fd(stalld_obj->maps.stalld_task_map);
+
+	memset(&key, 0, sizeof(key));
+	memset(&next_key, 0, sizeof(next_key));
+
+	while (bpf_map_get_next_key(fd, &key, &next_key) == 0) {
+		key = next_key;
+
+		if (key.cpu != cpu)
+			continue;
+
+		if (bpf_map_lookup_elem(fd, &key, &task) != 0)
+			continue;
+
+		log_msg("cpu: %-3d pid: %-8ld ctx: %-8lu\n", cpu,
+			task.pid, task.ctxswc);
 	}
 }
 
@@ -94,7 +107,7 @@ static int get_cpu_data(struct stalld_cpu_data *stalld_cpu_data, int cpu)
 		return ENODATA;
 	}
 
-	print_queued_tasks(stalld_cpu_data, cpu);
+	print_queued_tasks(cpu);
 
 	return 0;
 }
@@ -131,9 +144,6 @@ static int queue_track_get_cpu(char *buffer, int size, int cpu)
 	if (retval)
 		return 0;
 
-	/*
-	 * Make it compatible with ->get that returned the buffer size.
-	 */
 	return sizeof(struct stalld_cpu_data);
 }
 
@@ -144,35 +154,46 @@ static int queue_track_parse(struct cpu_info *cpu_info, char *buffer, size_t buf
 	int nr_old_tasks = cpu_info->nr_waiting_tasks;
 	long nr_running = 0, nr_rt_running = 0;
 	struct task_info *tasks, *task;
-	struct queued_task *qtask;
+	struct task_map_key key, next_key;
+	struct queued_task qtask;
 	int retval = 0;
+	int fd;
 
 	tasks = allocate_memory(MAX_QUEUE_TASK, sizeof(struct task_info));
 
-	for_each_queued_task(cpu_data, qtask) {
-		if (qtask->is_rt)
+	fd = bpf_map__fd(stalld_obj->maps.stalld_task_map);
+
+	memset(&key, 0, sizeof(key));
+	memset(&next_key, 0, sizeof(next_key));
+
+	while (bpf_map_get_next_key(fd, &key, &next_key) == 0) {
+		key = next_key;
+
+		if (key.cpu != cpu_info->id)
+			continue;
+
+		if (bpf_map_lookup_elem(fd, &key, &qtask) != 0)
+			continue;
+
+		if (qtask.is_rt)
 			nr_rt_running++;
 
-		/*
-		 * Current task is not starving.
-		 */
-		if (qtask->pid == cpu_data->current)
+		if (qtask.pid == cpu_data->current)
 			continue;
 
+		if (nr_running >= MAX_QUEUE_TASK)
+			break;
+
 		task = &tasks[nr_running];
 
-		/*
-		 * if we cannot get the process name, the process died.
-		 * RIP process, a loop of silence.
-		 */
-		retval = fill_process_comm(qtask->tgid, qtask->pid, task->comm, COMM_SIZE);
+		retval = fill_process_comm(qtask.tgid, qtask.pid, task->comm, COMM_SIZE);
 		if (retval)
 			continue;
 
-		task->pid = qtask->pid;
-		task->tgid = qtask->tgid;
+		task->pid = qtask.pid;
+		task->tgid = qtask.tgid;
 
-		task->ctxsw = qtask->ctxswc;
+		task->ctxsw = qtask.ctxswc;
 
 		task->since = time(NULL);
 
@@ -205,10 +226,6 @@ static int queue_track_has_starving_task(struct cpu_info *cpu)
 /**
  * initialize_maps - Initialize BPF per-CPU data maps
  *
- * This function initializes the BPF maps used for per-CPU monitoring data.
- * It retrieves existing CPU data from the BPF map, enables monitoring for
- * configured CPUs, and updates the map with the new monitoring state.
- *
  * Returns: 0 on success, -1 on error
  */
 static int initialize_maps(void)
@@ -226,7 +243,6 @@ static int initialize_maps(void)
 		set_cpu_data(&stalld_data, i);
 	}
 
-	/* it is static */
 	config_buffer_size = sizeof(struct stalld_cpu_data);
 	return 0;
 }
@@ -234,10 +250,6 @@ static int initialize_maps(void)
 /**
  * run_task_iterator - Execute the BPF task iterator
  *
- * This function creates and runs the BPF task iterator program to walk
- * through all tasks in the system. The iterator provides a snapshot view
- * of all tasks, complementing the event-driven tracepoint monitoring.
- *
  * Returns: 0 on success, negative value on error
  */
 static int run_task_iterator(void)
@@ -266,10 +278,8 @@ static int run_task_iterator(void)
 		return iter_fd;
 	}
 
-	/* Run the iterator - this will trigger iteration through all tasks */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0) {
 		/* Iterator output is processed by the BPF program itself */
-		/* The actual task tracking happens in the BPF program */
 	}
 
 	if (len < 0)
@@ -284,10 +294,6 @@ static int run_task_iterator(void)
 
 /**
  * load_ebpf_context - sets up ebpf context
- *
- * Set up the basics for the ebpf program to run, raising
- * memlock limit, loading and attaching the eBPF code, set
- * up the perf buffer and return the ebpf object.
  */
 static int load_ebpf_context(void)
 {
@@ -315,6 +321,12 @@ static int load_ebpf_context(void)
 		log_msg("adjusted stalld map to %d cpus\n", config_nr_cpus);
 	}
 
+	err = bpf_map__set_max_entries(stalld_obj->maps.stalld_task_map,
+				       MAX_QUEUE_TASK * config_nr_cpus);
+	if (err) {
+		warn("failed to resize BPF task map: %d\n", err);
+		goto cleanup;
+	}
 
 	err = stalld_bpf__load(stalld_obj);
 	if (err) {
@@ -358,7 +370,6 @@ static void queue_track_destroy(void)
 	int retval, i;
 
 	for (i = 0; i < config_nr_cpus; i++) {
-		/* Init data */
 		retval = get_cpu_data(&stalld_data, i);
 		if (retval)
 			continue;
diff --git a/src/queue_track.h b/src/queue_track.h
index c9c9987..efa1f81 100644
--- a/src/queue_track.h
+++ b/src/queue_track.h
@@ -8,6 +8,11 @@
 
 #define MAX_QUEUE_TASK 2048
 
+struct task_map_key {
+	unsigned long cpu;
+	long pid;
+};
+
 struct queued_task {
 	long pid;
 	long tgid;
@@ -20,110 +25,8 @@ struct stalld_cpu_data {
 	int monitoring;
 	int current;
 	int nr_rt_running;
-	struct queued_task tasks[MAX_QUEUE_TASK];
 };
 
-/*
- * Macro: for_each_task_entry
- * --------------------------
- * Iterates over *all* possible entries within the `tasks` array of a
- * `stalld_cpu_data` structure. This includes both active (valid) task entries
- * and empty (unused) slots.
- *
- * Usage:
- * for_each_task_entry(cpu_data, task_ptr) {
- * 	// Code to execute for each entry.
- * 	// task_ptr will be a pointer to a `struct queued_task`.
- * 	// Check task_ptr->pid to determine if the slot is active.
- * }
- *
- * Parameters:
- * @cpu_data: A pointer to a `struct stalld_cpu_data` instance
- * (e.g., obtained by `get_cpu_data()` from an eBPF map).
- * @task:     A pointer variable of type `struct queued_task *` that will
- * point to the current `queued_task` entry in each iteration.
- *
- * Example:
- * struct stalld_cpu_data *my_cpu_data = get_cpu_data(0);
- * struct queued_task *entry;
- * for_each_task_entry(my_cpu_data, entry) {
- * 	if (entry->pid != 0) {
- * 		// Process active task entry
- * 		printf("Active task: PID %ld, TGID %ld\n", entry->pid, entry->tgid);
- * 	} else {
- * 		// Slot is empty
- * 		printf("Empty slot\n");
- * 	}
- * }
- */
-#define for_each_task_entry(cpu_data, task)	\
-	task = cpu_data->tasks;			\
-	for (unsigned int i = 0;		\
-	     i < MAX_QUEUE_TASK;		\
-	     ++i, task = cpu_data->tasks + i)
-
-/*
- * Macro: for_each_queued_task
- * ---------------------------
- * Iterates specifically over *active* tasks currently present in the
- * `tasks` array of a `stalld_cpu_data` structure. It skips empty slots.
- * An entry is considered active if its `pid` field is non-zero.
- *
- * This macro builds upon `for_each_task_entry` and applies a filter
- * to process only valid, currently tracked tasks.
- *
- * Usage:
- * for_each_queued_task(cpu_data, task_ptr) {
- *	// Code to execute for each active (non-empty) task entry.
- *	// task_ptr will be a pointer to a `struct queued_task`.
- * }
- *
- * Parameters:
- * @cpu_data: A pointer to a `struct stalld_cpu_data` instance.
- * @task:     A pointer variable of type `struct queued_task *` that will
- * point to the current active `queued_task` entry in each
- * iteration.
- *
- * Example:
- * struct stalld_cpu_data *data_for_cpuX = get_data_from_map_for_cpu(X);
- * struct queued_task *q_task;
- * for_each_queued_task(data_for_cpuX, q_task) {
- *	// This block only executes for tasks where q_task->pid is not 0
- *	printf("Queued task on CPU %d: PID %ld (RT: %d, Prio: %d)\n",
- *		X, q_task->pid, q_task->is_rt, q_task->prio);
- * }
- */
-#define for_each_queued_task(cpu_data, task)	\
-	for_each_task_entry(cpu_data, task)	\
-		if (task->pid)
-
-/**
- * find_queued_task - Search for a task within a CPU's queued_task array
- * @cpu_data: A pointer to the `stalld_cpu_data` structure for a specific CPU.
- * @pid:      The Process ID (PID) of the task to search for.
- *
- * This function iterates through all possible task slots within the
- * `tasks` array of the provided `cpu_data`. It returns a pointer to the
- * `queued_task` structure if an entry with a matching PID is found.
- * If no task with the given PID is found after checking all slots,
- * the function returns `NULL`.
- *
- * This helper is used by the BPF program to efficiently locate tasks
- * for operations like enqueuing or dequeuing.
- */
-static inline struct queued_task *find_queued_task(struct stalld_cpu_data *cpu_data, long pid)
-{
-	struct queued_task *task;
-
-	for_each_task_entry(cpu_data, task) {
-		if (task->pid == pid)
-			return task;
-	}
-
-	// we don't have the NULL definition
-	return (struct queued_task *) 0;
-}
-
 extern struct stalld_backend queue_track_backend;
 
 #endif /* __QUEUE_TRACK_H */
-- 
2.54.0

