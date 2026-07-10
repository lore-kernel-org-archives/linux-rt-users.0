Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A028641E
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692949; cv=none; b=sy1GfRliB7bGjRM0SQwz5E2Pi4mVCIQOmdZD2Zz5nZR6haX1Q0ZrLdzAbZe2PbCWIv419zjf9k7JemRBersFO1Xf2FG9AASLNEFjdUx/BkRFkvNJMHi9g7s25qIxVD1ew0qR+EneEnWlY5NHD09HbU6kpah9N2x2L3HbaSsgBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692949; c=relaxed/simple;
	bh=Bh5M981VwX14Bu3Xi7tr42VskC7OfszLrzfmoveTaQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rKUcgxIuqzBx2RkqHIg+0EebDP/CsUEXeRMTITUQLu65BNlSNnQH6mcXQ3dZb8c4zDOOBqsV4ro/R9+LBYZplGAEyOa+LgEFYsVItcrHQm6Cdc+svLJa/M3n64Bvz0hrRGyBWW0GJv0Ystl09CCUCFA/Hexh/3ZrLtjqmfTdUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOHbT3X2; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOHbT3X2"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-737de525d2eso1100742137.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692947; x=1784297747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HvrmDRTCLzP01xySgOVqD4m4oi1MvhxCypAPgvp6h+k=;
        b=NOHbT3X2T2EsvlLntRlz2yoF5Pyfqb/aTprDVGlnzO2t8+TapYb+taWa+dVSg5lrMh
         yhb2OuRdATq8crTcQFdZAF5HxmS4rMMMFvHPOGMMSjbykxTX3NSmsEH6izJjjTk38KaI
         ItKp6aYEQ62z83BMYzFdfpJPS0+L6hHWdCvyeJtEbyp/NMbeJuKxEy6yajyCG1U8X66O
         VOj9w7gCziBPkDYaJhbk9K7IE+Ogkvpr/iUrJ1rXFgaY72pGLU8rPtKpcRoiqFDVUNqh
         U6w54XFcifk71AMeuRZPqxIEXIcf2pUVydiUOG/0OqCl2Pj0GSa5RserzYcHIRx8CrHC
         olGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692947; x=1784297747;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HvrmDRTCLzP01xySgOVqD4m4oi1MvhxCypAPgvp6h+k=;
        b=lFQLpL4U+jIQYOehFIHa6OiaJwMN43JhmRulG0xbipJDLHGRpPejZhoFBP478Du3s/
         J9GHBHryHxAMUDGoKZnd5l7gOI/hNFPgm12jCCyLr9Hg5l6X8fJGZL2iz8DbSTKOhrcA
         qL1CsemD1hRlZf6vWJWcwJNkupR8X7E+T/aIugc+m2IR6qMe7h8+t75bfNushBiHTBl9
         8LzVLN77hwG4s6Pze/6MGjBtBRMzBsVkPPO6LT9BwbgfhCPoLlDDSABjObyW968QwLym
         3CCK6cWVS9NRTasKMLWIpZ+k86ccha6Wk7NjnBVwR+PpCZ4n0LcP1EVONBs+caIHF4ZY
         GbMg==
X-Gm-Message-State: AOJu0YzmCq6gYP+jyjlT5loh+Z5oySjlv4tQBqLLPxPC5bOQD9Aco2tk
	9zg2elaBk2tUl/qtCvaeVDe1uGbfo7M0EfmMVCW1mo0zslcLqV6gpri5b8TK9Q==
X-Gm-Gg: AfdE7cnS1e++Mk+gSUnDLhh/D8BsY3k9QFGnYfCoLB8iw4RE8ugq+Nt8EKP7ZQ/hiO3
	AUDqv8G9k+mUKHw4ijmxZR8NeG60S8e5rPGOkCWo0c+6X5eue5zhfEaLQE6eAVo9ehVc2I3y7oy
	IOoSYpgzh2uWUI2JGccQyxiznjlbnJDFZ3cR3bdxLl6ZQfNecA3Gc6yXB3zcrQfXVJlELNUNhet
	SURw6TCTtjzNbdAQu91TtGvnqQ8xj1eiS9BrAsVcHcKhczWJdm/0rV+NBxHLMuzWC0F0rI9R6Nh
	Z80lSnTk+QQOACZGWiVy/qUD6Jzz7SEPqBzY2acmaLTnBhr64JGmT1N8iNgek3J8cX7CsO1cg4V
	9mfrgWJYji5EpTY/Mf9+0w75a4HhmXmcI383yoXV4Rau1xtqMRiIJSJdld4vRu0oEsttc0Wpi+p
	rvhWUMivn3HqDQRBePB+ExSjVTAS/2foGp5+oR8JLwz86LO5LhVCtTzHqEieYTHDWOi3x+LIBkG
	Q==
X-Received: by 2002:a05:6102:2920:b0:71e:39e9:ce5a with SMTP id ada2fe7eead31-744dfff5163mr8413538137.26.1783692947105;
        Fri, 10 Jul 2026 07:15:47 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:15:46 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 00/36] tuna: Add comprehensive cgroup v2 cpuset support
Date: Fri, 10 Jul 2026 10:14:38 -0400
Message-ID: <20260710141523.36440-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds comprehensive support for cgroup v2 cpusets to tuna,
providing a modern, container-based approach to CPU and memory node isolation
alongside the existing affinity-based mechanisms.

Background
==========

Traditional CPU isolation in tuna works by modifying process affinity masks
system-wide. While effective, this approach has limitations for complex
workloads that benefit from explicit container-based organization. Cgroup v2
cpusets provide kernel-enforced isolation with NUMA-aware memory node
assignment, making them ideal for real-time and high-performance computing
workloads.

This implementation maintains full backward compatibility with existing tuna
functionality while adding new cpuset-based workflows for users who need
stronger isolation guarantees.

Key Features
============

Core Infrastructure (patches 7-11):
- Complete cpuset module (tuna/cpuset.py) with context manager support
- NUMA-aware automatic memory node detection and assignment
- Process blocklist protection to prevent system instability
- Comprehensive test suite (146 tests: 45 non-root + 101 root-required)

Cpuset Management Commands (patches 12-23):
- create: Create cpusets with auto-naming (tuna0, tuna1, etc.)
- list: List cpusets with filtering and verbosity options
- destroy: Clean up cpusets individually or by pattern
- move: Migrate processes to cpusets with thread/PID support
- show: Display detailed cpuset information
- status: System-wide cpuset overview with statistics
- modify: Runtime modification of CPUs, memory nodes, and isolation

Integration with Existing Commands (patches 24-35):
- isolate --cpuset: Create isolated and housekeeping cpusets with automatic
  process migration
- move --cpuset: Move threads/IRQs to cpusets instead of setting affinity
- run --cpuset: Launch processes directly in cpusets
- show_threads --cpuset: Filter display by cpuset membership
- show_threads -G: Enhanced cgroup display showing cpuset names

General Improvements (patches 1-6):
- Pattern matching warnings with opt-in -w/--warn flag
- Enhanced what_is command with updated kernel thread descriptions
- Comprehensive docstrings for converter functions
- Centralized input validation for CPU numbers and RT priorities

Documentation and Testing
=========================

- Complete API documentation in tuna/cpuset_README.md
- Updated man page (docs/tuna.8) with full cpuset command reference
- 146 comprehensive tests with clear root/non-root separation
- Test documentation in tests/README.md
- Usage examples for common cpuset workflows

Design Decisions
================

- Skip empty cpusets by default in list/status commands to reduce noise
- Auto-detect NUMA nodes from CPU assignments for optimal performance
- Process blocklist prevents moving critical system processes (systemd, etc.)
- Cpuset and affinity modes are mutually exclusive per command
- Context managers ensure cleanup even when operations fail

All changes follow existing tuna coding style and commit message conventions.
The implementation has been tested on both single-node and multi-NUMA systems.

John Kacur (36):
  tuna: Warn when user-specified patterns match zero threads or IRQs
  tuna: Suppress output when pattern matches zero results
  tuna: Make warnings opt-in with -w/--warn flag
  tuna: Enhance what_is command with new kernel thread descriptions and
    usability improvements
  tuna: Add comprehensive docstrings to converter functions
  tuna: Add centralized input validation for CPU numbers and RT
    priorities
  tuna: Add cpuset module for CPU isolation using cgroup v2
  tuna: Add comprehensive test suite for cpuset module
  tuna: Add CLI commands for cpuset management
  tuna: Add comprehensive test suite for cpuset CLI commands
  tuna: Add comprehensive test targets and documentation
  tuna: Add cpuset move command for process migration
  tuna: Add comprehensive tests for cpuset move command
  tuna: Add NUMA-aware memory node assignment for cpusets
  tuna: Add tests for NUMA-aware memory node assignment
  tuna: Add process blocklist to prevent shutdown issues
  tuna: Add memory nodes and blocklist warnings to cpuset list
  tuna: Add cpuset show and status commands
  tuna: Add tests for cpuset show and status commands
  tuna: Dynamically find free CPU for test_cpu_exclusive
  tuna: Change cpuset commands to skip empty by default
  tuna: Add cpuset modify command
  tuna: Add tests for cpuset modify command
  tuna: Fix test_modify_cpus_empty_result for kernel constraints
  tuna: Add --cpuset option to move command
  tuna: Add tests for tuna move --cpuset command
  tuna: Add --cpuset option to isolate command
  tuna: Add tests for isolate --cpuset functionality
  tuna: Document high-level workflow vs manual primitives for cpusets
  tuna: Add --cpuset filter option to show_threads command
  tuna: Add tests for show_threads --cpuset filter
  tuna: Enhance show_threads -G to display cpuset names
  tuna: Add tests for cpuset name display in show_threads -G
  tuna: Add --cpuset option to run command
  tuna: Add tests for run --cpuset functionality
  tuna: Update man page for cpusets and current functionality

 Makefile                           |   26 +-
 docs/tuna.8                        |  201 ++++-
 tests/README.md                    |  360 +++++++-
 tests/test_cpuset.py               |  944 +++++++++++++++++++
 tests/test_cpuset_cli.py           | 1344 ++++++++++++++++++++++++++++
 tests/test_process_blocklist.py    |  139 +++
 tests/test_show_threads_cgroups.py |  199 ++++
 tests/test_show_threads_cpuset.py  |  245 +++++
 tuna-cmd.py                        | 1192 +++++++++++++++++++++++-
 tuna/cpuset.py                     |  820 +++++++++++++++++
 tuna/cpuset_README.md              |  597 ++++++++++++
 tuna/help.py                       |   26 +-
 tuna/tuna.py                       |  187 +++-
 13 files changed, 6165 insertions(+), 115 deletions(-)
 create mode 100644 tests/test_cpuset.py
 create mode 100644 tests/test_cpuset_cli.py
 create mode 100644 tests/test_process_blocklist.py
 create mode 100644 tests/test_show_threads_cgroups.py
 create mode 100755 tests/test_show_threads_cpuset.py
 create mode 100644 tuna/cpuset.py
 create mode 100644 tuna/cpuset_README.md

-- 
2.54.0

