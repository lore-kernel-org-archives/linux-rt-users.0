Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76386201004
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667896; cv=none; b=gwM1ofMkQneI/MZ4269LP89EGgp6m/tteGGloZKBFf/BbNRB97+qMBAveEhNk+N7E3D2FoEgGN22jAyNUCH5lR771vDun33+Ta2RNK1y5cCN024ghCNwr1e1QsISXdamUqbOVTyUQM/bEHNs1r6sczFgnPj4rD9MNP8HAZD8azw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667896; c=relaxed/simple;
	bh=PV7dBX4iaQvZbq/GSlfcQLuY725Omo1BZwBfeEKzjJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-type; b=SHb3YXR6do60QmDWeuyTRK+v++v59pk1FQrw2AeJ29Epe87MAhCxm2b+DvhrevdvFDjGxnuxL+u18i+2CrTd/IfPUi0K2Zac7dAW/Amt2kML2yEMSVFO5PmK7xYLN380GoldR01LqsH5jvxeskNL1K58DxQ2F5Vm1eNwUp0qLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFHN0VJJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFHN0VJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61C9C4CEFB;
	Fri, 17 Oct 2025 02:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667896;
	bh=PV7dBX4iaQvZbq/GSlfcQLuY725Omo1BZwBfeEKzjJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFHN0VJJKkxGeysit0XjVkt0WjlLLA+4tTm3UpYYVgvGpmM+O3cocTSzqSdcYLe3d
	 AD1H5BN+uipEO8l2ssifK4eqSBfa3+cS9wO+jR4W1WvPCWOOiUKvI/nJ/49YgJgGJK
	 EvtiZqPTz45SvEfxZYJnySAV1LrurgYCZCRZn/ac/JXzegUvqtqAGF/aEN13XZIf9i
	 vZSsVWTEtWyW7oDu/yflnXlMCKdnXr/PwFdjiw0DzdpWttXJ/Ajju8J/ycUtnEgyLt
	 DmPOA1TxZB9+Se7QMbCbg+F76XouvvIRqEMXmizi7VOd1SES6srSEtu0z/rrJYkYZF
	 2GsaPv9hiCIvA==
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
Subject: [PATCH 07/12] stalld.c: Add starvation logging in single-threaded log-only mode
Date: Thu, 16 Oct 2025 21:24:39 -0500
Message-ID: <20251017022444.118802-7-clrkwllms@kernel.org>
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

In single-threaded mode with -l/--log_only flag, stalld was not logging
the "starved" message when tasks reached the starvation threshold. This
was because the config_log_only check occurred before any logging, and
the "starved" message (present in check_starving_tasks() for per-CPU
threading modes) was missing from boost_cpu_starving_vector().

This caused test_log_only.sh to fail when looking for the "starved"
message in the log output.

Changes to boost_cpu_starving_vector():
- Move config_log_only check after starvation detection
- Add log_msg() call to output "starved" message when threshold reached
- Reset timestamp (cpu->since) in log-only mode to prevent continuous
  logging of the same starvation event
- Change threshold comparison from <= to < for consistency with
  check_starving_tasks()

This ensures consistent logging behavior between single-threaded mode
and per-CPU threading modes when using log-only mode.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/stalld.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/stalld.c b/src/stalld.c
index 6adc3e9a8cea..ebca23105ce9 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -924,12 +924,22 @@ int boost_cpu_starving_vector(struct cpu_starving_task_info *vector, int nr_cpus
 			log_verbose("\t cpu %d: pid: %d starving for %llu\n",
 				    i, cpu->pid, (now - cpu->since));
 
-		if (config_log_only)
+		/* Skip if no task or not starving long enough */
+		if (cpu->pid == 0 || (now - cpu->since) < config_starving_threshold)
 			continue;
 
-		/* Skip if no task or not starving long enough */
-		if (cpu->pid == 0 || (now - cpu->since) <= config_starving_threshold)
+		/* Log when task has reached starvation threshold */
+		if ((now - cpu->since) >= config_starving_threshold) {
+			log_msg("%s-%d starved on CPU %d for %d seconds\n",
+				cpu->task.comm, cpu->pid, i,
+				(now - cpu->since));
+		}
+
+		if (config_log_only) {
+			/* Reset timestamp to avoid continuous logging */
+			cpu->since = now;
 			continue;
+		}
 
 		/* Skip if task is on denylist */
 		if (config_ignore && !check_task_ignore(&cpu->task))
-- 
2.51.0

