Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427B1E1DF0
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288615; cv=none; b=FAlfxMhoMoEcKKW29/vRsY/w5mnrYpf9PgzLfeRtgcLHgYVxOJ+6rbb48XXIVa70uHALcks0rx5EGOB2BtDVA0auH9etLGeV8Vx9ZZ25+96zNhwnBxttMH5LzbQZvAifH+sXZNO7jLdkWeQRcGkIw4VF7Q7nxyEga/5ZOJbNLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288615; c=relaxed/simple;
	bh=0G34cb7K0w7ZueVcdkT5xt2nl/wLXT4/uNK2+2l5TIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7XTmccj8+XTUKsKyIcDdjJGTG2JFTiYrOBCW+gANAnTevH20RHX0ED0pLKnTkoHeXigJbi0ZOweKvYbCKs67bKuRzg81LvmgAfZ9OPZtPCT9PLxmlRsSOxWEPcE2rSZ1tl8j7T6cd1/iE+1vcX4eBJcZMsxlX3e1eG2Xj5uXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQyL+L/o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQyL+L/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aTOlmksSMxAzPhEzipcdV77v2tsUUqGBKCl/fQeOqmc=;
	b=gQyL+L/o00iJbS2tgm1AXyJbpvVQ/dAzxYiNPnrD5D7rQ3V+hYbTfT7oKRGTCvFLqvUVPW
	cg+n63LqGaMHbA2LD6H4oooIl1tpAGHSe/TxTNCfMvgVPAwadT2CVTDmHAhnKwJ59sVaF9
	b7/gRV0qybbG7jiuNNdntb8MBalAeqU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-3EAbtSftMaWnbAKUoNxZ2A-1; Mon,
 27 Apr 2026 07:16:51 -0400
X-MC-Unique: 3EAbtSftMaWnbAKUoNxZ2A-1
X-Mimecast-MFC-AGG-ID: 3EAbtSftMaWnbAKUoNxZ2A_1777288610
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56C09180034F;
	Mon, 27 Apr 2026 11:16:50 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D47B180047F;
	Mon, 27 Apr 2026 11:16:47 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 00/23] tests: Comprehensive suite hardening and fail-fast
Date: Mon, 27 Apr 2026 08:16:02 -0300
Message-ID: <20260427111632.24500-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The stalld functional test suite has accumulated significant
reliability and maintainability issues over time. Several tests
were silently passing due to missing assertions, shell scoping
bugs that discarded subshell results, and grep substring matches
causing false positives on multi-digit CPU systems. Additionally,
massive boilerplate duplication existed across the suite, and a
daemon bug was discovered where --force_fifo combined with
single-threaded mode silently fell back to adaptive mode instead
of erroring out.

This series addresses these issues by overhauling the test
validation logic and execution flow. It fixes the daemon's
--force_fifo fallback behavior and introduces eight shared test
helpers to eliminate duplicated validation patterns. The existing
tests are then refactored to utilize these helpers, flattening
conditional blocks and replacing verbose wait loops. Finally, the
suite is transitioned to fail-fast semantics, where any failure
immediately aborts the test run to provide immediate feedback.

As a result, approximately seven silently passing tests now
correctly validate daemon behavior. The introduction of shared
helpers and the removal of legacy C unit test infrastructure,
stale documentation, and unreachable cleanup code yields a net
reduction of roughly 9,700 lines (+626/-10325).

Wander Lairson Costa (23):
  stalld: Reject --force_fifo in single-threaded mode
  tests: Introduce test_section() helper
  tests: Introduce cleanup_scenario() helper
  tests: Introduce starvation and boost asserts
  tests: Introduce find_starved_child() helper
  tests: Fix task exit timing in test_boost_restoration
  tests: Consolidate and adopt init_functional_test()
  tests: Introduce assert_stalld_rejects() helper
  tests: Fix boost verification in runtime and duration tests
  tests: Fix subshell swallowing test results
  tests: Fix repeated log match finding same line
  chore: Remove legacy test infrastructure and stale docs
  tests: Add assertions to SCHED_OTHER restoration test
  tests: Fix CPU selection grep substring matches
  tests: Add idle CPU skipping assertion
  tests: Remove redundant pkill from cleanup
  tests: Introduce and adopt assert_log_contains() helper
  tests: Remove weak, redundant, and assertion-free test blocks
  tests: Introduce and adopt assert_success() helper
  tests: Replace wait conditionals with asserts
  tests: Remove if-wrappers around assert calls
  tests: Abort immediately on test failure
  tests: Remove dead code after making fail() fatal

 .claude/CLAUDE.md                             |  585 ---------
 .claude/agents/agent-prompt-engineer.md       |  135 --
 .claude/agents/c-expert.md                    |   53 -
 .claude/agents/code-reviewer.md               |  104 --
 .claude/agents/get-agent-hash                 |   99 --
 .claude/agents/git-scm-master.md              | 1154 -----------------
 .claude/agents/kernel-hacker.md               |  231 ----
 .claude/agents/plan-validator.md              |  130 --
 .claude/agents/project-historian.md           |  285 ----
 .claude/agents/project-librarian.md           |  604 ---------
 .claude/agents/project-manager.md             |  388 ------
 .claude/agents/project-scope-guardian.md      |  326 -----
 .claude/agents/python-expert.md               |   57 -
 .claude/agents/test-specialist.md             |  656 ----------
 .claude/agents/update-agent-hashes            |   96 --
 .claude/context-snapshot.json                 |  103 --
 .claude/rules                                 |   42 -
 .gitignore                                    |    5 +-
 src/utils.c                                   |    9 +-
 tests/BACKEND_USAGE.md                        |  269 ----
 tests/CONTEXT_SNAPSHOT_2025-10-31.md          |  231 ----
 tests/Makefile                                |   29 +-
 tests/README.md                               |   29 +-
 tests/TODO.md                                 |  727 -----------
 tests/functional/test_affinity.sh             |  154 +--
 tests/functional/test_backend_selection.sh    |   24 +-
 tests/functional/test_boost_duration.sh       |  160 +--
 tests/functional/test_boost_period.sh         |  151 +--
 tests/functional/test_boost_restoration.sh    |  306 +----
 tests/functional/test_boost_runtime.sh        |  179 +--
 tests/functional/test_cpu_selection.sh        |   76 +-
 tests/functional/test_deadline_boosting.sh    |  256 +---
 tests/functional/test_fifo_boosting.sh        |  263 +---
 .../test_fifo_priority_starvation.sh          |  188 +--
 tests/functional/test_force_fifo.sh           |  196 +--
 tests/functional/test_foreground.sh           |   58 +-
 tests/functional/test_idle_detection.sh       |  195 +--
 tests/functional/test_log_only.sh             |   26 +-
 tests/functional/test_logging_destinations.sh |   37 +-
 tests/functional/test_pidfile.sh              |  151 +--
 tests/functional/test_runqueue_parsing.sh     |  417 ------
 tests/functional/test_starvation_detection.sh |  276 +---
 tests/functional/test_starvation_threshold.sh |  133 +-
 tests/functional/test_task_merging.sh         |  146 +--
 tests/helpers/test_helpers.sh                 |  233 +++-
 tests/legacy/README.md                        |  169 ---
 tests/legacy/test01.c                         |  506 --------
 tests/legacy/test01_wrapper.sh                |  161 ---
 tests/run_tests.sh                            |  143 +-
 49 files changed, 626 insertions(+), 10325 deletions(-)
 delete mode 100644 .claude/CLAUDE.md
 delete mode 100644 .claude/agents/agent-prompt-engineer.md
 delete mode 100644 .claude/agents/c-expert.md
 delete mode 100644 .claude/agents/code-reviewer.md
 delete mode 100755 .claude/agents/get-agent-hash
 delete mode 100644 .claude/agents/git-scm-master.md
 delete mode 100644 .claude/agents/kernel-hacker.md
 delete mode 100644 .claude/agents/plan-validator.md
 delete mode 100644 .claude/agents/project-historian.md
 delete mode 100644 .claude/agents/project-librarian.md
 delete mode 100644 .claude/agents/project-manager.md
 delete mode 100644 .claude/agents/project-scope-guardian.md
 delete mode 100644 .claude/agents/python-expert.md
 delete mode 100644 .claude/agents/test-specialist.md
 delete mode 100755 .claude/agents/update-agent-hashes
 delete mode 100644 .claude/context-snapshot.json
 delete mode 100644 .claude/rules
 delete mode 100644 tests/BACKEND_USAGE.md
 delete mode 100644 tests/CONTEXT_SNAPSHOT_2025-10-31.md
 delete mode 100644 tests/TODO.md
 delete mode 100755 tests/functional/test_runqueue_parsing.sh
 delete mode 100644 tests/legacy/README.md
 delete mode 100644 tests/legacy/test01.c
 delete mode 100755 tests/legacy/test01_wrapper.sh

-- 
2.53.0

