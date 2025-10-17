Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB777201004
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667891; cv=none; b=nFTq8qqlh/z/GuHdOyHl7rfvV6o2YPljdBEz7Nh00k3WesNFQ/g4pNELDy+3ST4rWBn5AGdxZJ7OgM7kaskZfkCo21W4xt+BQjgffjrnyHbneoar0SMmcr6AIFG0ahc97UWegPfbse+rdsJhkVDb8WaLrTGDSgsHYY5klhRKY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667891; c=relaxed/simple;
	bh=x/bKE8TehT+cSvZZ4EI3byD1c62tbDkFSDTtEyA4jg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=k8y3IcS/jIElk0SsUFWveplEaXuOkdW8dT4pHnsqE4KzEQJrmJp5IEUhDIrZBoIFa2kGdAdrkudvgIDkz//GRVTEf2xgVmIh+PmVjp9RJl8shX2iay5jaI6ZslyHNhcTMWmN+whtiBBgIWtAl+0ax0R/BColpDgpxHc7ZIf1uhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyFbaM0K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyFbaM0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04666C4CEFB;
	Fri, 17 Oct 2025 02:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667891;
	bh=x/bKE8TehT+cSvZZ4EI3byD1c62tbDkFSDTtEyA4jg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyFbaM0Kfdw0DBz1+34to89X1bH8IoyTv3r8uB66KpVUfoYhuLSxYrCrwQS7qeh13
	 Kbfz5fQS4GEaeKYratm0LQ1ksv7l62vE9g8+77Uz1122amI+MJApJ8E9JR4fjej83U
	 wQRO5EWdm+Y1FsyTRo6yXVCmknwCEVCHa92gOMFohOn+UBexv71bWPxzLGcYH6WfI+
	 Hth6VDrcvRnqSWrBK8ocd/aWy+4ONQh0rgyXtRk4O5kwdcuFva6Jpss2F0u4tmtc4L
	 0xPLS6hfBADcV/o7NBCKylUUCBWdy7P/4fkJwsG4pjhtgKdF+N9dAC9Lr3/GzAQ6AU
	 HKSje+ZmcZdBQ==
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	wander@redhat.com,
	debarbos@redhat.com,
	marco.chiappero@suse.com,
	chris.friesen@windriver.com,
	luochunsheng@ustc.edu
Subject: [PATCH 04/12] stalld.c: remove noisy idle report and added report to should_skip_idle_cpus()
Date: Thu, 16 Oct 2025 21:24:36 -0500
Message-ID: <20251017022444.118802-4-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017022444.118802-1-clrkwllms@kernel.org>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Clark Williams <williams@redhat.com>

comment out the log_verbose() call in get_cpu_busy_list(), since
it's not helpful for production and chews up a lot of screen real-
estate when running tests. Added a report in should_skip_idle_cpus()
which reports that there were busy cpus and that a run-queue parse
will be done.

Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/stalld.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/stalld.c b/src/stalld.c
index 4c00158cf239..e8c927750ee0 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -289,9 +289,10 @@ int get_cpu_busy_list(struct cpu_info *cpus, int nr_cpus, char *busy_cpu_list)
 			continue;
 		}
 
-		log_verbose ("\t cpu %d had %ld idle time, and now has %ld\n",
-			     cpu->id, cpu->idle_time, idle_time);
-
+		/*
+		 * log_verbose ("\t cpu %d had %ld idle time, and now has %ld\n",
+		 *	     cpu->id, cpu->idle_time, idle_time);
+		 */
 		/* If the idle time did not change, the CPU is busy. */
 		if (cpu->idle_time == idle_time) {
 			busy_cpu_list[i] = 1;
@@ -795,7 +796,7 @@ static int should_skip_idle_cpus(struct cpu_info *cpus, int nr_cpus, char *busy_
 		log_verbose("all CPUs had idle time, skipping parse\n");
 		return 1;
 	}
-
+	log_verbose("some cpus ran, so run-queues should be parsed\n");
 	return 0;
 }
 
-- 
2.51.0

