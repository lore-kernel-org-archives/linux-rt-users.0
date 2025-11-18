Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8112D47E6
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Nov 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465538; cv=none; b=IG/6hAcCJHJCFQpRF+2OP5UyEh50q2EUN8yMOq1e6T5+8Wob/pDK71Ow+3hWRYAl7CvK2Z4V3aoy8qZP8INFjISp5Q7UCa26zwu/ibPFxKv2ZfE9Fv7l9jvwyk0ll3GetJTsqldMQw2krgsRnitucfPBcYZ3HeuliBkJASRlGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465538; c=relaxed/simple;
	bh=3rv6NdK8mhpFtyEaCyT7Mty0RrEgAO9KgiSyJy8bOW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fdzacnR3ZOKK2SRYf8j1K66ismVxsMekOvijlFXgzpRt+ZpI09p66mx6FVdL0pyr0xEeTpf9kYaiiVa2+9/N8T3QeXFN1EP1F/gu4arVuxKzR6sjKnPnKu0dZm658X+8HBdRHQxZodVDDWoufmetNmDPmDKYy50Q5sNPDYwhOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.163])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29feb34f2;
	Tue, 18 Nov 2025 19:32:04 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: williams@redhat.com,
	wander@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	debarbos@redhat.com,
	jkacur@redhat.com,
	luochunsheng@ustc.edu,
	luffyluo <luffyluo@tencent.com>
Subject: [PATCH] Fix typo: rename 'merge_taks_info' to 'merge_tasks_info'
Date: Tue, 18 Nov 2025 19:31:53 +0800
Message-ID: <20251118113202.16-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a96bc747b03a2kunm4780998f3f4da6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRhMVh4fS01OTkhJTh0fS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTUhZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

From: luffyluo <luffyluo@tencent.com>

---
 .claude/CLAUDE.md                     | 6 +++---
 src/queue_track.c                     | 2 +-
 src/sched_debug.c                     | 2 +-
 src/stalld.c                          | 2 +-
 src/stalld.h                          | 2 +-
 tests/TODO.md                         | 2 +-
 tests/functional/test_task_merging.sh | 4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/.claude/CLAUDE.md b/.claude/CLAUDE.md
index 718b704..2cd84ba 100644
--- a/.claude/CLAUDE.md
+++ b/.claude/CLAUDE.md
@@ -73,7 +73,7 @@ stalld/
 - Entry point: `main()` at line 1121
 - Boosting logic: `boost_with_deadline()`, `boost_with_fifo()` (lines 438-563)
 - Threading modes: `single_threaded_main()`, `conservative_main()`, `aggressive_main()`
-- Task merging: `merge_taks_info()` preserves starvation timestamps (lines 370-397)
+- Task merging: `merge_tasks_info()` preserves starvation timestamps (lines 370-397)
 
 **src/utils.c** - Utilities
 - Command-line parsing: `parse_args()`
@@ -311,7 +311,7 @@ Tests use `parse_test_options()` from `test_helpers.sh` to handle backend and th
 
 **Known Issues:**
 - **queue_track backend limitation**: BPF backend cannot detect SCHED_FIFO tasks waiting on runqueue due to `task_running()` check in `stalld.bpf.c:273` only tracking `__state == TASK_RUNNING`. Tests using `starvation_gen` (SCHED_FIFO workloads) pass on sched_debug but fail on queue_track.
-- **Segfault fix**: Fixed critical bug in `merge_taks_info()` that caused crashes in adaptive/aggressive modes (commit 7af4f55a5765)
+- **Segfault fix**: Fixed critical bug in `merge_tasks_info()` that caused crashes in adaptive/aggressive modes (commit 7af4f55a5765)
 
 🔄 **Phase 4 Planned** (Advanced Features):
 - Threading modes (adaptive vs aggressive)
@@ -521,7 +521,7 @@ Check: `/proc/sys/kernel/sched_rt_runtime_us` should be `-1`.
 ## Important Code Patterns
 
 ### Task Merging (src/stalld.c:370-397)
-When re-parsing tasks, `merge_taks_info()` preserves starvation timestamps for tasks that haven't made progress (same PID, same context switch count).
+When re-parsing tasks, `merge_tasks_info()` preserves starvation timestamps for tasks that haven't made progress (same PID, same context switch count).
 
 ### Denylist/Ignore Feature
 - `-i` flag: Ignore threads/processes matching regex patterns
diff --git a/src/queue_track.c b/src/queue_track.c
index dbae1b1..167e8ce 100644
--- a/src/queue_track.c
+++ b/src/queue_track.c
@@ -190,7 +190,7 @@ static int queue_track_parse(struct cpu_info *cpu_info, char *buffer, size_t buf
 		cpu_info->nr_waiting_tasks = nr_running - 1;
 
 	if (old_tasks) {
-		merge_taks_info(cpu_info->id, old_tasks, nr_old_tasks, cpu_info->starving, cpu_info->nr_waiting_tasks);
+		merge_tasks_info(cpu_info->id, old_tasks, nr_old_tasks, cpu_info->starving, cpu_info->nr_waiting_tasks);
                 free(old_tasks);
         }
 
diff --git a/src/sched_debug.c b/src/sched_debug.c
index 102a4e0..3754b56 100644
--- a/src/sched_debug.c
+++ b/src/sched_debug.c
@@ -594,7 +594,7 @@ static int sched_debug_parse(struct cpu_info *cpu_info, char *buffer, size_t buf
 
 	cpu_info->nr_waiting_tasks = fill_waiting_task(cpu_buffer, cpu_info);
 	if (old_tasks) {
-		merge_taks_info(cpu_info->id, old_tasks, nr_old_tasks, cpu_info->starving, cpu_info->nr_waiting_tasks);
+		merge_tasks_info(cpu_info->id, old_tasks, nr_old_tasks, cpu_info->starving, cpu_info->nr_waiting_tasks);
 		free(old_tasks);
 	}
 
diff --git a/src/stalld.c b/src/stalld.c
index 854e76d..b9372db 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -377,7 +377,7 @@ void update_cpu_starving_vector(int cpu, const struct task_info *task)
 	}
 }
 
-void merge_taks_info(int cpu, struct task_info *old_tasks, int nr_old, struct task_info *new_tasks, int nr_new)
+void merge_tasks_info(int cpu, struct task_info *old_tasks, int nr_old, struct task_info *new_tasks, int nr_new)
 {
 	static const struct task_info notask = {};
 
diff --git a/src/stalld.h b/src/stalld.h
index fd219bc..706e3ef 100644
--- a/src/stalld.h
+++ b/src/stalld.h
@@ -205,7 +205,7 @@ void cleanup_regex(unsigned int *nr_task, regex_t **compiled_expr);
 void find_sched_debug_path(void);
 int set_reservation(int period, int reservation);
 int get_tgid(int pid);
-void merge_taks_info(int cpu, struct task_info *old_tasks, int nr_old, struct task_info *new_tasks, int nr_new);
+void merge_tasks_info(int cpu, struct task_info *old_tasks, int nr_old, struct task_info *new_tasks, int nr_new);
 int set_cpu_affinity(char *cpu_list);
 int check_dl_server_dir_exists(void);
 
diff --git a/tests/TODO.md b/tests/TODO.md
index 57a7a16..a872254 100644
--- a/tests/TODO.md
+++ b/tests/TODO.md
@@ -624,7 +624,7 @@ Follow test_boost_period.sh and test_starvation_threshold.sh rewrites:
 
 ### 2025-10-13 - Critical Segfault Fix and Backend Limitation Documentation
 - **Fixed critical segfault in adaptive/aggressive modes**
-  - **Root cause**: `merge_taks_info()` unconditionally called `update_cpu_starving_vector()` at line 389
+  - **Root cause**: `merge_tasks_info()` unconditionally called `update_cpu_starving_vector()` at line 389
   - **Problem**: `cpu_starving_vector` only allocated in `single_threaded_main()` (line 1007)
   - **Impact**: Adaptive/aggressive modes crashed when parsing tasks (any backend)
   - **Fix**: Added `if (config_single_threaded)` guards before both `update_cpu_starving_vector()` calls
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index daa3eab..053c648 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Test: Task Merging Logic
-# Verify stalld's merge_taks_info() correctly preserves starvation timestamps
+# Verify stalld's merge_tasks_info() correctly preserves starvation timestamps
 # for tasks that make no progress (same PID + same context switches)
 #
 # Copyright (C) 2025 Red Hat Inc
@@ -362,7 +362,7 @@ log ""
 log "=========================================="
 log "Test Summary"
 log "=========================================="
-log "Task merging function: merge_taks_info() in stalld.c:370-397"
+log "Task merging function: merge_tasks_info() in stalld.c:370-397"
 log "Merge logic: if (PID == PID && ctxsw == ctxsw) preserve timestamp"
 log ""
 log "Total failures: ${TEST_FAILED}"
-- 
2.41.0

