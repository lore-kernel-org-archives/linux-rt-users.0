Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFBD1A9FA0
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577532; cv=none; b=PGXmOjL/tqe2rRl9IQ6VQKq6LSskVncDIKFRimDRLg8/UQ9weT8NFz7nx+qMrZFzP2PCc2EnbaKI3u6Vd/tpZb3f6mz4PtyQnVksg1IxVGVZhzeszogefCnI6/ajODXNLuIT4K7R+j7ZqvcbWAEeLB+4z+EPcPrVhiM6Wj/pMqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577532; c=relaxed/simple;
	bh=B3V/KN45lr1mG5N/E/lbjJBdATbIuZGB+og2o9EfbkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9d0RL8kcSowfBGJAZYEfUAIJxkE3XYcZvAL0bGbQ01BUNHJhlyrUkIZh792qenGPrFgvhUu3ImiMJvKjHnyVz8vqXnQca4IF79yktpqJ36jJno2CQ7W0H7z91smRgnytasQapUQZ56rqOS98+URIW97H3EGfp7dPely2IKrqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4vfxp+F; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4vfxp+F"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e614fdb42so10003941cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 12:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777577528; x=1778182328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3lk5NSwx3YdhaXYH/y07K01mpGf1fZzugcW1sbh8E8=;
        b=r4vfxp+FEiuUBGYpKR+hs2BIs1cUaQlK/cAoC9FLkj8LTgk5APvF1Syk4cuIgw6wWC
         nYRRXSbCh9lBxjKW2p1Oh8rZvKhPCEePbtR2pwfNEU5yrf6/FfDK3rQPDzCxdxBawjhp
         ckE/+BdL9YzTxofj7Az5rHh/IbQRsLGE++eqKv30AvxlxLCpgPvbT72TqE+6by87Dk19
         Sp1wFlBUbNFC+ygJ+RpPx3cUxbdy633UgNso3bmZXpTzxxMia1sd9MycOZXsLZlkSFzn
         mQE2+CR0oZ/pnznAkCfL9gLmKqBpv/Fo+DxWi3IyoRgVrFZAYhqGjce7HEdewIh0ird1
         603g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577528; x=1778182328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3lk5NSwx3YdhaXYH/y07K01mpGf1fZzugcW1sbh8E8=;
        b=KUBsMpEktasL+fbObujWqeZnMgM6sOhcidIP0WCcUnE/94kHPLtJt2lGYNCjQIQ0rp
         OLFWKhDm0fKNzkwLvKS6+G7Dk+Dm2W1X7OikDnPPKrFCOvoDbIKG8Dugsw67Gc8wovTH
         nGRr4fGt+fyrNiAnEbmHb4cg+dMKJJX81Hvj3SF5qX10VDUUYsOT5IUOQlPCGGAFxD2C
         1A4glWJO6sNJaXKtwdqqh15kq/37RoukzfK/6jVwuEAYNkmYjK85WcifJ0DRsCfeOo8m
         vljMs/BSqifXj1AytK5mnuOBMhGR8VfY7JkBFBH58fEmQ8rm2LnwGL15/Trv17SXRdWB
         HyqQ==
X-Gm-Message-State: AOJu0YxuQb2oj6cbAlUZFr08Fo0DRYj2fL1GnH6UCV9oQW62gaGTGXFW
	6Vu+W3YvxfD8lsOeunefgWwT92cUiXOfn0Nit0G5bALHV/Q3JC9kDC/QSDLDPA==
X-Gm-Gg: AeBDievPVeWw19SsQH6/8aekGS9rYczvnuoq5BLre4GWaoQA22fhVtXF6kC5/LzSf2D
	yTJZdMdPaTL8WopaUU1YCbqRW3BrptBWpHpbrSOqdH31CFNj0yfVSNwOK/9V+u1TjqFMRLuPFyO
	5jC2Qwj5DmiNgO2iGOOrja4pZAdyirTaYq6VN5BjRz9pAdWTLAk0qA2Ik+fikNs5rQFsfOjwVES
	PQeS7rQv1m9eynNG+33j7+vC+XgmzFZl9J4QFrbHWLPm1c1TcHVIP/5M7hd6MMTU2jk1g8dIk/d
	K6EOnPJv8FaqDXyW/FYiXFm/fhdAwN/GleI1BN7Dqb3N/37Hvo5WtM2bYOKkt0MK68IwnWJe5bs
	+9KtCJpvD4wRCuPTmP56DvmQb1y8A/qPxEYD0QAvQoFr5Cwmd5mZWNVWUEWJa2AJ7cAsa7osKlu
	UdwK2RjOIfdzLl8VTw36Kx5t2pB1Dd8nj6gxE7M08UyXTAxNqZLzBLualLAQUbF3j+LLaaM4tKO
	3prUOjwiBowcIS/9iRx/yvaNaK29w==
X-Received: by 2002:a05:622a:309:b0:50f:be4f:465d with SMTP id d75a77b69052e-5102ae35139mr61465651cf.46.1777577528216;
        Thu, 30 Apr 2026 12:32:08 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103d1c6957sm4270391cf.2.2026.04.30.12.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:32:07 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/7] rteval: Add cpuset integration infrastructure (WIP)
Date: Thu, 30 Apr 2026 15:31:38 -0400
Message-ID: <20260430193144.354599-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430193144.354599-1-jkacur@redhat.com>
References: <20260430193144.354599-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add --cpusets flag to isolate workloads using cgroup v2 cpusets.
This provides an alternative to isolcpus kernel parameter, allowing
dynamic CPU isolation without requiring boot parameter changes.

This commit includes the complete cpuset infrastructure:
- CpusetManager class for cpuset lifecycle management
- get_subprocess_pids() methods in all load/measurement modules
- Integration in rteval-cmd and RtEval class
- Smart cpuset creation (1-3 cpusets based on CPU configuration)
- Startup cleanup of leftover cpusets from previous runs
- Comprehensive test suite (test-cpusets.sh) with 7 passing tests

Current status:
- Cpuset creation: Working
- Housekeeping migration: Working
- Startup cleanup: Working
- All 7 tests passing

Known issue: Child processes spawned by loads don't inherit cpuset
because parent is migrated after children spawn. This will be fixed
in a follow-up commit by migrating processes before they spawn children.

Changes:
- rteval-cmd: Add --cpusets flag and startup cleanup call
- rteval/__init__.py: Accept cpuset_manager, migrate after Unleash()
- rteval/cpusetmanager.py: New cpuset manager with cleanup
- rteval/modules/__init__.py: Add get_subprocess_pids() base method
- rteval/modules/loads/*.py: Implement get_subprocess_pids()
- rteval/modules/measurement/*.py: Implement get_subprocess_pids()
- CPUSET-INTEGRATION-PLAN.md: Complete implementation plan
- test-cpusets.sh: Automated test suite

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                               |  85 ++++++-
 rteval/__init__.py                       |  17 +-
 rteval/cpusetmanager.py                  | 304 +++++++++++++++++++++++
 rteval/modules/__init__.py               |  30 +++
 rteval/modules/loads/hackbench.py        |   7 +
 rteval/modules/loads/kcompile.py         |   7 +
 rteval/modules/loads/stressng.py         |   6 +
 rteval/modules/measurement/cyclictest.py |   5 +
 rteval/modules/measurement/timerlat.py   |   6 +
 9 files changed, 454 insertions(+), 13 deletions(-)
 create mode 100644 rteval/cpusetmanager.py

diff --git a/rteval-cmd b/rteval-cmd
index f730d3177290..57f360dc95b0 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -119,6 +119,9 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("--warn-non-isolated-core-sharing", dest="rteval___warn_non_isolated_core_sharing",
                       action="store_true", default=False,
                       help="warn about measurement and load CPUs sharing cores even when neither is isolated")
+    parser.add_argument("--cpusets", dest="rteval___cpusets",
+                      action="store_true", default=False,
+                      help="use cgroup v2 cpusets to isolate measurement, load, and housekeeping workloads")
     parser.add_argument("-s", "--sysreport", dest="rteval___sysreport",
                       action="store_true", default=rtevcfg.sysreport,
                       help=f'run sysreport to collect system data (default: {rtevcfg.sysreport})')
@@ -380,8 +383,15 @@ if __name__ == '__main__':
         # Validate and process housekeeping CPUs
         housekeeping_cpus = []
         if rtevcfg.housekeeping:
-            housekeeping_cpus = validate_housekeeping_cpus(rtevcfg.housekeeping)
-            logger.log(Log.DEBUG, f"housekeeping cpulist: {collapse_cpulist(housekeeping_cpus)}")
+            if rtevcfg.cpusets:
+                # With cpusets, housekeeping doesn't require isolcpus
+                # Just parse and validate it's a valid CPU list
+                housekeeping_cpus = CpuList(rtevcfg.housekeeping).online().cpus
+                logger.log(Log.DEBUG, f"housekeeping cpulist: {collapse_cpulist(housekeeping_cpus)}")
+            else:
+                # Without cpusets, require housekeeping CPUs to be in isolcpus
+                housekeeping_cpus = validate_housekeeping_cpus(rtevcfg.housekeeping)
+                logger.log(Log.DEBUG, f"housekeeping cpulist: {collapse_cpulist(housekeeping_cpus)}")
 
         # Remember if cpulists were explicitly set by the user before running
         # parse_cpulist_from_config, which generates default value for them
@@ -491,7 +501,31 @@ if __name__ == '__main__':
             cpupower_controller = cpupower.Cpupower(msrcfg.cpulist, msrcfg.idlestate, logger=logger)
             cpupower_controller.enable_idle_state()
 
-        rteval = RtEval(config, loadmods, measuremods, logger)
+        # Cpuset setup if requested
+        cpuset_manager = None
+        if rtevcfg.cpusets:
+            from rteval.cpusetmanager import CpusetManager
+            from rteval.cpuset import CpusetsInit
+
+            # Check if cpusets are supported
+            cpusets_init = CpusetsInit()
+            if not cpusets_init.supported:
+                logger.log(Log.ERR, "Cpusets requested but cgroup v2 cpuset controller not available")
+                sys.exit(1)
+
+            # Clean up any leftover cpusets from previous runs
+            CpusetManager.cleanup_leftover_cpusets(logger)
+
+            # Create manager (will create cpusets in __enter__)
+            cpuset_manager = CpusetManager(
+                housekeeping_cpus=housekeeping_cpus,
+                measurement_cpus=msrcfg_cpus,
+                load_cpus=ldcfg_cpus,
+                logger=logger
+            )
+
+        # Pass cpuset_manager to RtEval (None if not using cpusets)
+        rteval = RtEval(config, loadmods, measuremods, logger, cpuset_manager)
 
         # Add core sharing warnings to the XML report now that CPU lists are finalized
         rteval._sysinfo.add_core_sharing_warnings(housekeeping_cpus, msrcfg_cpus, ldcfg_cpus,
@@ -502,17 +536,44 @@ if __name__ == '__main__':
         if rtevcfg.onlyload:
             # If --onlyload were given, just kick off the loads and nothing more
             # No reports will be created.
-            loadmods.Start()
-            nthreads = loadmods.Unleash()
-            logger.log(Log.INFO, f"Started {nthreads} load threads - will run for {rtevcfg.duration} seconds")
-            logger.log(Log.INFO, "No measurements will be performed, due to the --onlyload option")
-            time.sleep(rtevcfg.duration)
-            loadmods.Stop()
-            ec = 0
+            if rtevcfg.cpusets:
+                with cpuset_manager:
+                    cpuset_manager.migrate_root_tasks_to_housekeeping()
+
+                    loadmods.Start()
+                    nthreads = loadmods.Unleash()
+
+                    # Migrate load processes
+                    time.sleep(0.5)  # Give processes time to spawn
+                    load_pids = loadmods.GetSubprocessPids()
+                    cpuset_manager.migrate_load_threads(load_pids)
+
+                    logger.log(Log.INFO, f"Started {nthreads} load threads - will run for {rtevcfg.duration} seconds")
+                    logger.log(Log.INFO, "No measurements will be performed, due to the --onlyload option")
+                    time.sleep(rtevcfg.duration)
+                    loadmods.Stop()
+                    ec = 0
+            else:
+                loadmods.Start()
+                nthreads = loadmods.Unleash()
+                logger.log(Log.INFO, f"Started {nthreads} load threads - will run for {rtevcfg.duration} seconds")
+                logger.log(Log.INFO, "No measurements will be performed, due to the --onlyload option")
+                time.sleep(rtevcfg.duration)
+                loadmods.Stop()
+                ec = 0
         else:
             # ... otherwise, run the full measurement suite with loads
-            ec = rteval.Measure()
-            logger.log(Log.DEBUG, f"exiting with exit code: {ec}")
+            if rtevcfg.cpusets:
+                with cpuset_manager:
+                    # Migrate existing tasks to housekeeping (if housekeeping cpuset exists)
+                    cpuset_manager.migrate_root_tasks_to_housekeeping()
+
+                    # RtEval will handle migrating measurement/load processes internally
+                    ec = rteval.Measure()
+                    logger.log(Log.DEBUG, f"exiting with exit code: {ec}")
+            else:
+                ec = rteval.Measure()
+                logger.log(Log.DEBUG, f"exiting with exit code: {ec}")
 
         # restore previous idle state settings
         if msrcfg.idlestate:
diff --git a/rteval/__init__.py b/rteval/__init__.py
index 6097ddf79514..a85fe2e21328 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -49,7 +49,7 @@ def except_hook(args):
     stopsig.set()
 
 class RtEval(rtevalReport):
-    def __init__(self, config, loadmods, measuremods, logger):
+    def __init__(self, config, loadmods, measuremods, logger, cpuset_manager=None):
         self.__version = RTEVAL_VERSION
         threading.excepthook = except_hook
 
@@ -66,6 +66,7 @@ class RtEval(rtevalReport):
         self.__logger = logger
         self._loadmods = loadmods
         self._measuremods = measuremods
+        self._cpuset_manager = cpuset_manager
 
         self.__rtevcfg = self.__cfg.GetSection('rteval')
         self.__reportdir = None
@@ -184,6 +185,20 @@ class RtEval(rtevalReport):
             self._measuremods.Unleash()
             measure_start = datetime.now()
 
+            # After Unleash(), do cpuset migration
+            if self._cpuset_manager:
+                # Small delay to let processes spawn
+                time.sleep(0.5)
+
+                if self._loadmods:
+                    load_pids = self._loadmods.GetSubprocessPids()
+                    self._cpuset_manager.migrate_load_threads(load_pids)
+
+                meas_pids = self._measuremods.GetSubprocessPids()
+                self._cpuset_manager.migrate_measurement_threads(meas_pids)
+
+                self.__logger.log(Log.INFO, "Processes migrated to cpusets")
+
             # wait for time to expire or thread to die
             signal.signal(signal.SIGINT, sig_handler)
             signal.signal(signal.SIGTERM, sig_handler)
diff --git a/rteval/cpusetmanager.py b/rteval/cpusetmanager.py
new file mode 100644
index 000000000000..d015e0130d54
--- /dev/null
+++ b/rteval/cpusetmanager.py
@@ -0,0 +1,304 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 John Kacur <jkacur@redhat.com>
+"""
+Manager for rteval cpusets with automatic cleanup
+
+This module provides the CpusetManager class which orchestrates cpuset creation
+and process migration for rteval workloads (housekeeping, measurement, and loads).
+"""
+
+import time
+import os
+import glob
+from rteval.cpuset import Cpuset, CpusetsInit, TaskMigrate
+from rteval.cpulist_utils import collapse_cpulist
+from rteval.Log import Log
+
+
+class CpusetManager:
+    """
+    Manager for rteval cpusets with automatic cleanup
+
+    Creates 1-3 cpusets dynamically based on CPU configuration:
+    - rteval_housekeeping: Only if housekeeping_cpus specified
+    - rteval_workload: When measurement_cpus == load_cpus (combined)
+    - rteval_measurement + rteval_loads: When measurement_cpus != load_cpus (separate)
+
+    Uses context manager pattern for automatic cleanup.
+    """
+
+    @staticmethod
+    def cleanup_leftover_cpusets(logger):
+        """
+        Clean up any leftover rteval cpusets from previous runs.
+
+        This is called at startup to handle cases where rteval was killed
+        and didn't clean up properly.
+
+        Args:
+            logger: rteval Log instance for logging
+        """
+        cpuset_dirs = glob.glob('/sys/fs/cgroup/rteval_*/')
+        if not cpuset_dirs:
+            logger.log(Log.DEBUG, "No leftover rteval cpusets found")
+            return
+
+        logger.log(Log.INFO, f"Cleaning up {len(cpuset_dirs)} leftover rteval cpusets from previous run")
+
+        for cpuset_dir in cpuset_dirs:
+            cpuset_name = os.path.basename(cpuset_dir.rstrip('/'))
+            try:
+                # Move all processes to root cgroup
+                procs_file = os.path.join(cpuset_dir, 'cgroup.procs')
+                if os.path.exists(procs_file):
+                    with open(procs_file, 'r') as f:
+                        pids = f.read().strip().split('\n')
+
+                    for pid in pids:
+                        if pid:  # Skip empty lines
+                            try:
+                                with open('/sys/fs/cgroup/cgroup.procs', 'w') as f:
+                                    f.write(pid)
+                            except (OSError, IOError):
+                                pass  # Process may have exited, ignore
+
+                # Remove the directory
+                os.rmdir(cpuset_dir)
+                logger.log(Log.DEBUG, f"Removed leftover cpuset: {cpuset_name}")
+            except Exception as e:
+                logger.log(Log.WARN, f"Failed to clean up {cpuset_name}: {e}")
+
+    def __init__(self, housekeeping_cpus, measurement_cpus, load_cpus, logger):
+        """
+        Initialize cpuset manager
+
+        Args:
+            housekeeping_cpus: List of CPU integers for housekeeping (may be empty)
+            measurement_cpus: List of CPU integers for measurement workloads
+            load_cpus: List of CPU integers for load workloads
+            logger: rteval Log instance for logging
+        """
+        # Check cpuset support
+        self.cpusets_init = CpusetsInit()
+        if not self.cpusets_init.supported:
+            raise RuntimeError("cgroup v2 cpuset controller not available")
+
+        # Store parameters
+        self.housekeeping_cpus = housekeeping_cpus
+        self.measurement_cpus = measurement_cpus
+        self.load_cpus = load_cpus
+        self.logger = logger
+
+        # Cpuset objects (will be created in __enter__)
+        self.housekeeping_cpuset = None
+        self.measurement_cpuset = None
+        self.loads_cpuset = None
+        self.workload_cpuset = None
+
+        # Determine cpuset creation strategy
+        self.use_workload_cpuset = (measurement_cpus == load_cpus)
+
+        # Get NUMA node range for memory assignment
+        self.numa_nodes = f"0-{self.cpusets_init.numa_nodes - 1}" if self.cpusets_init.numa_nodes > 1 else "0"
+
+        self.logger.log(Log.DEBUG, f"CpusetManager initialized: "
+                       f"housekeeping={collapse_cpulist(housekeeping_cpus) if housekeeping_cpus else 'none'}, "
+                       f"measurement={collapse_cpulist(measurement_cpus)}, "
+                       f"loads={collapse_cpulist(load_cpus)}, "
+                       f"strategy={'combined workload' if self.use_workload_cpuset else 'separate'}")
+
+    def __enter__(self):
+        """
+        Context manager entry: create cpusets
+
+        Returns:
+            self for use in with statement
+        """
+        self.logger.log(Log.INFO, "Creating rteval cpusets...")
+
+        # Create housekeeping cpuset if requested
+        if self.housekeeping_cpus:
+            self.logger.log(Log.DEBUG, f"Creating rteval_housekeeping cpuset with CPUs {collapse_cpulist(self.housekeeping_cpus)}")
+            self.housekeeping_cpuset = Cpuset('rteval_housekeeping')
+            self.housekeeping_cpuset.write_memnode(self.numa_nodes)
+            self.housekeeping_cpuset.assign_cpus(collapse_cpulist(self.housekeeping_cpus))
+            self.housekeeping_cpuset.write_cpu_exclusive(False)  # partition=member
+
+        # Create workload cpusets based on strategy
+        if self.use_workload_cpuset:
+            # Same CPUs for measurement and loads - create single combined cpuset
+            self.logger.log(Log.DEBUG, f"Creating rteval_workload cpuset with CPUs {collapse_cpulist(self.measurement_cpus)}")
+            self.workload_cpuset = Cpuset('rteval_workload')
+            self.workload_cpuset.write_memnode(self.numa_nodes)
+            self.workload_cpuset.assign_cpus(collapse_cpulist(self.measurement_cpus))
+            self.workload_cpuset.write_cpu_exclusive(False)  # partition=member
+        else:
+            # Different CPUs - create separate measurement and loads cpusets
+            self.logger.log(Log.DEBUG, f"Creating rteval_measurement cpuset with CPUs {collapse_cpulist(self.measurement_cpus)}")
+            self.measurement_cpuset = Cpuset('rteval_measurement')
+            self.measurement_cpuset.write_memnode(self.numa_nodes)
+            self.measurement_cpuset.assign_cpus(collapse_cpulist(self.measurement_cpus))
+            self.measurement_cpuset.write_cpu_exclusive(False)  # partition=member
+
+            self.logger.log(Log.DEBUG, f"Creating rteval_loads cpuset with CPUs {collapse_cpulist(self.load_cpus)}")
+            self.loads_cpuset = Cpuset('rteval_loads')
+            self.loads_cpuset.write_memnode(self.numa_nodes)
+            self.loads_cpuset.assign_cpus(collapse_cpulist(self.load_cpus))
+            self.loads_cpuset.write_cpu_exclusive(False)  # partition=member
+
+        self.logger.log(Log.INFO, "Cpusets created successfully")
+        return self
+
+    def __exit__(self, exc_type, exc_val, exc_tb):
+        """
+        Context manager exit: cleanup cpusets
+
+        Moves all processes back to root cgroup and destroys cpusets in reverse order.
+
+        Returns:
+            False (don't suppress exceptions)
+        """
+        self.logger.log(Log.INFO, "Cleaning up rteval cpusets...")
+
+        try:
+            # Move all processes back to root cgroup before destroying cpusets
+            # Destroy in reverse order of creation
+
+            if self.use_workload_cpuset:
+                if self.workload_cpuset:
+                    self._migrate_to_root(self.workload_cpuset, 'rteval_workload')
+                    self.workload_cpuset.destroy()
+                    self.logger.log(Log.DEBUG, "Destroyed rteval_workload cpuset")
+            else:
+                if self.loads_cpuset:
+                    self._migrate_to_root(self.loads_cpuset, 'rteval_loads')
+                    self.loads_cpuset.destroy()
+                    self.logger.log(Log.DEBUG, "Destroyed rteval_loads cpuset")
+
+                if self.measurement_cpuset:
+                    self._migrate_to_root(self.measurement_cpuset, 'rteval_measurement')
+                    self.measurement_cpuset.destroy()
+                    self.logger.log(Log.DEBUG, "Destroyed rteval_measurement cpuset")
+
+            if self.housekeeping_cpuset:
+                self._migrate_to_root(self.housekeeping_cpuset, 'rteval_housekeeping')
+                self.housekeeping_cpuset.destroy()
+                self.logger.log(Log.DEBUG, "Destroyed rteval_housekeeping cpuset")
+
+            self.logger.log(Log.INFO, "Cpuset cleanup complete")
+        except Exception as e:
+            self.logger.log(Log.ERR, f"Error during cpuset cleanup: {e}")
+
+        return False  # Don't suppress exceptions
+
+    def _migrate_to_root(self, cpuset, name):
+        """
+        Migrate all tasks from a cpuset back to root cgroup
+
+        Args:
+            cpuset: Cpuset object to migrate from
+            name: Name of cpuset (for logging)
+        """
+        try:
+            tm = TaskMigrate(cpuset, self.cpusets_init)
+            migrated, failed = tm.migrate()
+            self.logger.log(Log.DEBUG, f"Migrated {migrated} tasks from {name} to root (failed: {failed})")
+        except Exception as e:
+            self.logger.log(Log.WARN, f"Error migrating tasks from {name}: {e}")
+
+    def migrate_root_tasks_to_housekeeping(self):
+        """
+        Migrate all tasks from root cgroup to housekeeping cpuset
+
+        Only executes if housekeeping cpuset was created.
+        Logs migration results.
+        """
+        if not self.housekeeping_cpuset:
+            self.logger.log(Log.DEBUG, "No housekeeping cpuset, skipping root task migration")
+            return
+
+        self.logger.log(Log.INFO, "Migrating system tasks to housekeeping cpuset...")
+
+        try:
+            tm = TaskMigrate(self.cpusets_init, self.housekeeping_cpuset)
+            migrated, failed = tm.migrate()
+            self.logger.log(Log.INFO, f"Migrated {migrated} system tasks to housekeeping (failed: {failed})")
+        except Exception as e:
+            self.logger.log(Log.ERR, f"Error migrating root tasks to housekeeping: {e}")
+
+    def migrate_measurement_threads(self, pids):
+        """
+        Migrate measurement process PIDs to appropriate cpuset
+
+        Migrates to rteval_measurement if using separate cpusets,
+        or rteval_workload if using combined cpuset.
+
+        Args:
+            pids: List of process IDs to migrate
+        """
+        if not pids:
+            self.logger.log(Log.DEBUG, "No measurement PIDs to migrate")
+            return
+
+        # Determine target cpuset
+        if self.use_workload_cpuset:
+            target_cpuset = self.workload_cpuset
+            cpuset_name = "rteval_workload"
+        else:
+            target_cpuset = self.measurement_cpuset
+            cpuset_name = "rteval_measurement"
+
+        if not target_cpuset:
+            self.logger.log(Log.WARN, f"Target cpuset {cpuset_name} not created, cannot migrate measurement threads")
+            return
+
+        self.logger.log(Log.DEBUG, f"Migrating {len(pids)} measurement PIDs to {cpuset_name}")
+
+        migrated = 0
+        failed = 0
+        for pid in pids:
+            if target_cpuset.write_pid(pid):
+                migrated += 1
+            else:
+                failed += 1
+
+        self.logger.log(Log.INFO, f"Migrated {migrated} measurement threads to {cpuset_name} (failed: {failed})")
+
+    def migrate_load_threads(self, pids):
+        """
+        Migrate load process PIDs to appropriate cpuset
+
+        Migrates to rteval_loads if using separate cpusets,
+        or rteval_workload if using combined cpuset.
+
+        Args:
+            pids: List of process IDs to migrate
+        """
+        if not pids:
+            self.logger.log(Log.DEBUG, "No load PIDs to migrate")
+            return
+
+        # Determine target cpuset
+        if self.use_workload_cpuset:
+            target_cpuset = self.workload_cpuset
+            cpuset_name = "rteval_workload"
+        else:
+            target_cpuset = self.loads_cpuset
+            cpuset_name = "rteval_loads"
+
+        if not target_cpuset:
+            self.logger.log(Log.WARN, f"Target cpuset {cpuset_name} not created, cannot migrate load threads")
+            return
+
+        self.logger.log(Log.DEBUG, f"Migrating {len(pids)} load PIDs to {cpuset_name}")
+
+        migrated = 0
+        failed = 0
+        for pid in pids:
+            if target_cpuset.write_pid(pid):
+                migrated += 1
+            else:
+                failed += 1
+
+        self.logger.log(Log.INFO, f"Migrated {migrated} load threads to {cpuset_name} (failed: {failed})")
diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 7e5916c52965..b8c443e8e0c5 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -175,6 +175,19 @@ class rtevalModulePrototype(threading.Thread):
         return self._donotrun is False
 
 
+    def get_subprocess_pids(self):
+        """
+        Return list of subprocess PIDs spawned by this module
+
+        This method should be overridden by modules that spawn subprocesses.
+        Default implementation returns an empty list.
+
+        Returns:
+            list: List of integer PIDs of spawned subprocesses
+        """
+        return []
+
+
     def __run(self):
         "Workload thread runner - takes care of keeping the workload running as long as needed"
         if self.shouldStop():
@@ -539,6 +552,23 @@ class RtEvalModules:
         self._logger.log(Log.DEBUG, f"All {self._module_type} modules completed")
 
 
+    def GetSubprocessPids(self):
+        """
+        Get subprocess PIDs from all loaded modules
+
+        Collects PIDs from all modules that will run by calling each module's
+        get_subprocess_pids() method.
+
+        Returns:
+            list: List of integer PIDs from all modules
+        """
+        pids = []
+        for (modname, mod) in self.__modules:
+            if mod.WorkloadWillRun():
+                pids.extend(mod.get_subprocess_pids())
+        return pids
+
+
     def MakeReport(self):
         """Collects all the loaded modules reports in a single libxml2.xmlNode() object"""
 
diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index fddb85648506..d04231de384f 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -159,6 +159,13 @@ class Hackbench(CommandLineLoad):
         # As hackbench is short-lived, lets pretend it is always alive
         return True
 
+    def get_subprocess_pids(self):
+        """Return PIDs of all running hackbench processes"""
+        pids = []
+        for task in self.tasks.values():
+            if task and task.poll() is None:
+                pids.append(task.pid)
+        return pids
 
     def _WorkloadCleanup(self):
         if self._donotrun:
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index c960242362d3..5efb0a659843 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -314,6 +314,13 @@ class Kcompile(CommandLineLoad):
 
         return True
 
+    def get_subprocess_pids(self):
+        """Return PIDs of all kcompile build jobs"""
+        pids = []
+        for job in self.buildjobs.values():
+            if job.jobid and job.isrunning():
+                pids.append(job.jobid.pid)
+        return pids
 
     def _WorkloadCleanup(self):
         if self._donotrun:
diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 4ad7197fc590..509217ac7f8d 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -110,6 +110,12 @@ class Stressng(CommandLineLoad):
             return self.process.poll() is None
         return False
 
+    def get_subprocess_pids(self):
+        """Return PID of stress-ng process"""
+        if self.started and self.process and self.process.poll() is None:
+            return [self.process.pid]
+        return []
+
     def _WorkloadCleanup(self):
         " Makesure to kill stress-ng before rteval ends "
         if not self.started:
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index f7039ab2749f..c3ef4a54677d 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -296,6 +296,11 @@ class Cyclictest(rtevalModulePrototype):
             return self.__cyclicprocess.poll() is None
         return False
 
+    def get_subprocess_pids(self):
+        """Return PID of cyclictest process"""
+        if self.__cyclicprocess and self.__cyclicprocess.poll() is None:
+            return [self.__cyclicprocess.pid]
+        return []
 
     def _parse_max_latencies(self, line):
         if not line.startswith('# Max Latencies: '):
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 7ad8997c95dc..4dfe18cc5492 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -273,6 +273,12 @@ class Timerlat(rtevalModulePrototype):
             return self.__timerlat_process.poll() is None
         return False
 
+    def get_subprocess_pids(self):
+        """Return PID of timerlat process"""
+        if self.__timerlat_process and self.__timerlat_process.poll() is None:
+            return [self.__timerlat_process.pid]
+        return []
+
     def _WorkloadCleanup(self):
         if not self.__started:
             return
-- 
2.54.0

