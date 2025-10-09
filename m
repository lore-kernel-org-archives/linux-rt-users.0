Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16926F2B8
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Oct 2025 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041669; cv=none; b=t25EPqMPc6t8Bt0K4t/T8YypPoBnwTAO+NVzw7W41sXnHMZ7BBwPWwX1DKtr45voZbTJSLnnr49R+Wrb1CLWahDcpbAqH9Lil2inlMl5l/tsqzzQx0syspvEC0dakxchrwWyIy04y/KM0aS7ZaGSQllQj5L9euv9B8B12TwRoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041669; c=relaxed/simple;
	bh=4qLZp9JXRBP0fLkYpSVOTLZOL+DxjDSup6EN7vVqxw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GERroeh/F+plUYHPBhDwCdAlfGvhEaGBPTE0jtk0ehyGmENbj/3D3eXtpOPV+S15mJ8PP/7042PMzY+rYvJI2CajWRHDPzw4qpx4knwtmzw/rpNR9AFhEwdl/ebd5pt59ZquGQ2olZBnElLyDpl/NG6yG3JSVLhOtVUI7kKMYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntcLXEej; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntcLXEej"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-79599d65f75so12937126d6.2
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Oct 2025 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760041666; x=1760646466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0+2XyHe/4In0MTAQyhO3Gb40wa8WqcUEM1FYMvBbAY=;
        b=ntcLXEejXoTHWmET9fO+hJKfj3/8DTerHq++YphhIkb5TV8gl4frzvFpAlqNr30+8i
         dNNFHftVBS1FSODJ8umveT3ChdBR0hOPijEQ0PEpfX3aJaAvn62ErdFlT2tAXPplCm0R
         IQuoj+PZnqNoJS09CK9XObkwFik45eMHebs7C/pL1LJ7Qz5FDeM3w+0Nu9p0ckQl6gYk
         mhqK6z5Vg9ImCEfeIahJ2jwttcDB11gc9ccxm/AazN0f/LpCxdScUhqIsOlI/3fs6LbF
         sxhXIThAEOi8Nk5UBixAbZzBzRgf8GXmFKJ0i3JytscYW3eGWUwd5w1nky3yJsHDlP1d
         hCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760041666; x=1760646466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0+2XyHe/4In0MTAQyhO3Gb40wa8WqcUEM1FYMvBbAY=;
        b=fTS+qM+MqCcOt3Dtnq4CtdGuYaAIhkCORVV1mY450sU+Y8ahfqlV1SJUovaGD2cWgR
         w5ZFWrLe6IFBi4tArA2fWNDObsipCPQPd2/+Ie4PagZdcE7+/0EqzeMkzrXRq0RYT5oH
         /q5/cBPisnlsjbD6slJWqsjjuAtIOFN3KLVD/IIs2h9DW2yOkkmHS/G5509BBY38zgff
         oL2Bh1s4VRnalX/uwa02OaL22V3TPF85h/z/+yiXMqsTJYtXCui4VDzMk2iIWzA6USu+
         WqWkFHxwm0zhuUe5T9kXgxg8Du6612DQ3cXILIBLsHGNoOgyiIITty8BVvHOcdfo7PJM
         uFew==
X-Gm-Message-State: AOJu0YwXoTHWB2HvnLxUe9tLhNRk+F9NehTuX23J8TIHnMz3718VoDc2
	NillLSEhYRvwxcnzuWLs6ivd0SHAaNxL/rRQ5ErFg/bVGjTpbVwjsThyQZ4iR8sYGHE=
X-Gm-Gg: ASbGncuXo7Zi8ohVBBipEOWZTBD3/B6//mJR8b6RrfHKrRT+TElTn0qnTRQK/rfvh6E
	mOLQAqO0tYWXtPXfSRc7lKw7sDNMmk354aZGhQ40JUqg7fGvXGmURTEPI4NEcT4cOh/dmrGSHts
	xGcHN/S9dYuvQF43wwyXsZCPrNH8OBammo7EvMHUmNcH9HQcHwNepLMHI/EPHTwykHgknLUOl1Q
	nl44caxd16FswTVKx1qD5zHO2rpBk2assjFzkq/qi+305OSjoQShuneewJuB71+CVfVsZGrG8yJ
	Z9C2BaczK3XnU31boE9a5KPjz+D+Gr+XL/eDXzAFtJHZ2aJ8nQHijeBgWk+MnFQk8wWnlmbdN7c
	w6eaOAR1Z0Hc4sBe6kXPzo1LfJt9Kgi4KhkjnwdOxZ5JbjUp6w9USEfI8x7b44+fykMun5AXXjs
	IgXSQCOmFFeyKAGlLQZCMmr+QXmPMxXpSzoc0=
X-Google-Smtp-Source: AGHT+IHwbSbXbu8tdhx4gGdN3Crca9goCEc2b7FQm0BddUBY99Go0eiVbGN5CyxI1xW0khn28BYSqQ==
X-Received: by 2002:a05:6214:48f:b0:852:eccb:62c5 with SMTP id 6a1803df08f44-87b2106d81emr120033566d6.20.1760041665968;
        Thu, 09 Oct 2025 13:27:45 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35713ccsm2664286d6.37.2025.10.09.13.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:27:44 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 2/4] python-linux-procfs: Modernize packaging and update authorship
Date: Thu,  9 Oct 2025 16:27:30 -0400
Message-ID: <20251009202732.57880-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009202732.57880-1-jkacur@redhat.com>
References: <20251009202732.57880-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- Remove six dependency from pflags (Python 3.10+ only)
- Add John Kacur as author in pyproject.toml and source files
- Update copyright statements to 2025
- Replace setup.py with pyproject.toml for modern packaging
- Add CLAUDE.md documentation for AI assistants

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 CLAUDE.md           | 102 ++++++++++++++++++++++++++++++++++++++++++++
 MANIFEST            |   2 -
 bitmasklist_test.py |   3 ++
 pflags              |  15 ++-----
 procfs/procfs.py    |   4 +-
 procfs/utilist.py   |   2 +-
 pyproject.toml      |  39 +++++++++++++++++
 setup.py            |  33 --------------
 8 files changed, 152 insertions(+), 48 deletions(-)
 create mode 100644 CLAUDE.md
 create mode 100644 pyproject.toml
 delete mode 100755 setup.py

diff --git a/CLAUDE.md b/CLAUDE.md
new file mode 100644
index 000000000000..7cfcc5c0a03c
--- /dev/null
+++ b/CLAUDE.md
@@ -0,0 +1,102 @@
+# CLAUDE.md
+
+This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.
+
+## Project Overview
+
+python-linux-procfs is a Python library that provides abstractions to extract information from the Linux kernel /proc filesystem. It's a GPL-2.0-only licensed library maintained by Red Hat developers, primarily for Linux system programming and process introspection.
+
+## Build and Test Commands
+
+### Installation
+```bash
+# Install the package locally for development
+python3 -m pip install -e .
+
+# Or using setup.py directly
+python3 setup.py install
+```
+
+### Testing
+```bash
+# Run the bitmasklist unit tests
+python3 bitmasklist_test.py
+```
+
+### Clean
+```bash
+# Remove temporary files and tags
+make clean
+
+# Remove only Python cache files
+make pyclean
+```
+
+### Tags Generation
+```bash
+# Generate ctags for code navigation
+make tags
+```
+
+## Architecture
+
+### Core Module Structure
+
+The library consists of a single `procfs` package with two main modules:
+
+**procfs/procfs.py** - Main module containing all /proc abstraction classes:
+- `pidstat` - Parses /proc/PID/stat files for process statistics
+- `pidstatus` - Parses /proc/PID/status files for additional process info
+- `process` - Combines stat and status data, lazy-loads cmdline, threads, cgroups, environ
+- `pidstats` - Collection of all processes in the system with find/search methods
+- `interrupts` - Parses /proc/interrupts for IRQ information
+- `cmdline` - Parses /proc/cmdline for kernel boot parameters
+- `cpuinfo` - Parses /proc/cpuinfo for CPU information and topology
+- `cpustat`/`cpusstats` - Parses /proc/stat for CPU usage statistics
+- `smaps`/`smaps_lib` - Parses /proc/PID/smaps for memory mapping information
+
+**procfs/utilist.py** - Utility functions for bitmask conversions:
+- `bitmasklist()` - Converts hex CPU affinity masks to lists of CPU numbers
+- `hexbitmask()` - Converts CPU number lists to hex bitmask format
+
+### Design Patterns
+
+1. **Lazy Loading**: The `process` class implements lazy loading via `__getitem__` - attributes like "stat", "status", "cmdline", "threads", "cgroups", and "environ" are only loaded when accessed.
+
+2. **Dictionary-like Interfaces**: Most classes implement dict-like access patterns (`__getitem__`, `keys()`, `values()`, `items()`, `__contains__`) for intuitive data access.
+
+3. **Ephemeral Process Handling**: Code throughout handles processes disappearing mid-query by catching `FileNotFoundError` and `IOError` exceptions.
+
+4. **basedir Parameter**: Most classes accept a `basedir` parameter (default "/proc") to support testing with mock /proc filesystems or accessing /proc from containers.
+
+### Key Implementation Details
+
+- **Process flags**: `pidstat` class defines PF_* constants matching kernel's include/linux/sched.h. Some flags have duplicate values representing kernel API changes (e.g., PF_THREAD_BOUND and PF_NO_SETAFFINITY both = 0x04000000).
+
+- **Thread handling**: Threads are loaded from /proc/PID/task/ with the thread leader (matching the PID) removed from the collection.
+
+- **CPU topology**: `cpuinfo` class calculates `nr_sockets` and `nr_cores` based on "physical id", "siblings", and "cpu cores" fields. Has special handling for s390/s390x architectures.
+
+- **Interrupt affinity**: The `interrupts` class reads both /proc/interrupts and /proc/irq/*/smp_affinity to provide complete IRQ information.
+
+## Command Line Tools
+
+**pflags** - Utility to display process flags for running processes:
+- Can filter by PID, process name, or glob patterns
+- Shows kernel process flags (PF_*) in human-readable format
+- Handles superseded flags (removes old flag names when new ones exist)
+- Note: Currently imports from `six.moves` which should be removed as Python 2 support is no longer needed (requires-python = ">=3.10")
+
+## Python Version Requirements
+
+- Minimum Python version: 3.10
+- The codebase has been migrated away from Python 2/3 compatibility
+- Still has one remaining `six` import in `pflags` that should be removed
+
+## Package Configuration
+
+The project uses modern Python packaging with both:
+- `pyproject.toml` - Modern build configuration (preferred)
+- `setup.py` - Legacy setup script for backwards compatibility
+
+Both files must be kept in sync for version numbers and metadata.
diff --git a/MANIFEST b/MANIFEST
index ebbd4998d03a..20742ff4ca73 100644
--- a/MANIFEST
+++ b/MANIFEST
@@ -5,5 +5,3 @@ pflags-cmd.py
 procfs/__init__.py
 procfs/procfs.py
 procfs/utilist.py
-rpm/SPECS/python-linux-procfs.spec
-setup.py
diff --git a/bitmasklist_test.py b/bitmasklist_test.py
index af26884c14b8..30197da5304f 100755
--- a/bitmasklist_test.py
+++ b/bitmasklist_test.py
@@ -1,5 +1,8 @@
 #!/usr/bin/python3
 # SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2025 Red Hat, Inc.
+# John Kacur <jkacur@redhat.com>
 
 """ Module to test bitmasklist functionality """
 
diff --git a/pflags b/pflags
index 46d396c87c2b..f5e107785166 100755
--- a/pflags
+++ b/pflags
@@ -1,24 +1,17 @@
 #! /usr/bin/python3
 # -*- python -*-
 # -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+#
 #   print process flags
-#   Copyright (C) 2015 Red Hat Inc.
+#   Copyright (C) 2015-2025 Red Hat, Inc.
 #   Arnaldo Carvalho de Melo <acme@redhat.com>
-#
-#   This application is free software; you can redistribute it and/or
-#   modify it under the terms of the GNU General Public License
-#   as published by the Free Software Foundation; version 2.
-#
-#   This application is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-#   General Public License for more details.
+#   John Kacur <jkacur@redhat.com>
 
 
 import procfs, re, fnmatch, sys
 import argparse
 from functools import reduce
-from six.moves import map
 
 ps = None
 
diff --git a/procfs/procfs.py b/procfs/procfs.py
index e3f9f44614ef..7e9459907d5f 100755
--- a/procfs/procfs.py
+++ b/procfs/procfs.py
@@ -3,7 +3,9 @@
 # -*- coding: utf-8 -*-
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Copyright (C) 2007-2015 Red Hat, Inc.
+# Copyright (C) 2007-2025 Red Hat, Inc.
+# Arnaldo Carvalho de Melo <acme@redhat.com>
+# John Kacur <jkacur@redhat.com>
 #
 
 import os
diff --git a/procfs/utilist.py b/procfs/utilist.py
index e36c739862a4..831ef85d51f1 100755
--- a/procfs/utilist.py
+++ b/procfs/utilist.py
@@ -3,7 +3,7 @@
 # -*- coding: utf-8 -*-
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Copyright (C) 2007 Red Hat, Inc.
+# Copyright (C) 2007-2025 Red Hat, Inc.
 #
 
 def hexbitmask(l, nr_entries):
diff --git a/pyproject.toml b/pyproject.toml
new file mode 100644
index 000000000000..01c4866add76
--- /dev/null
+++ b/pyproject.toml
@@ -0,0 +1,39 @@
+[build-system]
+requires = ["setuptools>=61.0"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "python-linux-procfs"
+version = "0.7.3"
+description = "Linux /proc abstraction classes"
+readme = "README.md"
+license = {text = "GPL-2.0-only"}
+authors = [
+    {name = "Arnaldo Carvalho de Melo", email = "acme@redhat.com"},
+    {name = "John Kacur", email = "jkacur@redhat.com"}
+]
+maintainers = [
+    {name = "John Kacur", email = "jkacur@redhat.com"}
+]
+requires-python = ">=3.10"
+dependencies = []
+classifiers = [
+    "Development Status :: 4 - Beta",
+    "Intended Audience :: Developers",
+    "License :: OSI Approved :: GNU General Public License v2 (GPLv2)",
+    "Operating System :: POSIX :: Linux",
+    "Programming Language :: Python :: 3",
+    "Programming Language :: Python :: 3.10",
+    "Programming Language :: Python :: 3.11",
+    "Programming Language :: Python :: 3.12",
+    "Topic :: System :: Operating System Kernels :: Linux",
+]
+
+[project.urls]
+Homepage = "https://www.kernel.org/pub/software/libs/python/python-linux-procfs"
+
+[tool.setuptools.packages.find]
+include = ["procfs*"]
+
+[tool.setuptools]
+script-files = ["pflags"]
diff --git a/setup.py b/setup.py
deleted file mode 100755
index 144e07e69e14..000000000000
--- a/setup.py
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/usr/bin/python3
-# SPDX-License-Identifier: GPL-2.0-only
-
-import os
-from os.path import isfile, relpath
-import sysconfig
-from setuptools import setup
-
-if isfile("MANIFEST"):
-    os.unlink("MANIFEST")
-
-SCHEME = 'rpm_prefix'
-if not SCHEME in sysconfig.get_scheme_names():
-    SCHEME = 'posix_prefix'
-
-# Get PYTHONLIB with no prefix so --prefix installs work.
-PYTHONLIB = relpath(sysconfig.get_path('platlib', SCHEME), '/usr')
-
-setup(name="python-linux-procfs",
-    version = "0.7.3",
-    description = "Linux /proc abstraction classes",
-    author = "Arnaldo Carvalho de Melo",
-    author_email = "acme@redhat.com",
-    url = "http://userweb.kernel.org/python-linux-procfs",
-    license = "GPLv2",
-    long_description =
-"""\
-Abstractions to extract information from the Linux kernel /proc files.
-""",
-    packages = ["procfs"],
-    scripts = ['pflags'],
-    install_requires = ['six'],
-)
-- 
2.51.0

