Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157E2D661C
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692975; cv=none; b=VHi53Dol9sHa22yWBvlxCOafDt2rN4QOTm6YD6xbPdjJHyfJciEfWcdgRUlQ+v0McqAxKQMsGOUmiKmd+R4n12mbPWkbWtL8IkQH8fJKJ2HS8/MmqlwQU2knWZhl3yqCK8Q7BOCR+DCQrNc1sLNrVOEz58p0oIE2mqT99vTWGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692975; c=relaxed/simple;
	bh=vDJC2Of9TAgiumO1lX9lB+eOYfJKkyUi1yxgxFWUwD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBJXkivj4U9+hRhuXI86FiMGVkMXgYTh45ElusrMQsiQLvDQQBIryhO2iGkQ2LbF7omsJJimQX5YD0aH5dDg+MdmJNmSRD3Ux2i20TPNl5eRyjhNI4Mpg+t2OSfwiEzZrfLD47LlsdwRoK1QdvcVVj/P2m5zqyEse6QVckm2Afs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj8sRfvu; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj8sRfvu"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-73b909fbb6bso576302137.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692973; x=1784297773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ig1bMF4N0xyOknt4+S56Oq13oxVEMg38aOh2VYR4dgQ=;
        b=Vj8sRfvug2ZfBdx3BruHRLX8wXXZ/XEof+mIRGUGzwxWJS8cLHqxsknKt1bStMnQos
         x2QuGr8R5VNOON+RcrLrYxjzmlK8ukBKN+Tlo5r/hdBT4zLd2K3DYHBz/1GaZc7LuNCX
         fTSDioJESy8icDnA+M7gpI4qcZwVa1qFvdwUQbts5T2EWgzBYfqY0Y3VjE4MAu3MkKWl
         xVDXAR3l7i3s0/gVSQr1hoByYy6iH7s9pLYv+2nyiPfoBUWE/xU86yt/q+hCvXXbpNum
         fxG+cZohKRhCD5heZUilp1EYO3iUbqFbmfbu8CWcS7SUFGxmD9ygJF3cpI75kfW90lZY
         FKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692973; x=1784297773;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ig1bMF4N0xyOknt4+S56Oq13oxVEMg38aOh2VYR4dgQ=;
        b=AvGO9G0M/vR7H3cVMLZ3UF5TQ8S1XkAluSu5GdpdLiDR0N9fGA8AQ9TH3kGs9qBFmi
         HtsYGD1uHn3DmgLVAciEuQpuPFzAPbJFRYTlmofsH5+01WTQW4zc3gs9mLpEX0w6Vqfh
         WbJuFuVyXYKu+48mOb915ufUP6YYdg+yvowZiIaAMpt4RNtkrGckr93vBN05ejVEOnb+
         Q9dVRPvqMpCJ5NaREawsUhT3Z9b6FbTf3IfAv9lXY6GgjHhAbQo9UtZaRNUOd8jw00V+
         8CQ4wXxZ2ByLhFAdJ1OsywaZSShcvZjI77nLUI9jnJZeDWoK8l691n0k2aQH+N8Rj9Ve
         mDaQ==
X-Gm-Message-State: AOJu0YzfwOjxz/MhhvJOsjRcJ6BrXW+RUSuJP6tao4ihye3WGCaEVyB4
	l3aMKzo5sgwuUO2dXXtAwEozXN897rHxBfro3Z4zp3hPTtazhtQhgeL/16tJvw==
X-Gm-Gg: AfdE7cl+2ic6RrD2pFLsoq7sOODE7Fyg0YN4NJBdgKaSxVgJN2BhtO79n+/5YvT9CXz
	DpkZnFK9CSqqE0PtdrpoCTVaSnVJ7B8/jBAwbzjxBMBQwfrmqcZ8FZnJAk/gVjuWC9zLPdnLiI6
	jQNfwn23Rj/zdqKaefWQh1YNwNYQCIkoi3VAbpqMAtaOcDcB6Gx+K8F6kiA3BBpSISisSjRGmiv
	MaQkol4zBVpviOsuR+EBarRHnSs0qN8Hh1Fg4lrzBssnyfUTTEufTSdwb2fokPWfeQWVpCNt95m
	S4Bqwz45/RZYd//KUlvN9OTvs41ZDF7zQCYE+RBBuHCGXIeeeHZ9r61euu+DUNZhb88Lw8NJwof
	8UH6kMPXmOp1zgPrxRd1XcVOuO3r8/v+mjEyk6Ia+E8aU8dey0JRmwZ4D4yVQvSYBhT9nwJgyEs
	otaUIzPe1PI4Llbh+MwVhHnWrLR7KM6jlyeQEE5kjIaelttqcANmRYfciNPZMi9V38uZH56unKm
	Q==
X-Received: by 2002:a05:6102:4413:b0:62f:46be:8318 with SMTP id ada2fe7eead31-744dfdf14a6mr7602369137.6.1783692972774;
        Fri, 10 Jul 2026 07:16:12 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 18/36] tuna: Add cpuset show and status commands
Date: Fri, 10 Jul 2026 10:14:56 -0400
Message-ID: <20260710141523.36440-19-jkacur@redhat.com>
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

Add two new cpuset subcommands to provide detailed information about
cpusets and system-wide overview:

1. 'tuna cpuset show <name>' - Display detailed information about a
   specific cpuset including CPUs, memory nodes, partition type, task
   count, and optional detailed task list with --show-tasks flag.

2. 'tuna cpuset status' - Display system-wide overview of all cpusets
   with summary statistics (total cpusets, CPUs assigned, tasks count,
   isolated cpusets) and a table view of all cpusets. Supports pattern
   filtering with --pattern and --skip-empty options.

Both commands share infrastructure through new helper functions:
- get_cpuset_info() - Gather detailed info about a single cpuset
- get_all_cpusets_info() - Gather info about multiple cpusets

These commands complement the existing create/list/destroy/move commands
and provide better visibility into cpuset configuration and usage.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 269 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 269 insertions(+)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 5c21d54bc2bf..b560ec805b7a 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -300,6 +300,17 @@ def gen_parser():
     cpuset_move.add_argument('-t', '--threads', **MODS['threads'])
     cpuset_move.add_argument('-p', '--pids', dest='pid_list', type=str, metavar='PID-LIST', help='Comma-separated list of PIDs to move')
 
+    # cpuset show
+    cpuset_show = cpuset_subparser.add_parser('show', description='Show detailed information about a cpuset', help='Show cpuset details')
+    cpuset_show.add_argument('name', type=str, metavar='NAME', help='Cpuset name to show')
+    cpuset_show.add_argument('--show-tasks', action='store_true', help='Show detailed list of tasks/processes')
+
+    # cpuset status
+    cpuset_status = cpuset_subparser.add_parser('status', description='Show system-wide cpuset overview', help='Show cpuset status')
+    cpuset_status.add_argument('-p', '--pattern', type=str, metavar='PATTERN', help='Filter by glob pattern (e.g., tuna*)')
+    cpuset_status.add_argument('--skip-empty', action='store_true', help='Skip cpusets with no CPUs assigned')
+    cpuset_status.add_argument('--no-recursive', dest='recursive', action='store_false', default=True, help='Only show top-level cpusets')
+
     return parser
 
 
@@ -831,6 +842,101 @@ def get_next_tuna_cpuset_name():
             return f'tuna{i}'
 
 
+def get_cpuset_info(cpuset_name):
+    """Get detailed information about a cpuset.
+
+    Args:
+        cpuset_name: Name of the cpuset (e.g., 'tuna0')
+
+    Returns:
+        dict: Cpuset information with keys:
+            - name: cpuset name
+            - path: full path to cpuset
+            - cpus: CPU list string (e.g., "0-3")
+            - mems: Memory nodes string (e.g., "0")
+            - tasks: List of PIDs
+            - task_count: Number of tasks
+            - partition: Partition type (isolated/member/root/n/a)
+            - blocklisted_pids: List of (pid, comm) tuples for blocklisted processes
+            - error: Error message if failed to read info
+
+    """
+    cs_path = os.path.join('/sys/fs/cgroup', cpuset_name)
+    info = {
+        'name': cpuset_name,
+        'path': cs_path,
+        'cpus': '',
+        'mems': '',
+        'tasks': [],
+        'task_count': 0,
+        'partition': 'n/a',
+        'blocklisted_pids': [],
+        'error': None
+    }
+
+    try:
+        # Read CPUs
+        with open(os.path.join(cs_path, 'cpuset.cpus'), 'r', encoding='utf-8') as f:
+            info['cpus'] = f.read().strip()
+
+        # Read memory nodes
+        with open(os.path.join(cs_path, 'cpuset.mems'), 'r', encoding='utf-8') as f:
+            info['mems'] = f.read().strip()
+
+        # Read tasks
+        with open(os.path.join(cs_path, 'cgroup.procs'), 'r', encoding='utf-8') as f:
+            info['tasks'] = [line.strip() for line in f if line.strip()]
+            info['task_count'] = len(info['tasks'])
+
+        # Read partition type (if available)
+        partition_file = os.path.join(cs_path, 'cpuset.cpus.partition')
+        if os.path.exists(partition_file):
+            with open(partition_file, 'r', encoding='utf-8') as f:
+                info['partition'] = f.read().strip()
+
+        # Check for blocklisted processes (skip system cgroups)
+        if not cpuset_name.endswith(('.mount', '.scope', '.slice')):
+            for pid_str in info['tasks']:
+                try:
+                    pid = int(pid_str)
+                    if cpuset.Cpuset._is_process_blocklisted(pid):
+                        comm = cpuset.Cpuset._get_process_name(pid)
+                        info['blocklisted_pids'].append((pid, comm))
+                except ValueError:
+                    pass
+
+    except (OSError, IOError) as e:
+        info['error'] = str(e)
+
+    return info
+
+
+def get_all_cpusets_info(pattern=None, recursive=True, skip_empty=False):
+    """Get information about all cpusets matching criteria.
+
+    Args:
+        pattern: Glob pattern to filter cpusets (None for all)
+        recursive: If True, search nested cpusets
+        skip_empty: If True, skip cpusets with no CPUs assigned
+
+    Returns:
+        list: List of cpuset info dictionaries (from get_cpuset_info)
+    """
+    cpusets = cpuset.list_cpusets(pattern=pattern, recursive=recursive)
+    infos = []
+
+    for cs_name in cpusets:
+        info = get_cpuset_info(cs_name)
+
+        # Skip empty cpusets if requested
+        if skip_empty and not info['cpus']:
+            continue
+
+        infos.append(info)
+
+    return infos
+
+
 def cpuset_create(cpu_list, name, isolated, memory_nodes=None):
     """Handler for 'tuna cpuset create' command.
 
@@ -1147,6 +1253,163 @@ def cpuset_move(name, thread_list, pid_list):
         sys.exit(1)
 
 
+def cpuset_show(name, show_tasks):
+    """Handler for 'tuna cpuset show' command.
+
+    Args:
+        name: Cpuset name to show details for
+        show_tasks: If True, show detailed task list
+    """
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
+        sys.exit(1)
+
+    # Check if cpuset exists
+    cpuset_path = os.path.join('/sys/fs/cgroup', name)
+    if not os.path.exists(cpuset_path):
+        print(f"Error: cpuset '{name}' does not exist", file=sys.stderr)
+        sys.exit(1)
+
+    # Get cpuset info
+    info = get_cpuset_info(name)
+
+    if info['error']:
+        print(f"Error reading cpuset info: {info['error']}", file=sys.stderr)
+        sys.exit(1)
+
+    # Print detailed information
+    print(f"Cpuset: {name}")
+    print(f"Path: {info['path']}")
+    print(f"CPUs: {info['cpus'] or '(none)'}")
+    print(f"Memory Nodes: {info['mems'] or '(none)'}")
+    print(f"Partition: {info['partition']}")
+    print(f"Task Count: {info['task_count']}")
+
+    # Show task details if requested
+    if show_tasks and info['tasks']:
+        print(f"\nTasks ({len(info['tasks'])} total):")
+        print(f"{'PID':<10} {'COMMAND':<30} {'STATUS':<10}")
+        print("-" * 52)
+
+        for pid_str in info['tasks']:
+            try:
+                pid = int(pid_str)
+                comm = cpuset.Cpuset._get_process_name(pid)
+                is_blocked = cpuset.Cpuset._is_process_blocklisted(pid)
+                status = "BLOCKED" if is_blocked else "ok"
+                print(f"{pid:<10} {comm:<30} {status:<10}")
+            except (ValueError, OSError):
+                print(f"{pid_str:<10} {'(error)':<30} {'error':<10}")
+
+    # Show blocklist warnings
+    if info['blocklisted_pids']:
+        print()
+        print("⚠️  WARNINGS:")
+        for pid, comm in info['blocklisted_pids']:
+            print(f"  - Blocklisted process PID {pid} ({comm})", file=sys.stderr)
+        print("  These critical system processes should not be in custom cpusets!", file=sys.stderr)
+
+
+def cpuset_status(pattern, skip_empty, recursive):
+    """Handler for 'tuna cpuset status' command.
+
+    Args:
+        pattern: Glob pattern to filter cpusets (None for all)
+        skip_empty: If True, skip cpusets with no CPUs assigned
+        recursive: If True, search nested cpusets
+    """
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
+        sys.exit(1)
+
+    # Get all cpusets info
+    infos = get_all_cpusets_info(pattern=pattern, recursive=recursive, skip_empty=skip_empty)
+
+    if not infos:
+        if pattern:
+            print(f"No cpusets found matching pattern '{pattern}'")
+        else:
+            print("No cpusets found")
+        return
+
+    # Calculate system-wide statistics
+    total_cpus_assigned = set()
+    total_tasks = 0
+    isolated_cpusets = []
+    cpusets_with_tasks = []
+
+    for info in infos:
+        if info['cpus']:
+            # Parse CPU list to get individual CPUs
+            try:
+                cpu_list = tuna.expand_cpulist(info['cpus'])
+                total_cpus_assigned.update(cpu_list)
+            except (ValueError, IndexError):
+                pass
+
+        total_tasks += info['task_count']
+
+        if info['partition'] == 'isolated':
+            isolated_cpusets.append(info['name'])
+
+        if info['task_count'] > 0:
+            cpusets_with_tasks.append(info['name'])
+
+    # Print system overview
+    print("=" * 70)
+    print("SYSTEM CPUSET OVERVIEW")
+    print("=" * 70)
+    print(f"Total cpusets: {len(infos)}")
+    print(f"CPUs assigned: {len(total_cpus_assigned)}")
+    print(f"Total tasks: {total_tasks}")
+    print(f"Isolated cpusets: {len(isolated_cpusets)}")
+    print()
+
+    # Print cpuset summary table
+    print(f"{'NAME':<25} {'CPUS':<20} {'MEMS':<8} {'TASKS':<7} {'PARTITION':<10}")
+    print("-" * 75)
+
+    for info in infos:
+        cpus_display = info['cpus'] or "(none)"
+        mems_display = info['mems'] or "(none)"
+
+        # Truncate long names with ellipsis
+        name_display = info['name']
+        if len(name_display) > 24:
+            name_display = name_display[:21] + "..."
+
+        # Truncate long CPU lists
+        if len(cpus_display) > 19:
+            cpus_display = cpus_display[:16] + "..."
+
+        print(f"{name_display:<25} {cpus_display:<20} {mems_display:<8} {info['task_count']:<7} {info['partition']:<10}")
+
+    # Show isolated cpusets if any
+    if isolated_cpusets:
+        print()
+        print(f"Isolated cpusets ({len(isolated_cpusets)}):")
+        for name in isolated_cpusets:
+            print(f"  - {name}")
+
+    # Check for blocklisted processes across all cpusets
+    warnings = []
+    for info in infos:
+        if info['blocklisted_pids']:
+            for pid, comm in info['blocklisted_pids']:
+                warnings.append((info['name'], pid, comm))
+
+    if warnings:
+        print()
+        print("⚠️  WARNINGS - Blocklisted processes found:")
+        for cpuset_name, pid, comm in warnings:
+            print(f"  - {cpuset_name}: PID {pid} ({comm})", file=sys.stderr)
+        print("  These critical system processes should not be in custom cpusets!", file=sys.stderr)
+
+
 def main():
     i18n_init()
     parser = gen_parser()
@@ -1370,6 +1633,12 @@ def main():
         elif args.cpuset_command == 'move':
             cpuset_move(args.name, args.thread_list, args.pid_list)
 
+        elif args.cpuset_command == 'show':
+            cpuset_show(args.name, args.show_tasks)
+
+        elif args.cpuset_command == 'status':
+            cpuset_status(args.pattern, args.skip_empty, args.recursive)
+
 
 if __name__ == '__main__':
     main()
-- 
2.54.0

