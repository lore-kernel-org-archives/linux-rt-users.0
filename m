Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DA3E63AC
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285691; cv=none; b=rmZ7uBGfphqWQ9FQQdBN5Yruv8HREkTL3nbYYdG86ELwZ/vUOL7zSlgPgvLdp4xU3heOLEWWev9W5Jg+eCDciEFSW3eowbJ/9KpVm3ymUw5yjpGyQsIzdOk3g2bK6iSieQJDHkpNBTwrwd/npQpk6oQjItXREMsS6i76sjmWfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285691; c=relaxed/simple;
	bh=U0Gn0t//61NcE2V7HLW8kCXK8kpdCukR4IEarbCLH8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGfK4RmXtP3c/M+a1r9WoACnRpvuSqfpJXrISs8++BAe3dm91PDUlLi0ArFg1pC/gNV3+ca7jJIxD8+KJZ9r5xv9jGsv/qp9UF9LkeQ/xB9yDKNKpwhiXzbkeyy8N6XH4DEFJLU6rBsirxz0l6E4eFf4sVyqMgJ6BeZW1z2UcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5LFNIWi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5LFNIWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X9DhKK2m7QcZXiUCD92zneV88reKDhif72ZZKy+sUcY=;
	b=B5LFNIWim9GWxxFOmtFJrgPiDsqfTl6S+36vOnw62TTLcA6wZznKVQfL2kG0lpY3Rf70P3
	ZwsSEF/bQ7PpgDYOL48HHM1QbIu4B/HgFVbzHEmcb6iEBHJT5ymCSa8HILP2+ETqh1Of2u
	4ki0+IPv/p0FABlFSy0gAPxI71UNfOM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-FgdQRH9NOE-ViRZy5_OD8w-1; Wed,
 20 May 2026 10:01:15 -0400
X-MC-Unique: FgdQRH9NOE-ViRZy5_OD8w-1
X-Mimecast-MFC-AGG-ID: FgdQRH9NOE-ViRZy5_OD8w_1779285674
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62AF918002FD;
	Wed, 20 May 2026 14:01:14 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 813FC1801A63;
	Wed, 20 May 2026 14:01:11 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 00/33] Test suite hardening, correctness fixes, and BPF optimization
Date: Wed, 20 May 2026 11:00:27 -0300
Message-ID: <20260520140104.112142-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The stalld functional test suite has accumulated significant
reliability and maintainability issues over time. Several tests
were silently passing due to missing assertions, shell scoping
bugs that discarded subshell results, and grep substring matches
causing false positives on multi-digit CPU systems. Massive
boilerplate duplication existed across the suite, timing-dependent
sleeps caused flakiness, and a daemon bug was discovered where
--force_fifo combined with single-threaded mode silently fell
back to adaptive mode instead of erroring out. Additionally, the
BPF queue_track backend suffered from an O(n) linear array scan
on every sched_wakeup event, consuming significant real-time
latency budget in Telco workloads.

This series addresses these issues in three areas. First, the
daemon's --force_fifo validation is fixed to reject the
incompatible single-threaded mode at startup. Second, the test
suite is overhauled by introducing eight shared helpers
(test_section, cleanup_scenario, find_starved_child,
init_functional_test, assert_stalld_rejects, assert_log_contains,
assert_success, and starvation/boost assertion helpers) that
replace duplicated validation patterns across all functional
tests. The tests are then hardened with proper assertions,
transitioned to fail-fast semantics where any failure immediately
aborts the run, and timing-dependent sleeps are replaced with
event-driven synchronization. The starvation_gen helper's signal
handler is fixed for async-signal safety. Legacy C test
infrastructure, stale documentation, and unreachable code are
removed. Third, the BPF queue_track backend replaces its per-CPU
linear array with a hash map keyed by (cpu, pid) for O(1) task
lookups, reducing thread latency from 5-6us to 3us on real-time
systems.

As a result, approximately seven previously silent tests now
correctly validate daemon behavior, the suite runs deterministically
via event-driven waits rather than fixed sleeps, and the BPF
backend eliminates its lookup overhead entirely. The series yields
a net reduction of roughly 9,850 lines (+874/-10,725).

Wander Lairson Costa (33):
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
  tests: Introduce and adopt process helpers
  tests: Extract wait_for_process_exit helper
  tests: Reduce default wait timeouts
  tests: Reduce starvation_gen durations
  tests: Replace init sleeps in test_affinity
  tests: Drop redundant sleeps in test_pidfile
  tests: Remove redundant sleeps after start_stalld
  tests: Reduce timing and replace sleeps with event waits
  tests: Fix async-signal-unsafe handler
  bpf: Replace linear task scan with hash map

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
 bpf/stalld.bpf.c                              |  206 ++-
 src/queue_track.c                             |   95 +-
 src/queue_track.h                             |  107 +-
 src/utils.c                                   |    9 +-
 tests/BACKEND_USAGE.md                        |  269 ----
 tests/CONTEXT_SNAPSHOT_2025-10-31.md          |  231 ----
 tests/Makefile                                |   29 +-
 tests/README.md                               |   29 +-
 tests/TODO.md                                 |  727 -----------
 tests/functional/test_affinity.sh             |  178 +--
 tests/functional/test_backend_selection.sh    |   24 +-
 tests/functional/test_boost_duration.sh       |  164 +--
 tests/functional/test_boost_period.sh         |  151 +--
 tests/functional/test_boost_restoration.sh    |  310 +----
 tests/functional/test_boost_runtime.sh        |  179 +--
 tests/functional/test_cpu_selection.sh        |   76 +-
 tests/functional/test_deadline_boosting.sh    |  266 +---
 tests/functional/test_fifo_boosting.sh        |  269 +---
 .../test_fifo_priority_starvation.sh          |  197 +--
 tests/functional/test_force_fifo.sh           |  196 +--
 tests/functional/test_foreground.sh           |   65 +-
 tests/functional/test_idle_detection.sh       |  195 +--
 tests/functional/test_log_only.sh             |   30 +-
 tests/functional/test_logging_destinations.sh |   38 +-
 tests/functional/test_pidfile.sh              |  166 +--
 tests/functional/test_runqueue_parsing.sh     |  417 ------
 tests/functional/test_starvation_detection.sh |  281 +---
 tests/functional/test_starvation_threshold.sh |  138 +-
 tests/functional/test_task_merging.sh         |  161 +--
 tests/helpers/starvation_gen.c                |    2 +-
 tests/helpers/test_helpers.sh                 |  356 +++--
 tests/legacy/README.md                        |  169 ---
 tests/legacy/test01.c                         |  506 --------
 tests/legacy/test01_wrapper.sh                |  161 ---
 tests/run_tests.sh                            |  149 +--
 53 files changed, 874 insertions(+), 10725 deletions(-)
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
2.54.0

