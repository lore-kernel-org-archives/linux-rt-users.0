Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159730C617
	for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2026 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781734566; cv=none; b=d8KbIZREZZ++tGIT0+jbrQuvpQ4+AtF1q6Tw+YTMprCm46ZK7g9zBj8EugWX0NdpTgEi5PtbnS/9ZZbNFu3yc5D60YvXQkhZRmzKzCYPgNBQUXvJC6N6vLHqNv4VaT4v2Cg2+BGDaTqtnM4Qj+5lqkT4y3/ph6jx8jr5Cz0LzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781734566; c=relaxed/simple;
	bh=iIwaAmWA9KUinw+g0uhcbTCjfe3h3fQRWTAaE2Um0t0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nif26w5wRWsN/we4CNA9TKcQ1pPyJ1US3jS6cFfnnfYJOWU07aTvHw0HJFsMHLdtndWsqsM3XgZduYzZoaedlB8/v6Qu7g8u4H5PgRxqO6HsbM1+7UnzRneb+HSACNWXEI5FNy8ZhqEAIpJ1uogSGfB1tvYKFdzzOghfuTOINX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZVmt05V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZVmt05V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB17E1F000E9;
	Wed, 17 Jun 2026 22:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781734565;
	bh=sX9S2yjlQVWsxgcHOLrtkWXfK6cUqguqxAyhubA2sHU=;
	h=Date:From:To:Subject;
	b=TZVmt05V/5vDmGQAHsaBj7u+PREBlSUMglgNq3HSwZ3scch35ks2bSyv0GoaNfg1g
	 AzDnuXnPN2V+pHMTAHYGZCJUB8/3QvlR6DydyQlIsXAIdSPDYGjVQE4NwTAibMvWFy
	 gSuMZJRVeCD50IhTKgwhkDRGRmkOELQtyC87m3FDhe2mEH+41SN65kiEN6FCenOLSm
	 T3EdBGzCxCwafVaGKDAAuI2cNkH1IqouY31K49FI7Sm6DhlsIEOz3b8WaIPn3obttg
	 1QnYmzsXugs3nroepzX07h7TnohuNPSpEeN+x9D2wjFw6JWZnwd4sNJB76//7QuKEp
	 v0V3U6CoLfoHA==
Date: Wed, 17 Jun 2026 17:16:03 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: wander@redhat.com, debarbos@redhat.com, juri.lelli@redhat.com,
	marco.chiappero@suse.com, chris.friesen@windriver.com,
	luochunsheng@ustc.edu, luffyluo@tencent.com, davidlt@rivosinc.com,
	clrkwllms@kernel.org, williams@redhat.com,
	linux-rt-users@vger.kernel.org
Subject: [ANNOUNCE] stalld v1.28.1
Message-ID: <ajMco4CZyWrgwnNs@lysander>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

stalld v1.28.1 is available at:

  https://git.kernel.org/pub/scm/utils/stalld/stalld.git

  tag: v1.28.1

This is a hardening and test reliability release. It contains 17 bug
fixes addressing buffer safety, data races, signal safety, type
correctness, and a logic error in starvation timing. There is one
behavioral change (--force_fifo rejection in single-threaded mode), one
BPF performance improvement (hash map replaces linear scan), and a
major test suite overhaul for reliability and speed.

Changes since v1.27.1:

Bug Fixes — stalld core:

  Memory safety & buffer handling:
  - Fix buffer underflow in read_proc_stat and sched_debug_get
  - Fix uninitialized buffer use in find_debugfs_mount_point
  - Fix missing null-termination in is_runnable
  - Fix snprintf truncation check in is_runnable
  - Remove NULL deref in fill_waiting_task error handler

  Type correctness:
  - Fix format string type mismatch for time_t
  - Fix format string type mismatch in set_cpu_affinity
  - Fix type mismatches in detect_task_format

  Concurrency & signal safety:
  - Fix data race on config_buffer_size
  - Fix data race on thread_running
  - Remove async-signal-unsafe calls from signal handler
  - Check pthread_create return in both aggressive_main and
    conservative_main

  Logic fixes:
  - Fix signed integer overflow in set_reservation
  - Fix error return in queue_track_get_cpu
  - Fix inverted DAEMON_UMASK value
  - Guard nextline() returns in sched_debug parsing
  - Use CLOCK_MONOTONIC for starvation detection

New behavior:
  - Reject --force_fifo in single-threaded mode (runtime validation)

BPF:
  - Replace linear task scan with hash map

Test infrastructure overhaul:

  New helpers and assertions:
  - assert_success(), assert_log_contains(), assert_stalld_rejects()
  - find_starved_child(), cleanup_scenario(), test_section()
  - wait_for_process_exit, process helpers, starvation/boost asserts
  - init_functional_test() consolidation

  Reliability fixes:
  - Fix subshell swallowing test results
  - Fix boost verification in runtime and duration tests
  - Fix journal flush race in logging destinations test
  - Fix async-signal-unsafe handler in tests
  - Fix repeated log match finding same line
  - Fix CPU selection grep substring matches
  - Fix task exit timing in test_boost_restoration

  Cleanup & speed:
  - Remove dead code, redundant sleeps, weak/assertion-free test blocks
  - Replace sleep-based waits with event waits
  - Reduce starvation_gen durations and default wait timeouts
  - Abort immediately on test failure

Chore:
  - Remove legacy test infrastructure and stale docs

 57 files changed, 969 insertions(+), 10781 deletions(-)

Contributors:
  Clark Williams (2):
        tests: Fix journal flush race in logging destinations test
        stalld: bump version to 1.28.1

  Wander Lairson Costa (52):
        stalld: Reject --force_fifo in single-threaded mode
        bpf: Replace linear task scan with hash map
        stalld: 16 bug fixes (see above)
        tests: 30 test infrastructure commits
        chore: Remove legacy test infrastructure and stale docs

Clark
-- 
The United States Coast Guard
Ruining Natural Selection since 1790
