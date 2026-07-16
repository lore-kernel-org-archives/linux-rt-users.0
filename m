Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B61043E08F
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223974; cv=none; b=K4qUnZxFoepcmaCmK4D1YEmwxDlnS+GEau1FoDJ+DbQBwbLiN2I0ZK/s9K+OlMCX3n3/h/vW+82CIxfojvKWp7v66ZUVopZAGp2zb7Rn6yn4CQ/Gbr5dVIDocKDWDJleh5KNUiTMqo374nlMsnRcaGizfmMnEIPbdu4UmJq8h0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223974; c=relaxed/simple;
	bh=s43hRAhUcZv0DrTmoA8TqAN18IpDagllwA4CuquYpuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+TD/bnA5/rpiIwHOjnIUj+xoSHGno8EaWn04oO4sFDogz1r4tQ/RuHCvWC/SYTgtCd4tJ9n4v8Ec63MVo/RRtDRFIu6dM+MuDIJlVc8Uej0yLNE0UJN897jMOrcH+7P29mVgM1kdM9Mv2nFXLoq2KQuuPwUQ7rQ39OrulfR9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq4LEH1t; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq4LEH1t"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f23e851626so71429646d6.3
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223972; x=1784828772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W/a82ZQxksmq5/5RKU88rytATKDEHPmdI/MwkOrpCzg=;
        b=Uq4LEH1tIorVTiwOfyJfTSwHPmSfac6fUAcBTXkeD0e18i8h6h7iebS0EC+75vF6Cf
         AI5cOVUuFFCkjqyoKhChlgvpb++prJJ/HPpCG9n6tJJszDB9D3UM8jwCdviX+yBnKsqQ
         K4DASILCS9sZydbsSeaL2J+vl4sCJYMZRbcXLpWGZKBNFjLRqKadpnBItnxIb0f3l8Bk
         QlfxOt5QRnnBy584ZWSEYK5Nd+fUxL+yzXflxzPg12q2ol3SN+SEIQbk2oefbMBvVINP
         pzTdpEcsZK4IKv8H2eRgHMSnPYN8GQt08OAR9noCXtX8RAUu2tMU1cqDgwXTpAxht7mf
         t+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223972; x=1784828772;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/a82ZQxksmq5/5RKU88rytATKDEHPmdI/MwkOrpCzg=;
        b=gAqOvPplR95OwxaluL8v123kxIP9tas6VTnvD9NsmG2QPDL6CsXN3KPK3La02igrj+
         Q/r9y3f4ZlN5bsx6et4GaM8jAMQubfS2uIJ7j8HKkVdt1N7emvY0TfwMc8smE3KAnI27
         r5Gdi+Yzw+KikWhk/L6X7sf0vVHWgfYbvy0L2MkFZNNv99GMSafSDiAUBCY/LRroeu0X
         MzKfX8Xvsl5w64f7rlb3cQKtFXpjTMRNr3IKC/aelhMecIoo97TtjLWx228mZYIvUy6t
         ds6Zsg1SQ4scU6Cq79d5uVWPM5v+BFA7uTWToZnKpvLnnVLOlpBMMbMUorujJZipa1vX
         iqfA==
X-Gm-Message-State: AOJu0YwJtAJvpoDnjcKJb6cvG+HxhIcWlghiKDi5fVeR+HY7jOyl3sr2
	MmBDgZqVqyr1hcoxrFa3KpRovxlpbWvAJh74oEHB6kzyh8OhUPFsryRoCxVONw==
X-Gm-Gg: AfdE7cldYIELfL6PYwXfPJU0YXY6vCe+phXFE4ACUTwefCLMQOZDRHYDj/elmhFbiiZ
	uHpT3CxaCDuwPJOinBij0pX1tUY11arXU+EgY+J/gq5+kO6Qv5/nMO5XZVW2M417qIFxrL2smh3
	h9H6LvGuEVZEASIm/u4QcVo6oIZstgMKXpudLwaq64/ZdNwIItG5yX9/d9qw53wMvcZ0m8d2vlw
	cjoe6Pa0N7TkxXgdcQdcpe6yHx1S6EB+n7DAbJ2Sbu80+SWPVLwcQNqoyYncwngvPqHWGcdCWFQ
	BFhEM2u4gO7/LvPl1Q4qXqr7SRDMojNdgVKT0M/qrf+u9f8IHhSXHYmVNrhqO0V+NG8CLk1fjvt
	0K8+eGqUMMVckjVsDwurGf8GMa2tFAbTPNlL2ir0gtSCLIRn0aJXkwOKEoCQmHH+JaGxgWpLpUC
	vZCmhxWi6/eNwXjx7C2Ytv0RHMIJjNDNOpfLXwp11IvhTe3brwH2ye8Ws8b8D7k3I2Ko6s
X-Received: by 2002:a05:6214:29c6:b0:904:2a2a:d3 with SMTP id 6a1803df08f44-90747cf4a6bmr159832846d6.47.1784223971740;
        Thu, 16 Jul 2026 10:46:11 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0347sm224952276d6.2.2026.07.16.10.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:46:11 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 1/7] tuna: Add --show-system flag to filter systemd cpusets
Date: Thu, 16 Jul 2026 13:45:44 -0400
Message-ID: <20260716174554.126145-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716174554.126145-1-jkacur@redhat.com>
References: <20260716174554.126145-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add ability to filter out systemd-managed cpusets from cpuset list
and status commands. By default, system cpusets (.slice, .scope,
.mount, .service) are now hidden as they are not relevant for RT
tuning. Users can show them with --show-system flag.

Changes:
- Add skip_system parameter to get_all_cpusets_info()
- Add --show-system flag to 'cpuset list' and 'cpuset status'
- Refactor cpuset_list() to use centralized get_all_cpusets_info()
- Simplify blocklist checking to reuse data from get_all_cpusets_info()

This prepares for cpuset save/restore where we only want to save
user-created cpusets, not systemd infrastructure.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 114 ++++++++++++++++------------------------------------
 1 file changed, 35 insertions(+), 79 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 25257c465532..262159150211 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -292,6 +292,7 @@ def gen_parser():
     cpuset_list.add_argument('-p', '--pattern', type=str, metavar='PATTERN', help='Filter by glob pattern (e.g., tuna*)')
     cpuset_list.add_argument('-v', '--verbose', action='store_true', help='Show detailed information (CPUs, tasks, partition type)')
     cpuset_list.add_argument('--show-empty', action='store_true', help='Include cpusets with no CPUs assigned (default: skip empty)')
+    cpuset_list.add_argument('--show-system', action='store_true', help='Include systemd-managed cpusets (default: skip system)')
     cpuset_list.add_argument('--no-recursive', dest='recursive', action='store_false', default=True, help='Only search top-level cpusets')
 
     # cpuset destroy
@@ -317,6 +318,7 @@ def gen_parser():
     cpuset_status = cpuset_subparser.add_parser('status', description='Show system-wide cpuset overview', help='Show cpuset status')
     cpuset_status.add_argument('-p', '--pattern', type=str, metavar='PATTERN', help='Filter by glob pattern (e.g., tuna*)')
     cpuset_status.add_argument('--show-empty', action='store_true', help='Include cpusets with no CPUs assigned (default: skip empty)')
+    cpuset_status.add_argument('--show-system', action='store_true', help='Include systemd-managed cpusets (default: skip system)')
     cpuset_status.add_argument('--no-recursive', dest='recursive', action='store_false', default=True, help='Only show top-level cpusets')
 
     # cpuset modify
@@ -984,13 +986,14 @@ def get_cpuset_info(cpuset_name):
     return info
 
 
-def get_all_cpusets_info(pattern=None, recursive=True, skip_empty=False):
+def get_all_cpusets_info(pattern=None, recursive=True, skip_empty=False, skip_system=False):
     """Get information about all cpusets matching criteria.
 
     Args:
         pattern: Glob pattern to filter cpusets (None for all)
         recursive: If True, search nested cpusets
         skip_empty: If True, skip cpusets with no CPUs assigned
+        skip_system: If True, skip systemd-managed cpusets (.slice, .scope, .mount, .service)
 
     Returns:
         list: List of cpuset info dictionaries (from get_cpuset_info)
@@ -998,6 +1001,9 @@ def get_all_cpusets_info(pattern=None, recursive=True, skip_empty=False):
     cpusets = cpuset.list_cpusets(pattern=pattern, recursive=recursive)
     infos = []
 
+    # System cpuset suffixes to filter
+    system_suffixes = ('.slice', '.scope', '.mount', '.service')
+
     for cs_name in cpusets:
         info = get_cpuset_info(cs_name)
 
@@ -1005,6 +1011,10 @@ def get_all_cpusets_info(pattern=None, recursive=True, skip_empty=False):
         if skip_empty and not info['cpus']:
             continue
 
+        # Skip system cpusets if requested
+        if skip_system and cs_name.endswith(system_suffixes):
+            continue
+
         infos.append(info)
 
     return infos
@@ -1056,13 +1066,14 @@ def cpuset_create(cpu_list, name, isolated, memory_nodes=None):
         sys.exit(1)
 
 
-def cpuset_list(pattern, verbose, show_empty, recursive):
+def cpuset_list(pattern, verbose, show_empty, show_system, recursive):
     """Handler for 'tuna cpuset list' command.
 
     Args:
         pattern: Glob pattern to filter cpusets (None for all)
         verbose: If True, show detailed info (CPUs, memory nodes, tasks, partition)
         show_empty: If True, show cpusets with no CPUs assigned (default: skip empty)
+        show_system: If True, show systemd-managed cpusets (default: skip system)
         recursive: If True, search nested cpusets
     """
     # Check cgroup v2 support
@@ -1071,25 +1082,11 @@ def cpuset_list(pattern, verbose, show_empty, recursive):
         print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
         sys.exit(1)
 
-    # List cpusets
-    cpusets = cpuset.list_cpusets(pattern=pattern, recursive=recursive)
-
-    # Filter out empty cpusets unless --show-empty was specified
-    if not show_empty:
-        filtered_cpusets = []
-        for cs_name in cpusets:
-            cs_path = os.path.join('/sys/fs/cgroup', cs_name)
-            try:
-                with open(os.path.join(cs_path, 'cpuset.cpus'), 'r', encoding='utf-8') as f:
-                    cpus = f.read().strip()
-                    if cpus:  # Only include if CPUs are assigned
-                        filtered_cpusets.append(cs_name)
-            except (OSError, IOError):
-                # If we can't read it, skip it
-                pass
-        cpusets = filtered_cpusets
+    # Get cpuset info using centralized function (skip_* params are inverse of show_*)
+    infos = get_all_cpusets_info(pattern=pattern, recursive=recursive,
+                                  skip_empty=not show_empty, skip_system=not show_system)
 
-    if not cpusets:
+    if not infos:
         if pattern:
             print(f"No cpusets found matching pattern '{pattern}'")
         else:
@@ -1101,64 +1098,21 @@ def cpuset_list(pattern, verbose, show_empty, recursive):
         print(f"{'NAME':<20} {'CPUS':<15} {'MEMS':<10} {'TASKS':<7} {'PARTITION':<10}")
         print("-" * 65)
 
-        for cs_name in cpusets:
-            cs_path = os.path.join('/sys/fs/cgroup', cs_name)
-
-            try:
-                # Read CPUs
-                with open(os.path.join(cs_path, 'cpuset.cpus'), 'r', encoding='utf-8') as f:
-                    cpus = f.read().strip() or "(none)"
-
-                # Read memory nodes
-                with open(os.path.join(cs_path, 'cpuset.mems'), 'r', encoding='utf-8') as f:
-                    mems = f.read().strip() or "(none)"
-
-                # Read tasks count
-                with open(os.path.join(cs_path, 'cgroup.procs'), 'r', encoding='utf-8') as f:
-                    tasks = [line.strip() for line in f if line.strip()]
-                    task_count = len(tasks)
-
-                # Read partition type (if available)
-                partition_file = os.path.join(cs_path, 'cpuset.cpus.partition')
-                if os.path.exists(partition_file):
-                    with open(partition_file, 'r', encoding='utf-8') as f:
-                        partition = f.read().strip()
-                else:
-                    partition = "n/a"
-
-                print(f"{cs_name:<20} {cpus:<15} {mems:<10} {task_count:<7} {partition:<10}")
-
-            except (OSError, IOError) as e:
-                print(f"{cs_name:<20} (error reading: {e})", file=sys.stderr)
+        for info in infos:
+            cpus = info['cpus'] or "(none)"
+            mems = info['mems'] or "(none)"
+            print(f"{info['name']:<20} {cpus:<15} {mems:<10} {info['task_count']:<7} {info['partition']:<10}")
     else:
         # Simple output: just names
-        for cs_name in cpusets:
-            print(cs_name)
+        for info in infos:
+            print(info['name'])
 
-    # Check for blocklisted processes in cpusets
-    # Skip system cgroups (*.mount, *.scope, *.slice) - these are managed by systemd
+    # Check for blocklisted processes (already collected by get_cpuset_info)
     warnings = []
-    for cs_name in cpusets:
-        # Skip system cgroups - only check user-created cpusets
-        if cs_name.endswith(('.mount', '.scope', '.slice')):
-            continue
-
-        cs_path = os.path.join('/sys/fs/cgroup', cs_name)
-        try:
-            with open(os.path.join(cs_path, 'cgroup.procs'), 'r', encoding='utf-8') as f:
-                pids = [line.strip() for line in f if line.strip()]
-                for pid_str in pids:
-                    try:
-                        pid = int(pid_str)
-                        if cpuset.Cpuset._is_process_blocklisted(pid):
-                            comm = cpuset.Cpuset._get_process_name(pid)
-                            warnings.append(f"⚠️  WARNING: Blocklisted process PID {pid} ({comm}) found in cpuset '{cs_name}'")
-                    except ValueError:
-                        # Invalid PID, skip
-                        pass
-        except (OSError, IOError):
-            # Can't read procs, skip
-            pass
+    for info in infos:
+        if info['blocklisted_pids']:
+            for pid, comm in info['blocklisted_pids']:
+                warnings.append(f"⚠️  WARNING: Blocklisted process PID {pid} ({comm}) found in cpuset '{info['name']}'")
 
     # Display warnings if any
     if warnings:
@@ -1385,12 +1339,13 @@ def cpuset_show(name, show_tasks):
         print("  These critical system processes should not be in custom cpusets!", file=sys.stderr)
 
 
-def cpuset_status(pattern, show_empty, recursive):
+def cpuset_status(pattern, show_empty, show_system, recursive):
     """Handler for 'tuna cpuset status' command.
 
     Args:
         pattern: Glob pattern to filter cpusets (None for all)
         show_empty: If True, show cpusets with no CPUs assigned (default: skip empty)
+        show_system: If True, show systemd-managed cpusets (default: skip system)
         recursive: If True, search nested cpusets
     """
     # Check cgroup v2 support
@@ -1399,8 +1354,9 @@ def cpuset_status(pattern, show_empty, recursive):
         print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
         sys.exit(1)
 
-    # Get all cpusets info (skip_empty is inverse of show_empty)
-    infos = get_all_cpusets_info(pattern=pattern, recursive=recursive, skip_empty=not show_empty)
+    # Get all cpusets info (skip_* params are inverse of show_*)
+    infos = get_all_cpusets_info(pattern=pattern, recursive=recursive,
+                                  skip_empty=not show_empty, skip_system=not show_system)
 
     if not infos:
         if pattern:
@@ -1901,7 +1857,7 @@ def main():
             cpuset_create(args.cpu_list, args.name, args.isolated, args.memory_nodes)
 
         elif args.cpuset_command == 'list':
-            cpuset_list(args.pattern, args.verbose, args.show_empty, args.recursive)
+            cpuset_list(args.pattern, args.verbose, args.show_empty, args.show_system, args.recursive)
 
         elif args.cpuset_command == 'destroy':
             cpuset_destroy(args.name, args.pattern, args.force, args.include_empty, args.recursive)
@@ -1913,7 +1869,7 @@ def main():
             cpuset_show(args.name, args.show_tasks)
 
         elif args.cpuset_command == 'status':
-            cpuset_status(args.pattern, args.show_empty, args.recursive)
+            cpuset_status(args.pattern, args.show_empty, args.show_system, args.recursive)
 
         elif args.cpuset_command == 'modify':
             # Parse CPU lists if provided
-- 
2.55.0

