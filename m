Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720CC303C8A
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639235; cv=none; b=nosCxcKAj8N/vDxjfoaDi87vI28Qzgk0HC1k/7kwjus7A+7f+4bJwwnOdxXMqGgF/SK39r+hypdColfxKB9+hUXL2TvKg8vdtAvxvMo3fM3q4VWf/uG8uuYxbtbzHUGvr0LT6ESvIwb1lUJ8dg+X6W/L8tZ65/2UyGglBjK5cU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639235; c=relaxed/simple;
	bh=IxpgJnVD4R4wzjkNayNEZBXUocSEwT2of3RAE0b3Bfg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWvWQWI7ZFmvhKFKifLgNoXbbZyrhcx9hnX5+JPv+mZHUr6viiTriFBg5Yt+Ex9nzEJH9ZQGhvS2Ha/uPVRkh5bEgUXIvONco6C9SuCjUuVTaaMxOdQXPvEG5u4mB9vZ45EpGWM3xI3CJuCd/Z3f8sL3IGU/WkUKcQfePYcS0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaMTNOx0; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaMTNOx0"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ccda0ac4fcso53145316d6.2
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781639232; x=1782244032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHEjAhW31Vl99y6mqzO45iGRGqSt1IdaAqM9748IIfM=;
        b=aaMTNOx0j1B/RlRK06vpSlNh/Q8F1DL4aQZF9vSXBXS4+PxKj7sFCXqPU/7wr//Fgr
         KyXyptM2Y7wlMLfz92xG+GAQZptoclST+g9n5RFWSBLw7IMDm9zQzLgcIrCQkTj8GYLy
         QrekvGrGDZscG7xR7hl/sr1FkKAZO4s8HA+kPL0AYevup6JZnw2AwzX23sv7IluIOLlT
         TXDXuhs6KYVfG52g7R+J0MssVERI1KQZtXmi7nxr24IOJA/7B8CUm+Y4OlIMOOPn/BW8
         j8uIriOqq6kxnAvUitvpOZzwfjQfxoKqX4wAKsl+tl+bdmyOVzPhr6Ym9up5OrTJ9+0i
         MDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781639232; x=1782244032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHEjAhW31Vl99y6mqzO45iGRGqSt1IdaAqM9748IIfM=;
        b=WC7dB8jvh3WsDqSToPN4ezK/PiSdHZ3Kxv8EpJJQfSDYyTEHOZn/SBu2b51UGzb64K
         rhkJVbx7BbeDLdsh+rhHgc2DaJk9GVu+nTWQ2IMJdKgSTEMZwH3mb2wyf/t1Q73v53X/
         xfkEcqh1ndi8dTefO7RRGXRhWQnJUB0tbs8WY1pkvobwi0S/yw+MXBEi6e6StRUe2Tm5
         50cnIUDi3rWdKeGRg1ft9Y6TXMq3vSz2vobFjDKIIzQzpYNRqH5xOry0XtfNL9lvrQX9
         RPHZw0Q8ZjdsGPqxqpx3lqOp/6TAbNzv5o0wHUxiqWkBR85lNMGu/8IfHZ9GtK3lLfr1
         Kf8Q==
X-Gm-Message-State: AOJu0Yx40pWpzHU2xrSpZUrRGyV1bSq4l0A7lyHHaBDpMAjOJGzeplss
	elEVd1Wt1rcLqiMGthcnKXkuP7j20RBufj2ktoD3PmlX9EetBVt/v1ZCf68irQ==
X-Gm-Gg: Acq92OGkilRWk2XmJ/lMQ4zSCaWEQ6r3Kbmh9O8Z4ng9Z9ymnDTzVXb8A8XSDdlgFTR
	1CryQk98POMatKzWrJvqmoT09B3Zss3vr9iY9D+fWkTvp8DxlKeNeXYGVeUFuVJT88eDTZ/8NYm
	f/gxLjMlZ1NRjr9MqZ/ntcE6HV2ng2mfBV6dBMsLb9xaAB/4+Q/criCEaXp3vIQBerO2V2S6DUY
	/MwZUC346s7yfy5GBIHBftDUoyi6FBa0CiTY14OL2KXiTlnGZEqNor0Xww7os9f7cFm5A6M0skB
	2BLbZlCSJ9rLK4vQdf7psie7UyVsvTxJC4IpZzMt+kMvzgi8VfmBJ0ZfXa+Jmh2Ytv3EdBG1764
	UEEWmkXODLL2gyMvnV52JAj1kqTKsxSg3wqHN4rynMv/PPzPHMUNtnYXJGNP9AxOTza0yXLKZwP
	z9sORApXddsx6DdiRddYSrvdewA9bq4/QLP4XYDEieZn4CHeFCet4CgqB6e1/7gtVi6H9tWLFgv
	CCeFe2dwXjgAijiQkhgohE29krA70uqyDiXbpbw6462CcY52fkXmuiT4p1weOlDJ+HeY0lB5fH1
	cStidNXw
X-Received: by 2002:a05:6214:501d:b0:8da:8d23:8bba with SMTP id 6a1803df08f44-8db5cdf5286mr18719576d6.6.1781639231811;
        Tue, 16 Jun 2026 12:47:11 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f18f31d7sm43977906d6.12.2026.06.16.12.47.11
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:47:11 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH 2/2] python-linux-procfs: Add AGENTS.md and update copyright to 2026
Date: Tue, 16 Jun 2026 15:47:02 -0400
Message-ID: <20260616194706.382817-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616194706.382817-1-jkacur@redhat.com>
References: <20260616194706.382817-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add comprehensive AGENTS.md documentation for AI coding assistants
working with the python-linux-procfs codebase. This guide covers project
architecture, development guidelines, core components, usage examples,
and contribution workflow.

Replace CLAUDE.md with AGENTS.md to match the documentation format used
in other RT userspace programs (rteval, tuna, rt-tests).

Update copyright notices to 2026 in all source files to reflect current
year of modification.

Fix spelling: "superseeded" -> "superseded" in pflags comment.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 AGENTS.md           | 313 ++++++++++++++++++++++++++++++++++++++++++++
 CLAUDE.md           | 102 ---------------
 bitmasklist_test.py |   2 +-
 pflags              |   4 +-
 procfs/__init__.py  |   4 +-
 procfs/procfs.py    |   2 +-
 procfs/utilist.py   |   2 +-
 7 files changed, 320 insertions(+), 109 deletions(-)
 create mode 100644 AGENTS.md
 delete mode 100644 CLAUDE.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 000000000000..08e50b4d2243
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,313 @@
+SPDX-License-Identifier: GPL-2.0-only
+
+Copyright 2026 John Kacur <jkacur@redhat.com>
+
+# AGENTS.md - AI Coding Assistant Guide for python-linux-procfs
+
+This document provides guidance for AI coding assistants working with the python-linux-procfs codebase.
+
+## Project Overview
+
+**python-linux-procfs** is a Python library that provides abstractions to extract information from the Linux kernel /proc filesystem. It's used by system programming tools for process introspection, CPU topology detection, interrupt handling, and system state monitoring.
+
+- **License**: GPL-2.0-only
+- **Language**: Python 3.10+
+- **Primary Maintainer**: John Kacur <jkacur@redhat.com>
+- **Original Author**: Arnaldo Carvalho de Melo <acme@redhat.com>
+- **Repository**: https://git.kernel.org/pub/scm/libs/python/python-linux-procfs/python-linux-procfs.git
+
+## Architecture
+
+### Directory Structure
+
+```
+python-linux-procfs/
+├── procfs/                       # Core Python package
+│   ├── __init__.py              # Package initialization, exports all classes
+│   ├── procfs.py                # Main module with /proc abstraction classes
+│   └── utilist.py               # Bitmask utility functions
+├── pflags                        # Command-line utility to display process flags
+├── bitmasklist_test.py          # Unit tests for bitmask functions
+├── pyproject.toml               # Modern Python project metadata
+├── setup.py                     # Legacy setuptools configuration
+├── Makefile                     # Build targets (clean, tags)
+├── MANIFEST                     # Python packaging manifest
+├── COPYING                      # License file (GPL-2.0-only)
+└── .gitignore                   # Git ignore patterns
+```
+
+### Core Components
+
+The library consists of a single `procfs` package with two main modules:
+
+**procfs/procfs.py** - Main module containing all /proc abstraction classes:
+
+1. **Process Information Classes**
+   - `pidstat` - Parses /proc/PID/stat files for process statistics
+   - `pidstatus` - Parses /proc/PID/status files for additional process info
+   - `process` - Combines stat and status data, lazy-loads cmdline, threads, cgroups, environ
+   - `pidstats` - Collection of all processes in the system with find/search methods
+
+2. **System Information Classes**
+   - `interrupts` - Parses /proc/interrupts for IRQ information
+   - `cmdline` - Parses /proc/cmdline for kernel boot parameters
+   - `cpuinfo` - Parses /proc/cpuinfo for CPU information and topology
+   - `cpustat`/`cpusstats` - Parses /proc/stat for CPU usage statistics
+
+3. **Memory Information Classes**
+   - `smaps` - Parses /proc/PID/smaps for memory mapping information
+   - `smaps_lib` - Aggregates memory maps by library
+
+**procfs/utilist.py** - Utility functions for bitmask conversions:
+- `bitmasklist()` - Converts hex CPU affinity masks to lists of CPU numbers
+- `hexbitmask()` - Converts CPU number lists to hex bitmask format
+
+### Command Line Tools
+
+**pflags** - Utility to display process flags for running processes:
+- Can filter by PID, process name, or glob patterns
+- Shows kernel process flags (PF_*) in human-readable format
+- Handles superseded flags (removes old flag names when new ones exist)
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
+## Development Guidelines
+
+### Code Style
+
+- Follow PEP 8 Python style guidelines
+- Use 4-space indentation (no tabs)
+- SPDX license identifier at top of each file: `# SPDX-License-Identifier: GPL-2.0-only`
+- Use descriptive variable names
+- Add docstrings for modules, classes, and public methods
+- Docstrings should use Python 3 syntax (e.g., `print()` with parentheses)
+
+### Python Version
+
+- Target Python 3.10+ for compatibility with RHEL 9+
+- No Python 2 compatibility code needed
+- Use modern Python features (type hints encouraged)
+
+### Dependencies
+
+**Required**:
+- Python >= 3.10
+- No external dependencies (stdlib only)
+
+**Optional** (for development):
+- ctags (for code navigation)
+
+### Error Handling
+
+- Use exceptions for error conditions
+- Handle processes disappearing by catching `FileNotFoundError` and `IOError`
+- Handle binary data in /proc files with `UnicodeDecodeError`
+- Provide informative error messages
+- Return `None` for missing or inaccessible data
+
+## Build and Installation
+
+### Build Commands
+
+```bash
+# Run unit tests
+python3 bitmasklist_test.py
+
+# Clean Python cache files
+make pyclean
+
+# Generate ctags
+make tags
+
+# Full clean
+make clean
+```
+
+### Installation
+
+```bash
+# Install with pip (development mode)
+pip install -e .
+
+# Install with setup.py
+python3 setup.py install
+
+# Install via system package manager (Fedora/RHEL)
+dnf install python3-linux-procfs
+```
+
+## Testing
+
+### Test Structure
+
+**Unit Tests** (`bitmasklist_test.py`):
+- Tests for CPU bitmask/list conversions
+- Tests for hexbitmask generation
+- Run with: `python3 bitmasklist_test.py`
+
+### Important Testing Notes
+
+- Most functionality requires /proc filesystem access
+- Tests should handle permission errors gracefully
+- Docstring examples are illustrative but system-dependent (won't pass doctest on most systems)
+
+## Common Tasks
+
+### Using Process Information
+
+```python
+import procfs
+
+# Get all processes
+ps = procfs.pidstats()
+
+# Find process by name
+pids = ps.find_by_name("firefox")
+
+# Access process info
+if pids:
+    proc = ps[pids[0]]
+    print(proc["stat"]["comm"])      # Process name
+    print(proc["stat"]["state"])     # Process state
+    print(proc["status"]["VmRSS"])   # Resident memory
+```
+
+### Working with CPU Topology
+
+```python
+import procfs
+
+# Get CPU information
+cpus = procfs.cpuinfo()
+print(cpus.nr_cpus)           # Total CPU count
+print(len(cpus.sockets))      # Number of sockets
+print(cpus["model name"])     # CPU model
+```
+
+### Working with Interrupts
+
+```python
+import procfs
+
+# Get interrupt information
+interrupts = procfs.interrupts()
+
+# Find specific interrupt
+irq = interrupts.find_by_user("ethernet")
+if irq:
+    print(interrupts[irq]["affinity"])  # CPU affinity
+    print(interrupts[irq]["cpu"])       # Per-CPU counters
+```
+
+### Converting CPU Bitmasks
+
+```python
+from procfs import bitmasklist, hexbitmask
+
+# Convert hex mask to CPU list
+cpus = bitmasklist("f", 8)  # Returns [0, 1, 2, 3]
+
+# Convert CPU list to hex mask
+mask = hexbitmask([0, 2, 4], 8)  # Returns [0x15]
+```
+
+## Key Files
+
+- `procfs/procfs.py` - Core /proc abstraction classes
+- `procfs/utilist.py` - Bitmask utility functions
+- `pflags` - Process flags display utility
+- `pyproject.toml` - Modern Python project metadata
+- `setup.py` - Legacy setuptools configuration
+
+## Package Configuration
+
+The project uses modern Python packaging with both:
+- `pyproject.toml` - Modern build configuration (preferred)
+- `setup.py` - Legacy setup script for backwards compatibility
+
+Both files must be kept in sync for version numbers and metadata.
+
+## Common Gotchas
+
+1. **Process Disappearance**: Processes can vanish between enumeration and access - always handle FileNotFoundError
+2. **Binary Data in cmdline**: Some processes have binary/non-UTF-8 data in arguments - handle UnicodeDecodeError
+3. **Thread Leader**: When loading threads, the thread leader (TID == PID) is removed from the collection
+4. **basedir for Testing**: Use the `basedir` parameter to point to mock /proc filesystems for testing
+5. **CPU Topology on s390**: Special handling exists for s390/s390x architectures
+6. **has_key() Methods**: Classes define `has_key()` for backwards compatibility, but `key in obj` syntax is preferred
+7. **Docstring Examples**: Examples in docstrings are illustrative and won't pass doctest on most systems
+
+## Recent Changes
+
+Check `git log` for recent commits. Notable recent development:
+
+**Python 3 Migration:**
+- Updated docstring examples to use Python 3 print() syntax
+- Removed confusing TODO comment about UnicodeDecodeError handling
+- Updated copyright notices to 2026
+
+**Modernization:**
+- Added pyproject.toml for modern Python packaging
+- Removed Python 2 compatibility code
+- Added SPDX license identifiers
+- Updated copyright statements
+
+## Support and Contact
+
+- Maintainer: John Kacur <jkacur@redhat.com>
+- Mailing list: linux-rt-users@vger.kernel.org
+- Bug reports: Send to maintainer with mailing list CC'd
+
+## Git Workflow
+
+- **Main branch**: `main`
+- **Repository**: https://git.kernel.org/pub/scm/libs/python/python-linux-procfs/python-linux-procfs.git
+- **Patch submission**: Use standard git format-patch/send-email, send to maintainer with mailing list CC'd
+- **Mailing list**: linux-rt-users@vger.kernel.org
+
+### Development Workflow
+
+1. Make changes to code
+2. Run unit tests: `python3 bitmasklist_test.py`
+3. Test manually with specific use cases
+4. Update documentation if needed
+5. Submit patches to maintainer with mailing list CC'd
+
+## Additional Notes for AI Assistants
+
+1. **Python Version**: Target Python 3.10+ for RHEL 9+ compatibility
+2. **No External Dependencies**: Library uses only Python stdlib
+3. **Error Recovery**: Handle ephemeral processes and missing data gracefully
+4. **Dictionary Interface**: Most classes provide dict-like access for convenience
+5. **Lazy Loading**: Process attributes are loaded on-demand to minimize overhead
+6. **Kernel Versions**: Process flags and /proc file formats may vary across kernel versions
+7. **Architecture Support**: Code should work on x86_64, aarch64, ppc64le, s390x
+
+## Related Projects
+
+Projects that use python-linux-procfs:
+
+- **tuna**: Thread and IRQ tuning tool - https://git.kernel.org/pub/scm/utils/tuna/tuna.git
+
+---
+
+**Last Updated**: 2026-06-16
+**Document Version**: 1.0
diff --git a/CLAUDE.md b/CLAUDE.md
deleted file mode 100644
index 7cfcc5c0a03c..000000000000
--- a/CLAUDE.md
+++ /dev/null
@@ -1,102 +0,0 @@
-# CLAUDE.md
-
-This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.
-
-## Project Overview
-
-python-linux-procfs is a Python library that provides abstractions to extract information from the Linux kernel /proc filesystem. It's a GPL-2.0-only licensed library maintained by Red Hat developers, primarily for Linux system programming and process introspection.
-
-## Build and Test Commands
-
-### Installation
-```bash
-# Install the package locally for development
-python3 -m pip install -e .
-
-# Or using setup.py directly
-python3 setup.py install
-```
-
-### Testing
-```bash
-# Run the bitmasklist unit tests
-python3 bitmasklist_test.py
-```
-
-### Clean
-```bash
-# Remove temporary files and tags
-make clean
-
-# Remove only Python cache files
-make pyclean
-```
-
-### Tags Generation
-```bash
-# Generate ctags for code navigation
-make tags
-```
-
-## Architecture
-
-### Core Module Structure
-
-The library consists of a single `procfs` package with two main modules:
-
-**procfs/procfs.py** - Main module containing all /proc abstraction classes:
-- `pidstat` - Parses /proc/PID/stat files for process statistics
-- `pidstatus` - Parses /proc/PID/status files for additional process info
-- `process` - Combines stat and status data, lazy-loads cmdline, threads, cgroups, environ
-- `pidstats` - Collection of all processes in the system with find/search methods
-- `interrupts` - Parses /proc/interrupts for IRQ information
-- `cmdline` - Parses /proc/cmdline for kernel boot parameters
-- `cpuinfo` - Parses /proc/cpuinfo for CPU information and topology
-- `cpustat`/`cpusstats` - Parses /proc/stat for CPU usage statistics
-- `smaps`/`smaps_lib` - Parses /proc/PID/smaps for memory mapping information
-
-**procfs/utilist.py** - Utility functions for bitmask conversions:
-- `bitmasklist()` - Converts hex CPU affinity masks to lists of CPU numbers
-- `hexbitmask()` - Converts CPU number lists to hex bitmask format
-
-### Design Patterns
-
-1. **Lazy Loading**: The `process` class implements lazy loading via `__getitem__` - attributes like "stat", "status", "cmdline", "threads", "cgroups", and "environ" are only loaded when accessed.
-
-2. **Dictionary-like Interfaces**: Most classes implement dict-like access patterns (`__getitem__`, `keys()`, `values()`, `items()`, `__contains__`) for intuitive data access.
-
-3. **Ephemeral Process Handling**: Code throughout handles processes disappearing mid-query by catching `FileNotFoundError` and `IOError` exceptions.
-
-4. **basedir Parameter**: Most classes accept a `basedir` parameter (default "/proc") to support testing with mock /proc filesystems or accessing /proc from containers.
-
-### Key Implementation Details
-
-- **Process flags**: `pidstat` class defines PF_* constants matching kernel's include/linux/sched.h. Some flags have duplicate values representing kernel API changes (e.g., PF_THREAD_BOUND and PF_NO_SETAFFINITY both = 0x04000000).
-
-- **Thread handling**: Threads are loaded from /proc/PID/task/ with the thread leader (matching the PID) removed from the collection.
-
-- **CPU topology**: `cpuinfo` class calculates `nr_sockets` and `nr_cores` based on "physical id", "siblings", and "cpu cores" fields. Has special handling for s390/s390x architectures.
-
-- **Interrupt affinity**: The `interrupts` class reads both /proc/interrupts and /proc/irq/*/smp_affinity to provide complete IRQ information.
-
-## Command Line Tools
-
-**pflags** - Utility to display process flags for running processes:
-- Can filter by PID, process name, or glob patterns
-- Shows kernel process flags (PF_*) in human-readable format
-- Handles superseded flags (removes old flag names when new ones exist)
-- Note: Currently imports from `six.moves` which should be removed as Python 2 support is no longer needed (requires-python = ">=3.10")
-
-## Python Version Requirements
-
-- Minimum Python version: 3.10
-- The codebase has been migrated away from Python 2/3 compatibility
-- Still has one remaining `six` import in `pflags` that should be removed
-
-## Package Configuration
-
-The project uses modern Python packaging with both:
-- `pyproject.toml` - Modern build configuration (preferred)
-- `setup.py` - Legacy setup script for backwards compatibility
-
-Both files must be kept in sync for version numbers and metadata.
diff --git a/bitmasklist_test.py b/bitmasklist_test.py
index 30197da5304f..a54730989268 100755
--- a/bitmasklist_test.py
+++ b/bitmasklist_test.py
@@ -1,7 +1,7 @@
 #!/usr/bin/python3
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Copyright (C) 2025 Red Hat, Inc.
+# Copyright (C) 2025-2026 Red Hat, Inc.
 # John Kacur <jkacur@redhat.com>
 
 """ Module to test bitmasklist functionality """
diff --git a/pflags b/pflags
index f5e107785166..3adf21d0d9b6 100755
--- a/pflags
+++ b/pflags
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 #   print process flags
-#   Copyright (C) 2015-2025 Red Hat, Inc.
+#   Copyright (C) 2015-2026 Red Hat, Inc.
 #   Arnaldo Carvalho de Melo <acme@redhat.com>
 #   John Kacur <jkacur@redhat.com>
 
@@ -62,7 +62,7 @@ def main(argv):
             flags = ps[pid].stat.process_flags()
         except AttributeError:
             continue
-        # Remove flags that were superseeded
+        # Remove flags that were superseded
         if "PF_THREAD_BOUND" in flags and "PF_NO_SETAFFINITY" in flags:
             flags.remove("PF_THREAD_BOUND")
         if "PF_FLUSHER" in flags and "PF_NPROC_EXCEEDED" in flags:
diff --git a/procfs/__init__.py b/procfs/__init__.py
index 6deedf41c650..4c048a477b6c 100644
--- a/procfs/__init__.py
+++ b/procfs/__init__.py
@@ -3,10 +3,10 @@
 # -*- coding: utf-8 -*-
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Copyright (C) 2008, 2009  Red Hat, Inc.
+# Copyright (C) 2007-2026 Red Hat, Inc.
 #
 """
-Copyright (c) 2008, 2009  Red Hat Inc.
+Copyright (C) 2007-2026 Red Hat, Inc.
 
 Abstractions to extract information from the Linux kernel /proc files.
 """
diff --git a/procfs/procfs.py b/procfs/procfs.py
index 945f11471a2e..a2dddd35e93a 100755
--- a/procfs/procfs.py
+++ b/procfs/procfs.py
@@ -3,7 +3,7 @@
 # -*- coding: utf-8 -*-
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Copyright (C) 2007-2025 Red Hat, Inc.
+# Copyright (C) 2007-2026 Red Hat, Inc.
 # Arnaldo Carvalho de Melo <acme@redhat.com>
 # John Kacur <jkacur@redhat.com>
 #
diff --git a/procfs/utilist.py b/procfs/utilist.py
index 831ef85d51f1..f5ad302b7658 100755
--- a/procfs/utilist.py
+++ b/procfs/utilist.py
@@ -3,7 +3,7 @@
 # -*- coding: utf-8 -*-
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Copyright (C) 2007-2025 Red Hat, Inc.
+# Copyright (C) 2007-2026 Red Hat, Inc.
 #
 
 def hexbitmask(l, nr_entries):
-- 
2.54.0

