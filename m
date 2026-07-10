Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABF33DEF9
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692979; cv=none; b=LoZNqpxsvcBsVLI9ZcN3BqxppxaWBcmSo5NjB3NV6RIsuf08owevsUy+LvZN2/Jo4Dfy7fHAvp/+bbFdyR8EiGwkEChm7fS0+sMms+3vLICtkY4ygxBkvwAPKTW0JZrkLjWcMAfyntBic5ADfQpFAoHvI8qun6fcAwCNenOVJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692979; c=relaxed/simple;
	bh=EFK7WJwfi/nUIGOY1irdbmkougPipVXzoq4aTTonV6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OO3ObbsE4UHytNN29SkBGw379iZSIIHHhXYZ++k9+vZdRSWsakwxzo7ZMfLzBt01d9j7MdzobSqL5ge5fuHMYC0kQyBq/u9UzmDmDy9wFr8Iph41g9lNs71YBSleQfW8XXuj4gzPUFQFFo3w1sDWvrTIpLQ0K0j/OfjcY7YmY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inNjfmxx; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inNjfmxx"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bbc717c52aso404782e0c.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692977; x=1784297777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1H9Lcz7wWwt/bJTOgM3/R0ppYrakWghoAWzymYQtPY8=;
        b=inNjfmxx94TZgf/b+5mQ3hkRoQdK80ggS6Sd/0UTdhj2CZU4O66kxy7yOix8/SCPQD
         VRXR67C1A6vRfAdDnqPQOYZGmgQlozTUauuKzF5fZ7gakQf8O2haaNVELo9IAsQnUNFC
         tVgq2s18J/nlr27luaWFtFJH+wdVlohnsQdUxTwWPrITiNT/kZ+Iqms+cGTa/8ZiPN/+
         6UNuyrKbbNpttUMwA9zoOorjs2xdkcEdbZAvE0jhqX9fVO/dpmev5zknXWZZlm37fn1E
         yZT8anJk+OLsQBMnwQHITMUt6uBb6NmEqt3yPvUnDaT7zpPyTSxunjA85gvXXjFeJWvu
         RoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692977; x=1784297777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1H9Lcz7wWwt/bJTOgM3/R0ppYrakWghoAWzymYQtPY8=;
        b=WQblhYvt7W9p0TKE2WfREyR2sTPVwztq4qjoVd7bPdLcDdgGcy6+U37HeSdB5GKV7U
         pEXwwb54ZDV7uhhaFPe8iF6xNp4iCecExuDBKt27QGSZiwoPvSsDF/MseiSB/Yf+7nVP
         WX33CZ+CsOqlspWGjMjrttrzxhOHU38PJYKg1nWf8IjHwdoAf1U3qI8byPOfiLaCf3cS
         XPC0x1zoQA/OHg6MecgZt1ZB2zxWFsg5DbMi3CSaBKjsKQV+/fKzx3U3vQWp/3E9IijH
         3+L5Qe6d2oOlK+26ln0VftagITEX7QDLenCEUnxn9GMU8DmcpgvMTTYC+0MJjmJJi905
         7D3g==
X-Gm-Message-State: AOJu0Yy8JUj3cDivsD39vjnIGT0MyMnYoNRbyfJgCuEQX0iRkUOCN6iZ
	amCCWr6YVlfbrDpNF60ngjIgoeeunEg3+UU9rvXIzbZEOBFYe2dXC2nGuavmiA==
X-Gm-Gg: AfdE7clmwAd3re3PG0OnEy3s6Do++bZR89tKG9yXtGsjTHu4u7JNrhmSb3EHwgOw5Tq
	nYZnOCZXQzicGTj1Qv0Ctua9nLNOY5mqEeXhYccMRXmvgv4hm7F0IuR7j4SgQdBQKz1mufCPf5S
	QgNhJbW/aZTwX5FDSZK4aJD5F7NkE9sIS0HcW/KXXFyEDO7ypsuO7Vzs6/Vp7bhQCqrz8sm1u25
	eXXo0sS8XGhAcrYU/hkMoz3WzMvm7EQkY5GKQdnTa+it6PIZHbVbMPQwM2H1Qd3+umEWCGePNe9
	SmNhze1JFreDhxnQ+Piy3nsM+4ONXKq9XxYo0vMPgNJR677su8Ld0sBvEBEqm0SAywETKpFZ6/G
	hnn5+DlS+VEpbuy0a9v71svFWtHD0aAHJe7xbkJWAmmLQ7yIprI7khIZSsVkQQIk2u2TC8oppAu
	S2hlLCF75odjzK8/T5V9hqNPQmLD/W0BK8aINL8X4ETvIahY4eDCfcRPzQyQI278MQ2ANaM3R2v
	3CiO5NrrzD6
X-Received: by 2002:a05:6102:41a2:b0:739:4fa1:50af with SMTP id ada2fe7eead31-744dff52aa7mr7963729137.2.1783692976887;
        Fri, 10 Jul 2026 07:16:16 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:15 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 21/36] tuna: Change cpuset commands to skip empty by default
Date: Fri, 10 Jul 2026 10:14:59 -0400
Message-ID: <20260710141523.36440-22-jkacur@redhat.com>
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

Change the default behavior for cpuset list, destroy, and status
commands to skip empty cpusets (cpusets with no CPUs assigned).

Previously, these commands required --skip-empty to filter out empty
cpusets. This was counterintuitive since empty cpusets are rarely
useful in practice.

New flags:
- cpuset list/status: Use --show-empty to include empty cpusets
- cpuset destroy: Use --include-empty to destroy empty cpusets

The default behavior (without flags) now skips empty cpusets for all
three commands, providing a cleaner and more useful user experience.

Tests updated to reflect the new flag names and default behavior.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/test_cpuset_cli.py | 22 +++++++++++-----------
 tuna-cmd.py              | 36 ++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index 51c9b5d193c0..f8bf723d5c72 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -248,12 +248,12 @@ class TestCpusetListCLI(unittest.TestCase):
         self.assertIn('test_list_2', cpusets)
         self.assertIn('test_list_empty', cpusets)
 
-    def test_list_skip_empty(self):
-        """Test cpuset list with --skip-empty"""
+    def test_list_default_skips_empty(self):
+        """Test cpuset list default behavior (skips empty cpusets)"""
         # Get all cpusets matching pattern
         all_cpusets = cpuset.list_cpusets(pattern='test_list_*', recursive=False)
 
-        # Filter out empty ones manually (simulating --skip-empty)
+        # Filter out empty ones manually (simulating default behavior)
         non_empty = []
         for cs_name in all_cpusets:
             cs_path = os.path.join('/sys/fs/cgroup', cs_name)
@@ -300,7 +300,7 @@ class TestCpusetDestroyCLI(unittest.TestCase):
 
         # Destroy it (without force, no tasks)
         cpuset_destroy(name='test_destroy_single', pattern=None, force=False,
-                       skip_empty=False, recursive=True)
+                       include_empty=True, recursive=True)
 
         # Should be gone
         self.assertFalse(os.path.exists(path))
@@ -317,15 +317,15 @@ class TestCpusetDestroyCLI(unittest.TestCase):
 
         # Destroy by pattern
         cpuset_destroy(name=None, pattern='test_destroy_bulk_*', force=True,
-                       skip_empty=False, recursive=False)
+                       include_empty=True, recursive=False)
 
         # Should be gone
         self.assertFalse(os.path.exists(cs1.cpuset_path))
         self.assertFalse(os.path.exists(cs2.cpuset_path))
         self.created_cpusets = []
 
-    def test_destroy_with_skip_empty(self):
-        """Test destroying with --skip-empty (should skip empty cpusets)"""
+    def test_destroy_default_skips_empty(self):
+        """Test destroying with default behavior (skips empty cpusets)"""
         # Create cpuset with CPUs
         cs1 = cpuset.Cpuset('test_destroy_nonempty')
         cs1.write_memnode('0')
@@ -337,9 +337,9 @@ class TestCpusetDestroyCLI(unittest.TestCase):
         cs2.write_memnode('0')
         self.created_cpusets.append('test_destroy_empty')
 
-        # Destroy with skip_empty
+        # Destroy with default (include_empty=False, which skips empty)
         cpuset_destroy(name=None, pattern='test_destroy_*', force=True,
-                       skip_empty=True, recursive=False)
+                       include_empty=False, recursive=False)
 
         # Non-empty should be destroyed
         self.assertFalse(os.path.exists(cs1.cpuset_path))
@@ -617,8 +617,8 @@ class TestCpusetStatusCLI(unittest.TestCase):
         except:
             pass
 
-    def test_status_skip_empty(self):
-        """Test status with skip_empty option"""
+    def test_status_empty_filtering(self):
+        """Test status filtering of empty cpusets"""
         # Create cpuset with CPUs
         cs1 = cpuset.Cpuset('test_status_filled')
         cs1.write_memnode('0')
diff --git a/tuna-cmd.py b/tuna-cmd.py
index b560ec805b7a..62553bf51869 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -283,7 +283,7 @@ def gen_parser():
     cpuset_list = cpuset_subparser.add_parser('list', description='List cpusets', help='List cpusets')
     cpuset_list.add_argument('-p', '--pattern', type=str, metavar='PATTERN', help='Filter by glob pattern (e.g., tuna*)')
     cpuset_list.add_argument('-v', '--verbose', action='store_true', help='Show detailed information (CPUs, tasks, partition type)')
-    cpuset_list.add_argument('--skip-empty', action='store_true', help='Skip cpusets with no CPUs assigned')
+    cpuset_list.add_argument('--show-empty', action='store_true', help='Include cpusets with no CPUs assigned (default: skip empty)')
     cpuset_list.add_argument('--no-recursive', dest='recursive', action='store_false', default=True, help='Only search top-level cpusets')
 
     # cpuset destroy
@@ -291,7 +291,7 @@ def gen_parser():
     cpuset_destroy.add_argument('name', nargs='?', type=str, metavar='NAME', help='Cpuset name to destroy (use this OR --pattern)')
     cpuset_destroy.add_argument('-p', '--pattern', type=str, metavar='PATTERN', help='Glob pattern to destroy multiple cpusets (e.g., tuna*)')
     cpuset_destroy.add_argument('-f', '--force', action='store_true', help='Migrate tasks to root cgroup before destroying')
-    cpuset_destroy.add_argument('--skip-empty', action='store_true', help='When using --pattern, skip cpusets with no CPUs assigned')
+    cpuset_destroy.add_argument('--include-empty', action='store_true', help='When using --pattern, include cpusets with no CPUs assigned (default: skip empty)')
     cpuset_destroy.add_argument('--no-recursive', dest='recursive', action='store_false', default=True, help='Only destroy top-level cpusets when using --pattern')
 
     # cpuset move
@@ -308,7 +308,7 @@ def gen_parser():
     # cpuset status
     cpuset_status = cpuset_subparser.add_parser('status', description='Show system-wide cpuset overview', help='Show cpuset status')
     cpuset_status.add_argument('-p', '--pattern', type=str, metavar='PATTERN', help='Filter by glob pattern (e.g., tuna*)')
-    cpuset_status.add_argument('--skip-empty', action='store_true', help='Skip cpusets with no CPUs assigned')
+    cpuset_status.add_argument('--show-empty', action='store_true', help='Include cpusets with no CPUs assigned (default: skip empty)')
     cpuset_status.add_argument('--no-recursive', dest='recursive', action='store_false', default=True, help='Only show top-level cpusets')
 
     return parser
@@ -983,13 +983,13 @@ def cpuset_create(cpu_list, name, isolated, memory_nodes=None):
         sys.exit(1)
 
 
-def cpuset_list(pattern, verbose, skip_empty, recursive):
+def cpuset_list(pattern, verbose, show_empty, recursive):
     """Handler for 'tuna cpuset list' command.
 
     Args:
         pattern: Glob pattern to filter cpusets (None for all)
         verbose: If True, show detailed info (CPUs, memory nodes, tasks, partition)
-        skip_empty: If True, skip cpusets with no CPUs assigned
+        show_empty: If True, show cpusets with no CPUs assigned (default: skip empty)
         recursive: If True, search nested cpusets
     """
     # Check cgroup v2 support
@@ -1001,8 +1001,8 @@ def cpuset_list(pattern, verbose, skip_empty, recursive):
     # List cpusets
     cpusets = cpuset.list_cpusets(pattern=pattern, recursive=recursive)
 
-    # Filter out empty cpusets if requested
-    if skip_empty:
+    # Filter out empty cpusets unless --show-empty was specified
+    if not show_empty:
         filtered_cpusets = []
         for cs_name in cpusets:
             cs_path = os.path.join('/sys/fs/cgroup', cs_name)
@@ -1096,14 +1096,14 @@ def cpuset_list(pattern, verbose, skip_empty, recursive):
         print("This may indicate a problem with blocklist protection.", file=sys.stderr)
 
 
-def cpuset_destroy(name, pattern, force, skip_empty, recursive):
+def cpuset_destroy(name, pattern, force, include_empty, recursive):
     """Handler for 'tuna cpuset destroy' command.
 
     Args:
         name: Cpuset name to destroy (single cpuset, mutually exclusive with pattern)
         pattern: Glob pattern for cpusets to destroy (mutually exclusive with name)
         force: If True, migrate tasks to root before destroying
-        skip_empty: If True, skip cpusets with no CPUs assigned (only used with pattern)
+        include_empty: If True, include cpusets with no CPUs assigned (default: skip empty, only used with pattern)
         recursive: If True, find and clean nested cpusets (only used with pattern)
     """
     # Check cgroup v2 support
@@ -1122,12 +1122,12 @@ def cpuset_destroy(name, pattern, force, skip_empty, recursive):
 
     try:
         if name:
-            # Single cpuset destroy (skip_empty not applicable)
+            # Single cpuset destroy (include_empty not applicable)
             cpuset.destroy_cpuset(name, force=force)
             print(f"Destroyed cpuset '{name}'")
         else:
             # Pattern-based cleanup
-            if skip_empty:
+            if not include_empty:
                 # Filter out empty cpusets before destroying
                 all_cpusets = cpuset.list_cpusets(pattern=pattern, recursive=recursive)
                 cpusets_to_destroy = []
@@ -1312,12 +1312,12 @@ def cpuset_show(name, show_tasks):
         print("  These critical system processes should not be in custom cpusets!", file=sys.stderr)
 
 
-def cpuset_status(pattern, skip_empty, recursive):
+def cpuset_status(pattern, show_empty, recursive):
     """Handler for 'tuna cpuset status' command.
 
     Args:
         pattern: Glob pattern to filter cpusets (None for all)
-        skip_empty: If True, skip cpusets with no CPUs assigned
+        show_empty: If True, show cpusets with no CPUs assigned (default: skip empty)
         recursive: If True, search nested cpusets
     """
     # Check cgroup v2 support
@@ -1326,8 +1326,8 @@ def cpuset_status(pattern, skip_empty, recursive):
         print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
         sys.exit(1)
 
-    # Get all cpusets info
-    infos = get_all_cpusets_info(pattern=pattern, recursive=recursive, skip_empty=skip_empty)
+    # Get all cpusets info (skip_empty is inverse of show_empty)
+    infos = get_all_cpusets_info(pattern=pattern, recursive=recursive, skip_empty=not show_empty)
 
     if not infos:
         if pattern:
@@ -1625,10 +1625,10 @@ def main():
             cpuset_create(args.cpu_list, args.name, args.isolated, args.memory_nodes)
 
         elif args.cpuset_command == 'list':
-            cpuset_list(args.pattern, args.verbose, args.skip_empty, args.recursive)
+            cpuset_list(args.pattern, args.verbose, args.show_empty, args.recursive)
 
         elif args.cpuset_command == 'destroy':
-            cpuset_destroy(args.name, args.pattern, args.force, args.skip_empty, args.recursive)
+            cpuset_destroy(args.name, args.pattern, args.force, args.include_empty, args.recursive)
 
         elif args.cpuset_command == 'move':
             cpuset_move(args.name, args.thread_list, args.pid_list)
@@ -1637,7 +1637,7 @@ def main():
             cpuset_show(args.name, args.show_tasks)
 
         elif args.cpuset_command == 'status':
-            cpuset_status(args.pattern, args.skip_empty, args.recursive)
+            cpuset_status(args.pattern, args.show_empty, args.recursive)
 
 
 if __name__ == '__main__':
-- 
2.54.0

