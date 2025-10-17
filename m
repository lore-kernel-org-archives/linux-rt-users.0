Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1EB4A21
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760670959; cv=none; b=sE59e7JkLq0lg/NERuYo8SyA4yObRXKzA2/vbeny5FUVk2Bn2r4dh6TV/kZirSvL1P2WWqU6nErEOAhvJKMH9hlRWHRyVVLDn/3EA8mcsdkw1l9uIjb4PJFoG7xeG83Byt21Pq9vNi70TR/Pz/M3W6hBCPmmzM750CswSrYyvJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760670959; c=relaxed/simple;
	bh=H+cRUHRpZ4hLdkaOUOh0thhoNuqN5HaMlcTabicU9ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-type; b=D7iiPgEyPngNJ+A7am4PAt8NG9BQt7x6FL66RD+a62zPHwVd2WcP4zMHIZmCe9eNBr7dUiWF4dnG/qCpiNkrrQXBB7hKe/zlQ5PaTAAqUr5tdUZddX0SxkvEOfytFfviTcAlrnH9OP8TSE+fFV97RXwTzkfuP8l3LgPaiUs5a/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b907l1+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b907l1+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB67FC4CEF1;
	Fri, 17 Oct 2025 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760670958;
	bh=H+cRUHRpZ4hLdkaOUOh0thhoNuqN5HaMlcTabicU9ug=;
	h=From:To:Cc:Subject:Date:From;
	b=b907l1+mOrCJ9yj+zTKnOICc568Glu55jSYGtBilqLWxMTyWaRtw+ou2c8Axrwr7u
	 SeKw6YEU6ov21ejFt7QP3bxKuh8IZG345ku8sg9PGZLCriMQmFYtbd4Adj1NGHNkdd
	 DWCExsUPOv8GfKR2gpT5kXVTCYwwckpeIdEtXM0iX2Vy9nVePXIZlQZbR3bjdayHCe
	 abEJ6WM3Fio7T3H6bwPc62A8+FIcxHcm4RoC/teemI3SnTUakyxpkzDzPILFxLyhJU
	 Qkzqqc2XO3f0YYFahT7Eq9WXuFsxQNfCjeMaXNa//9+LPOOrV65/qpCKgoOfa9j93/
	 4pYViOn3TZKyg==
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	wander@redhat.com,
	debarbos@redhat.com,
	marco.chiappero@suse.com,
	chris.friesen@windriver.com,
	luochunsheng@ustc.edu
Subject: [PATCH 00/12] stalld: sched_debug parser refactoring and stability fixes
Date: Thu, 16 Oct 2025 22:15:57 -0500
Message-ID: <20251017022304.118722-1-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.51.0
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit

This patch series refactors the sched_debug backend parser to support
multiple kernel versions, fixes critical crashes, and enhances stalld's
robustness and testing capabilities. Note that if you aren't interested
in playing with patches you get pull the 'parser' branch from:

   https://github.com/clrkwllms/stalld

I'd appreciate some review. 

The series is organized into three logical groups:

## sched_debug Parser Refactoring (Patches 1-3)

The first group modernizes the sched_debug task parser to handle format
variations across kernel versions from 3.x through 6.12+:

  - Patch 1 unifies the OLD/NEW parsing code paths into a single
    word-based parser with detected field offsets, eliminating code
    duplication and improving maintainability.

  - Patch 2 fixes critical parsing logic errors including state
    filtering for NEW_TASK_FORMAT ('>R', 'R', 'X' states), corrects
    the skip2word() function to properly position at word boundaries,
    and fixes buffer allocation to include null terminators.

  - Patch 3 resolves a double-free crash in fill_waiting_task() by
    explicitly setting cpu_info->starving = NULL on early returns,
    preventing freed memory from being accessed on subsequent iterations.

## stalld Core Improvements (Patches 4-9)

The second group enhances stalld's logging, testing capabilities, and
runtime robustness:

  - Patches 4-6 improve logging quality: removing noisy idle reports,
    initializing idle_time to -1 to force initial queue checks, and
    removing misleading DL-server messages.

  - Patch 7 adds missing starvation logging in single-threaded log-only
    mode, ensuring consistent behavior across threading modes and fixing
    test_log_only.sh failures.

  - Patch 8 introduces -N/--no_idle_detect flag to disable idle CPU
    detection optimization, critical for controlled test environments.

  - Patch 9 adds defensive NULL checks and bounds validation in
    print_boosted_info() to prevent segfaults during task boosting.

## Build System and Final Fixes (Patches 10-12)

The final group adds legacy kernel support and resolves a remaining
crash in adaptive/aggressive modes:

  - Patch 10 adds comprehensive legacy 3.x kernel build support,
    detecting kernel version and adjusting compilation flags, disabling
    BPF/CET on legacy systems, and defaulting to sched_debug backend.

  - Patch 11 fixes a bash syntax error in run-local.sh for
    compatibility with bash 4.2.x on legacy systems.

  - Patch 12 fixes a critical segfault in adaptive/aggressive modes by
    guarding update_cpu_starving_vector() calls with config_single_threaded
    checks, since cpu_starving_vector is only allocated in single-threaded
    mode.

## Testing

This series has been tested across multiple kernel versions and
threading modes:
  - Legacy 3.x kernels with OLD_TASK_FORMAT
  - Modern 4.18+ kernels with NEW_TASK_FORMAT
  - 6.12+ kernels with EEVDF field additions
  - Single-threaded, adaptive, and aggressive modes
  - Log-only mode with starvation detection
  - Idle detection disabled mode for testing

Clark Williams (10):
  sched_debug: Unify parsing methods for task_info
  sched_debug: Fix runqueue task parsing logic and state filtering
  sched_debug: Fix double-free crash in fill_waiting_task()
  stalld.c: remove noisy idle report and added report to
    should_skip_idle_cpus()
  stalld.c: initialize cpu_info->idle_time to be -1
  stalld.c: get rid of misleading print about DL-Server
  stalld.c: Add starvation logging in single-threaded log-only mode
  stalld: Add -N/--no_idle_detect flag to disable idle detection
  stalld: Add defensive checks in print_boosted_info
  Fix segfault in adaptive/aggressive modes

Derek Barbosa (2):
  Makefile: Add support for legacy kernels
  scripts: fix run-local if bashism

 Makefile             |  40 +++-
 scripts/run-local.sh |   2 +-
 src/sched_debug.c    | 437 ++++++++++++++++++++++---------------------
 src/sched_debug.h    |  65 ++++++-
 src/stalld.c         |  59 ++++--
 src/utils.c          |   8 +-
 6 files changed, 377 insertions(+), 234 deletions(-)
