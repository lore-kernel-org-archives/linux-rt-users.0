Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022D201004
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667889; cv=none; b=cEb7dv+pa0AmXWYnM3R0W9sqGTl5mG7wIff6yIIDW1NdqlM/VSpfW4FLFT9KqFl3mN9zIoFV2Qhuv4BcIZRc29YIAkm1D0TUD1QqVRVTtCnch1R42XyxX+IJjX7M5DKOQpw/Og2PbuJ61DZLxEinUAjtug9UIZJRDfLbOkj+5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667889; c=relaxed/simple;
	bh=O1O+berWXOQ3/emwM5UlsRg7591oNF9krVTCxmH9WY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-type; b=aD43bMaOM+Fr+wzsrqRkIbNArtTCij74Yy9OenFLs4Uadk73BYZ9UgHU+abKb/5Kuyb9cV1XmbHEP0YBNRpO2AZYXgyOYUNRpq60HLdqI//SE8iBgllWXInSuASOWWbYlSs1oqMl7L4u/20+TI7kuH4+wmtr8Ewmzyx4Fr2bOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwYZWX7o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwYZWX7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5464AC4CEF1;
	Fri, 17 Oct 2025 02:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667889;
	bh=O1O+berWXOQ3/emwM5UlsRg7591oNF9krVTCxmH9WY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwYZWX7oqUOPBNuF+8JWcl7cBM903WhHfoR+0aPJT3VkSYnfXybXE/4+jmf/MDbnh
	 sDguj9oxB2OCa5b+tTageFug8I3z9apwC9Cnqkx2WONnQG7U++NaxLqGOIa84y9QaP
	 pNdi023r5lc/3F/gex+7tNVe+jt1Ie31Fu5b6JGhu7zARLfW/v8kBidd2TIiLCF5ER
	 du0yguW9pa63tp04gwKepRGlzP7qGnQqE36C7HIkBGikeXj/YjwdWUbTEbZo5JrSPC
	 f88CX28KqdhLGm1tXPmiEc2K4O5ofNw6i6rIfVA477bw9blIbcB1XT0MFhVRpDiVbM
	 yZtojGSTZFR5w==
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
Subject: [PATCH 03/12] sched_debug: Fix double-free crash in fill_waiting_task()
Date: Thu, 16 Oct 2025 21:24:35 -0500
Message-ID: <20251017022444.118802-3-clrkwllms@kernel.org>
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

Fix a critical double-free bug that occurs when fill_waiting_task()
returns early without allocating new memory for cpu_info->starving.

Root cause:
In sched_debug_parse(), the code saves old_tasks = cpu_info->starving,
then calls fill_waiting_task(). If fill_waiting_task() returns early
(nr_entries <= 0 or cpu_info == NULL), it doesn't allocate new memory
or update cpu_info->starving. This leaves cpu_info->starving pointing
to the old memory. When the code later frees old_tasks, it's freeing
the same memory that cpu_info->starving still points to. On the next
iteration, old_tasks again points to this already-freed memory, causing
a double-free crash.

Example crash sequence:
1. First parse: cpu_info->starving = malloc(memory A)
2. Second parse: old_tasks = memory A
                 nr_entries = 5, so cpu_info->starving = malloc(memory B)
                 free(old_tasks) → frees memory A
3. Third parse:  old_tasks = memory B
                 nr_entries = 0, so fill_waiting_task() returns early
                 cpu_info->starving still points to memory B
                 free(old_tasks) → frees memory B
4. Fourth parse: old_tasks = memory B (already freed!)
                 nr_entries > 0, so cpu_info->starving = malloc(memory C)
                 free(old_tasks) → DOUBLE FREE of memory B → CRASH

The fix:
Explicitly set cpu_info->starving = NULL in fill_waiting_task() when
returning early without allocation. This ensures that cpu_info->starving
never points to freed memory, preventing the double-free.

Impact:
- Prevents random crashes in sched_debug backend
- Enables stable operation with varying numbers of runnable tasks
- Critical for test suite reliability

Testing:
- Verified no crash with: sudo stalld -f -v -N -b sched_debug -t 3 -c 0 -l
- Runs stably for extended periods without crashes

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/sched_debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/sched_debug.c b/src/sched_debug.c
index 04a12ef2a7c2..102a4e02d57d 100644
--- a/src/sched_debug.c
+++ b/src/sched_debug.c
@@ -525,6 +525,7 @@ static int fill_waiting_task(char *buffer, struct cpu_info *cpu_info)
 
 	if (cpu_info == NULL) {
 		warn("NULL cpu_info pointer!\n");
+		cpu_info->starving = NULL;
 		return 0;
 	}
 
@@ -533,8 +534,10 @@ static int fill_waiting_task(char *buffer, struct cpu_info *cpu_info)
 	else
 		nr_entries = cpu_info->nr_running;
 
-	if (nr_entries <= 0)
+	if (nr_entries <= 0) {
+		cpu_info->starving = NULL;
 		return 0;
+	}
 
 	cpu_info->starving = malloc(sizeof(struct task_info) * nr_entries);
 	if (cpu_info->starving == NULL) {
-- 
2.51.0

