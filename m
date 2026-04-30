Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9935369203
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577535; cv=none; b=Dgf7S/LqSBb13DoARYrpv3XNEmjhC86zgvqa3HoG4A6pnnrUtQx4pOI4xUzMvO36KIYblfwMun/ujSa+BoUAbWAV3HI1e8IwEQy/BRknfM3myDSo2I9SPFmcsXUH0+jeZFZ3ECbDQntj6JQd/W15EPSPg+riofRmMl3kRIhB3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577535; c=relaxed/simple;
	bh=fQiJjSONEFLrGJy0OyB+aFRreHkcL4r9e3a3wdSSwaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVUROj05QcZocVnTcIIqAVZvnYMxWCaTYP6A7+bhxe2Nf2mxX5lVziJLHG4+vxWgObgoqTtpOUZ6PIncNUxjQTwjAR6q2v+6h3Pzgg1+QSh/6mLx/ISv7ZZ6tHkMj7H6Aln5n0CT89F6DXiVZ752ViYx5MxftOoxVb9y8rAK7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sibTRiRG; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sibTRiRG"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d6d5e45c43so137824485a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777577532; x=1778182332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFgSKhWBdRGOdfAn8EL2fciwxhOnu75+ZNipJ2sz354=;
        b=sibTRiRGrTdyiMaLbLihyPfgbl7ixCMOfw3/meEgajwsNyKubLp9tuKqi1+HbWvLpW
         6HdZLQb2KOy7U42/cCerEnGS0xT+cmXa1EA8lO9sRoIMAysjmUXW6+XQAhont3iCpK3w
         5lNbeLmplfDt1Uu9YS8erLwPLR7W74d3TWvgbCfdVwYMhzyvMNFM1YJinOPacZYy7pxd
         NJucHCpaq1yA87O855GDHZkEBC8EoNauAO3+mizW/0KbjlKZVxygxnmjhIHu6VqS/NnO
         JARoAn+9EY5QDtyEEiX7oMQCn5PE6yoAZUhLnPKSWq91/uXdJZR65DwvPTaX8gT9DlQH
         dDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577532; x=1778182332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFgSKhWBdRGOdfAn8EL2fciwxhOnu75+ZNipJ2sz354=;
        b=oYeX2wbAwGHCG9Gb9AMRtyjscckh/6obsO/hU8TiegLNoL9E1XoitA2bEqgx6e6L+V
         7tQG2dQbbCtQCR5Wc24Rf+3eXiJa1F+e6IbhxhozXGB7U8az34/UPUEXj62wELr+gcs9
         BsvmrJPCHg2p2WwaWxzLi/d6ELldRD3O3b4ic1prW25L+OYzpx01KxFjAbBt/rmvMwL3
         MH5B93utfEtRv0FKxpfzvrx0TV/GNbqkpWZZrUj1jDFO4jVi05riBqC5TyLN7EZw4RnG
         gBiBCSr2VHm72PdL3Mp0mPsYsfMw421dmRkv9yNMSVbKxxS1hQKIrLNTtJrxvXHd2N4n
         xwBA==
X-Gm-Message-State: AOJu0Yzj9UgVCTlU0ltZc604ggXsHZ0XRfheIwBaTtbQ+Ao23kjUJnMO
	N1cFiOrvKIlArLuwJwZi1iPKh021YDbEJPEcgdnzlpsqh5iaoz4BFXf55Y9QAQ==
X-Gm-Gg: AeBDieszx0CZAHtjMHHBDWigTUoG41h/IZvDrjyQcmzqq1F4gOz5JCU/2a99Rp8wRfJ
	C+K9UKdz2VHoAJbxINFIB5UzmBnlmq+JFIcseGumW4xooeg5L7Dr9/beXDHF0ZczygEbpftpjvQ
	BkAux9kEzBC5lxFn+yRFtPZwVB5mlSoEKJz2T3MhT8XaSdXOaIKZu7Ap/Vw/Tj951XUoEX8IkRI
	1lVfhvfo4zyMr3JPqnzcRXepWwnwpZRKYxPHFmIOixkoN1ax60CQBxa0qpz2jv9VdP/T4UicbBs
	5GyCofC3vEiL8P8muHJ+orzeD/KVVY8AX5Agu8KXHb8VKYmvj++a63FFbx8LHp/ueX/0HCqCCu2
	/DHmMKEJyyThcVDEd5YIDk6MbiVTW+alF+D95rGjhcrhKHj06S6eDpA6AMrI3bfaPegGNtAmRYi
	WoR8iXF+eRyuiFXF7fvKMuUt0kfe4jjV5bn1E336qBjPw32rO0DzzN+Ir0weFcL52yj6GYddRKf
	kchVkb/0JSyfdg8dT4grBahgYNgbg==
X-Received: by 2002:a05:622a:1356:b0:50e:ca38:e220 with SMTP id d75a77b69052e-5102adff28dmr64219361cf.45.1777577532169;
        Thu, 30 Apr 2026 12:32:12 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103d1c6957sm4270391cf.2.2026.04.30.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:32:11 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 4/7] rteval: Simplify cpuset implementation to match isolcpus philosophy
Date: Thu, 30 Apr 2026 15:31:41 -0400
Message-ID: <20260430193144.354599-5-jkacur@redhat.com>
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

Simplify the cpuset integration to create only 1-2 cpusets instead of 1-3,
matching how rteval works with isolcpus: measurements get isolation, loads
use affinity constraints only.

Changes:
- rteval_housekeeping: Created only if --housekeeping specified (system tasks)
- rteval_measurement: Always created for measurement threads
- Loads: Use taskset for CPU affinity (no cpuset migration)

This approach:
- Mirrors isolcpus behavior (measurements isolated, loads constrained via affinity)
- Eliminates complexity of load cpuset migration
- Removes race conditions with short-lived load processes
- Simplifies codebase while maintaining CPU isolation goals

Modified files:
- rteval/cpusetmanager.py: Removed load_cpus parameter and migrate_load_threads()
- rteval-cmd: Updated CpusetManager instantiation, removed load migration
- rteval/__init__.py: Simplified to only migrate measurement threads
- rteval/modules/loads/*: Removed get_subprocess_pids() methods (no longer needed)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                        |   8 +-
 rteval/__init__.py                |  11 +--
 rteval/cpusetmanager.py           | 131 ++++++------------------------
 rteval/modules/loads/hackbench.py |   8 --
 rteval/modules/loads/kcompile.py  |   8 --
 rteval/modules/loads/stressng.py  |   6 --
 6 files changed, 30 insertions(+), 142 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 85adf2502d20..29254a8f1a7c 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -542,10 +542,10 @@ if __name__ == '__main__':
             CpusetManager.cleanup_leftover_cpusets(logger)
 
             # Create manager (will create cpusets in __enter__)
+            # Note: Load CPUs not needed - loads use taskset for CPU affinity
             cpuset_manager = CpusetManager(
                 housekeeping_cpus=housekeeping_cpus,
                 measurement_cpus=msrcfg_cpus,
-                load_cpus=ldcfg_cpus,
                 logger=logger
             )
 
@@ -568,11 +568,7 @@ if __name__ == '__main__':
                     loadmods.Start()
                     nthreads = loadmods.Unleash()
 
-                    # Migrate load processes
-                    time.sleep(0.5)  # Give processes time to spawn
-                    load_pids = loadmods.GetSubprocessPids()
-                    cpuset_manager.migrate_load_threads(load_pids)
-
+                    # Loads use taskset for CPU affinity (no cpuset migration needed)
                     logger.log(Log.INFO, f"Started {nthreads} load threads - will run for {rtevcfg.duration} seconds")
                     logger.log(Log.INFO, "No measurements will be performed, due to the --onlyload option")
                     time.sleep(rtevcfg.duration)
diff --git a/rteval/__init__.py b/rteval/__init__.py
index a85fe2e21328..2eadb2045e2b 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -185,20 +185,15 @@ class RtEval(rtevalReport):
             self._measuremods.Unleash()
             measure_start = datetime.now()
 
-            # After Unleash(), do cpuset migration
+            # After Unleash(), migrate measurement threads to cpuset
+            # Note: Load threads use taskset for CPU affinity (no cpuset migration needed)
             if self._cpuset_manager:
-                # Small delay to let processes spawn
+                # Small delay to let measurement processes spawn
                 time.sleep(0.5)
 
-                if self._loadmods:
-                    load_pids = self._loadmods.GetSubprocessPids()
-                    self._cpuset_manager.migrate_load_threads(load_pids)
-
                 meas_pids = self._measuremods.GetSubprocessPids()
                 self._cpuset_manager.migrate_measurement_threads(meas_pids)
 
-                self.__logger.log(Log.INFO, "Processes migrated to cpusets")
-
             # wait for time to expire or thread to die
             signal.signal(signal.SIGINT, sig_handler)
             signal.signal(signal.SIGTERM, sig_handler)
diff --git a/rteval/cpusetmanager.py b/rteval/cpusetmanager.py
index 55f57580d5fa..c1aa04431f3a 100644
--- a/rteval/cpusetmanager.py
+++ b/rteval/cpusetmanager.py
@@ -20,10 +20,11 @@ class CpusetManager:
     """
     Manager for rteval cpusets with automatic cleanup
 
-    Creates 1-3 cpusets dynamically based on CPU configuration:
+    Creates 1-2 cpusets based on configuration:
     - rteval_housekeeping: Only if housekeeping_cpus specified
-    - rteval_workload: When measurement_cpus == load_cpus (combined)
-    - rteval_measurement + rteval_loads: When measurement_cpus != load_cpus (separate)
+    - rteval_measurement: Always created for measurement workloads
+
+    Load workloads use taskset for CPU affinity (no cpuset needed).
 
     Uses context manager pattern for automatic cleanup.
     """
@@ -69,15 +70,16 @@ class CpusetManager:
             except Exception as e:
                 logger.log(Log.WARN, f"Failed to clean up {cpuset_name}: {e}")
 
-    def __init__(self, housekeeping_cpus, measurement_cpus, load_cpus, logger):
+    def __init__(self, housekeeping_cpus, measurement_cpus, logger):
         """
         Initialize cpuset manager
 
         Args:
             housekeeping_cpus: List of CPU integers for housekeeping (may be empty)
             measurement_cpus: List of CPU integers for measurement workloads
-            load_cpus: List of CPU integers for load workloads
             logger: rteval Log instance for logging
+
+        Note: Load workloads use taskset for CPU affinity and don't need cpusets.
         """
         # Check cpuset support
         self.cpusets_init = CpusetsInit()
@@ -87,26 +89,18 @@ class CpusetManager:
         # Store parameters
         self.housekeeping_cpus = housekeeping_cpus
         self.measurement_cpus = measurement_cpus
-        self.load_cpus = load_cpus
         self.logger = logger
 
         # Cpuset objects (will be created in __enter__)
         self.housekeeping_cpuset = None
         self.measurement_cpuset = None
-        self.loads_cpuset = None
-        self.workload_cpuset = None
-
-        # Determine cpuset creation strategy
-        self.use_workload_cpuset = (measurement_cpus == load_cpus)
 
         # Get NUMA node range for memory assignment
         self.numa_nodes = f"0-{self.cpusets_init.numa_nodes - 1}" if self.cpusets_init.numa_nodes > 1 else "0"
 
         self.logger.log(Log.DEBUG, f"CpusetManager initialized: "
                        f"housekeeping={collapse_cpulist(housekeeping_cpus) if housekeeping_cpus else 'none'}, "
-                       f"measurement={collapse_cpulist(measurement_cpus)}, "
-                       f"loads={collapse_cpulist(load_cpus)}, "
-                       f"strategy={'combined workload' if self.use_workload_cpuset else 'separate'}")
+                       f"measurement={collapse_cpulist(measurement_cpus)}")
 
     def __enter__(self):
         """
@@ -125,27 +119,12 @@ class CpusetManager:
             self.housekeeping_cpuset.assign_cpus(collapse_cpulist(self.housekeeping_cpus))
             self.housekeeping_cpuset.write_cpu_exclusive(False)  # partition=member
 
-        # Create workload cpusets based on strategy
-        if self.use_workload_cpuset:
-            # Same CPUs for measurement and loads - create single combined cpuset
-            self.logger.log(Log.DEBUG, f"Creating rteval_workload cpuset with CPUs {collapse_cpulist(self.measurement_cpus)}")
-            self.workload_cpuset = Cpuset('rteval_workload')
-            self.workload_cpuset.write_memnode(self.numa_nodes)
-            self.workload_cpuset.assign_cpus(collapse_cpulist(self.measurement_cpus))
-            self.workload_cpuset.write_cpu_exclusive(False)  # partition=member
-        else:
-            # Different CPUs - create separate measurement and loads cpusets
-            self.logger.log(Log.DEBUG, f"Creating rteval_measurement cpuset with CPUs {collapse_cpulist(self.measurement_cpus)}")
-            self.measurement_cpuset = Cpuset('rteval_measurement')
-            self.measurement_cpuset.write_memnode(self.numa_nodes)
-            self.measurement_cpuset.assign_cpus(collapse_cpulist(self.measurement_cpus))
-            self.measurement_cpuset.write_cpu_exclusive(False)  # partition=member
-
-            self.logger.log(Log.DEBUG, f"Creating rteval_loads cpuset with CPUs {collapse_cpulist(self.load_cpus)}")
-            self.loads_cpuset = Cpuset('rteval_loads')
-            self.loads_cpuset.write_memnode(self.numa_nodes)
-            self.loads_cpuset.assign_cpus(collapse_cpulist(self.load_cpus))
-            self.loads_cpuset.write_cpu_exclusive(False)  # partition=member
+        # Create measurement cpuset
+        self.logger.log(Log.DEBUG, f"Creating rteval_measurement cpuset with CPUs {collapse_cpulist(self.measurement_cpus)}")
+        self.measurement_cpuset = Cpuset('rteval_measurement')
+        self.measurement_cpuset.write_memnode(self.numa_nodes)
+        self.measurement_cpuset.assign_cpus(collapse_cpulist(self.measurement_cpus))
+        self.measurement_cpuset.write_cpu_exclusive(False)  # partition=member
 
         self.logger.log(Log.INFO, "Cpusets created successfully")
         return self
@@ -165,21 +144,10 @@ class CpusetManager:
             # Move all processes back to root cgroup before destroying cpusets
             # Destroy in reverse order of creation
 
-            if self.use_workload_cpuset:
-                if self.workload_cpuset:
-                    self._migrate_to_root(self.workload_cpuset, 'rteval_workload')
-                    self.workload_cpuset.destroy()
-                    self.logger.log(Log.DEBUG, "Destroyed rteval_workload cpuset")
-            else:
-                if self.loads_cpuset:
-                    self._migrate_to_root(self.loads_cpuset, 'rteval_loads')
-                    self.loads_cpuset.destroy()
-                    self.logger.log(Log.DEBUG, "Destroyed rteval_loads cpuset")
-
-                if self.measurement_cpuset:
-                    self._migrate_to_root(self.measurement_cpuset, 'rteval_measurement')
-                    self.measurement_cpuset.destroy()
-                    self.logger.log(Log.DEBUG, "Destroyed rteval_measurement cpuset")
+            if self.measurement_cpuset:
+                self._migrate_to_root(self.measurement_cpuset, 'rteval_measurement')
+                self.measurement_cpuset.destroy()
+                self.logger.log(Log.DEBUG, "Destroyed rteval_measurement cpuset")
 
             if self.housekeeping_cpuset:
                 self._migrate_to_root(self.housekeeping_cpuset, 'rteval_housekeeping')
@@ -229,76 +197,27 @@ class CpusetManager:
 
     def migrate_measurement_threads(self, pids):
         """
-        Migrate measurement process PIDs to appropriate cpuset
-
-        Migrates to rteval_measurement if using separate cpusets,
-        or rteval_workload if using combined cpuset.
+        Migrate measurement subprocess PIDs to rteval_measurement cpuset
 
         Args:
-            pids: List of process IDs to migrate
+            pids: List of subprocess PIDs to migrate
         """
         if not pids:
             self.logger.log(Log.DEBUG, "No measurement PIDs to migrate")
             return
 
-        # Determine target cpuset
-        if self.use_workload_cpuset:
-            target_cpuset = self.workload_cpuset
-            cpuset_name = "rteval_workload"
-        else:
-            target_cpuset = self.measurement_cpuset
-            cpuset_name = "rteval_measurement"
-
-        if not target_cpuset:
-            self.logger.log(Log.WARN, f"Target cpuset {cpuset_name} not created, cannot migrate measurement threads")
-            return
-
-        self.logger.log(Log.DEBUG, f"Migrating {len(pids)} measurement PIDs to {cpuset_name}")
-
-        migrated = 0
-        failed = 0
-        for pid in pids:
-            if target_cpuset.write_pid(pid):
-                migrated += 1
-            else:
-                failed += 1
-
-        self.logger.log(Log.INFO, f"Migrated {migrated} measurement threads to {cpuset_name} (failed: {failed})")
-
-    def migrate_load_threads(self, pids):
-        """
-        Migrate load process PIDs to appropriate cpuset
-
-        Migrates to rteval_loads if using separate cpusets,
-        or rteval_workload if using combined cpuset.
-
-        Args:
-            pids: List of process IDs to migrate
-        """
-        if not pids:
-            self.logger.log(Log.DEBUG, "No load PIDs to migrate")
-            return
-
-        # Determine target cpuset
-        if self.use_workload_cpuset:
-            target_cpuset = self.workload_cpuset
-            cpuset_name = "rteval_workload"
-        else:
-            target_cpuset = self.loads_cpuset
-            cpuset_name = "rteval_loads"
-
-        if not target_cpuset:
-            self.logger.log(Log.WARN, f"Target cpuset {cpuset_name} not created, cannot migrate load threads")
+        if not self.measurement_cpuset:
+            self.logger.log(Log.WARN, "rteval_measurement cpuset not created, cannot migrate measurement threads")
             return
 
-        self.logger.log(Log.DEBUG, f"Migrating {len(pids)} load PIDs to {cpuset_name}")
+        self.logger.log(Log.DEBUG, f"Migrating {len(pids)} measurement PIDs to rteval_measurement")
 
         migrated = 0
         failed = 0
         for pid in pids:
-            if target_cpuset.write_pid(pid):
+            if self.measurement_cpuset.write_pid(pid):
                 migrated += 1
             else:
                 failed += 1
 
-        self.logger.log(Log.INFO, f"Migrated {migrated} load threads to {cpuset_name} (failed: {failed})")
+        self.logger.log(Log.INFO, f"Migrated {migrated} measurement threads to rteval_measurement (failed: {failed})")
diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index d04231de384f..946a2adc2e57 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -159,14 +159,6 @@ class Hackbench(CommandLineLoad):
         # As hackbench is short-lived, lets pretend it is always alive
         return True
 
-    def get_subprocess_pids(self):
-        """Return PIDs of all running hackbench processes"""
-        pids = []
-        for task in self.tasks.values():
-            if task and task.poll() is None:
-                pids.append(task.pid)
-        return pids
-
     def _WorkloadCleanup(self):
         if self._donotrun:
             return
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 5efb0a659843..23586b7a3c8d 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -314,14 +314,6 @@ class Kcompile(CommandLineLoad):
 
         return True
 
-    def get_subprocess_pids(self):
-        """Return PIDs of all kcompile build jobs"""
-        pids = []
-        for job in self.buildjobs.values():
-            if job.jobid and job.isrunning():
-                pids.append(job.jobid.pid)
-        return pids
-
     def _WorkloadCleanup(self):
         if self._donotrun:
             return
diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 509217ac7f8d..4ad7197fc590 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -110,12 +110,6 @@ class Stressng(CommandLineLoad):
             return self.process.poll() is None
         return False
 
-    def get_subprocess_pids(self):
-        """Return PID of stress-ng process"""
-        if self.started and self.process and self.process.poll() is None:
-            return [self.process.pid]
-        return []
-
     def _WorkloadCleanup(self):
         " Makesure to kill stress-ng before rteval ends "
         if not self.started:
-- 
2.54.0

