Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC9337BB8
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692963; cv=none; b=gjVoGeBj41kffMqhb2fAJoWTHdrR44mUFSL3WHLltQPS1G+1DmSJfmqcc9N4Re2Q59UUn9lSJ3o+VcGOmdO4aaLcoeL4ea+ttFeOSWcgZGMqBzLckrxym6YV+aNuAR4sEpoDmzjQ9M7w9eei5ZaZIFVuiHpPi8mHUJW54niChjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692963; c=relaxed/simple;
	bh=WG4T6DMr35DencwF1MgSqCFRAZtLkSEXTbgVwInSPis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g20gm4Vm6jy7CK6pVQPhiV0XZl+i4aoRJwphZSTVonMEP65HQ4KEg5vKlV6zaCFTojZPiQED+S5/IjWp8sE1LUBS5xIORvbhl0Wu+GZzmBWRo8eetq2oo/CZk1mVh6ivXQ4WvIptZN4E1RqdGVtFo6P/aRJZgOKvPDfx7pzaxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRHPdcux; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRHPdcux"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bf9466867cso331673e0c.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692960; x=1784297760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+lMKeohrNYKDJo8RBf23/PuKMIOI2UWlHyPIM5qV/ls=;
        b=lRHPdcuxkguaMH31Pd5WXsXMWquaELe0x+ru87YTRJi+POykRqnLtRobNLQgQNW96l
         UokP/VLYsA4M76XmZHbU8rpiU4Rgjf/WlgYMcBIyvDlxgL7q7TNCYR3KBwf9MrgdKxiJ
         tIkPyigVBGCXaH3Adhbk2GSeJ4EO67lxYwPEuHvNcWv3EtJ0jxHUIJb8667kKP20hxbz
         Ii5QVjJawIW0/27rDU1IHGaSyGKaoz5q6uucz9z6tY5eYI01NOoFswESSASajbpXAbaY
         hcrvkfSU8AX/US6I6n+AxR67iv7xh3mhO6sBqt6pBU3QVwjw3rJv1AzEMyAuuKUdlm0B
         H0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692960; x=1784297760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lMKeohrNYKDJo8RBf23/PuKMIOI2UWlHyPIM5qV/ls=;
        b=C64F4zkDnt70hJj7URwmjvSMbRNyDc+LozHhnUBxGkEX0i0ghKi4zpoSlOmvTP8vx5
         XQAYzLWiluSfJorwtumIYY3MmnSuO9BcJk6XjYHKCIt1dJnCtj1QjudFSQS8cat4JYz4
         vil/vHUDIUhgA1HqO9RG0qrZknNZeIuzqoZir8gvDiucROUarpWSOVEEehVwXQqBY9r9
         PJbfk+RIA9at6qcXFtmmr88ecBbdo76XnIibabaijeI9U/FixMyvHCNbTwn53Aq62Ad1
         LDdZHbcDs8Eh8W36lvJfbCbOrky5gCEowb5cp72SQkegIeTUYzsoPLDHP0F2ve/PLWR5
         WPOg==
X-Gm-Message-State: AOJu0YyW9hTs3HUORUvk2232JjAPLZc6S2zkm5XlIRDBpiAwZPUBAvEP
	1CkIa2ysqE8yoeSDQWlMsqIa2PoCPt1FzltNV07HrH7zuet92TzXtGiK6quBHA==
X-Gm-Gg: AfdE7cmh4gUgufp8cbEUXCXsCSmYFIzqN3Yk/mAbsogXfBHLzD+LJWoAi+GrSlgyGSL
	wJLiBYuTOUAuC9/P13BlKf+F+e3I0xj8hLMAhSBjHFbOR76fuSmkkOMay/DNUFg+VkzWo5rR3D2
	8NriwnIHNSdTX8UoGa05Xq5eOLet3W/J243VRswBW40mpCNiEaZKc0Uio4FSEaLLBul15xt9CDt
	I0UGzZCELTkJ5CX99m9pX9xwd+weBrUL719aHq8FH5H9L9U/eTNgdFK2hv9T5Z+QAZVAO3zzUnw
	D/r16xi6SjjyVxrgDwnorn5xgjfyPgkzpzu7Xv5KZHgk6evzFpnY1CFVESjBqD4ueXN0MVFt2Hp
	uRfpdfRya4E4UrNNd0Wa77pSj0y7CEzrax6IFtOEF+HE4aqMqHG11ZMSEJCS9IVnHkIo7qT0Hob
	iGiwlE3Ty8tdhw3XdALDrrmd+mWuzoblT/v1r4RptJ3vfjHKhVq1YDjGOJAxYpsFM4heR5mLVhv
	w==
X-Received: by 2002:a05:6102:374d:b0:728:4383:c831 with SMTP id ada2fe7eead31-744dff87b7emr6832235137.10.1783692959916;
        Fri, 10 Jul 2026 07:15:59 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:15:59 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 09/36] tuna: Add CLI commands for cpuset management
Date: Fri, 10 Jul 2026 10:14:47 -0400
Message-ID: <20260710141523.36440-10-jkacur@redhat.com>
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

Add nested subcommands under 'tuna cpuset' for managing CPU sets using
cgroup v2. The implementation provides three main commands: create, list,
and destroy.

Command structure:
  tuna cpuset create --cpus <cpu-list> [--name <name>] [--isolated]
  tuna cpuset list [--pattern <pattern>] [--verbose] [--skip-empty] [--no-recursive]
  tuna cpuset destroy <name> [--force]
  tuna cpuset destroy --pattern <pattern> [--force] [--skip-empty] [--no-recursive]

Key features:
- Auto-naming: Creates cpusets as tuna0, tuna1, etc. with gap-filling logic
  when no name is specified
- Safety: force=False by default, requiring explicit --force to migrate tasks
  before destroying cpusets
- Filtering: --skip-empty option to filter out systemd infrastructure cgroups
  that have no CPUs assigned
- Pattern matching: Destroy multiple cpusets using glob patterns (e.g., tuna*)
- Validation: Enforces mutual exclusion between NAME and --pattern arguments

The destroy command combines single cpuset destruction with pattern-based
bulk cleanup, validated to prevent accidentally destroying the wrong cpusets.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 251 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index b9a071414125..2ff73426ba4f 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -22,6 +22,7 @@ import tuna.new_eth as ethtool
 import tuna.tuna_sched as tuna_sched
 import procfs
 from tuna import tuna, sysfs, utils
+from tuna import cpuset
 import logging
 import time
 import shutil
@@ -175,6 +176,7 @@ def gen_parser():
     show_configs = subparser.add_parser('show_configs', description='List preloaded profiles', help='List preloaded profiles')
     what_is = subparser.add_parser('what_is', description='Provides help about selected entities', help='Provides help about selected entities')
     gui = subparser.add_parser('gui', description="Start the GUI", help="Start the GUI")
+    cpuset = subparser.add_parser('cpuset', description='Manage CPU sets (cgroup v2)', help='Manage CPU sets')
 
     isolate_group = isolate.add_mutually_exclusive_group(required=True)
     isolate_group.add_argument('-c', '--cpus', **MODS['cpus'])
@@ -266,6 +268,30 @@ def gen_parser():
     gui.add_argument('-U', '--no_uthreads', **MODS['no_uthreads'])
     gui.add_argument('-K', '--no_kthreads', **MODS['no_kthreads'])
 
+    # Cpuset nested subcommands
+    cpuset_subparser = cpuset.add_subparsers(dest='cpuset_command', required=True)
+
+    # cpuset create
+    cpuset_create = cpuset_subparser.add_parser('create', description='Create a new cpuset', help='Create a new cpuset')
+    cpuset_create.add_argument('-c', '--cpus', **MODS['cpus'], required=True)
+    cpuset_create.add_argument('-n', '--name', type=str, metavar='NAME', help='Cpuset name (default: auto-generate tunaN)')
+    cpuset_create.add_argument('-i', '--isolated', action='store_true', help='Set CPU partition to isolated')
+
+    # cpuset list
+    cpuset_list = cpuset_subparser.add_parser('list', description='List cpusets', help='List cpusets')
+    cpuset_list.add_argument('-p', '--pattern', type=str, metavar='PATTERN', help='Filter by glob pattern (e.g., tuna*)')
+    cpuset_list.add_argument('-v', '--verbose', action='store_true', help='Show detailed information (CPUs, tasks, partition type)')
+    cpuset_list.add_argument('--skip-empty', action='store_true', help='Skip cpusets with no CPUs assigned')
+    cpuset_list.add_argument('--no-recursive', dest='recursive', action='store_false', default=True, help='Only search top-level cpusets')
+
+    # cpuset destroy
+    cpuset_destroy = cpuset_subparser.add_parser('destroy', description='Destroy cpuset(s)', help='Destroy cpuset(s)')
+    cpuset_destroy.add_argument('name', nargs='?', type=str, metavar='NAME', help='Cpuset name to destroy (use this OR --pattern)')
+    cpuset_destroy.add_argument('-p', '--pattern', type=str, metavar='PATTERN', help='Glob pattern to destroy multiple cpusets (e.g., tuna*)')
+    cpuset_destroy.add_argument('-f', '--force', action='store_true', help='Migrate tasks to root cgroup before destroying')
+    cpuset_destroy.add_argument('--skip-empty', action='store_true', help='When using --pattern, skip cpusets with no CPUs assigned')
+    cpuset_destroy.add_argument('--no-recursive', dest='recursive', action='store_false', default=True, help='Only destroy top-level cpusets when using --pattern')
+
     return parser
 
 
@@ -769,6 +795,220 @@ def nohz_full_to_cpu():
         sys.exit(2)
 
 
+def get_next_tuna_cpuset_name():
+    """Find next available tunaN name for auto-generated cpusets.
+
+    Scans existing cpusets matching pattern 'tuna[0-9]*' and returns
+    the first available number in the sequence (fills gaps).
+
+    Returns:
+        str: Next available cpuset name (e.g., 'tuna0', 'tuna1')
+    """
+    existing = cpuset.list_cpusets(pattern='tuna[0-9]*', recursive=False)
+
+    # Extract numbers from tuna0, tuna1, etc.
+    numbers = []
+    for name in existing:
+        match = re.match(r'tuna(\d+)', name)
+        if match:
+            numbers.append(int(match.group(1)))
+
+    # Find first gap in sequence, or use 0 if none exist
+    if not numbers:
+        return 'tuna0'
+
+    # Find first gap in sequence
+    for i in range(max(numbers) + 2):
+        if i not in numbers:
+            return f'tuna{i}'
+
+
+def cpuset_create(cpu_list, name, isolated):
+    """Handler for 'tuna cpuset create' command.
+
+    Args:
+        cpu_list: List of CPU numbers to assign to cpuset
+        name: Cpuset name (None for auto-generated tunaN)
+        isolated: If True, set CPU partition to isolated
+    """
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
+        sys.exit(1)
+
+    # Auto-generate name if not provided
+    if name is None:
+        name = get_next_tuna_cpuset_name()
+
+    # Convert CPU list to string format (e.g., [0,1,2,3] -> "0-3")
+    cpu_str = tuna.collapse_cpulist(cpu_list)
+
+    try:
+        # Create cpuset
+        cs = cpuset.Cpuset(name)
+
+        # Configure it (must set memnode before CPUs in cgroup v2)
+        cs.write_memnode('0')
+        cs.assign_cpus(cpu_str)
+
+        # Set isolated partition if requested
+        if isolated:
+            cs.set_cpu_exclusive()
+
+        print(f"Created cpuset '{name}' with CPUs {cpu_str}" +
+              (f" (isolated)" if isolated else ""))
+
+    except (OSError, ValueError) as e:
+        print(f"Error creating cpuset: {e}", file=sys.stderr)
+        sys.exit(1)
+
+
+def cpuset_list(pattern, verbose, skip_empty, recursive):
+    """Handler for 'tuna cpuset list' command.
+
+    Args:
+        pattern: Glob pattern to filter cpusets (None for all)
+        verbose: If True, show detailed info (CPUs, tasks, partition)
+        skip_empty: If True, skip cpusets with no CPUs assigned
+        recursive: If True, search nested cpusets
+    """
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
+        sys.exit(1)
+
+    # List cpusets
+    cpusets = cpuset.list_cpusets(pattern=pattern, recursive=recursive)
+
+    # Filter out empty cpusets if requested
+    if skip_empty:
+        filtered_cpusets = []
+        for cs_name in cpusets:
+            cs_path = os.path.join('/sys/fs/cgroup', cs_name)
+            try:
+                with open(os.path.join(cs_path, 'cpuset.cpus'), 'r', encoding='utf-8') as f:
+                    cpus = f.read().strip()
+                    if cpus:  # Only include if CPUs are assigned
+                        filtered_cpusets.append(cs_name)
+            except (OSError, IOError):
+                # If we can't read it, skip it
+                pass
+        cpusets = filtered_cpusets
+
+    if not cpusets:
+        if pattern:
+            print(f"No cpusets found matching pattern '{pattern}'")
+        else:
+            print("No cpusets found")
+        return
+
+    if verbose:
+        # Verbose output: NAME, CPUS, TASKS, PARTITION
+        print(f"{'NAME':<20} {'CPUS':<15} {'TASKS':<7} {'PARTITION':<10}")
+        print("-" * 55)
+
+        for cs_name in cpusets:
+            cs_path = os.path.join('/sys/fs/cgroup', cs_name)
+
+            try:
+                # Read CPUs
+                with open(os.path.join(cs_path, 'cpuset.cpus'), 'r', encoding='utf-8') as f:
+                    cpus = f.read().strip() or "(none)"
+
+                # Read tasks count
+                with open(os.path.join(cs_path, 'cgroup.procs'), 'r', encoding='utf-8') as f:
+                    tasks = [line.strip() for line in f if line.strip()]
+                    task_count = len(tasks)
+
+                # Read partition type (if available)
+                partition_file = os.path.join(cs_path, 'cpuset.cpus.partition')
+                if os.path.exists(partition_file):
+                    with open(partition_file, 'r', encoding='utf-8') as f:
+                        partition = f.read().strip()
+                else:
+                    partition = "n/a"
+
+                print(f"{cs_name:<20} {cpus:<15} {task_count:<7} {partition:<10}")
+
+            except (OSError, IOError) as e:
+                print(f"{cs_name:<20} (error reading: {e})", file=sys.stderr)
+    else:
+        # Simple output: just names
+        for cs_name in cpusets:
+            print(cs_name)
+
+
+def cpuset_destroy(name, pattern, force, skip_empty, recursive):
+    """Handler for 'tuna cpuset destroy' command.
+
+    Args:
+        name: Cpuset name to destroy (single cpuset, mutually exclusive with pattern)
+        pattern: Glob pattern for cpusets to destroy (mutually exclusive with name)
+        force: If True, migrate tasks to root before destroying
+        skip_empty: If True, skip cpusets with no CPUs assigned (only used with pattern)
+        recursive: If True, find and clean nested cpusets (only used with pattern)
+    """
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
+        sys.exit(1)
+
+    # Validate: must have either name OR pattern, not both, not neither
+    if name and pattern:
+        print("Error: specify either NAME or --pattern, not both", file=sys.stderr)
+        sys.exit(2)
+    if not name and not pattern:
+        print("Error: must specify either NAME or --pattern", file=sys.stderr)
+        sys.exit(2)
+
+    try:
+        if name:
+            # Single cpuset destroy (skip_empty not applicable)
+            cpuset.destroy_cpuset(name, force=force)
+            print(f"Destroyed cpuset '{name}'")
+        else:
+            # Pattern-based cleanup
+            if skip_empty:
+                # Filter out empty cpusets before destroying
+                all_cpusets = cpuset.list_cpusets(pattern=pattern, recursive=recursive)
+                cpusets_to_destroy = []
+
+                for cs_name in all_cpusets:
+                    cs_path = os.path.join('/sys/fs/cgroup', cs_name)
+                    try:
+                        with open(os.path.join(cs_path, 'cpuset.cpus'), 'r', encoding='utf-8') as f:
+                            cpus = f.read().strip()
+                            if cpus:  # Only destroy if CPUs are assigned
+                                cpusets_to_destroy.append(cs_name)
+                    except (OSError, IOError):
+                        # If we can't read it, skip it
+                        pass
+
+                # Destroy each non-empty cpuset individually
+                if not cpusets_to_destroy:
+                    print(f"No non-empty cpusets found matching pattern '{pattern}'")
+                    return
+
+                # Sort in reverse order by depth to ensure children destroyed before parents
+                cpusets_by_depth = sorted(cpusets_to_destroy, key=lambda x: x.count(os.sep), reverse=True)
+
+                for cs_name in cpusets_by_depth:
+                    try:
+                        cpuset.destroy_cpuset(cs_name, force=force)
+                        print(f"Destroyed cpuset '{cs_name}'")
+                    except (OSError, ValueError) as e:
+                        print(f"Error destroying cpuset '{cs_name}': {e}", file=sys.stderr)
+            else:
+                # Use cleanup_cpusets for normal pattern-based destroy
+                cpuset.cleanup_cpusets(pattern, force=force, recursive=recursive)
+    except (OSError, ValueError) as e:
+        print(f"Error destroying cpuset(s): {e}", file=sys.stderr)
+        sys.exit(1)
+
+
 def main():
     i18n_init()
     parser = gen_parser()
@@ -978,6 +1218,17 @@ def main():
         except KeyboardInterrupt:
             pass
 
+    elif args.command == 'cpuset':
+        # Handle cpuset subcommands
+        if args.cpuset_command == 'create':
+            cpuset_create(args.cpu_list, args.name, args.isolated)
+
+        elif args.cpuset_command == 'list':
+            cpuset_list(args.pattern, args.verbose, args.skip_empty, args.recursive)
+
+        elif args.cpuset_command == 'destroy':
+            cpuset_destroy(args.name, args.pattern, args.force, args.skip_empty, args.recursive)
+
 
 if __name__ == '__main__':
     main()
-- 
2.54.0

