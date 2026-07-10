Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6C30EF68
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692960; cv=none; b=Z3rQSHi/odfgSx3ecOFhGPF0VOh2lym97S0g+ExNQ5IM7/Im26SA/T7FP3eWM1Ahlji5AfDtA1OIGoKl7j6m5AFfWOQy5E4pVs1JHsK2/f+hIqRV/9ZS8pkI7DjV4mGzfXG4bLR0+DBhXjg//GsFkioiklRiS0/nG1IOn6vN+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692960; c=relaxed/simple;
	bh=8qARpRoFYCGa/nmGCIMKQ1r+Liry+hWQ5Hj5ych6IuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oir4y2gUiAe4XIVWXWML8I2zc863habZQJXh4B87rRFFzrouqZ5F18PGJjWTn3xQgWx8rbM5JIk2BnfBGUXpJJbW+pNXIUZExsd4nhYJlexiunaHHdBue8AZTmUC81y2uN7KvkaEh1ZJrolab5Yxs7mSNYmqdo6076y+a0BECGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxkrQ825; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxkrQ825"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-73770fd1b65so301398137.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692957; x=1784297757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4K50HG23BuZ+QBIwyl1S4ErK6fDWHhTlo2QCBdsdSnc=;
        b=jxkrQ825JDKNErm7B1oZiITsxzrz9qseCCjMsoKbwZ/ZreL+XgIVwJpBeGYuxLPHMy
         /j7wuwDwKXZt8ko1Myiyvgi7Dn2a2b4QAEPwE3EWgnrnzZS1vcUkBd2O4DHhPatrZS/B
         VxXddQ30CPuOqSIg7BKL8omn3FvfzCJTkU0NCJk49tLdrMIrjnQ43Ewe7+unl3orkOqE
         AuKLc0oJEB0zWcSZjoIkl22HcLIx1k0QAkTJw7gI2uyF39bLmRC/W1WiKet/TKlDjNTH
         L0EIi0BHX00lXyeVDWhaiTVdLcNnGMn8id4terFbaShg+1ZPUtWr5JJNZ8UmiMxphDYA
         n4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692957; x=1784297757;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4K50HG23BuZ+QBIwyl1S4ErK6fDWHhTlo2QCBdsdSnc=;
        b=IeIWV1XC8FbkM0MZjqxn2iv1Zk3U/cmjs35E+w2uWBLFwFkkLi31Ad44kODqahWJFl
         4lJUiUgufH7I5LM+h5LWQaUGr1DuOG7KNA66xGg/nD8sh8SbTfXFoLURihhCvqtS7ZUo
         +90xTe8zb7LrYgJmrTagogoV+qgBnMQoSz3KbdGnhvqXIKxBl/eXjc99Uz7x0klEuY3E
         +fM/Eo0k4cGUpgsv9I7ngpTYUCnKuNBnILVf2LwdM4JxoMn/20ZJAHhXZpS43uaLurXE
         PmjOj02vGdXxe4e7P8MkKLf20nRCqUiZzQcymm8YUPGVLY5wRp1/vnUanyJVWm8mmjDo
         nefw==
X-Gm-Message-State: AOJu0Yy0b+F9OvgHvI+15y5RBzUHaTRiUwRYwsvhsK4IP91qwBFAR8Hj
	xyNUwaw58/IYOgFNkQqB9rmeBPCdJVW6AJreuIXsgNLlJck3/6vzS5lTwGRUmw==
X-Gm-Gg: AfdE7cmBcdv+xF/ectBD8QJRjvj43hVWQgMao95LgiCP2z7mpbSXD54qlP9U9I/YLPW
	Y8P0fZvo5JsgI0npzO/M1OWfhu5PV9viZJj2j1+szkGzIiFIdV8r4jXEY+wmJrIEeIJ3EjEMGKi
	1HyWXLvtEAbAq44U2MRtWThPP3GjpbFA2ed/ELH0p5t/v+9LMbVeIBHzMvqqRYMIeAstvfs11ig
	qNYAfpSK2n/p4H9Kf9291D7PZuoeN440ILxT7f5ZPOX+7Jqk41AiHlTURt/f4skEBCGu2r6CMiW
	Wnwl5NvORTNTjARxF7OyXIWVMYIRCoPneNNOpKgG7RwJJCJolrGzW3w2BC1hJqWO14t7wQjtlK9
	TPsfysfLknUYJoM19FNt8ChUIgiLHCSOsf97eIHybAwwvkMjnSkgnqKo94dDjE0wO7KxrAAkS8f
	Eb/XBNclQ00YWxacpO6MLuRtOJHCSlQKD+rtzXSWIE5605Xy7qgjgg1nbzId2mFSXbluyCFmMlv
	Q==
X-Received: by 2002:a05:6102:5984:b0:738:be73:55e0 with SMTP id ada2fe7eead31-744dffae44emr6633329137.12.1783692956922;
        Fri, 10 Jul 2026 07:15:56 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:15:56 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 07/36] tuna: Add cpuset module for CPU isolation using cgroup v2
Date: Fri, 10 Jul 2026 10:14:45 -0400
Message-ID: <20260710141523.36440-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710141523.36440-1-jkacur@redhat.com>
References: <20260710141523.36440-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Port cpuset functionality from rteval with tuna-specific enhancements.
Originally prototyped in tuna, implemented in rteval, now adapted back
to tuna for persistent CPU isolation capabilities.

Core functionality (rteval-compatible):
- Cpuset class for creating/destroying cpusets
- CpusetsInit class for cgroup v2 detection
- TaskMigrate class for moving processes between cpusets
- Context manager support with optional auto_destroy
- NUMA awareness and CPU partitioning

Tuna-specific enhancements:
- Persistent cpusets by default (auto_destroy=False)
- list_cpusets() for discovering existing cpusets
- destroy_cpuset() for cleaning up any cpuset
- destroy_cpuset_recursive() for nested hierarchies
- cleanup_cpusets() for pattern-based bulk cleanup
- Support for systemd/container nested cgroup hierarchies

Also standardize cpulist utility functions in tuna.py:
- Add expand_cpulist() and collapse_cpulist() from rteval
- Update existing functions to use the standardized versions
- Maintain backward compatibility with wrapper functions

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/cpuset.py | 595 +++++++++++++++++++++++++++++++++++++++++++++++++
 tuna/tuna.py   | 108 ++++++---
 2 files changed, 667 insertions(+), 36 deletions(-)
 create mode 100644 tuna/cpuset.py

diff --git a/tuna/cpuset.py b/tuna/cpuset.py
new file mode 100644
index 000000000000..4a3a71416c53
--- /dev/null
+++ b/tuna/cpuset.py
@@ -0,0 +1,595 @@
+#!/usr/bin/python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2026 John Kacur <jkacur@redhat.com>
+#
+# Originally prototyped in tuna, implemented in rteval,
+# and adapted back to tuna with tuna-specific enhancements.
+#
+""" Module for creating and using cpusets (cgroup v2) """
+
+import errno
+import os
+import logging
+from glob import glob
+
+logger = logging.getLogger(__name__)
+
+
+class Cpuset:
+    """ Class for manipulating cpusets """
+
+    mpath = '/sys/fs/cgroup'
+
+    def __init__(self, name=None, auto_destroy=False):
+        """
+        Initialize a cpuset
+
+        Args:
+            name: Name of the cpuset to create
+            auto_destroy: If True, cpuset will be automatically destroyed when
+                         exiting a context manager (rteval style).
+                         If False (default), cpuset persists after program exits
+                         (tuna style).
+        """
+        self.cpuset_name = None
+        self._cpuset_path = None
+        self.auto_destroy = auto_destroy
+        self.create_cpuset(name)
+
+    @property
+    def cpuset_path(self):
+        """ Return the cpuset path, for example /sys/fs/cgroup/tuna_0 """
+        return self._cpuset_path
+
+    def __str__(self):
+        return f'cpuset_name={self.cpuset_name}, cpuset_path={self.cpuset_path}'
+
+    def create_cpuset(self, name=None):
+        """
+        Create a cpuset (cgroup) below /sys/fs/cgroup
+
+        If the cpuset already exists, prints a warning and returns without
+        creating a new one.
+        """
+        if name is None:
+            raise ValueError("cpuset name cannot be None")
+        self.cpuset_name = name
+        path = os.path.join(Cpuset.mpath, self.cpuset_name)
+
+        # Check if cpuset already exists
+        if os.path.exists(path):
+            logger.warning(f"Cpuset '{name}' already exists at {path}")
+            print(f"Warning: cpuset '{name}' already exists at {path}")
+            self._cpuset_path = path
+            return
+
+        os.mkdir(path)
+        self._cpuset_path = path
+        # Enable cpuset controller in parent if needed
+        self._enable_controllers()
+
+    def _enable_controllers(self):
+        """ Enable cpuset controller in parent cgroup """
+        # Get parent path
+        parent_path = os.path.dirname(self._cpuset_path)
+        if parent_path == '/sys/fs':
+            parent_path = '/sys/fs/cgroup'
+
+        subtree_control = os.path.join(parent_path, 'cgroup.subtree_control')
+        try:
+            # Read current controllers
+            with open(subtree_control, 'r', encoding='utf-8') as f:
+                current = f.read().strip()
+
+            # Enable cpuset if not already enabled
+            # Controllers are space-separated, so split and check
+            if 'cpuset' not in current.split():
+                with open(subtree_control, 'w', encoding='utf-8') as f:
+                    f.write('+cpuset')
+        except (OSError, PermissionError):
+            # May fail if already enabled or no permissions
+            pass
+
+    def assign_cpus(self, cpu_str):
+        """
+        Assign cpus in list-format to a cpuset
+        Note: In cgroup v2, you must call write_memnode() before assign_cpus()
+        """
+        path = os.path.join(self._cpuset_path, "cpuset.cpus")
+        with open(path, 'w', encoding='utf-8') as f:
+            f.write(cpu_str)
+
+    def write_pid(self, pid):
+        """
+        Place a pid in a cpuset
+        Returns True if successful, False if the process cannot be moved
+        Raises OSError for unexpected errors
+        """
+        path = os.path.join(self._cpuset_path, "cgroup.procs")
+        pid_str = str(pid)
+        try:
+            with open(path, 'w', encoding='utf-8') as f:
+                f.write(pid_str)
+                f.flush()
+            return True
+        except OSError as err:
+            # EINVAL: Invalid argument (process can't be moved, or invalid PID format)
+            # ESRCH: No such process (process died between read and write)
+            # EBUSY: Device or resource busy (process can't be moved)
+            # EACCES: Permission denied (some kernel threads can't be moved)
+            if err.errno in (errno.EINVAL, errno.ESRCH, errno.EBUSY, errno.EACCES):
+                return False
+            else:
+                raise
+
+    def write_memnode(self, memnode):
+        """ Place memnode in a cpuset """
+        path = os.path.join(self._cpuset_path, "cpuset.mems")
+        memnode_str = str(memnode)
+        with open(path, 'w', encoding='utf-8') as f:
+            f.write(memnode_str)
+
+    def write_cpu_exclusive(self, cpu_exclusive):
+        """
+        Set CPU partition type (cgroup v2)
+        In v2, cpu_exclusive is replaced by cpuset.cpus.partition
+
+        Args:
+            cpu_exclusive: True/1/'1' for 'isolated', False/0/'0' for 'member'
+        """
+        path = os.path.join(self._cpuset_path, "cpuset.cpus.partition")
+        if not os.path.exists(path):
+            # cpuset.cpus.partition may not exist in all kernels
+            return
+
+        # Convert to boolean: handles bool, int, or string input
+        if isinstance(cpu_exclusive, str):
+            is_exclusive = cpu_exclusive not in ('0', '', 'false', 'False')
+        else:
+            is_exclusive = bool(cpu_exclusive)
+
+        partition_type = 'isolated' if is_exclusive else 'member'
+        try:
+            with open(path, 'w', encoding='utf-8') as f:
+                f.write(partition_type)
+        except OSError:
+            # Partition may not be supported or may fail
+            pass
+
+    def set_cpu_exclusive(self):
+        """ Turn cpu_exclusive on (set partition to isolated) """
+        self.write_cpu_exclusive(True)
+
+    def unset_cpu_exclusive(self):
+        """ Turn cpu_exclusive off (set partition to member) """
+        self.write_cpu_exclusive(False)
+
+    def write_memory_migrate(self, memory_migrate):
+        """
+        Memory migrate is not available in cgroup v2
+        This is kept for API compatibility but does nothing
+        """
+        pass
+
+    def set_memory_migrate(self):
+        """ Memory_migrate not available in cgroup v2 (no-op for compatibility) """
+        pass
+
+    def unset_memory_migrate(self):
+        """ Memory migrate not available in cgroup v2 (no-op for compatibility) """
+        pass
+
+    def destroy(self):
+        """
+        Remove this cpuset (cgroup directory)
+        The cpuset must be empty (no processes) before it can be removed.
+        Raises OSError if the directory is not empty or doesn't exist.
+        """
+        if self._cpuset_path and os.path.exists(self._cpuset_path):
+            os.rmdir(self._cpuset_path)
+
+    def __enter__(self):
+        """
+        Context manager entry point
+        Allows usage: with Cpuset('name') as cpuset: ...
+        """
+        return self
+
+    def __exit__(self, exc_type, exc_val, exc_tb):
+        """
+        Context manager exit point
+        Only destroys the cpuset if auto_destroy=True was set during initialization.
+        This allows rteval-style automatic cleanup when desired, but preserves
+        tuna's default behavior of persistent cpusets.
+        """
+        if self.auto_destroy:
+            self.destroy()
+        return False  # Don't suppress exceptions
+
+    def get_tasks(self):
+        """ Get the tasks (PIDs) currently in a cpuset """
+        path = os.path.join(self.cpuset_path, "cgroup.procs")
+        with open(path, 'r', encoding='utf-8') as f:
+            return [line.strip() for line in f if line.strip()]
+
+
+class CpusetsInit(Cpuset):
+    """
+    CpusetsInit initializes cpusets (cgroup v2)
+    It verifies that cgroup v2 is mounted and cpuset controller is available
+    This class represents the root cgroup /sys/fs/cgroup
+    """
+
+    mpath = '/sys/fs/cgroup'
+
+    def __init__(self):
+        self._supported = self._cpuset_supported()
+        self._numa_nodes = self._get_numa_nodes() if self._supported else 0
+        if self._supported:
+            # Set attributes directly for the root cgroup
+            self.cpuset_name = None
+            self._cpuset_path = Cpuset.mpath
+            # Root cgroup is never auto-destroyed
+            self.auto_destroy = False
+
+    @property
+    def supported(self):
+        """ Return True if cpuset is supported """
+        return self._supported
+
+    @property
+    def numa_nodes(self):
+        """ Return the number of numa nodes """
+        return self._numa_nodes
+
+    @staticmethod
+    def _cpuset_supported():
+        """
+        Return True if cpusets are supported
+        For cgroup v2, check if:
+        1. cgroup2 filesystem is available
+        2. /sys/fs/cgroup is mounted
+        3. cpuset controller is available
+        """
+        # Check if cgroup2 is in /proc/filesystems
+        cgroup2_found = False
+        dpath = '/proc/filesystems'
+        try:
+            with open(dpath, encoding='utf-8') as fp:
+                for line in fp:
+                    elems = line.strip().split()
+                    if len(elems) == 2 and elems[1] == "cgroup2":
+                        cgroup2_found = True
+                        break
+        except OSError:
+            return False
+
+        if not cgroup2_found:
+            return False
+
+        # Check if /sys/fs/cgroup is mounted and has cpuset controller
+        cgroup_path = '/sys/fs/cgroup'
+        controllers_file = os.path.join(cgroup_path, 'cgroup.controllers')
+
+        if not os.path.exists(controllers_file):
+            return False
+
+        try:
+            with open(controllers_file, encoding='utf-8') as f:
+                controllers = f.read().strip().split()
+                return 'cpuset' in controllers
+        except OSError:
+            return False
+
+    @staticmethod
+    def _get_numa_nodes():
+        """
+        return the number of numa nodes
+        used by init to set _numa_nodes
+        Users of this class should use the "numa_nodes" method
+        """
+        return len(glob('/sys/devices/system/node/node*'))
+
+
+class TaskMigrate:
+    """ A class for migrating a set of pids from one cpuset to another """
+
+    def __init__(self, cpuset_from, cpuset_to):
+        self.cpuset_from = cpuset_from
+        self.cpuset_to = cpuset_to
+        # memory_migrate is not available in cgroup v2, but keep for API compat
+        self.cpuset_to.set_memory_migrate()
+        self.migrated = 0
+        self.failed = 0
+
+    def migrate(self):
+        """ Do the migration, only attempt on pids where this is allowed """
+        self.migrated = 0
+        self.failed = 0
+        tasks = self.cpuset_from.get_tasks()
+        for task in tasks:
+            if self.cpuset_to.write_pid(task):
+                self.migrated += 1
+            else:
+                self.failed += 1
+        return self.migrated, self.failed
+
+
+#
+# Tuna-specific utility functions for cpuset discovery and management
+#
+
+def list_cpusets(pattern=None, recursive=True):
+    """
+    List all cpusets under /sys/fs/cgroup
+
+    Args:
+        pattern: Optional glob pattern to filter (e.g., "tuna_*", "rteval_*")
+                If None, returns all cpusets.
+        recursive: If True, find nested cpusets; if False, only top-level
+
+    Returns:
+        List of cpuset paths relative to /sys/fs/cgroup
+
+    Note: Real-world scenario - systemd, containers, and users may create
+    nested cgroup hierarchies, so recursive search is important
+    """
+    cpusets = []
+    base_path = '/sys/fs/cgroup'
+
+    if not recursive:
+        # Only search top-level directories
+        import fnmatch
+        for entry in os.listdir(base_path):
+            entry_path = os.path.join(base_path, entry)
+            if os.path.isdir(entry_path):
+                # Check if it's a cpuset by looking for cpuset.cpus file
+                if os.path.exists(os.path.join(entry_path, 'cpuset.cpus')):
+                    if pattern is None or fnmatch.fnmatch(entry, pattern):
+                        cpusets.append(entry)
+    else:
+        # Recursive search using os.walk
+        for root, dirs, files in os.walk(base_path):
+            # Check if this directory has cpuset.cpus (indicates it's a cpuset)
+            if 'cpuset.cpus' in files:
+                # Get relative path from base_path
+                rel_path = os.path.relpath(root, base_path)
+                if rel_path == '.':
+                    # Skip the root cgroup itself
+                    continue
+                if pattern is None:
+                    cpusets.append(rel_path)
+                else:
+                    # Match pattern against the basename only
+                    import fnmatch
+                    if fnmatch.fnmatch(os.path.basename(rel_path), pattern):
+                        cpusets.append(rel_path)
+
+    return sorted(cpusets)
+
+
+def destroy_cpuset(name_or_path, force=False):
+    """
+    Destroy a cpuset by name or path
+
+    Args:
+        name_or_path: Cpuset name (e.g., "tuna_0") or full path
+                     (e.g., "/sys/fs/cgroup/tuna_0")
+        force: If True, migrate tasks out to root cgroup before destroying
+
+    Raises:
+        OSError: If the cpuset doesn't exist or can't be removed
+        ValueError: If trying to destroy the root cgroup
+
+    Note: When cleaning nested hierarchies, must destroy children before parents
+    (cgroups can't be removed if they have children)
+    """
+    base_path = '/sys/fs/cgroup'
+
+    # Normalize the path
+    if name_or_path.startswith('/'):
+        cpuset_path = name_or_path
+    else:
+        cpuset_path = os.path.join(base_path, name_or_path)
+
+    # Prevent destroying root cgroup
+    if cpuset_path == base_path or cpuset_path == '/sys/fs/cgroup':
+        raise ValueError("Cannot destroy the root cgroup")
+
+    if not os.path.exists(cpuset_path):
+        raise OSError(f"Cpuset does not exist: {cpuset_path}")
+
+    # If force=True, migrate tasks to root cgroup first
+    if force:
+        root_cgroup = CpusetsInit()
+        if not root_cgroup.supported:
+            raise RuntimeError("Cpusets not supported on this system")
+
+        # Create temporary Cpuset object for this path
+        cpuset = Cpuset.__new__(Cpuset)
+        cpuset._cpuset_path = cpuset_path
+        cpuset.cpuset_name = os.path.basename(cpuset_path)
+
+        # Migrate tasks to root
+        tm = TaskMigrate(cpuset, root_cgroup)
+        migrated, failed = tm.migrate()
+        logger.info(f"Migrated {migrated} tasks to root cgroup, {failed} failed")
+
+    # Destroy the cpuset
+    os.rmdir(cpuset_path)
+    logger.info(f"Destroyed cpuset: {cpuset_path}")
+
+
+def destroy_cpuset_recursive(name_or_path, force=False):
+    """
+    Recursively destroy a cpuset and all its children
+
+    Args:
+        name_or_path: Cpuset name or full path
+        force: If True, migrate tasks out before destroying
+
+    This is useful when a cpuset has nested children that need to be
+    destroyed before the parent can be removed.
+    """
+    base_path = '/sys/fs/cgroup'
+
+    # Normalize the path
+    if name_or_path.startswith('/'):
+        cpuset_path = name_or_path
+    else:
+        cpuset_path = os.path.join(base_path, name_or_path)
+
+    if not os.path.exists(cpuset_path):
+        return  # Already destroyed or doesn't exist
+
+    # Find all children
+    children = []
+    for entry in os.listdir(cpuset_path):
+        child_path = os.path.join(cpuset_path, entry)
+        if os.path.isdir(child_path) and os.path.exists(os.path.join(child_path, 'cgroup.procs')):
+            children.append(child_path)
+
+    # Recursively destroy children first
+    for child_path in children:
+        destroy_cpuset_recursive(child_path, force=force)
+
+    # Now destroy this cpuset
+    try:
+        destroy_cpuset(cpuset_path, force=force)
+    except (OSError, ValueError) as e:
+        logger.warning(f"Failed to destroy {cpuset_path}: {e}")
+
+
+def cleanup_cpusets(pattern, force=True, recursive=True):
+    """
+    Clean up multiple cpusets matching a pattern
+
+    Args:
+        pattern: Glob pattern (e.g., "tuna_*" or "rteval_*")
+        force: If True, migrate tasks out before destroying
+        recursive: If True, find and clean nested cpusets too
+
+    Note: When cleaning nested hierarchies, must destroy children before parents
+    (cgroups can't be removed if they have children). This function will
+    automatically handle nested children even if they don't match the pattern.
+    """
+    # Find all matching cpusets
+    cpusets = list_cpusets(pattern=pattern, recursive=recursive)
+
+    if not cpusets:
+        logger.info(f"No cpusets found matching pattern: {pattern}")
+        return
+
+    # Sort in reverse order by depth to ensure children are destroyed before parents
+    # Depth is determined by the number of path separators
+    cpusets_by_depth = sorted(cpusets, key=lambda x: x.count(os.sep), reverse=True)
+
+    destroyed_count = 0
+    failed_count = 0
+    # Keep track of what we've already destroyed to avoid double-counting
+    destroyed_paths = set()
+
+    for cpuset_name in cpusets_by_depth:
+        cpuset_path = os.path.join('/sys/fs/cgroup', cpuset_name)
+
+        # Skip if already destroyed
+        if cpuset_path in destroyed_paths or not os.path.exists(cpuset_path):
+            continue
+
+        try:
+            # Use recursive destroy to handle any nested children
+            # (even those that don't match the pattern)
+            destroy_cpuset_recursive(cpuset_name, force=force)
+            destroyed_count += 1
+            destroyed_paths.add(cpuset_path)
+        except (OSError, ValueError) as e:
+            logger.error(f"Failed to destroy {cpuset_name}: {e}")
+            failed_count += 1
+
+    logger.info(f"Cleanup complete: {destroyed_count} destroyed, {failed_count} failed")
+    if destroyed_count > 0 or failed_count > 0:
+        print(f"Cleanup complete: {destroyed_count} cpusets destroyed, {failed_count} failed")
+
+
+if __name__ == '__main__':
+
+    cpusets_init = CpusetsInit()
+    print(f'cpusets_init.supported = {cpusets_init.supported}')
+    if cpusets_init.supported:
+        print(f'cpusets_init.numa_nodes = {cpusets_init.numa_nodes}')
+        print(f'cpusets_init.cpuset_path = {cpusets_init.cpuset_path}')
+
+        # Creating and manipulating cgroups requires root permissions
+        print("\nTo test cpuset creation, run as root:")
+        print("  sudo python3 -m tuna.cpuset")
+
+        try:
+            # Example 1: Using context manager with auto_destroy (rteval style)
+            print("\n" + "="*60)
+            print("Example 1: Context Manager with auto_destroy=True")
+            print("="*60)
+            with Cpuset('tuna_demo', auto_destroy=True) as cpuset:
+                print(f"Created cpuset: {cpuset.cpuset_path}")
+                cpuset.write_memnode('0')
+                cpuset.assign_cpus('0-3')
+                print(f"Configured cpuset with CPUs 0-3")
+            print("Context manager exited - cpuset automatically destroyed!")
+
+            # Example 2: Persistent cpuset (tuna style, default)
+            print("\n" + "="*60)
+            print("Example 2: Persistent Cpuset (tuna style, default)")
+            print("="*60)
+            print("Creating tuna_0...")
+            cpuset0 = Cpuset('tuna_0')  # auto_destroy=False by default
+            print("Creating tuna_1...")
+            cpuset1 = Cpuset('tuna_1')
+
+            # In cgroup v2, must set mems before cpus
+            print("Setting memory nodes...")
+            cpuset0.write_memnode('0')
+            cpuset1.write_memnode('0')
+
+            print("Assigning CPUs to tuna_0 (0-4)...")
+            cpuset0.assign_cpus('0-4')
+            print("Assigning CPUs to tuna_1 (5-7)...")
+            cpuset1.assign_cpus('5-7')
+
+            print("Setting cpu_exclusive on tuna_1...")
+            cpuset1.set_cpu_exclusive()
+
+            print("\nCpusets created and will persist after program exits.")
+            print("Use cleanup_cpusets('tuna_*') to remove them later.")
+
+            # Example 3: Tuna-specific discovery and cleanup functions
+            print("\n" + "="*60)
+            print("Example 3: Tuna-specific Discovery and Cleanup")
+            print("="*60)
+            print("\nListing all cpusets matching 'tuna_*':")
+            tuna_cpusets = list_cpusets(pattern='tuna_*')
+            for cs in tuna_cpusets:
+                print(f"  - {cs}")
+
+            print("\nCleaning up with cleanup_cpusets('tuna_*', force=True)...")
+            cleanup_cpusets('tuna_*', force=True)
+
+            print("\nAfter cleanup, listing cpusets again:")
+            remaining = list_cpusets(pattern='tuna_*')
+            if remaining:
+                print(f"  Still found: {remaining}")
+            else:
+                print("  No tuna_* cpusets remaining (cleanup successful)")
+
+            # Success message
+            print("\n" + "="*60)
+            print("✅ All examples completed successfully!")
+            print("="*60)
+
+        except PermissionError as e:
+            print(f"\nPermission denied: {e}")
+            print("Run as root to create and manipulate cgroups")
+        except Exception as e:
+            print(f"\nError: {e}")
+            import traceback
+            traceback.print_exc()
diff --git a/tuna/tuna.py b/tuna/tuna.py
index 1cb538575b17..5e5f5578fbe4 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -128,59 +128,95 @@ def set_irq_affinity_filename(filename, bitmasklist):
 def set_irq_affinity(irq, bitmasklist):
     return set_irq_affinity_filename("%d/smp_affinity" % irq, bitmasklist)
 
+def expand_cpulist(cpulist):
+    """
+    Expand a range string into an array of cpu numbers
+
+    Standardized implementation shared with rteval for consistent behavior.
+    Handles empty strings, single values, and ranges correctly.
+
+    Args:
+        cpulist: String representation (e.g., "0-3,5-7")
+
+    Returns:
+        List of CPU numbers (integers), deduplicated
+    """
+    result = []
+
+    if not cpulist:
+        return result
+
+    for part in cpulist.split(','):
+        if '-' in part:
+            a, b = part.split('-')
+            a, b = int(a), int(b)
+            result.extend(list(range(a, b + 1)))
+        else:
+            a = int(part)
+            result.append(a)
+    return [int(i) for i in list(set(result))]
+
 def cpustring_to_list(cpustr):
     """Convert a string of numbers to an integer list.
 
+    DEPRECATED: Use expand_cpulist() instead.
+    Kept for backward compatibility with existing code.
+
     Given a string of comma-separated numbers and number ranges,
     return a simple sorted list of the integers it represents.
 
-    This function will throw exceptions for badly-formatted strings.
-
     Returns a list of integers."""
 
-    fields = cpustr.strip().split(",")
-    cpu_list = []
-    for field in fields:
-        ends = [int(a, 0) for a in field.split("-")]
-        if len(ends) > 2:
-            raise SyntaxError("Syntax error")
-        if len(ends) == 2:
-            cpu_list += list(range(ends[0], ends[1] + 1))
+    return expand_cpulist(cpustr)
+
+def collapse_cpulist(cpulist):
+    """
+    Collapse a list of cpu numbers into a string range of cpus (e.g. 0-5, 7, 9)
+
+    Standardized implementation shared with rteval for consistent behavior.
+    Handles duplicates and unsorted lists correctly.
+
+    Args:
+        cpulist: List of CPU numbers (integers)
+
+    Returns:
+        String representation with ranges collapsed (e.g., "0-3,5-7")
+    """
+    if not cpulist:
+        return ""
+
+    # Ensure we're working with integers, remove duplicates, and sort them
+    sorted_cpus = sorted(set([int(cpu) for cpu in cpulist]))
+
+    cur_range = [None, None]
+    result = []
+    for cpu in sorted_cpus + [None]:
+        if cur_range[0] is None:
+            cur_range[0] = cur_range[1] = cpu
+            continue
+        if cpu is not None and cpu == cur_range[1] + 1:
+            # Extend currently processed range
+            cur_range[1] += 1
         else:
-            cpu_list += [ends[0]]
-    return list(set(cpu_list))
+            # Range processing finished, add range to string
+            result.append(f"{cur_range[0]}-{cur_range[1]}"
+                          if cur_range[0] != cur_range[1]
+                          else str(cur_range[0]))
+            # Reset
+            cur_range[0] = cur_range[1] = cpu
+    return ",".join(result)
 
 def list_to_cpustring(l):
     """Convert a list of integers into a range string.
 
-    Consecutive values will be collapsed into ranges.
+    DEPRECATED: Use collapse_cpulist() instead.
+    Kept for backward compatibility with existing code.
 
-    This should not throw any exceptions as long as the list is all
-    positive integers.
+    Consecutive values will be collapsed into ranges.
 
     Returns a string."""
 
-    l = list(set(l))
-    strings = []
-    prev = -2
-    while l:
-        i = l.pop(0)
-        if i - 1 == prev:
-            while l:
-                j = l.pop(0)
-                if j - 1 != i:
-                    l.insert(0, j)
-                    break
-                i = j
-            t = strings.pop()
-            if int(t) + 1 == i:
-                strings.append("%s,%u" % (t, i))
-            else:
-                strings.append("%s-%u" % (t, i))
-        else:
-            strings.append("%u" % i)
-        prev = i
-    return ",".join(strings)
+    return collapse_cpulist(l)
 
 # FIXME: move to python-linux-procfs
 def is_hardirq_handler(self, pid):
-- 
2.54.0

