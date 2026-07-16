Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721343F8C9
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223975; cv=none; b=agtsCkY6M6lsrl37d46d5IUa3KqtLZkA0qHI9NEi4K0Emdan839RLs2E055ESfZD+hAzJmk1wubVnJESiXkaawaQbrt9UlI7sIveJdA/W7sbFY8lYSliSaXs0XpC6JOSlXq2LA3iuUk5Ezg1ypvRBUNAbTDYmQAYw8cq47PLSwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223975; c=relaxed/simple;
	bh=b8AX8hhhv/1+5MQ44jf1qOGJWUitGAS2IXxwnThUk+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjLZTbsinkNZKyahAJhdwNBjUJoKDKum68sZKqt5UjjdNwcxoo5R6WQKHY+Yscw35QdqMKC3MaQtzsR4s3j+QQHpedvHoWqf8qf+NEhq3aTk/y4uVCdr+BmGjeABo1Sbz5pXYCJhE/TEyy5YVE7g0JbNvhYbadUo0mBM/D4Zepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pR+90JNR; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR+90JNR"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8eefd4a8057so30874976d6.0
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223973; x=1784828773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cvHwvbB086G8hIp3cAskjEvg2SfCobnq0BY9CrcB3dM=;
        b=pR+90JNR+RLuiCzoh8mMDEhbuo3USHenUFAsAukr/JJ7NOhISIlfS8XtWLU6wLUxB2
         TJsnZKvjDc8P2fSRUOg4gWhkCRq7bk9V2DLZ2UPhmFO2//k/ydWCociD6Bb6YOMUN1FY
         ICdq9jO4raKtHKkjn4S3zp2OvE9g3OwQTE5VUNayYzxwqpC/mbecJqln6m7gfBpm64tQ
         50eMZsN/tFEdG4L/NG1Dd2ENJrZiadvE1KdsiggY19tqpggGmHrvA80W3L9qdS8pdLAs
         PEbVnOyBxkAJDXZprZL1U9yRqCTlBYQ3kwUfH0fnH9pL16w591aP7bIwU7s1HVKyoolw
         xcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223973; x=1784828773;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cvHwvbB086G8hIp3cAskjEvg2SfCobnq0BY9CrcB3dM=;
        b=HR8NOuWXm4SZCJPmHSSJUAV/txIw1GInV5E4QQij7KaYfZTXosVXkvjAFCf85I4oQ1
         UKRvX6+5/+lCTR1IBW6KXMm4eXScYqiOO92r7jIGZuvqJ90M8doJ+ea8qW1HxtWp62Ml
         CfbYaNR58KyvclswHnryQF9x1oz9S5o9b8FDdSVLdXcad7oy5JxCiYQdRKGYl0gJ2A3n
         9gbBRvcWplkfcBNSCX6VaZx24vwTRSA9tJsFFOV15D1vmaJizC46h7eX4VVqsjiXo3w6
         I9JcUKK7qeupetIbEo9j1rQddsycm65l4vVFwkY4lUlafvYu/aXPxuj0mMtgVrw9LWVE
         sYEw==
X-Gm-Message-State: AOJu0YwqVm2VYpL5gZcpxYfrYxXjA3Hu3pfpHu2R5SN00Ns8CFVMhxIi
	XBus7nulBv2YkPFVys9UzBsTYBRysfqyr6AeR81Nv0r/Q5FWgVwfBLE4gX4K5w==
X-Gm-Gg: AfdE7clPZkSw/5xWZB2toHA62xd2/YKL3/cYEDaVWat/iaRNqJ72Qgqh/ud0cqahj1c
	X3qrQ2hwvDNI2dvwtU5doU46tEFBRgaEVuwMCu7zA/ovPTMiv3/ViZbJUn3Ff9e//mIiiKX1mcu
	1LIRF6NrDN/KIiWvvqXDW8zHKT4YDdeq6yYx32eLXNEYbH9gCQ/HkTSMuAcM+mUxX0b/zc6ZCf6
	pPDqpQm6hTSZJX3CTGEsajhTNOIWipgOpgn9E0ESH9m750+ZBs/Bg0tiBfxFB1t0pFHJQ4TimrZ
	HsuzUjpIqXCdNTPuAzOSUQ5HjlvxdruJRRsAf1/ypQDE3pM14rLprOUE1aZP7kj0Pm3rWuFYaD3
	ud1QZ5blzd6+jILt6/t81CqskIdlmQLzPIJh1hHlxel5xYeda7ZoiAmW974b/BXVOItb0K4UzNl
	jxfRbRb0SRNE9FZ/To/hdP8/sTSeU1+ficK6p6LDO/8LT5plhV033C2PcDFUvkreQ8bgIYPwqu4
	goHbAA=
X-Received: by 2002:a05:6214:5c41:b0:8f1:7779:518b with SMTP id 6a1803df08f44-907744c4a43mr6719596d6.47.1784223972668;
        Thu, 16 Jul 2026 10:46:12 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0347sm224952276d6.2.2026.07.16.10.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:46:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 2/7] tuna: Add cpuset save/apply functionality
Date: Thu, 16 Jul 2026 13:45:45 -0400
Message-ID: <20260716174554.126145-3-jkacur@redhat.com>
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

Implement save and apply commands as cpuset subcommands for cpuset
configuration management, enabling users to save their cpuset setup to
YAML and restore it later. This is useful for preserving RT isolation
configurations across reboots or applying consistent setups across
multiple systems.

Save functionality (tuna cpuset save):
- Saves all user-created cpusets to YAML profile
- Automatically filters out system cpusets (.slice, .scope, .mount, .service)
- Skips empty cpusets (no CPUs assigned)
- Captures: name, CPUs, memory nodes, partition type
- Default filename: tuna-profile.yaml

Apply functionality (tuna cpuset apply):
- Recreates cpusets from saved YAML profile
- Follows cgroup v2 requirements (memory nodes before CPUs)
- Non-destructive: warns when cpusets already exist instead of failing
- Supports verbose mode (-v) for detailed progress
- Returns statistics on applied/warnings/errors

Implementation details:
- Created tuna/profile.py module with save_cpusets() and apply_cpusets()
- Reuses existing get_all_cpusets_info() from tuna-cmd.py via parameter passing
- Passes cpuset module to apply function for code reuse
- Both commands check cgroup v2 support before proceeding
- Uses ruamel.yaml for human-readable YAML output
- Added save and apply as cpuset subcommands for consistency

Command structure:
  tuna cpuset save [filename]           # Save to file (default: tuna-profile.yaml)
  tuna cpuset apply [filename] [-v]     # Apply from file with optional verbose

Usage examples:
  tuna cpuset save my-config.yaml       # Save to custom file
  tuna cpuset apply my-config.yaml -v   # Apply with verbose output
  tuna cpuset save                      # Use default filename
  tuna cpuset apply                     # Apply default profile

This approach provides superior RT isolation by using kernel-enforced
CPU partitioning via cgroups v2 rather than manual affinity settings.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py     |  91 ++++++++++++++++++-------
 tuna/profile.py | 177 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+), 24 deletions(-)
 create mode 100644 tuna/profile.py

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 262159150211..4eba82aac412 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -167,10 +167,6 @@ def gen_parser():
                                     help="Set thread scheduler tunables: POLICY and RTPRIO")
     run = subparser.add_parser('run', description="Fork a new process and run the COMMAND",
                                 help="Fork a new process and run the COMMAND")
-    save = subparser.add_parser('save', description="Save kthreads sched tunables to FILENAME",
-                                help="Save kthreads sched tunables to FILENAME")
-    # apply = subparser.add_parser('apply', description="Apply changes described in profile",
-    #                             help="Apply changes described in profile")
     show_threads = subparser.add_parser('show_threads', description='Show thread list', help='Show thread list')
     show_irqs = subparser.add_parser('show_irqs', description='Show IRQ list', help='Show IRQ list')
     show_configs = subparser.add_parser('show_configs', description='List preloaded profiles', help='List preloaded profiles')
@@ -225,15 +221,6 @@ def gen_parser():
     run.add_argument('-p', '--priority', **MODS['priority'])
     run.add_argument('-b', '--background', **MODS['background'])
 
-    save.add_argument('filename', **POS['filename'])
-    save_group = save.add_mutually_exclusive_group(required=False)
-    save_group.add_argument('-c', '--cpus', **MODS['cpus'])
-    save_group.add_argument('-S', '--sockets', **MODS['sockets'])
-    save_group.add_argument('-N', '--nohz_full', **MODS['nohz_full'])
-    save.add_argument('-t', '--threads', **MODS['threads'])
-
-    # apply.add_argument('profilename', **POS['profilename'])
-
     show_threads_group1 = show_threads.add_mutually_exclusive_group(required=False)
     show_threads_group1.add_argument('-c', '--cpus', **MODS['cpus'])
     show_threads_group1.add_argument('-N', '--nohz_full', **MODS['nohz_full'])
@@ -334,6 +321,18 @@ def gen_parser():
     partition_group.add_argument('--isolated', action='store_true', help='Set CPU partition to isolated')
     partition_group.add_argument('--no-isolated', action='store_true', help='Set CPU partition to member (not isolated)')
 
+    # cpuset save
+    cpuset_save = cpuset_subparser.add_parser('save', description='Save cpuset configuration to YAML profile', help='Save cpuset configuration')
+    cpuset_save.add_argument('filename', nargs='?', default='tuna-profile.yaml',
+                             help='Output YAML file (default: tuna-profile.yaml)')
+
+    # cpuset apply
+    cpuset_apply = cpuset_subparser.add_parser('apply', description='Apply cpuset configuration from YAML profile', help='Apply cpuset configuration')
+    cpuset_apply.add_argument('filename', nargs='?', default='tuna-profile.yaml',
+                              help='Input YAML file (default: tuna-profile.yaml)')
+    cpuset_apply.add_argument('-v', '--verbose', action='store_true',
+                              help='Print detailed progress messages')
+
     return parser
 
 
@@ -351,14 +350,55 @@ def thread_help(tid, ps):
     print(help)
 
 
-def save(cpu_list, thread_list, filename):
-    kthreads = tuna.get_kthread_sched_tunings()
-    for name in list(kthreads.keys()):
-        kt = kthreads[name]
-        if (cpu_list and not set(kt.affinity).intersection(set(cpu_list))) or \
-           (thread_list and kt.pid not in thread_list):
-            del kthreads[name]
-    tuna.generate_rtgroups(filename, kthreads, utils.get_nr_cpus())
+def save_cpusets_cmd(filename):
+    """Handler for 'tuna cpuset save' command - saves cpuset configuration to YAML.
+
+    Args:
+        filename: Output YAML file path
+    """
+    from tuna import profile
+
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
+        sys.exit(1)
+
+    # Save cpusets using profile module (reuses get_all_cpusets_info)
+    num_saved = profile.save_cpusets(filename, get_all_cpusets_info)
+
+    if num_saved > 0:
+        print(f"Saved {num_saved} cpuset(s) to {filename}")
+    else:
+        print("No cpusets to save", file=sys.stderr)
+
+
+def apply_cpusets_cmd(filename, verbose=False):
+    """Handler for 'tuna cpuset apply' command - applies cpuset configuration from YAML.
+
+    Args:
+        filename: Input YAML file path
+        verbose: If True, print detailed progress messages
+    """
+    from tuna import profile
+
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
+        sys.exit(1)
+
+    # Apply cpusets using profile module (passes cpuset module for code reuse)
+    num_applied, num_warnings, num_errors = profile.apply_cpusets(filename, cpuset, verbose)
+
+    # Print summary
+    if num_applied > 0:
+        print(f"Applied {num_applied} cpuset(s) from {filename}")
+    if num_warnings > 0:
+        print(f"Warnings: {num_warnings}", file=sys.stderr)
+    if num_errors > 0:
+        print(f"Errors: {num_errors}", file=sys.stderr)
+        sys.exit(1)
 
 
 def extract_cpuset_name(cgroup_path):
@@ -1814,9 +1854,6 @@ def main():
             if args.irq_list:
                 tuna.move_irqs_to_cpu(args.cpu_list, args.irq_list, spread=spread)
 
-    elif args.command in ['s', 'save']:
-        save(args.cpu_list, args.thread_list, args.filename)
-
     elif args.command in ['W', 'what_is']:
         if not ps:
             ps = procfs.pidstats()
@@ -1883,6 +1920,12 @@ def main():
             cpuset_modify(args.name, add_cpus, remove_cpus, args.memory_nodes,
                          args.isolated, args.no_isolated)
 
+        elif args.cpuset_command == 'save':
+            save_cpusets_cmd(args.filename)
+
+        elif args.cpuset_command == 'apply':
+            apply_cpusets_cmd(args.filename, args.verbose)
+
 
 if __name__ == '__main__':
     main()
diff --git a/tuna/profile.py b/tuna/profile.py
new file mode 100644
index 000000000000..8372d081546f
--- /dev/null
+++ b/tuna/profile.py
@@ -0,0 +1,177 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0-only
+
+"""
+RT system profile save/restore functionality.
+
+This module provides functions to save and restore RT system configurations
+including cpuset definitions.
+"""
+
+import datetime
+import sys
+from ruamel.yaml import YAML
+
+
+def save_cpusets(filename, get_cpusets_info_func):
+    """Save cpuset configuration to a YAML profile.
+
+    Args:
+        filename: Path to output YAML file
+        get_cpusets_info_func: Function to get cpuset info
+                               (should be get_all_cpusets_info from tuna-cmd.py)
+
+    Returns:
+        Number of cpuset entries saved
+
+    Note:
+        Only saves user-created cpusets with CPUs assigned.
+        System cpusets (.slice, .scope, .mount, .service) are automatically filtered out.
+    """
+    # Get all user-created cpusets with CPUs assigned
+    # Reuses existing filtering logic from get_all_cpusets_info:
+    #   skip_empty=True: Don't save cpusets with no CPUs
+    #   skip_system=True: Don't save systemd-managed cpusets
+    all_cpusets = get_cpusets_info_func(pattern=None, recursive=True,
+                                        skip_empty=True, skip_system=True)
+
+    if not all_cpusets:
+        print("No user-created cpusets found to save", file=sys.stderr)
+        return 0
+
+    # Build list of cpuset entries for YAML
+    # Reuses the structure from get_cpuset_info() - just extract what we need
+    cpuset_entries = []
+
+    for cs_info in all_cpusets:
+        entry = {
+            'name': cs_info['name'],
+            'cpus': cs_info['cpus'],
+            'mems': cs_info['mems'],
+            'partition': cs_info['partition']
+        }
+        cpuset_entries.append(entry)
+
+    # Create profile structure
+    profile = {
+        'version': '1.0',
+        'timestamp': datetime.datetime.now().isoformat(),
+        'cpusets': cpuset_entries
+    }
+
+    # Write YAML with ruamel.yaml for human readability
+    yaml = YAML()
+    yaml.default_flow_style = False
+    yaml.width = 4096  # Avoid line wrapping
+
+    with open(filename, 'w') as f:
+        # Write header comments
+        f.write("# Tuna RT System Profile - Cpuset Configuration\n")
+        f.write(f"# Generated: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
+        f.write("#\n")
+        f.write("# This file can be applied with: tuna cpuset apply <filename>\n")
+        f.write("#\n\n")
+
+        # Write YAML structure
+        yaml.dump(profile, f)
+
+    return len(cpuset_entries)
+
+
+def apply_cpusets(filename, cpuset_module, verbose=False):
+    """Apply cpuset configuration from a YAML profile.
+
+    Args:
+        filename: Path to input YAML file
+        cpuset_module: The cpuset module (passed as parameter for code reuse)
+        verbose: If True, print detailed progress messages
+
+    Returns:
+        Tuple of (num_applied, num_warnings, num_errors)
+
+    Note:
+        Creates cpusets in the order they appear in the profile.
+        Sets memory nodes before CPUs (cgroup v2 requirement).
+        Existing cpusets with matching names are skipped with a warning.
+    """
+    # Read YAML file
+    yaml = YAML()
+    try:
+        with open(filename, 'r') as f:
+            profile = yaml.load(f)
+    except FileNotFoundError:
+        print(f"Error: Profile file '{filename}' not found", file=sys.stderr)
+        return (0, 0, 1)
+    except Exception as e:
+        print(f"Error reading profile: {e}", file=sys.stderr)
+        return (0, 0, 1)
+
+    # Validate profile structure
+    if not profile or 'cpusets' not in profile:
+        print("Error: No cpusets found in profile", file=sys.stderr)
+        return (0, 0, 1)
+
+    # Check version compatibility
+    version = profile.get('version', 'unknown')
+    if verbose:
+        print(f"Applying profile version {version}")
+        timestamp = profile.get('timestamp', 'unknown')
+        print(f"Generated: {timestamp}")
+
+    cpuset_entries = profile['cpusets']
+    if not cpuset_entries:
+        print("No cpusets to apply", file=sys.stderr)
+        return (0, 0, 0)
+
+    num_applied = 0
+    num_warnings = 0
+    num_errors = 0
+
+    # Apply each cpuset
+    for entry in cpuset_entries:
+        name = entry.get('name')
+        cpus = entry.get('cpus', '')
+        mems = entry.get('mems', '0')
+        partition = entry.get('partition', 'member')
+
+        if not name:
+            print("Error: Cpuset entry missing 'name' field", file=sys.stderr)
+            num_errors += 1
+            continue
+
+        if verbose:
+            print(f"Creating cpuset '{name}' (CPUs: {cpus}, mems: {mems}, partition: {partition})")
+
+        try:
+            # Check if cpuset already exists
+            import os
+            cpuset_path = os.path.join('/sys/fs/cgroup', name)
+            if os.path.exists(cpuset_path):
+                print(f"Warning: Cpuset '{name}' already exists, skipping", file=sys.stderr)
+                num_warnings += 1
+                continue
+
+            # Create cpuset
+            cs = cpuset_module.Cpuset(name)
+
+            # Set memory nodes BEFORE CPUs (cgroup v2 requirement)
+            cs.write_memnode(mems)
+
+            # Set CPUs
+            if cpus:
+                cs.assign_cpus(cpus)
+
+            # Set partition type if isolated
+            if partition == 'isolated':
+                cs.set_cpu_exclusive()
+
+            num_applied += 1
+
+            if verbose:
+                print(f"  ✓ Created cpuset '{name}'")
+
+        except (OSError, ValueError) as e:
+            print(f"Error creating cpuset '{name}': {e}", file=sys.stderr)
+            num_errors += 1
+
+    return (num_applied, num_warnings, num_errors)
-- 
2.55.0

