Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF877337BB8
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692995; cv=none; b=A+nA7kUzJNocoAIPeDFIHmkRx0xjCe2k1kIANirKp1BijqfHFmqCfl2H2o0o/IrH3/36Pw5LdyPFaEOfzhPoIGvcYsZSUvBoIHsGENiSUFjVkouById2ZuN+5NbVBx6Q6VA+NLN+IFzp4YXgJ9p/sE7U2OCxEO5jkwdCdGpv0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692995; c=relaxed/simple;
	bh=YINOJ7rU7bEldc/MdtNljH/i8v3mbo6I5YJln4yTppU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RC51nAO5QkeFVfISsLOPY9lJ3pma8uopU6dRiTc5avULUlUiKGA35HmVX6En3LJWOHccl7p9lXEHbhGtCp8VueLSCe4sLVh7ChyjwuYekn6wm9whg59z0wrzJQMySE4gnBMyQg+dx9NAMpnCK/0kwKv07V08Yh9L+QG7XY6cUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fk8IXABo; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk8IXABo"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-73a442f7cd3so292100137.3
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692992; x=1784297792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2yT9yqllZqCNtFMAdcu1ZW9rhx6OKEQLY8sM7pr0qfg=;
        b=Fk8IXABo2EU86HLsNn6vu+CIoAMfdAgT1UX25IOVlMoH+DEpAvrAubLFm1BVfNdeXn
         fTY2v58CuCoXWpUWJ3DUqlSR00QjgHr3uFBeZ3BQXMX75u/XiZ3eWbcZZuat+fJFyLbU
         LPAT3m0OKsPyVWBmQQbibjYf8qRAWJbpRcP5j9l0GOVecaZi2cAwks8TwpW4hIlUZLDo
         cAKvy3OYHTj8TPF/AoNTClk9shMnZSl4wTvH/52vtvZkqROtmoGJt5TKu/fBoirmyPRX
         +bxoA2lyaxtnb+Qcj7FlXNWX46IAlAYrI0UJxc5Jt260EXGf0LXRz3zNaEOYoXbFbdFX
         fOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692992; x=1784297792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2yT9yqllZqCNtFMAdcu1ZW9rhx6OKEQLY8sM7pr0qfg=;
        b=MwkZG0qWMkcfvt4+dlDKSQaFKerthiEhImZ3pTg2nQtSKLf8R6jMR1Qh2GcOMTl01C
         YTVzCFP8913GRG3wDT58kLwxkkO+1/P8IYFigtetP1MdB6/Q55q11Da+t1191bGrWHRK
         XXBLnRMaNtc5FWc6DdEqVMhky3V30TEWFWOQfroo8DF9EZNC+V9tx+AoFiByHFS7cI3s
         Z7i6iIVQHVfGWj12xDr2TJrmNERoZrJqOkl962Gv+tstlgyjPFOlsrm69uTyGkm841ml
         riESXs037Q3IBhBWcv+9K9TeIx9F/DSJzx8pxadwN1J8kCpujo+RtYwT3cVrkG5sCD9V
         4N8w==
X-Gm-Message-State: AOJu0YwJpZZtIt/krRQCfM5MSB7WGrKgMyEGMpFQMAjkaO261t7GBaf0
	cqzxY2NsWralItmuEnqWu51xeh6FHAy28M5RrsIH2sDIRMEeOeRj8ladPV/eHA==
X-Gm-Gg: AfdE7cnV7gMXtgU2LFVV7+iwxtehQEDfK5R32JJhseYedDiULDXVNacT7M0oPAely/+
	rJu29HuB/OcE69KHUmPtSEUlZ/BASYRFvJPJbXIDrYmAKwnXAAEMcnBDvtl9XLcENrO7pqfx8eu
	pOMTzV9Tyw+6Gmn3+nSTHGz2FklW/0xVvrBRXcuYvsi8KZIfb5hdFLqgTwH+fYKR5A5h9qWUfQ7
	w2+HoUrYIgqwFsuTvP90Q/eEScIVylKENWio/xalgL6+4UojpfMbFwc2/SSpGCnYq1CpoDxnKHT
	c9xGef0waC1dxOhm7ro7K7nwHdLvEb/XU2yvSMGRCfPJ4fLdU3audB86bLTepCmQs/etBvVOFEL
	L1mMmTOf/VUZjeU37ek3SsSV4yA5beGd5Fmhl7NEY5iBarYo39M3wW6hEDy2vZm7JbFAsnoWRtE
	8dlMnlEiToES3XlawAZ4MUrJcBmdle72kTzFBY8DfT6cONEsSccJ6AyHbaWbX5as37c6Q1Oh4ta
	Q==
X-Received: by 2002:a05:6102:f85:b0:739:77a7:90bc with SMTP id ada2fe7eead31-744e0334b31mr7237051137.23.1783692992202;
        Fri, 10 Jul 2026 07:16:32 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 29/36] tuna: Document high-level workflow vs manual primitives for cpusets
Date: Fri, 10 Jul 2026 10:15:07 -0400
Message-ID: <20260710141523.36440-30-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710141523.36440-1-jkacur@redhat.com>
References: <20260710141523.36440-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new section to tuna/cpuset_README.md explaining the difference
between high-level workflow commands (like 'tuna isolate --cpuset')
and manual primitives (like 'tuna cpuset create').

The documentation includes:
- High-level workflow example showing automatic cpuset setup
- Manual equivalent using primitive commands (create, migrate)
- Guidance on when to use each approach
- Design philosophy: primitives as Unix-style building blocks
  vs workflows that combine them for common tasks

This helps users understand:
- What 'tuna isolate --cpuset' does automatically (creates both
  isolated and housekeeping cpusets, migrates processes, sets
  NUMA nodes, configures partitions)
- How to replicate the same setup manually for custom workflows
- When to choose convenience vs fine-grained control

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/cpuset_README.md | 597 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 597 insertions(+)
 create mode 100644 tuna/cpuset_README.md

diff --git a/tuna/cpuset_README.md b/tuna/cpuset_README.md
new file mode 100644
index 000000000000..7ce75dc4eb84
--- /dev/null
+++ b/tuna/cpuset_README.md
@@ -0,0 +1,597 @@
+# tuna.cpuset - CPU Set Management for Tuna
+
+## Overview
+
+The `tuna.cpuset` module provides Python interfaces for managing CPU sets (cpusets) using Linux cgroup v2. Cpusets allow you to isolate CPUs by assigning processes to specific CPU groups, complementing the kernel's `isolcpus` boot parameter with userspace-level CPU isolation.
+
+This module was originally prototyped in tuna, implemented in rteval, and has been adapted back to tuna with tuna-specific enhancements.
+
+## Key Features
+
+### Core Functionality (rteval-compatible)
+- **Cpuset class**: Create and manipulate individual cpusets
+- **CpusetsInit class**: Detect cgroup v2 support and represent the root cgroup
+- **TaskMigrate class**: Migrate processes between cpusets
+- **Context manager support**: Automatic cleanup with `auto_destroy=True`
+- **NUMA awareness**: Multi-NUMA node support
+- **CPU partitioning**: Isolated vs member partition types
+
+### Tuna-Specific Enhancements
+- **Persistent cpusets** (default): Cpusets remain after program exits, unlike rteval's ephemeral approach
+- **Discovery functions**: List and find existing cpusets (including nested hierarchies)
+- **Cleanup utilities**: Destroy cpusets by pattern matching
+- **Flexible destruction**: Can destroy any cpuset, not just self-created ones
+- **Nested cpuset support**: Handles systemd, container, and user-created hierarchies
+
+## Requirements
+
+- **Linux kernel**: cgroup v2 support (kernel 4.5+, recommended 5.0+)
+- **Root permissions**: Required for creating/destroying cgroups
+- **Python**: 3.6+ (uses f-strings, type hints)
+
+### Checking cgroup v2 Support
+
+```python
+from tuna import cpuset
+
+ci = cpuset.CpusetsInit()
+if ci.supported:
+    print(f"cgroup v2 is supported, {ci.numa_nodes} NUMA nodes")
+else:
+    print("cgroup v2 is not supported on this system")
+```
+
+## Installation
+
+The module is part of tuna and doesn't require separate installation. Just ensure tuna is in your Python path:
+
+```python
+from tuna import cpuset
+```
+
+## Basic Usage
+
+### Example 1: Creating a Persistent Cpuset (Tuna Style)
+
+```python
+from tuna import cpuset
+
+# Create a persistent cpuset (default behavior)
+cs = cpuset.Cpuset('tuna_isolated')
+
+# Configure it (must set memory before CPUs in cgroup v2)
+cs.write_memnode('0')      # NUMA node 0
+cs.assign_cpus('0-3')      # CPUs 0-3
+
+# Optionally set as isolated partition
+cs.set_cpu_exclusive()
+
+# The cpuset persists after the program exits
+# Other programs can use it later
+```
+
+### Example 2: Using Context Manager for Automatic Cleanup (rteval Style)
+
+```python
+from tuna import cpuset
+
+# Create with auto_destroy=True for automatic cleanup
+with cpuset.Cpuset('temp_cpuset', auto_destroy=True) as cs:
+    cs.write_memnode('0')
+    cs.assign_cpus('4-7')
+
+    # Do work with the cpuset...
+
+# Cpuset is automatically destroyed when exiting the with block
+```
+
+### Example 3: Moving Processes to a Cpuset
+
+```python
+from tuna import cpuset
+import os
+
+# Create and configure cpuset
+cs = cpuset.Cpuset('workload_cpus')
+cs.write_memnode('0')
+cs.assign_cpus('8-15')
+
+# Move current process
+cs.write_pid(os.getpid())
+
+# Move another process
+cs.write_pid(12345)
+```
+
+### Example 4: Migrating All Tasks from Root to Cpuset
+
+```python
+from tuna import cpuset
+
+# Get root cgroup
+root = cpuset.CpusetsInit()
+
+# Create isolated cpuset
+isolated = cpuset.Cpuset('isolated_cpus')
+isolated.write_memnode('0')
+isolated.assign_cpus('0-7')
+
+# Migrate most tasks to isolated cpuset
+tm = cpuset.TaskMigrate(root, isolated)
+migrated, failed = tm.migrate()
+print(f"Migrated {migrated} tasks, {failed} failed")
+```
+
+### Example 5: Discovering Existing Cpusets
+
+```python
+from tuna import cpuset
+
+# List all cpusets
+all_cpusets = cpuset.list_cpusets()
+print(f"Found cpusets: {all_cpusets}")
+
+# List only tuna-created cpusets
+tuna_cpusets = cpuset.list_cpusets(pattern='tuna_*')
+print(f"Tuna cpusets: {tuna_cpusets}")
+
+# List with recursive search (finds nested cpusets)
+nested = cpuset.list_cpusets(pattern='systemd*', recursive=True)
+print(f"Systemd cpusets: {nested}")
+```
+
+### Example 6: Cleaning Up Cpusets
+
+```python
+from tuna import cpuset
+
+# Destroy a single cpuset
+cpuset.destroy_cpuset('tuna_isolated', force=False)
+
+# Destroy with force (migrates tasks to root first)
+cpuset.destroy_cpuset('busy_cpuset', force=True)
+
+# Bulk cleanup with pattern matching
+cpuset.cleanup_cpusets('tuna_*', force=True)
+
+# Cleanup nested hierarchies (destroys children before parents)
+cpuset.cleanup_cpusets('systemd/user*', force=True, recursive=True)
+```
+
+## API Reference
+
+### Classes
+
+#### `Cpuset(name, auto_destroy=False)`
+
+Core class for managing a single cpuset.
+
+**Parameters:**
+- `name` (str): Name of the cpuset (required)
+- `auto_destroy` (bool): If True, destroy on context manager exit (default: False)
+
+**Methods:**
+- `assign_cpus(cpu_str)`: Assign CPUs (e.g., "0-3,5,7")
+- `write_memnode(memnode)`: Set NUMA memory node (e.g., "0")
+- `write_pid(pid)`: Move a process to this cpuset (returns True/False)
+- `get_tasks()`: Get list of PIDs in this cpuset
+- `set_cpu_exclusive()`: Set as isolated partition
+- `unset_cpu_exclusive()`: Set as member partition
+- `destroy()`: Remove this cpuset (must be empty)
+
+**Properties:**
+- `cpuset_path`: Full path to cpuset (e.g., "/sys/fs/cgroup/tuna_0")
+- `cpuset_name`: Name of cpuset
+- `auto_destroy`: Whether to auto-destroy on context exit
+
+#### `CpusetsInit()`
+
+Represents the root cgroup and provides system information.
+
+**Properties:**
+- `supported`: True if cgroup v2 is available
+- `numa_nodes`: Number of NUMA nodes in the system
+- `cpuset_path`: Path to root cgroup ("/sys/fs/cgroup")
+
+**Methods:**
+- Inherits all methods from `Cpuset` class
+- Use to migrate tasks to/from root cgroup
+
+#### `TaskMigrate(cpuset_from, cpuset_to)`
+
+Helper class for bulk task migration.
+
+**Methods:**
+- `migrate()`: Migrate all tasks, returns (migrated_count, failed_count)
+
+**Attributes:**
+- `migrated`: Number of successfully migrated tasks
+- `failed`: Number of tasks that couldn't be migrated
+
+### Functions
+
+#### `list_cpusets(pattern=None, recursive=True)`
+
+List cpusets under `/sys/fs/cgroup`.
+
+**Parameters:**
+- `pattern` (str): Glob pattern to filter (e.g., "tuna_*")
+- `recursive` (bool): If True, search nested cpusets
+
+**Returns:** List of cpuset paths relative to /sys/fs/cgroup
+
+**Example:**
+```python
+# All cpusets
+all_cpusets = cpuset.list_cpusets()
+
+# Only tuna cpusets
+tuna_cpusets = cpuset.list_cpusets(pattern='tuna_*')
+
+# Top-level only
+top_level = cpuset.list_cpusets(recursive=False)
+```
+
+#### `destroy_cpuset(name_or_path, force=False)`
+
+Destroy a single cpuset.
+
+**Parameters:**
+- `name_or_path` (str): Cpuset name or full path
+- `force` (bool): If True, migrate tasks to root first
+
+**Raises:**
+- `OSError`: If cpuset doesn't exist or can't be removed
+- `ValueError`: If trying to destroy root cgroup
+
+**Example:**
+```python
+# Destroy empty cpuset
+cpuset.destroy_cpuset('tuna_isolated')
+
+# Destroy with tasks (migrates to root first)
+cpuset.destroy_cpuset('busy_cpuset', force=True)
+```
+
+#### `cleanup_cpusets(pattern, force=True, recursive=True)`
+
+Bulk cleanup of multiple cpusets.
+
+**Parameters:**
+- `pattern` (str): Glob pattern (e.g., "tuna_*")
+- `force` (bool): If True, migrate tasks before destroying
+- `recursive` (bool): If True, find and clean nested cpusets
+
+**Example:**
+```python
+# Clean all tuna cpusets
+cpuset.cleanup_cpusets('tuna_*', force=True)
+
+# Clean nested hierarchies (children destroyed before parents)
+cpuset.cleanup_cpusets('user/*', force=True, recursive=True)
+```
+
+## Testing
+
+### Running Tests
+
+The test suite uses Python's unittest framework:
+
+```bash
+# Run basic tests (no root required)
+python3 -m unittest tests.test_cpuset
+
+# Run all tests (requires root)
+sudo python3 -m unittest tests.test_cpuset -v
+
+# Run specific test class
+sudo python3 -m unittest tests.test_cpuset.TestCpusetCreation -v
+
+# Run basic functionality test script
+sudo python3 test_cpuset_basic.py
+```
+
+### Test Coverage
+
+- **TestCpusetsInit**: Initialization and cgroup v2 detection (no root needed)
+- **TestCpusetCreation**: Creating and destroying cpusets (requires root)
+- **TestCpusetConfiguration**: CPU/memory assignment (requires root)
+- **TestContextManager**: auto_destroy behavior (requires root)
+- **TestTaskMigration**: Process migration (requires root)
+- **TestDiscoveryFunctions**: list_cpusets() functionality (requires root)
+- **TestCleanupFunctions**: destroy_cpuset() and cleanup_cpusets() (requires root)
+
+## Key Differences from rteval
+
+| Feature | rteval | tuna |
+|---------|--------|------|
+| Default behavior | Ephemeral (auto-destroyed) | Persistent |
+| auto_destroy default | True (via context manager) | False |
+| Cleanup after exit | Automatic | Manual (or opt-in auto_destroy) |
+| Discovery functions | No | Yes (list_cpusets) |
+| Arbitrary destroy | No | Yes (destroy_cpuset, cleanup_cpusets) |
+| Nested cpuset support | Basic | Enhanced (recursive search) |
+| Primary use case | Testing (temporary isolation) | Environment setup (persistent) |
+
+## Architecture
+
+### Persistent vs Ephemeral Cpusets
+
+**rteval approach** (ephemeral):
+- Creates cpusets at start of measurement run
+- Uses them during testing
+- Destroys them automatically when run finishes
+- Cpusets don't persist after rteval exits
+
+**tuna approach** (persistent):
+- Creates cpusets that persist after tuna exits
+- Other programs use these cpusets after tuna has finished
+- Provides utilities to list and manage existing cpusets
+- Can destroy any cpuset (not just ones tuna created)
+
+### Context Manager Behavior
+
+```python
+# rteval style: auto-cleanup
+with cpuset.Cpuset('temp', auto_destroy=True) as cs:
+    # Use cpuset
+    pass
+# Cpuset is destroyed here
+
+# tuna style: persistent (default)
+with cpuset.Cpuset('persistent') as cs:
+    # Use cpuset
+    pass
+# Cpuset still exists here
+```
+
+## Nested Cpusets
+
+The module supports nested cpuset hierarchies created by systemd, containers, or users:
+
+```python
+# Create parent
+parent = cpuset.Cpuset('parent')
+parent.write_memnode('0')
+
+# Create child manually
+child_path = os.path.join(parent.cpuset_path, 'child')
+os.mkdir(child_path)
+
+# Discovery finds both
+all_cpusets = cpuset.list_cpusets(recursive=True)
+# Returns: ['parent', 'parent/child']
+
+# Cleanup handles nesting (children destroyed first)
+cpuset.cleanup_cpusets('parent*', recursive=True)
+```
+
+## Common Use Cases
+
+### 1. Isolate CPUs for Real-Time Workload
+
+```python
+from tuna import cpuset
+
+# Create isolated cpuset for RT tasks
+rt_cpuset = cpuset.Cpuset('realtime_cpus')
+rt_cpuset.write_memnode('0')
+rt_cpuset.assign_cpus('0-3')
+rt_cpuset.set_cpu_exclusive()
+
+# Move RT processes to isolated CPUs
+for pid in [1234, 5678]:
+    rt_cpuset.write_pid(pid)
+```
+
+### 2. Move Housekeeping Tasks Away from Critical CPUs
+
+```python
+from tuna import cpuset
+
+# Create cpuset for housekeeping
+housekeeping = cpuset.Cpuset('housekeeping')
+housekeeping.write_memnode('0')
+housekeeping.assign_cpus('4-7')
+
+# Migrate most tasks from root to housekeeping
+root = cpuset.CpusetsInit()
+tm = cpuset.TaskMigrate(root, housekeeping)
+migrated, failed = tm.migrate()
+```
+
+### 3. Setup and Teardown for Testing
+
+```python
+from tuna import cpuset
+
+# Setup: Create test environment
+def setup_test_cpusets():
+    # Housekeeping CPUs
+    hk = cpuset.Cpuset('test_housekeeping')
+    hk.write_memnode('0')
+    hk.assign_cpus('4-7')
+
+    # Isolated CPUs
+    iso = cpuset.Cpuset('test_isolated')
+    iso.write_memnode('0')
+    iso.assign_cpus('0-3')
+    iso.set_cpu_exclusive()
+
+    return hk, iso
+
+# Teardown: Clean up
+def teardown_test_cpusets():
+    cpuset.cleanup_cpusets('test_*', force=True)
+```
+
+### 4. Discover and Report Existing Cpusets
+
+```python
+from tuna import cpuset
+
+def report_cpusets():
+    """Generate a report of all active cpusets"""
+    all_cpusets = cpuset.list_cpusets(recursive=True)
+
+    for cs_name in all_cpusets:
+        cs_path = f"/sys/fs/cgroup/{cs_name}"
+
+        # Read configuration
+        with open(f"{cs_path}/cpuset.cpus") as f:
+            cpus = f.read().strip()
+        with open(f"{cs_path}/cgroup.procs") as f:
+            tasks = f.read().strip().split('\n')
+
+        print(f"{cs_name}:")
+        print(f"  CPUs: {cpus}")
+        print(f"  Tasks: {len(tasks)}")
+```
+
+### 5. High-Level Workflow vs Manual Primitives
+
+The `tuna isolate --cpuset` command provides a high-level workflow that automatically creates both isolated and housekeeping cpusets, migrates processes, and sets up kernel-enforced CPU isolation. For advanced users or custom setups, you can replicate this manually using the primitive cpuset commands.
+
+#### High-Level Workflow (Recommended)
+
+```bash
+# Automatic: Creates both cpusets, sets partition=isolated, migrates processes
+$ tuna isolate -c 0-1 --cpuset --cpuset-housekeeping 2-3
+
+# What happens automatically:
+# 1. Creates tuna_isolated cpuset with CPUs 0-1 (partition=isolated, empty)
+# 2. Creates tuna_housekeeping cpuset with CPUs 2-3 (partition=isolated)
+# 3. Auto-detects NUMA nodes for both cpusets
+# 4. Migrates all processes from root to tuna_housekeeping
+# 5. Leaves tuna_isolated empty and ready for RT workload
+```
+
+#### Manual Equivalent Using Primitives
+
+```bash
+# Step 1: Create isolated cpuset (partition=isolated, empty)
+$ tuna cpuset create -c 0-1 -n tuna_isolated --isolated
+
+# Step 2: Create housekeeping cpuset (partition=isolated)
+$ tuna cpuset create -c 2-3 -n tuna_housekeeping --isolated
+
+# Step 3: Migrate all processes from root to housekeeping
+# (This requires reading PIDs from root and moving them one by one)
+$ for pid in $(cat /sys/fs/cgroup/cgroup.procs); do
+    echo $pid > /sys/fs/cgroup/tuna_housekeeping/cgroup.procs 2>/dev/null || true
+done
+
+# Or use Python with the cpuset module:
+# >>> from tuna import cpuset
+# >>> root = cpuset.CpusetsInit()
+# >>> hk = cpuset.Cpuset('tuna_housekeeping', existing_ok=True)
+# >>> tm = cpuset.TaskMigrate(root, hk)
+# >>> migrated, failed = tm.migrate()
+```
+
+#### When to Use Each Approach
+
+**Use the high-level workflow** (`tuna isolate --cpuset`):
+- When you want complete CPU isolation setup in one command
+- For standard RT workload scenarios (isolated CPUs + housekeeping CPUs)
+- When you want automatic NUMA-aware configuration
+- For quick setup with best practices built-in
+
+**Use manual primitives** (`tuna cpuset create`, `modify`, `move`):
+- When you need fine-grained control over each cpuset
+- For non-standard configurations (e.g., multiple isolated cpusets)
+- When you want to create cpusets without immediate process migration
+- For scripting custom workflows or integration with other tools
+- When you need to modify existing cpusets incrementally
+
+#### Design Philosophy
+
+The primitive commands (`tuna cpuset create`, `modify`, `move`, etc.) are **building blocks** that follow the Unix philosophy: do one thing well. They give you complete control.
+
+The workflow commands (`tuna isolate --cpuset`, `tuna move --cpuset`) combine multiple primitives to accomplish common high-level tasks with sensible defaults.
+
+Both approaches are valid and coexist peacefully - choose based on your use case and level of control needed.
+
+## Troubleshooting
+
+### "Permission denied" errors
+
+Most operations require root permissions. Run with `sudo`:
+
+```bash
+sudo python3 your_script.py
+```
+
+### "cgroup v2 not supported"
+
+Check if cgroup v2 is enabled:
+
+```bash
+# Check mount
+mount | grep cgroup2
+
+# Should show:
+# cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime)
+
+# Enable cgroup v2 (if needed)
+# Add to kernel boot parameters: systemd.unified_cgroup_hierarchy=1
+```
+
+### "Invalid argument" when assigning CPUs
+
+In cgroup v2, you must set memory nodes before CPUs:
+
+```python
+# Correct order
+cs.write_memnode('0')    # First
+cs.assign_cpus('0-3')    # Then
+
+# Wrong order (will fail)
+cs.assign_cpus('0-3')    # Error!
+cs.write_memnode('0')
+```
+
+### Can't destroy cpuset: "Device or resource busy"
+
+The cpuset still has processes. Use `force=True` to migrate them first:
+
+```python
+cpuset.destroy_cpuset('busy_cpuset', force=True)
+```
+
+### Can't destroy parent cpuset: "Directory not empty"
+
+Destroy children before parents:
+
+```python
+# Manual approach
+os.rmdir('/sys/fs/cgroup/parent/child')
+os.rmdir('/sys/fs/cgroup/parent')
+
+# Or use recursive cleanup (handles ordering automatically)
+cpuset.cleanup_cpusets('parent*', recursive=True)
+```
+
+## Contributing
+
+When contributing to this module, please:
+
+1. Maintain compatibility with rteval's core API
+2. Keep tuna-specific enhancements clearly documented
+3. Add tests for new functionality
+4. Ensure tests can run both with and without root (use `@unittest.skipUnless`)
+5. Update this documentation
+
+## References
+
+- [Linux cgroup v2 documentation](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html)
+- [CPU management in cgroup v2](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#cpu)
+- [rteval cpuset implementation](https://git.kernel.org/pub/scm/utils/rteval/rteval.git/)
+
+## License
+
+SPDX-License-Identifier: GPL-2.0-only
+
+Copyright 2026 John Kacur <jkacur@redhat.com>
+
+Originally prototyped in tuna, implemented in rteval, and adapted back to tuna with enhancements.
-- 
2.54.0

