Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77F4AAC63
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116013; cv=none; b=t5WW6nJR2QU+8BKVgTYUbDY3TcoUDPFhNuYlIwtmpaiUbfEq2PqiaGafnVCEt+vzlNhGgtqWUrGTdTSJKV0BWYmJVUnBD3USnizBn9a0EG5/LLXEO3XMYoelt8IIAFMAy2A3QsXZxL/yyV8Gn5XyjDHb7qvgQGQeMo9ySULAdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116013; c=relaxed/simple;
	bh=EKOrlkiAOVB4WYDR7CaN74LhmaPtS2Tx4pP8z7D+72A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTaLd8455zp2FWq8g29P6MON0cbtBF5crGl1vEDi0X/whsCn/Z12Se7figW3uOGBwSfYg1e/9gzRnYOMBlS2AV/YMnmYonG4Xs+m0JjtVWnwTaaCcFYigDCUxKy2aIKVdRY5OJlTO4/4YCNw6js6WNpAKkKMsr85TxTu9m/fCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvIhAF02; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvIhAF02"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ca5aa8so33981885a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115998; x=1790720798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLH+D/VDF8UzatiSWcn5He1BFyCY2KHdnDWdijD/O6E=;
        b=EvIhAF02mGfcCubb/1NJ1UmlnGzmCublsgxoj0/Nw8WhRKqA0Xx2c5xG4gq9N4psxE
         u/Cyxg5SZURgZcRCvRfhNSHow4EJ14J9f/K6p5XJO+CJNlWojHdqUoCWO+6otvPqKRta
         0N5DIJAwFlEZZdBvElxzupCrgNAcnKSBAWbsGBjDXq+jwlU1IzhXDGCm+WJwNbAIh81d
         5pknNAy9XWYMhec4D9txtq41t5MRT1megVpQSueKuS5NBSpM3qZtXrpTcW8Qz82MaYJw
         iFGycD1pVwsWLAws3OoL572ytSPuTL003EMu5AjWHDtwwm/+o/mb6fPVnit9ExZHiLku
         6RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115998; x=1790720798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GLH+D/VDF8UzatiSWcn5He1BFyCY2KHdnDWdijD/O6E=;
        b=RchY1nc9bZuDmsJk/IITTDE/c1KQgPNM2HakF8aR4YIFK0smVCGK5tG2x/sw7pdOfl
         9V1ha3kck6xfSrVnBrQUAyzZJhg4karyZGARe7SUTfUULBJ5v45fbyPi8u/Ae1uzfY9x
         BoYzkiktervu9UMVKtMe8OfxixeplRBnK5pi4+HiKx6SAOaHT8l2qO1TPG3FWK5RrlfQ
         9kncFFtcjqJPxt+U4ij0kE8aNdSfWNZmYLKg5f8/TbK2L4BYyK3ruf197ns2frToz8sr
         2YKpSL2KyrSKfXKN6imFABuqqiHn9t1D6LGswjVxBgxGqGJqzVjuTRh37l74pGsekzQR
         5feA==
X-Gm-Message-State: AFuF++kmPq0Gn9A1ww0N4mF2RWa8HfrrKVU+K0f1gLk537FDetyVXGzV
	XIfvjXNv37TaX8yru19zSrXO7mvQXe8Z4/43Tolbuig1azmr3mxYgeIuYDEcAg==
X-Gm-Gg: AYBFou1C5EsnjO9kNv7wRW3kh8+O1/NGpDpm6R8XJp5kofcgr0PqawyaG4m70rfZ27k
	an6nb8c3iBIbQe5w8tuyB0xwpxtgrjJ2Z76oINePWT+ul0eBHGwIOjQiyFkc5JMzh9T2FMYx/J2
	xXGHuFJxLtGtwN6eIdPQhfxZfLnBkb+BcEJrlRbuzB6i2xhfj4jhu7DQaXvuZBrMkZlXBxkgAQO
	4xcmPbYoogcxxa83NTSvNwHdDWqssCEvhTk5+7Z0TjawDsDQGYOC4UbyoYMq2XNjphDxUZmgmz3
	dLdN1u2G1QHUAxzW/tnDPk9EdKTSTzEs9At0PjjeSzjsr/bERTLmpq1h9MGB2gkx1u1fgLfFSbl
	Z2VVXXmqniwOkOFIAGY03g+jLkxfY+7IKWVr2Ib+bOrazwQ+Nu+S/ERub0FquZK3ReEZM6KAS8Y
	6ON4rbJaOkoj0vHhMi+sTVg5h7dVxbE0KvLH+tdXTSUhEzULnLAvekeEryFojMRh2sge45SqCFd
	kBX5OryK9NTEALcVeN2+PeoIEpN/uY7TtOD+V4uSW3lKO3sBkTy7LNL
X-Received: by 2002:a05:620a:438c:b0:92e:71bb:d1c0 with SMTP id af79cd13be357-93c250a9555mr130402985a.15.1790115998062;
        Tue, 22 Sep 2026 15:26:38 -0700 (PDT)
Received: from Cumhall.home ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4425f3sm7552786d6.34.2026.09.22.15.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:26:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 8/8] rteval: Add --loads-cpuset to confine loads to a member cpuset
Date: Tue, 22 Sep 2026 18:25:52 -0400
Message-ID: <20260922222552.482102-9-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922222552.482102-1-jkacur@redhat.com>
References: <20260922222552.482102-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an opt-in --loads-cpuset flag that places load workloads in a
dedicated rteval_loads cgroup v2 cpuset (partition=member) instead of
relying only on taskset. This is additive: when the flag is absent,
loads keep using taskset exactly as before.

A cpuset is a hard ceiling that all descendants inherit, so kcompile
(make -jN -> gcc/as/ld) and hackbench fan-outs cannot escape it, unlike
a taskset mask which a child can widen via sched_setaffinity(). The
loads cpuset is always a member partition so its CPUs remain in the root
cgroup's effective set, keeping CPUs available to the main rteval
process when it is left in root (no --housekeeping).

Confinement uses self-placement before exec: a shared cpuset_preexec()
helper returns a preexec_fn that writes the child's own PID into the
cpuset's cgroup.procs, so the whole descendant subtree self-homes as it
spawns. For loads it is strict (a failure raises RuntimeError and aborts
the launch, so a load cannot silently escape its cpuset); for
measurement it is lenient and falls back to post-hoc PID migration. The
cyclictest and timerlat modules are refactored onto this shared helper,
removing two copies of the previous inline closure; timerlat continues
to work independently of cyclictest.

--loads-cpuset requires --cpusets and is skipped under --noload. Because
the loads and measurement cpusets are both member partitions when
--measurement-member is also given, they may share CPUs; the isolated
measurement partition overlap case is still rejected by the existing
overlap guard.

Tests covering the new flag are added to tests/cpusets/test-cpusets.sh
(requires --cpusets, member partition, skipped with --noload, and the
overlapping member-cpuset case with --measurement-member) and to
tests/test_cpusetmanager.py (default no loads cpuset, member creation,
CLI validation and help text).

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                               |  12 +-
 rteval/__init__.py                       |  42 ++--
 rteval/cpuset.py                         |  37 ++++
 rteval/cpusetmanager.py                  | 111 +++++++---
 rteval/modules/__init__.py               |  11 +
 rteval/modules/loads/hackbench.py        |   7 +-
 rteval/modules/loads/kcompile.py         |  12 +-
 rteval/modules/loads/stressng.py         |   7 +-
 rteval/modules/measurement/cyclictest.py |  13 +-
 rteval/modules/measurement/timerlat.py   |  13 +-
 tests/cpusets/test-cpusets.sh            | 256 +++++++++++++++++++++++
 tests/test_cpusetmanager.py              |  68 ++++++
 12 files changed, 517 insertions(+), 72 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 15f6f505fed7..126226725697 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -425,6 +425,11 @@ if __name__ == '__main__':
             if not rtevcfg.cpusets:
                 raise RuntimeError("--measurement-member requires --cpusets")
 
+        # Validate --loads-cpuset usage
+        if ldcfg.cpuset:
+            if not rtevcfg.cpusets:
+                raise RuntimeError("--loads-cpuset requires --cpusets")
+
         # Validate and process housekeeping CPUs
         housekeeping_cpus = []
         if rtevcfg.housekeeping:
@@ -591,14 +596,17 @@ if __name__ == '__main__':
             CpusetManager.cleanup_leftover_cpusets(logger)
 
             # Create manager (will create cpusets in __enter__)
-            # Note: Load CPUs not needed - loads use taskset for CPU affinity
+            # Loads use taskset by default; with --loads-cpuset they are also
+            # confined to the rteval_loads cpuset (member partition).
             cpuset_manager = CpusetManager(
                 housekeeping_cpus=housekeeping_cpus,
                 measurement_cpus=msrcfg_cpus,
                 logger=logger,
                 housekeeping_isolated=rtevcfg.housekeeping_isolated,
                 create_measurement=not rtevcfg.onlyload,
-                measurement_member=msrcfg.member
+                measurement_member=msrcfg.member,
+                loads_cpus=ldcfg_cpus,
+                create_loads=ldcfg.cpuset and not rtevcfg.noload
             )
 
         # Pass cpuset_manager to RtEval (None if not using cpusets)
diff --git a/rteval/__init__.py b/rteval/__init__.py
index b6d3c39a4b6a..5b4558f68518 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -142,6 +142,27 @@ class RtEval(rtevalReport):
         self._measuremods.Setup(params)
 
 
+    def __apply_cpuset_path(self, modules, cpuset, label):
+        """Tell each module in a container which cpuset to self-home into.
+
+        Sets cfg.cpuset_path on every module's config so the module can launch
+        its workload directly inside the cpuset (self-placement before exec).
+        No-op when the cpuset was not created or the container is empty.
+        """
+        if not modules or not cpuset:
+            return
+        cpuset_path = cpuset._cpuset_path
+        for (modname, mod) in modules._RtEvalModules__modules:
+            # Try to find the config attribute - modules use self.__cfg (name-mangled)
+            cfg = None
+            for attr in ['_cfg', f'_{mod.__class__.__name__}__cfg']:
+                if hasattr(mod, attr):
+                    cfg = getattr(mod, attr)
+                    break
+            if cfg:
+                cfg.cpuset_path = cpuset_path
+                self.__logger.log(Log.DEBUG, f"Set {label} cpuset_path for {modname}: {cpuset_path}")
+
     def __RunMeasurement(self):
         global EARLYSTOP
 
@@ -174,19 +195,14 @@ class RtEval(rtevalReport):
                 print(f"started measurement threads on {onlinecpus} cores")
             print(f"Run duration: {str(self.__rtevcfg.duration)} seconds")
 
-            # Pass cpuset path to measurement modules so they can launch inside the cpuset
-            if self._cpuset_manager and self._cpuset_manager.measurement_cpuset:
-                cpuset_path = self._cpuset_manager.measurement_cpuset._cpuset_path
-                for (modname, mod) in self._measuremods._RtEvalModules__modules:
-                    # Try to find the config attribute - modules use self.__cfg (name-mangled)
-                    cfg = None
-                    for attr in ['_cfg', f'_{mod.__class__.__name__}__cfg']:
-                        if hasattr(mod, attr):
-                            cfg = getattr(mod, attr)
-                            break
-                    if cfg:
-                        cfg.cpuset_path = cpuset_path
-                        self.__logger.log(Log.DEBUG, f"Set cpuset_path for {modname}: {cpuset_path}")
+            # Pass cpuset paths to the modules so they can launch inside their
+            # cpuset (self-placement before exec). Done before Start()/Unleash()
+            # so each workload self-homes as it spawns.
+            if self._cpuset_manager:
+                self.__apply_cpuset_path(self._measuremods,
+                                         self._cpuset_manager.measurement_cpuset, "measurement")
+                self.__apply_cpuset_path(self._loadmods,
+                                         self._cpuset_manager.loads_cpuset, "loads")
 
             self._measuremods.Start()
 
diff --git a/rteval/cpuset.py b/rteval/cpuset.py
index a0b3d8102543..3c85fce6b04d 100644
--- a/rteval/cpuset.py
+++ b/rteval/cpuset.py
@@ -17,6 +17,43 @@ PROCESS_BLOCKLIST = {
 }
 
 
+def cpuset_preexec(cpuset_path, strict=False):
+    """Return a subprocess preexec_fn that self-homes the child into a cpuset.
+
+    The returned callable runs in the forked child just before exec and writes
+    the child's own PID into <cpuset_path>/cgroup.procs, so the child and every
+    descendant it later forks inherit the cpuset natively -- a hard ceiling that
+    taskset masks cannot widen. Returns None when cpuset_path is falsy, so
+    callers can pass the result straight to Popen(preexec_fn=...) whether or not
+    a cpuset is in use.
+
+    strict controls the failure policy:
+      - False (measurement modules): swallow errors so a failed self-placement
+        falls back to the parent's post-hoc PID migration.
+      - True (loads): let the error propagate and abort the launch, since a load
+        escaping its cpuset would defeat the confinement the caller asked for.
+    """
+    if not cpuset_path:
+        return None
+
+    procs_file = os.path.join(cpuset_path, 'cgroup.procs')
+
+    def _move_to_cpuset():
+        """Move the forked child into the cpuset before exec."""
+        try:
+            with open(procs_file, 'w') as fp:
+                fp.write(str(os.getpid()))
+        except Exception as exc:
+            if strict:
+                # Raise a RuntimeError (not the underlying OSError) so callers
+                # that catch OSError around Popen don't silently swallow it.
+                raise RuntimeError(
+                    f"failed to move process into cpuset {cpuset_path}: {exc}") from exc
+            # else: fail silently - parent will attempt migration as fallback
+
+    return _move_to_cpuset
+
+
 class Cpuset:
     """ Class for manipulating cpusets """
 
diff --git a/rteval/cpusetmanager.py b/rteval/cpusetmanager.py
index 0c99744b42cf..9607a2b38381 100644
--- a/rteval/cpusetmanager.py
+++ b/rteval/cpusetmanager.py
@@ -21,12 +21,14 @@ class CpusetManager:
     """
     Manager for rteval cpusets with automatic cleanup
 
-    Creates 1-2 cpusets based on configuration:
+    Creates 1-3 cpusets based on configuration:
     - rteval_housekeeping: Only if housekeeping_cpus specified
+    - rteval_loads: Only if create_loads is True (partition=member)
     - rteval_measurement: Created unless create_measurement is False
       (e.g. --onlyload, which runs no measurement workloads)
 
-    Load workloads use taskset for CPU affinity (no cpuset needed).
+    Unless create_loads is set, load workloads use taskset for CPU affinity
+    (no cpuset needed).
 
     Uses context manager pattern for automatic cleanup.
     """
@@ -72,7 +74,7 @@ class CpusetManager:
             except Exception as e:
                 logger.log(Log.WARN, f"Failed to clean up {cpuset_name}: {e}")
 
-    def __init__(self, housekeeping_cpus, measurement_cpus, logger, housekeeping_isolated=False, create_measurement=True, measurement_member=False):
+    def __init__(self, housekeeping_cpus, measurement_cpus, logger, housekeeping_isolated=False, create_measurement=True, measurement_member=False, loads_cpus=None, create_loads=False):
         """
         Initialize cpuset manager
 
@@ -85,8 +87,17 @@ class CpusetManager:
                 (e.g. --onlyload, which runs no measurement workloads; default: True)
             measurement_member: If True, use partition=member for measurement, allowing
                 loads and measurement to share CPUs (default: False = partition=isolated)
-
-        Note: Load workloads use taskset for CPU affinity and don't need cpusets.
+            loads_cpus: List of CPU integers for load workloads (used only when
+                create_loads is True)
+            create_loads: If True, create the rteval_loads cpuset (partition=member)
+                and confine loads to it instead of relying only on taskset
+                (default: False = loads use taskset, as before)
+
+        Note: Unless create_loads is set, load workloads use taskset for CPU
+        affinity and don't need a cpuset. The load cpuset is always a member
+        partition (confinement only), so its CPUs stay in the root cgroup's
+        effective set -- the main rteval process, when left in root (no
+        housekeeping), still has those CPUs to run on.
         """
         # Check cpuset support
         self.cpusets_init = CpusetsInit()
@@ -100,9 +111,12 @@ class CpusetManager:
         self.housekeeping_isolated = housekeeping_isolated
         self.create_measurement = create_measurement
         self.measurement_member = measurement_member
+        self.loads_cpus = loads_cpus if loads_cpus is not None else []
+        self.create_loads = create_loads
 
         # Cpuset objects (will be created in __enter__)
         self.housekeeping_cpuset = None
+        self.loads_cpuset = None
         self.measurement_cpuset = None
 
         # Get NUMA node range for memory assignment
@@ -112,6 +126,27 @@ class CpusetManager:
                        f"housekeeping={collapse_cpulist(housekeeping_cpus) if housekeeping_cpus else 'none'}, "
                        f"measurement={collapse_cpulist(measurement_cpus)}")
 
+    def _create_cpuset(self, name, cpus, isolated):
+        """
+        Create a single cpuset with the given CPUs and partition type.
+
+        Args:
+            name: cpuset name (e.g. 'rteval_measurement')
+            cpus: list of CPU integers to assign
+            isolated: True for partition=isolated, False for partition=member
+
+        Returns:
+            the created Cpuset object
+        """
+        partition_type = "isolated" if isolated else "member"
+        self.logger.log(Log.DEBUG, f"Creating {name} cpuset with CPUs "
+                        f"{collapse_cpulist(cpus)} (partition={partition_type})")
+        cpuset = Cpuset(name)
+        cpuset.write_memnode(self.numa_nodes)
+        cpuset.assign_cpus(collapse_cpulist(cpus))
+        cpuset.write_cpu_exclusive(isolated)  # partition=isolated if True, member if False
+        return cpuset
+
     def __enter__(self):
         """
         Context manager entry: create cpusets
@@ -121,24 +156,33 @@ class CpusetManager:
         """
         self.logger.log(Log.INFO, "Creating rteval cpusets...")
 
-        # Create housekeeping cpuset if requested
+        # Creation order is not significant: each cpuset is created from an
+        # explicit, pre-computed disjoint CPU list, so creating one never
+        # changes what another gets. The main rteval process is placed into
+        # housekeeping by the separate migrate_root_tasks_to_housekeeping()
+        # sweep, which runs after all cpusets exist; the workloads then self-home
+        # into their own cpusets before exec. The only overlap ever allowed is
+        # member+member (loads + --measurement-member), which needs no ordering
+        # since member partitions are not exclusive; the isolated-measurement
+        # overlap case is rejected upstream. Measurement (the potential isolated
+        # partition) is created last as a defensive habit.
+
+        # Create housekeeping cpuset if requested.
         if self.housekeeping_cpus:
-            partition_type = "isolated" if self.housekeeping_isolated else "member"
-            self.logger.log(Log.DEBUG, f"Creating rteval_housekeeping cpuset with CPUs {collapse_cpulist(self.housekeeping_cpus)} (partition={partition_type})")
-            self.housekeeping_cpuset = Cpuset('rteval_housekeeping')
-            self.housekeeping_cpuset.write_memnode(self.numa_nodes)
-            self.housekeeping_cpuset.assign_cpus(collapse_cpulist(self.housekeeping_cpus))
-            self.housekeeping_cpuset.write_cpu_exclusive(self.housekeeping_isolated)  # partition=isolated if True, member if False
+            self.housekeeping_cpuset = self._create_cpuset(
+                'rteval_housekeeping', self.housekeeping_cpus, self.housekeeping_isolated)
+
+        # Create loads cpuset if requested (always a member partition, so its
+        # CPUs remain in the root cgroup's effective set)
+        if self.create_loads:
+            self.loads_cpuset = self._create_cpuset(
+                'rteval_loads', self.loads_cpus, isolated=False)
 
         # Create measurement cpuset (skipped when there are no measurement
         # workloads, e.g. --onlyload)
         if self.create_measurement:
-            partition_type = "member" if self.measurement_member else "isolated"
-            self.logger.log(Log.DEBUG, f"Creating rteval_measurement cpuset with CPUs {collapse_cpulist(self.measurement_cpus)} (partition={partition_type})")
-            self.measurement_cpuset = Cpuset('rteval_measurement')
-            self.measurement_cpuset.write_memnode(self.numa_nodes)
-            self.measurement_cpuset.assign_cpus(collapse_cpulist(self.measurement_cpus))
-            self.measurement_cpuset.write_cpu_exclusive(not self.measurement_member)  # partition=isolated unless member
+            self.measurement_cpuset = self._create_cpuset(
+                'rteval_measurement', self.measurement_cpus, isolated=not self.measurement_member)
 
         self.logger.log(Log.INFO, "Cpusets created successfully")
         return self
@@ -155,18 +199,11 @@ class CpusetManager:
         self.logger.log(Log.INFO, "Cleaning up rteval cpusets...")
 
         try:
-            # Move all processes back to root cgroup before destroying cpusets
-            # Destroy in reverse order of creation
-
-            if self.measurement_cpuset:
-                self._migrate_to_root(self.measurement_cpuset, 'rteval_measurement')
-                self.measurement_cpuset.destroy()
-                self.logger.log(Log.DEBUG, "Destroyed rteval_measurement cpuset")
-
-            if self.housekeeping_cpuset:
-                self._migrate_to_root(self.housekeeping_cpuset, 'rteval_housekeeping')
-                self.housekeeping_cpuset.destroy()
-                self.logger.log(Log.DEBUG, "Destroyed rteval_housekeeping cpuset")
+            # Move all processes back to root cgroup before destroying cpusets.
+            # Destroy in reverse order of creation.
+            self._destroy_cpuset(self.measurement_cpuset, 'rteval_measurement')
+            self._destroy_cpuset(self.loads_cpuset, 'rteval_loads')
+            self._destroy_cpuset(self.housekeeping_cpuset, 'rteval_housekeeping')
 
             self.logger.log(Log.INFO, "Cpuset cleanup complete")
         except Exception as e:
@@ -174,6 +211,20 @@ class CpusetManager:
 
         return False  # Don't suppress exceptions
 
+    def _destroy_cpuset(self, cpuset, name):
+        """
+        Migrate a cpuset's tasks back to root and destroy it (no-op if None).
+
+        Args:
+            cpuset: Cpuset object to tear down, or None
+            name: Name of cpuset (for logging)
+        """
+        if not cpuset:
+            return
+        self._migrate_to_root(cpuset, name)
+        cpuset.destroy()
+        self.logger.log(Log.DEBUG, f"Destroyed {name} cpuset")
+
     def _migrate_to_root(self, cpuset, name):
         """
         Migrate all tasks from a cpuset back to root cgroup
diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index ad7891fcb3c8..183efd8ef813 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -329,6 +329,17 @@ reference from the first import"""
                                   default=None,
                                   help='Select measurement module: cyclictest or timerlat (overrides config file)')
 
+        # Set up options for load modules only
+        if self.__modtype == 'loads':
+            grparser.add_argument('--loads-cpuset',
+                                  dest='loads___cpuset',
+                                  action='store_true',
+                                  default=False,
+                                  help='confine loads to a cgroup v2 cpuset (rteval_loads, '
+                                       'partition=member) instead of only taskset; loads and '
+                                       'all their descendants are held to the load CPUs '
+                                       '(requires --cpusets)')
+
         for (modname, mod) in list(self.__modsloaded.items()):
             opts = mod.ModuleParameters()
             if len(opts) == 0:
diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index 20ebbbc4617c..6f93623535ae 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -18,6 +18,7 @@ from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
 from rteval.systopology import SysTopology
 from rteval.cpulist_utils import CpuList
+from rteval.cpuset import cpuset_preexec
 
 class Hackbench(CommandLineLoad):
     def __init__(self, config, logger):
@@ -123,10 +124,14 @@ class Hackbench(CommandLineLoad):
         # Only log initial startup at DEBUG level to avoid spam
         if initial:
             self._log(Log.DEBUG, f"starting on node {node}: args = {args}")
+        # When a loads cpuset is in use, self-home into it before exec so
+        # hackbench and its fan-out of tasks are confined to the load CPUs.
+        preexec_fn = cpuset_preexec(self._cfg.cpuset_path, strict=True)
         p = subprocess.Popen(args,
                              stdin=self.__nullfp,
                              stdout=self.__out,
-                             stderr=self.__err)
+                             stderr=self.__err,
+                             preexec_fn=preexec_fn)
         if not p:
             self._log(Log.DEBUG, f"hackbench failed to start on node {node}")
             raise RuntimeError(f"hackbench failed to start on node {node}")
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 23586b7a3c8d..99f2b3734791 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -16,6 +16,7 @@ from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
 from rteval.systopology import SysTopology
 from rteval.cpulist_utils import CpuList, collapse_cpulist
+from rteval.cpuset import cpuset_preexec
 
 DEFAULT_KERNEL_PREFIX = "linux-6.17.7"
 
@@ -89,12 +90,16 @@ class KBuildJob:
         subprocess.call(self.cleancmd, shell=True,
                         stdin=sin, stdout=sout, stderr=serr)
 
-    def run(self, sin=None, sout=None, serr=None):
+    def run(self, sin=None, sout=None, serr=None, cpuset_path=None):
         """ Use Popen to launch a kcompile job """
         self.log(Log.INFO, f"starting workload on node {int(self.node)}")
         self.log(Log.DEBUG, f"running on node {int(self.node)}: {self.runcmd}")
+        # When a loads cpuset is in use, self-home the build shell into it before
+        # exec so the whole make -jN subtree (gcc/as/ld) is confined to the load CPUs.
+        preexec_fn = cpuset_preexec(cpuset_path, strict=True)
         self.jobid = subprocess.Popen(self.runcmd, shell=True,
-                                      stdin=sin, stdout=sout, stderr=serr)
+                                      stdin=sin, stdout=sout, stderr=serr,
+                                      preexec_fn=preexec_fn)
 
     def isrunning(self):
         """ Query whether a job is running, returns True or False """
@@ -301,7 +306,8 @@ class Kcompile(CommandLineLoad):
                     if self.buildjobs[n].jobid.returncode not in (0, -2):
                         raise RuntimeError(f"kcompile module failed to run (returned {self.buildjobs[n].jobid.returncode}), please check logs for more detail")
                 self._log(Log.INFO, f"Starting load on node {n}")
-                self.buildjobs[n].run(self.__nullfd, self.__outfd, self.__errfd)
+                self.buildjobs[n].run(self.__nullfd, self.__outfd, self.__errfd,
+                                      cpuset_path=self._cfg.cpuset_path)
 
     def WorkloadAlive(self):
         # if any of the jobs has stopped, return False
diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index df4685ee16b3..564e7988b328 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -10,6 +10,7 @@ from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
 from rteval.systopology import SysTopology
 from rteval.cpulist_utils import CpuList
+from rteval.cpuset import cpuset_preexec
 
 def get_valid_stressors():
     """Query stress-ng for list of valid stressor names."""
@@ -120,11 +121,15 @@ class Stressng(CommandLineLoad):
             return
 
         self._log(Log.DEBUG, f'starting with {" ".join(self.args)}')
+        # When a loads cpuset is in use, self-home into it before exec so
+        # stress-ng and its workers are confined to the load CPUs.
+        preexec_fn = cpuset_preexec(self._cfg.cpuset_path, strict=True)
         try:
             self.process = subprocess.Popen(self.args,
                                             stdout=self.__out,
                                             stderr=self.__err,
-                                            stdin=self.__in)
+                                            stdin=self.__in,
+                                            preexec_fn=preexec_fn)
             self.started = True
             self.jobs = 1
             self._log(Log.DEBUG, "running")
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index b193330e27e0..029dc726f640 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -18,6 +18,7 @@ from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
 from rteval.systopology import cpuinfo, SysTopology
 from rteval.cpulist_utils import expand_cpulist, collapse_cpulist
+from rteval.cpuset import cpuset_preexec
 
 class RunData:
     '''class to keep instance data from a cyclictest run'''
@@ -332,17 +333,7 @@ class Cyclictest(rtevalModulePrototype):
 
         # If cpuset is configured, launch process inside the cpuset
         # This is critical for cyclictest - migrating it mid-startup disrupts initialization
-        preexec_fn = None
-        if hasattr(self.__cfg, 'cpuset_path') and self.__cfg.cpuset_path:
-            def move_to_cpuset():
-                """Move child process into cpuset before exec"""
-                try:
-                    cpuset_procs = os.path.join(self.__cfg.cpuset_path, 'cgroup.procs')
-                    with open(cpuset_procs, 'w') as f:
-                        f.write(str(os.getpid()))
-                except Exception:
-                    pass  # Fail silently - parent will attempt migration as fallback
-            preexec_fn = move_to_cpuset
+        preexec_fn = cpuset_preexec(self.__cfg.cpuset_path)
 
         self.__cyclicprocess = subprocess.Popen(self.__cmd,
                                                 stdout=self.__cyclicoutput,
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 735141e6796d..40465ca315b8 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -15,6 +15,7 @@ from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
 from rteval.systopology import cpuinfo, SysTopology
 from rteval.cpulist_utils import expand_cpulist, collapse_cpulist
+from rteval.cpuset import cpuset_preexec
 
 
 class TLRunData:
@@ -363,17 +364,7 @@ class Timerlat(rtevalModulePrototype):
 
         # If cpuset is configured, launch process inside the cpuset
         # This is critical for timerlat - migrating it mid-startup disrupts initialization
-        preexec_fn = None
-        if hasattr(self.__cfg, 'cpuset_path') and self.__cfg.cpuset_path:
-            def move_to_cpuset():
-                """Move child process into cpuset before exec"""
-                try:
-                    cpuset_procs = os.path.join(self.__cfg.cpuset_path, 'cgroup.procs')
-                    with open(cpuset_procs, 'w') as f:
-                        f.write(str(os.getpid()))
-                except Exception:
-                    pass  # Fail silently - parent will attempt migration as fallback
-            preexec_fn = move_to_cpuset
+        preexec_fn = cpuset_preexec(self.__cfg.cpuset_path)
 
         self.__timerlat_process = subprocess.Popen(self.__cmd,
                                                    stdout=self.__timerlat_out,
diff --git a/tests/cpusets/test-cpusets.sh b/tests/cpusets/test-cpusets.sh
index 0996d76ea1df..b5bca42f51b7 100755
--- a/tests/cpusets/test-cpusets.sh
+++ b/tests/cpusets/test-cpusets.sh
@@ -638,6 +638,258 @@ test_onlyload_no_measurement_cpuset() {
     fi
 }
 
+test_loads_cpuset_requires_cpusets() {
+    ((TESTS_RUN++)) || true
+    print_test "--loads-cpuset Requires --cpusets"
+
+    cleanup_cpusets
+
+    local all_good=true
+
+    # --loads-cpuset is meaningless without --cpusets (no cpuset infrastructure
+    # to confine the loads into), so it must be rejected early.
+    print_info "Running (expect early exit): $RTEVAL_CMD --loads-cpuset -d $TEST_DURATION"
+    if timeout 60s $RTEVAL_CMD --loads-cpuset -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1; then
+        print_fail "rteval succeeded, but --loads-cpuset without --cpusets should fail early"
+        all_good=false
+    else
+        print_info "rteval exited non-zero without --cpusets: OK"
+        if grep -q -- "--loads-cpuset requires --cpusets" "$LOG_FILE" 2>/dev/null; then
+            print_info "Error message points to --cpusets: OK"
+        else
+            print_fail "Validation error message missing guidance"
+            all_good=false
+        fi
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "--loads-cpuset requires --cpusets test"
+    else
+        print_fail "--loads-cpuset requires --cpusets test"
+    fi
+}
+
+test_loads_cpuset_member_partition() {
+    ((TESTS_RUN++)) || true
+    print_test "--loads-cpuset Creates rteval_loads Member Partition"
+
+    cleanup_cpusets
+
+    local cpus=$(get_test_cpus)
+    local msr_cpus=$(echo $cpus | awk '{print $2}')
+    local load_cpus=$(echo $cpus | awk '{print $3}')
+
+    local all_good=true
+
+    # With --loads-cpuset (and disjoint measurement/load CPUs so the default
+    # isolated measurement partition doesn't overlap the loads), rteval creates
+    # an rteval_loads cpuset as a member partition and confines the loads to it.
+    print_info "Running (expect success): $RTEVAL_CMD --cpusets --loads-cpuset --measurement-cpulist $msr_cpus --loads-cpulist $load_cpus -d $TEST_DURATION"
+
+    timeout 60s $RTEVAL_CMD --cpusets --loads-cpuset --measurement-cpulist "$msr_cpus" --loads-cpulist "$load_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    if check_cpuset_exists "rteval_loads"; then
+        print_info "rteval_loads cpuset created: OK"
+    else
+        print_fail "rteval_loads cpuset not created"
+        all_good=false
+    fi
+
+    if check_cpuset_cpus "rteval_loads" "$load_cpus"; then
+        print_info "Loads CPU assignment correct: OK"
+    else
+        print_fail "Loads CPU assignment incorrect"
+        all_good=false
+    fi
+
+    # Loads must be a member partition so their CPUs stay in the root cgroup's
+    # effective set (the main rteval process, left in root, still has CPUs).
+    if check_cpuset_partition "rteval_loads" "member"; then
+        print_info "Loads partition type is 'member': OK"
+    else
+        print_fail "Loads partition type is not 'member'"
+        all_good=false
+    fi
+
+    if check_cpuset_exists "rteval_measurement"; then
+        print_info "rteval_measurement cpuset created: OK"
+    else
+        print_fail "rteval_measurement cpuset not created"
+        all_good=false
+    fi
+
+    wait $rteval_pid
+    local rc=$?
+    if [ "$rc" -eq 0 ]; then
+        print_info "rteval exited 0 with --loads-cpuset: OK"
+    else
+        print_fail "rteval exited $rc with --loads-cpuset (expected 0)"
+        all_good=false
+    fi
+
+    sleep 1
+    if check_no_cpusets; then
+        print_info "Cleanup successful: OK"
+    else
+        print_fail "Cpusets not cleaned up"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "--loads-cpuset member partition test"
+    else
+        print_fail "--loads-cpuset member partition test"
+    fi
+}
+
+test_loads_cpuset_skipped_with_noload() {
+    ((TESTS_RUN++)) || true
+    print_test "--loads-cpuset Skipped with --noload"
+
+    cleanup_cpusets
+
+    local cpus=$(get_test_cpus)
+    local msr_cpus=$(echo $cpus | awk '{print $2}')
+
+    local all_good=true
+
+    # --noload runs no loads, so even with --loads-cpuset no rteval_loads cpuset
+    # should be created (create_loads is gated on 'not rtevcfg.noload').
+    print_info "Running (expect success): $RTEVAL_CMD --cpusets --loads-cpuset --noload --measurement-cpulist $msr_cpus -d $TEST_DURATION"
+
+    timeout 60s $RTEVAL_CMD --cpusets --loads-cpuset --noload --measurement-cpulist "$msr_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    if ! check_cpuset_exists "rteval_loads"; then
+        print_info "No rteval_loads cpuset with --noload: OK"
+    else
+        print_fail "rteval_loads cpuset created, but --noload runs no loads"
+        all_good=false
+    fi
+
+    wait $rteval_pid
+    local rc=$?
+    if [ "$rc" -eq 0 ]; then
+        print_info "rteval exited 0 with --loads-cpuset --noload: OK"
+    else
+        print_fail "rteval exited $rc (expected 0)"
+        all_good=false
+    fi
+
+    sleep 1
+    if check_no_cpusets; then
+        print_info "Cleanup successful: OK"
+    else
+        print_fail "Cpusets not cleaned up"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "--loads-cpuset skipped with --noload test"
+    else
+        print_fail "--loads-cpuset skipped with --noload test"
+    fi
+}
+
+test_loads_cpuset_with_measurement_member_overlap() {
+    ((TESTS_RUN++)) || true
+    print_test "--loads-cpuset + --measurement-member on Overlapping CPUs (Two Member Cpusets)"
+
+    cleanup_cpusets
+
+    local cpus=$(get_test_cpus)
+    local msr_cpus=$(echo $cpus | awk '{print $2}')
+
+    local all_good=true
+
+    # --measurement-member is the only safe way to overlap a loads cpuset with
+    # the measurement cpuset: both become member partitions, which may share
+    # CPUs (member partitions are not exclusive in cgroup v2). This exercises the
+    # otherwise-untested state of two overlapping member cpusets existing at once.
+    # The overlap guard is skipped because --measurement-member is set.
+    print_info "Running (expect success): $RTEVAL_CMD --cpusets --measurement-member --loads-cpuset --measurement-cpulist $msr_cpus --loads-cpulist $msr_cpus -d $TEST_DURATION"
+
+    timeout 60s $RTEVAL_CMD --cpusets --measurement-member --loads-cpuset --measurement-cpulist "$msr_cpus" --loads-cpulist "$msr_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    if check_cpuset_exists "rteval_loads"; then
+        print_info "rteval_loads cpuset created: OK"
+    else
+        print_fail "rteval_loads cpuset not created"
+        all_good=false
+    fi
+
+    if check_cpuset_exists "rteval_measurement"; then
+        print_info "rteval_measurement cpuset created: OK"
+    else
+        print_fail "rteval_measurement cpuset not created"
+        all_good=false
+    fi
+
+    # Both cpusets share the same CPUs
+    if check_cpuset_cpus "rteval_loads" "$msr_cpus"; then
+        print_info "Loads CPU assignment matches shared CPUs: OK"
+    else
+        print_fail "Loads CPU assignment incorrect"
+        all_good=false
+    fi
+
+    if check_cpuset_cpus "rteval_measurement" "$msr_cpus"; then
+        print_info "Measurement CPU assignment matches shared CPUs: OK"
+    else
+        print_fail "Measurement CPU assignment incorrect"
+        all_good=false
+    fi
+
+    # Both must be member partitions (overlap is only legal for member siblings)
+    if check_cpuset_partition "rteval_loads" "member"; then
+        print_info "Loads partition type is 'member': OK"
+    else
+        print_fail "Loads partition type is not 'member'"
+        all_good=false
+    fi
+
+    if check_cpuset_partition "rteval_measurement" "member"; then
+        print_info "Measurement partition type is 'member': OK"
+    else
+        print_fail "Measurement partition type is not 'member'"
+        all_good=false
+    fi
+
+    wait $rteval_pid
+    local rc=$?
+    if [ "$rc" -eq 0 ]; then
+        print_info "rteval exited 0 with overlapping member cpusets: OK"
+    else
+        print_fail "rteval exited $rc (expected 0)"
+        all_good=false
+    fi
+
+    sleep 1
+    if check_no_cpusets; then
+        print_info "Cleanup successful: OK"
+    else
+        print_fail "Cpusets not cleaned up"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "--loads-cpuset + --measurement-member overlap test"
+    else
+        print_fail "--loads-cpuset + --measurement-member overlap test"
+    fi
+}
+
 test_cleanup_on_interrupt() {
     ((TESTS_RUN++)) || true
     print_test "Cleanup on Ctrl+C (Interrupt Handling)"
@@ -900,6 +1152,10 @@ main() {
     test_backward_compatibility
     test_noload_skips_overlap_check
     test_onlyload_no_measurement_cpuset
+    test_loads_cpuset_requires_cpusets
+    test_loads_cpuset_member_partition
+    test_loads_cpuset_skipped_with_noload
+    test_loads_cpuset_with_measurement_member_overlap
     test_cleanup_on_interrupt
 
     # Tests that require isolcpus (will skip if not available)
diff --git a/tests/test_cpusetmanager.py b/tests/test_cpusetmanager.py
index 74466be89615..3f1c4b4ee868 100644
--- a/tests/test_cpusetmanager.py
+++ b/tests/test_cpusetmanager.py
@@ -164,6 +164,45 @@ class TestCpusetManagerHousekeepingPartitions(unittest.TestCase):
             self.assertTrue(os.path.exists(hk_path),
                           "Housekeeping cpuset should exist")
 
+    def test_no_loads_cpuset_by_default(self):
+        """Test that the loads cpuset is not created unless create_loads is True"""
+        with CpusetManager(
+            housekeeping_cpus=[],
+            measurement_cpus=[2, 3],
+            logger=self.logger
+        ) as manager:
+            loads_path = '/sys/fs/cgroup/rteval_loads'
+            self.assertFalse(os.path.exists(loads_path),
+                           "Loads cpuset should not exist by default (loads use taskset)")
+            self.assertIsNone(manager.loads_cpuset,
+                            "manager.loads_cpuset should be None by default")
+
+    def test_loads_cpuset_created_as_member(self):
+        """Test that create_loads=True makes an rteval_loads member partition"""
+        with CpusetManager(
+            housekeeping_cpus=[],
+            measurement_cpus=[2, 3],
+            logger=self.logger,
+            loads_cpus=[0, 1],
+            create_loads=True
+        ) as manager:
+            loads_path = '/sys/fs/cgroup/rteval_loads'
+            self.assertTrue(os.path.exists(loads_path),
+                          "Loads cpuset should exist when create_loads is True")
+
+            # Loads must be a member partition so their CPUs stay in the root
+            # cgroup's effective set.
+            with open(os.path.join(loads_path, 'cpuset.cpus.partition')) as f:
+                partition = f.read().strip()
+            self.assertEqual(partition, 'member',
+                           "Loads cpuset should have partition=member")
+
+            # CPUs assigned to the loads cpuset should match loads_cpus
+            with open(os.path.join(loads_path, 'cpuset.cpus')) as f:
+                cpus = f.read().strip()
+            self.assertEqual(cpus, '0-1',
+                           "Loads cpuset should be assigned the requested CPUs")
+
 
 @unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
 @unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
@@ -228,6 +267,35 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
         self.assertIn('partition=member', result.stdout,
                      "Help should mention partition=member")
 
+    def test_loads_cpuset_requires_cpusets(self):
+        """Test that --loads-cpuset requires --cpusets"""
+        result = subprocess.run(
+            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+             '--loads-cpuset',
+             '--duration', '1', '--onlyload'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertNotEqual(result.returncode, 0,
+                          "--loads-cpuset without --cpusets should fail")
+        self.assertIn('requires --cpusets', result.stderr,
+                     "Error message should mention --cpusets requirement")
+
+    def test_loads_cpuset_help_text(self):
+        """Test that --loads-cpuset appears in help"""
+        result = subprocess.run(
+            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('--loads-cpuset', result.stdout,
+                     "--loads-cpuset should appear in help")
+        self.assertIn('partition=member', result.stdout,
+                     "Help should mention partition=member")
+
     def test_housekeeping_isolated_requires_housekeeping(self):
         """Test that --housekeeping-isolated requires --housekeeping"""
         result = subprocess.run(
-- 
2.55.0

