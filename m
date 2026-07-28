Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F92346AC2
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274611; cv=none; b=jHuLF7PUUH1qajDiQsMZUSLrMmtITXLAmABYXW+0kVp9g1WdtPA7lPyz23C9gPIsB7w8eUJoGY/+eoL44NFNxZELAp/BZr0HArCQGM2AyaeG0Eq0bFPq5LqpnaBmgAhZ89vk3Mwl1TsLKr/c/+p6HI0J5zBriJUIrPduKBiyMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274611; c=relaxed/simple;
	bh=M0PDDD4ncZX618+hJ8WuzPgvBWEXbgN78BLYQGOVjKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lhBQaaRpmz3Tzkjdgk7MyX/VHa5KLQ5aXdA5889UcNEgc0qCmF3hTU1WhA397ZTczMPpe7brS3yXDrYZgSDeEO4hteUxqeYHK8q+u8G4KLdeP5QkiQTd2N+6Y9e8wV77KbbKHhv5PB9fA4t+CbVo0YfKrm8mdPStmnMtIJVyAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo45j8/o; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo45j8/o"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-526f963372aso2415411cf.1
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 14:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274608; x=1785879408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vbGxirBfHb+q+mDUa/rnyg77BAbay6Gvj4MUkkGvN8s=;
        b=Xo45j8/o1TaAPfXtv7hdcVcwqjjnGcHVAoJrMNOvWcs1dHD23CIiS22K9Volam1Awv
         KGFQWEBZS1GV1Yd6ABauYmU2rkEWMUb1a1Pa07/1uwFeSkVxC8sMrcDANn5iduXUsJBT
         OBKHQ93xONJJJY0hnFGUjGsNzmCt+WbzuBBXV8qlWaSkHniE2wG3Ezm0bDc+ubbzbSG1
         JdSiFfuC8+/+WGU07J2gqUTWoEGxd5FVoAqpV5d3o4a2KSP/83qZKKptz87CVydhiKM8
         VchS+REuFjawfsnURA7nyUqjZwT33SLkm4PxdzqpTDoSmCvBhTEHSiEaTnWEXmR6pmct
         7t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274608; x=1785879408;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vbGxirBfHb+q+mDUa/rnyg77BAbay6Gvj4MUkkGvN8s=;
        b=HVaEwRaFkdOJgmQmDMB1pE/VCYdwDal6u2PzMxJxT5FgDNSZp6KpzhZ/mw3QJQWgRo
         1/HQL9/FUdMpsqUZiDvB0eRtetvoB2ZoWlyjL2aKAJ0fKos1ZGJfpNjmnci04fKSY/0x
         unq8WQE5Hfvb+EU+d0IUT1f8EZZNxglJFtaDBQtPfAWno8w9zwy8n03L6Kov1poOis6G
         BH4lzQb6XM8+2piJkqay5wnZCOrDPqNU9nDSVQ9WZMLHSsd6HtZvHur1xXrA2qyXgaU1
         v6psLdGr+Xiq4P34NSY5E1X0WmDm/OU76dnst8SSg9RdsQPcXocKZc1oFqAyCE7V3jbm
         aTZg==
X-Gm-Message-State: AOJu0Yz+lr+alUAB/0Jy3U9yDqyyVnVfuYRU1pDdCye93AiL3s0obA5F
	eaHBqU8KEukmHRQtnr7teN+X5XvSHnxEDc4b0Y2mJLe3xQz4X0WfeX0Fp5kKBw==
X-Gm-Gg: AR+sD12pSNnT6eo1xnaiAsFnfYCuwx2vY3XT+Ccmsibsf8g8ohFY4AbotKYiwjyThw1
	2WCl3SSvgPFKZw2L2aK2MUY7y20hXZ5OoEvjNNDIyHTqsq4CwuXMGQZjgOgHBbdC3ejqx0GloR+
	/LIncLgkWb2dgzgZSqgUm5qJk3y8XSwbEoPaNyyQvqfld33Pkg6984WCfvMnLKROnB4zE0L+hjU
	8e9VW97q3ZfcxsnlFe1CjHwew6p/SjJVQWW1Rfga+HIxTYmclcs9kn/gbBAxEM3lKI72z42Qo53
	dbGrOPoDxwvGjBzqHMp0xUkT8cr/mjBUZ4d4iQEJonHGAj0MBxjbYs8HwKn3kN0ZFYHHzLusrRx
	YFOUlZt4jOIuDw0jH3VxB+dYS7R6cKbwVAfE/RyNHGhp5ltPe+3LTKQaHEFPfRaiSVrLbHnF/+T
	XiiR4ONgNNisDEG+LrBj1fzt5bM3SK7vGcGS4riT/9XZkR7DchuQ6lHKQnnHf7+6sBfJDEB3qvI
	UfQzhU=
X-Received: by 2002:a05:622a:244b:b0:51c:7b12:6007 with SMTP id d75a77b69052e-529d717db92mr42199501cf.83.1785274608465;
        Tue, 28 Jul 2026 14:36:48 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e29b88a7sm7025931cf.0.2026.07.28.14.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:36:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] tuna v0.21 released
Date: Tue, 28 Jul 2026 17:36:31 -0400
Message-ID: <20260728213631.285648-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Major Features:
- Complete cpuset support for CPU isolation using cgroup v2
  - Commands: create, list, destroy, move, show, status, modify
  - save/apply functionality for persisting cpuset configurations
  - Integration with isolate, move, run, and show_threads commands
  - NUMA-aware memory node assignment
  - Process blocklist to protect critical system processes
- Comprehensive testing infrastructure with unittest framework
- Context-aware default paths for cpuset profiles (git vs production)
- Intelligent path resolution for finding configuration files

Code Quality Improvements:
- Centralized version management (single source in tuna/version.py)
- Input validation for CPU numbers and RT priorities
- Eliminated global variables and argparse side effects
- Replace bare except clauses with specific exception types
- Enhanced kernel thread descriptions in what_is command

Documentation:
- Updated man page for cpuset functionality and recent changes
- Comprehensive test documentation
- AGENTS.md guide for AI coding assistants

Cleanup:
- Removed obsolete ChangeLog file (not updated since 2013)
- Removed obsolete tuna apply functionality
- Simplified GUI to monitoring-only functionality

Full commit list below.

To fetch tuna:
Clone one of the following
git://git.kernel.org/pub/scm/utils/tuna/tuna.git
https://git.kernel.org/pub/scm/utils/tuna/tuna.git
https://kernel.googlesource.com/pub/scm/utils/tuna/tuna.git

Branch: main
Tag: v0.20

Tarballs are here:
https://kernel.org/pub/software/utils/tuna/
older ones are here
https://kernel.org/pub/software/utils/tuna/older

Enjoy!

John Kacur

John Kacur (63):
  tuna: Disable the tuna apply functionality
  tuna: Remove tuna apply from the man page
  tuna: Print warning if setting affinity results in EPERM and continue
  tuna: Add testing infrastructure using unittest framework
  tuna: Fix setuptools deprecation warnings for license field
  tuna: Replace bare except clauses with specific exception types
  tuna: Eliminate side effects from argparse by deferring type
    conversions
  tuna: Eliminate global ps and irqs variables
  tuna: Add .local/ directory to .gitignore
  tuna: Add tests for converter functions and update test README
  tuna: Update copyright notices to reflect current maintainership
  tuna: Add AGENTS.md guide for AI coding assistants
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
  tuna: Add --show-system flag to filter systemd cpusets
  tuna: Add cpuset save/apply functionality
  tuna: Add comprehensive tests for save/apply functionality
  tuna: Remove obsolete apply command functionality
  tuna: Simplify GUI to monitoring-only functionality
  tuna: Change housekeeping cpuset default to partition=member
  tuna: Change default profile filename to cpuset-profile.yaml
  tuna: Improve process migration messaging clarity
  tuna: Allow cpuset destroy to accept multiple names
  tests: Update cpuset_destroy test calls for new parameter name
  tuna: Remove obsolete ChangeLog file
  tuna: Use context-aware default path for cpuset profiles
  tuna: Update man page for cpuset save/apply and recent changes
  tuna: Add intelligent path resolution for cpuset apply
  tuna: Get the tuna version from a single source

 .gitignore                         |    1 +
 AGENTS.md                          |  415 ++++++++
 ChangeLog                          |  152 ---
 Makefile                           |   33 +
 docs/tuna.8                        |  261 ++++-
 po/LINGUAS                         |    3 -
 po/POTFILES.in                     |   17 -
 po/ja.po                           |  718 --------------
 po/pt_BR.po                        |  634 ------------
 po/zh_CN.po                        |  667 -------------
 pyproject.toml                     |    8 +-
 setup.py                           |    5 +-
 tests/README.md                    |  542 +++++++++++
 tests/run_tests.sh                 |   25 +
 tests/test_converters.py           |  160 ++++
 tests/test_cpuset.py               |  944 ++++++++++++++++++
 tests/test_cpuset_cli.py           | 1370 ++++++++++++++++++++++++++
 tests/test_eperm_handling.py       |   87 ++
 tests/test_process_blocklist.py    |  139 +++
 tests/test_save_apply.py           |  300 ++++++
 tests/test_show_threads_cgroups.py |  199 ++++
 tests/test_show_threads_cpuset.py  |  245 +++++
 tuna-cmd.py                        | 1433 +++++++++++++++++++++++++---
 tuna/__init__.py                   |    3 +-
 tuna/config.py                     |    2 -
 tuna/cpuset.py                     |  820 ++++++++++++++++
 tuna/cpuset_README.md              |  597 ++++++++++++
 tuna/gui/__init__.py               |    3 +-
 tuna/gui/profileview.py            |    4 +-
 tuna/help.py                       |   27 +-
 tuna/profile.py                    |  177 ++++
 tuna/tuna.py                       |  191 +++-
 tuna/tuna_gui.glade                |    8 +-
 tuna/version.py                    |    7 +
 34 files changed, 7794 insertions(+), 2403 deletions(-)
 create mode 100644 AGENTS.md
 delete mode 100644 ChangeLog
 delete mode 100644 po/LINGUAS
 delete mode 100644 po/POTFILES.in
 delete mode 100644 po/ja.po
 delete mode 100644 po/pt_BR.po
 delete mode 100644 po/zh_CN.po
 create mode 100644 tests/README.md
 create mode 100755 tests/run_tests.sh
 create mode 100644 tests/test_converters.py
 create mode 100644 tests/test_cpuset.py
 create mode 100644 tests/test_cpuset_cli.py
 create mode 100644 tests/test_eperm_handling.py
 create mode 100644 tests/test_process_blocklist.py
 create mode 100644 tests/test_save_apply.py
 create mode 100644 tests/test_show_threads_cgroups.py
 create mode 100755 tests/test_show_threads_cpuset.py
 create mode 100644 tuna/cpuset.py
 create mode 100644 tuna/cpuset_README.md
 create mode 100644 tuna/profile.py
 create mode 100644 tuna/version.py

-- 
2.55.0

