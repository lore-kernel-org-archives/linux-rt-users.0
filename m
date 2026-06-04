Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F41375F6C
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Jun 2026 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597329; cv=none; b=gI4r8KAnD/sr5NMoc7QtaNrqzWzCoU6mofHQf4X9Jh96cbhNl9Yarn+NGLfMtIKihciL9EUw3pcphe+1dxGbJu4RLmj1EFvNC8rN127Ce7k2AW8TT1QviTz0DT7Vc+PouNLzXSbKFU+SjNPcEwrydXbQTPE45HgijKRZtt94a+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597329; c=relaxed/simple;
	bh=qUq40LNvtgLSdIozqJSxLr6bx5ayAxdYivNbRawXjF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqciKzgDyS6xNoHClhho40sAyuMHOktx3fIrPKQ0sNRv2hRp9sZNt1h8YFfHzp8Ig8y42wsGDPZZznjm7JLZd0GkHEBETej5Utfa6AWlsAzidMx/tNRnXlaCzbXE+u1ka2ayFDQZNrp14/AqdB51EA1pzGnJeVYAMx+7F7G/wEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCYZPN3G; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCYZPN3G"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-915336b83adso123139785a.2
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Jun 2026 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780597327; x=1781202127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VeeUKm/5dMglW7Nz1QsfBLXVi4qz0Nj8mHhaV7e+XYg=;
        b=fCYZPN3GBlVhwzsJs8JGVm0Tz1wHtpJtVreCL29ZHyt56QE9QafCZ1kogMPPqku9FR
         rxIshEP7j3/9Nk9Lug7Hn9RvHGxO4MI4cDLsbDxKO7Dzc4v8Ufnl+7zsiJjaoAMUeil7
         C2pOaPY/+KbawWGHs4oopJIbKHInL5HrGR4cm7yszXajP+YROVsb3ELhwEz0E3UAmTMW
         yrOJoZecf0KPpEImIfV/Q7t98yH5WtBas1JG4gurWHOaV2UgAShAYiuNLFlzwOPt6KFT
         PPZ0Ga4hvcvljycFiTJynKLcI3FDOTB3dHrDRDwzE31Yck3QgG3xfN4zxp1NhkcUshdV
         Ab0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597327; x=1781202127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeeUKm/5dMglW7Nz1QsfBLXVi4qz0Nj8mHhaV7e+XYg=;
        b=sc3lx/53UqGzJgZ3kjMfe20TM0l36mfKqdCcFjc6TWkbvFxF1zssQtsVzEXmdLOJSp
         9ffRKg9hbQjRtHyLXgt8AlDheqdYToKnFOwxty8JD3mUWj2k6xpJiDMNgHZ+5S9YYaZ6
         yPoSj6RkAmNR+YCfaIIMxuAC0Lo+yNqHLiLGZNdoZktvgOgUfXPTuSxr5KnybSrHcVJ1
         nCsbFraw71HzTpD4XfpgEuZmSSdSiYy3cJU34pbE4V095Fp0XJ26x65UTHfEgqE8GWrt
         QkIqVbnOEFOhLE1BoOdQKduxip2SIMpqxdMUpL+Fu2AgW71byPUx05Y6zge/UP1Q3NXr
         btDw==
X-Gm-Message-State: AOJu0YwzETpE3hgb9ILxWkxRtYpjz1jqR0+GyaoMLLMzLAQ6IpQMu30s
	usvJY/9nCji+iLcSN2UFbzerikbXJVpX1nO9GN0atZwVNvzDuiZcbTCcHOMyMQ==
X-Gm-Gg: Acq92OHSvsWk3CPT0j0CKsRzRtIl4wWG/RMgGMZPBJgskf5+oFuMgp0ddHyiPaVuYnf
	C9x0KyTJX3xET+1/5OXNtD0vhajIDE7ahNkWYAs/bVyYfrk+9NRnvvs+VJqpX/gTT4Me/B2LoBv
	Xx4Yt44Omt3btwHFa9k929F+UmtixEvkScPfF/5uM93XTsFAwQbyX/+WO2N5ytH/jC1Oh4FvUWK
	cRIphlp5PosTNIFHF5Sg0vhsToTs+DcL4trqhO4+6Yaw96sqwRvYJBUktoxK1/v449zPlQxjVqV
	AtTB8F/ppRhTLU+2AbLkzhuQgRWmLBbKcoXQs7JQHbKILD886L/mN3kSG9UZ4gWBizmAaKLsW2V
	rhWvmX4Mm/bL/EMvUkzl6kMvcXrfm4HaerpgE49s+I94iwEg1RSr4pnC3FkTy+m4wI5/De4XZXk
	vzdcpgHjG6I/N/N0IincWgaon0Y/3n9tMPemnbI372iC1136NVMaZZbr3FpC/EF//lFae4VqIFY
	2Mm6S3tHSv8kXvCrgtMqSKSXgEaAswizN7bynzdsIKBJkPoiZUIqN4QjtLJFUIwm2+UwgmQvviK
	dmWtGkJEorftMv58RlevZZIAzf4wcQ==
X-Received: by 2002:a05:620a:1d02:b0:915:8988:4e55 with SMTP id af79cd13be357-915a9d52781mr44505785a.40.1780597326718;
        Thu, 04 Jun 2026 11:22:06 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c4e6sm643584485a.26.2026.06.04.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:22:06 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	linux-kernel@vger.kernel.org,
	James Mills <jamills@redhat.com>
Subject: [ANNOUNCE] rteval-v3.11
Date: Thu,  4 Jun 2026 14:21:56 -0400
Message-ID: <20260604182156.113025-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rteval 3.11 Release Highlights:

Major New Features:

* cpuset support for cgroup v2 management - This is the biggest addition
  - New cpuset module and cpusetmanager for CPU isolation
  - --housekeeping option to reserve isolated CPUs
  - --cleanup-cpusets flag to remove leftover cpusets
  - Comprehensive test suite (732 lines of cpuset tests)

* Core sharing validation - New CPU topology awareness
  - Warns when measurement and load threads share CPU cores
  - --warn-non-isolated-core-sharing option
  - CoreSiblings class for topology queries

Critical Bug Fixes:

* Fix timerlat and cyclictest error handling to prevent hangs
* Fix timerlat module for rtla short option parsing bug

New Features:

* -L/--logging support added to both timerlat and cyclictest measurement modules

Code Quality & Testing:

* Major testing improvements - regression tests, reorganized unit tests, e2e test fixes
* New CpuList class with comprehensive unit tests for better CPU list handling

Documentation:

* Modernized documentation - updated man page (398 lines changed), new README-tests,
  added make uninstall target

Stats: 44 files changed, 4305 insertions, 517 deletions

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.11

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older

To accommodate distributions that require this, I have linked the last
version v3.10 from the older directory to the current directory

Bug reports, patches, etc are always welcome.

Enjoy!


John Kacur (37):
  rteval: Add cpuset module for cgroup v2 management
  rteval: Fix xmlout unit test XSL file path
  rteval: Add CpuList class to cpulist_utils module
  rteval: Migrate call sites to use CpuList class where beneficial
  rteval: Add unit tests for CpuList class
  rteval: Add --housekeeping option to reserve isolated CPUs
  rteval: Add CoreSiblings class for CPU core topology queries
  rteval: Add core sharing validation for CPU isolation
  rteval: Include core sharing warnings in XML report
  rteval: Add temporary test for core sharing validation with mocked
    isolated CPUs
  rteval: Display core sharing warnings in text report
  rteval: Add --warn-non-isolated-core-sharing option for measurement vs
    load warnings
  rteval: Include --warn-non-isolated-core-sharing warnings in XML
    report
  rteval: Clean timestamped test run directories in make clean
  rteval: Remove executable permission from cpuset.py
  rteval: Add cpuset integration infrastructure (WIP)
  rteval: Add --cleanup-cpusets flag to remove leftover cpusets
  rteval: Reorganize command-line arguments into logical groups
  rteval: Simplify cpuset implementation to match isolcpus philosophy
  rteval: Add local/ directory to .gitignore for development files
  rteval: Update cpuset documentation to reflect simplified
    implementation
  rteval: Warn when all CPUs isolated and loads have no CPUs
  rteval: Fix timerlat error handling to prevent hangs
  rteval: Fix cyclictest error handling to prevent hangs
  rteval: Update config files to clarify measurement module selection
  rteval: Add regression tests for measurement module error handling
  rteval: Fix e2e test patterns for current rteval behavior
  rteval: Refactor core sharing validation test into proper unittest
  rteval: Rename unittest target to unit-tests for consistency
  rteval: Organize cpuset tests and make core sharing tests skip
    gracefully
  rteval: Move run_tests.sh to tests/ and remove obsolete test scripts
  rteval: Add -L/--logging support to timerlat measurement module
  rteval: Add -L/--logging support to cyclictest measurement module
  rteval: Fix timerlat module for rtla short option parsing bug
  rteval: Modernize documentation
  rteval: Add make uninstall target and fix pyproject.toml license
  Create rteval-3.11

Tomas Glozar (2):
  rteval: Move unittest.py to tests/unittest-legacy.py
  rteval: Add README-tests

 .gitignore                                    |   2 +
 Makefile                                      |  79 +-
 README                                        | 122 ++-
 README-tests                                  | 102 +++
 doc/installing.txt                            |  23 -
 doc/{rteval.txt => rteval-legacy.txt}         |   2 +
 doc/rteval.8                                  | 398 +++++++---
 pyproject.toml                                |   2 +-
 rteval-cmd                                    | 261 +++++--
 rteval.conf                                   |   5 +-
 rteval/__init__.py                            |  12 +-
 rteval/cpulist_utils.py                       | 161 +++-
 rteval/cpupower.py                            |   4 +-
 rteval/cpuset.py                              | 350 +++++++++
 rteval/cpusetmanager.py                       | 224 ++++++
 rteval/modules/__init__.py                    |  30 +
 rteval/modules/loads/__init__.py              |   7 +-
 rteval/modules/loads/hackbench.py             |  10 +-
 rteval/modules/loads/kcompile.py              |  15 +-
 rteval/modules/loads/stressng.py              |   8 +-
 rteval/modules/measurement/__init__.py        |   6 +-
 rteval/modules/measurement/cyclictest.py      | 172 ++--
 rteval/modules/measurement/timerlat.py        | 388 ++++++----
 rteval/rteval.conf                            |  12 +
 rteval/rteval_text.xsl                        |  13 +-
 rteval/sysinfo/__init__.py                    |   3 +
 rteval/sysinfo/coresiblings.py                | 116 +++
 rteval/sysinfo/cputopology.py                 |  35 +
 rteval/systopology.py                         | 116 ++-
 rteval/version.py                             |   2 +-
 rteval/xmlout.py                              |   4 +-
 tests/cpusets/README.md                       | 199 +++++
 tests/cpusets/test-cpusets.sh                 | 732 ++++++++++++++++++
 tests/e2e/loads.t                             |   6 +-
 tests/e2e/measurement.t                       |   4 +-
 tests/regression/README.md                    | 155 ++++
 .../mock-cyclictest-partial-output.py         | 165 ++++
 .../mock-rtla-timerlat-partial-output.py      | 138 ++++
 .../test-cyclictest-error-handling.sh         | 225 ++++++
 .../test-timerlat-error-handling.sh           | 228 ++++++
 run_tests.sh => tests/run_tests.sh            |  10 +-
 tests/test_core_sharing_validation.py         | 155 ++++
 tests/test_cpulist_class.py                   | 121 +++
 .../unittest.py => tests/unittest-legacy.py   |   0
 44 files changed, 4305 insertions(+), 517 deletions(-)
 create mode 100644 README-tests
 delete mode 100644 doc/installing.txt
 rename doc/{rteval.txt => rteval-legacy.txt} (99%)
 create mode 100644 rteval/cpuset.py
 create mode 100644 rteval/cpusetmanager.py
 create mode 100644 rteval/sysinfo/coresiblings.py
 create mode 100644 tests/cpusets/README.md
 create mode 100755 tests/cpusets/test-cpusets.sh
 create mode 100644 tests/regression/README.md
 create mode 100755 tests/regression/mock-cyclictest-partial-output.py
 create mode 100755 tests/regression/mock-rtla-timerlat-partial-output.py
 create mode 100755 tests/regression/test-cyclictest-error-handling.sh
 create mode 100755 tests/regression/test-timerlat-error-handling.sh
 rename run_tests.sh => tests/run_tests.sh (87%)
 create mode 100755 tests/test_core_sharing_validation.py
 create mode 100644 tests/test_cpulist_class.py
 rename unit-tests/unittest.py => tests/unittest-legacy.py (100%)

-- 
2.54.0

