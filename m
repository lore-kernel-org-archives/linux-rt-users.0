Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A92BE7DD
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692969; cv=none; b=fA2Oqcfs6qAlh2YT+siCzE1ngI/B/b2CRn+S6xE1mPAwwBmCRMGeISORV27UkmYMEeWZt53LVrFVaL2dCgCgPGsOxM8ZrFqkHN5Aal8Oa+M4MNHsP6gjAUqGbBzknnEzE8AAA8Nn+HdK3uklSteu1+zYKTxzg8AVznKSS7ySE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692969; c=relaxed/simple;
	bh=zNOBLpPHdd5yv2gwiB7AMDWi5MkyIzEQutfIn7yuwxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLOY1pr940iztYfhfXybihfYJmqZYYW8ukWxrUXKDZUlI16QJevCKJ953Wa9RxkGvegRYi3AXmAnoCEH9rrfx16u5iRhfZXCSGDW5WoSp32LKrS2TYTuC7DC/a3Ufdep09eJyFJuIOXFKHsqdCKIwuDBzb8P7ed/F+TQUba60Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJfaCIVd; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJfaCIVd"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-738bcf9a573so328526137.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692967; x=1784297767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2PWh0aDlmFFRNVwpCbtpUK2M8DRRSIKaNQxtAh5Aw7A=;
        b=OJfaCIVduIKYIAEv9+a4f+WbGf5WJ2LJTpiNFPcIXxqcu42YhZl5eqJSXsVNBnFeQM
         4dgUS2T2GQqWeVJtHg37qixNG3A8sbh4LGwORZ7jwQmU9xOsihs0kMCLd6z/R61vX+YM
         EacRviL5JJsNP9GYZ7dCcJ9+D9NSPsoGz9tAiJeQBGtliMtHIQu24mebNJ4qQfoVCGsJ
         nRzB9MYQgrhF+msUjvs+uJxwKO/cCmknCUpni41BLXXT7jCiy+qyyZy9++08AbWROx2i
         9G5su3GpkK5PamBFwtJfS/3K1Z7zEDcg/yn67Cy8cbShC5qsSMGPpUv+Xmc9L+0PqwPk
         AT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692967; x=1784297767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2PWh0aDlmFFRNVwpCbtpUK2M8DRRSIKaNQxtAh5Aw7A=;
        b=acfXLl+5FcQwmjeC2nkyDj1DxOSc2DS0Lfkq0h8xrhE4jjGp39mTNj+lcfz4ulzv/x
         6TGCNZFYHqSp62VpxgbIByYnn2XbIT8lfMltaLjkXn5ipMusvvF2A/sn8QebCJEMEcHa
         mF5/w3lmEdDlLKaA/8ritqQcqyfSMsT9+G3ISK6EiW7+ucq7+pGHACGcnLbMn50e7JFO
         iagKFhdi8YmOXl16uactvBKEXQcZ6zIi9/s4sJg1yinblbS0LF14SrxxaG1qruvQLRma
         fwACNb1B/XCI6UkU9XHWU2sihaFF2uJbYOULeLgzSuCM2r/fuT+r0itqZ5x+A4dvYTgp
         giDQ==
X-Gm-Message-State: AOJu0YzR50X7bBcAz8/kUxWGuhDwTluB55NkrzsP/xACyrkHOY2xT4zf
	xo3erDx9X7satVmVToXrL6Gza7rCxzVNReiFpo5CYyD4Iudp1xDV9WRGvrrXmg==
X-Gm-Gg: AfdE7cmoU6zn5fDrcxYoCWYR+4FI1SPnk9qLLJHyzNMEq5fHYhWHNmoUUsfGxLW1gT0
	C+Qh9UbqZp8WP2sso3rBeQ37ZnxmsjlJDDLj4lEttPhihXU5H48qDLBNAUa9jGyc5locW/jeCfx
	vHGuMwfuQqRTrvCbPZidM1w89UBuqwjvWfhyQ2yFMHXy+DDKySAhFKzuwuizTenfiqJDyasg+/i
	WsQ/MTlKhjTnPXxlVSZFJeOW/Ltjrc0DcERmy+ppSNcwPVKbdnG9Xg/qzQADiL6uFGr/Y4WhTJx
	Nu+fTdCzH3E404JXzHbb2HD5mKf50zJlsFeEWaE7BDF+vFsrzuyZ0UKuknCgEledHFK1M7Hl73F
	DmZ/M/93Viy2Fi50Nxb65xvmG+25HNHJ/P2oxnM3FYTvsjpLz9qtBFy3HY9b5Kg7arUjDrFNSH/
	Hh7ythd0wCrY0oMcAcGZ6layuq/3II21tTYhhcWpAbtAUrMLFUOdXIe3I+omnb8hq54L2o/yjq8
	g==
X-Received: by 2002:a05:6102:5e96:b0:6ef:db57:ed3f with SMTP id ada2fe7eead31-744e0311b62mr6407006137.29.1783692967130;
        Fri, 10 Jul 2026 07:16:07 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:06 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 14/36] tuna: Add NUMA-aware memory node assignment for cpusets
Date: Fri, 10 Jul 2026 10:14:52 -0400
Message-ID: <20260710141523.36440-15-jkacur@redhat.com>
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

Implement smart NUMA memory node detection and assignment for cpusets
to optimize memory performance by avoiding cross-NUMA access.

Changes to tuna/cpuset.py:
- Add NumaNode class to represent NUMA nodes and their CPUs
- Add discover_numa_nodes() to detect NUMA topology from sysfs
  - Reads from /sys/devices/system/node/node*/cpulist on multi-node systems
  - Falls back to /sys/devices/system/cpu/possible for single-node systems
- Add get_numa_nodes_for_cpus() to auto-detect memory nodes for CPU lists
  - Maps CPUs to their NUMA nodes
  - Returns appropriate cpuset.mems string (e.g., "0", "0-1", "0,2")
- Adapted from rteval.systopology but simplified for tuna's needs

Changes to tuna-cmd.py:
- Add --memory-nodes parameter to 'tuna cpuset create' command
- Update cpuset_create() to use NUMA auto-detection by default
  - Auto-detects memory nodes from assigned CPUs
  - Allows manual override with --memory-nodes
  - Replaces hardcoded memnode='0' for better NUMA performance

Example usage:
  # Auto-detect memory nodes (recommended):
  tuna cpuset create -c 0-3 -n myapp

  # Manual override if needed:
  tuna cpuset create -c 0-7,16-23 -n myapp --memory-nodes 0,1

Benefits:
- Better performance by keeping memory local to CPUs
- Works correctly on both single-node and multi-node systems
- Smart defaults with expert override capability

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py    |  15 +++++--
 tuna/cpuset.py | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 0e70b9208665..04c72a5352ac 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -276,6 +276,8 @@ def gen_parser():
     cpuset_create.add_argument('-c', '--cpus', **MODS['cpus'], required=True)
     cpuset_create.add_argument('-n', '--name', type=str, metavar='NAME', help='Cpuset name (default: auto-generate tunaN)')
     cpuset_create.add_argument('-i', '--isolated', action='store_true', help='Set CPU partition to isolated')
+    cpuset_create.add_argument('-m', '--memory-nodes', type=str, metavar='MEM-NODES', dest='memory_nodes',
+                                help='Memory nodes (default: auto-detect from CPUs, e.g., "0" or "0-1")')
 
     # cpuset list
     cpuset_list = cpuset_subparser.add_parser('list', description='List cpusets', help='List cpusets')
@@ -829,13 +831,14 @@ def get_next_tuna_cpuset_name():
             return f'tuna{i}'
 
 
-def cpuset_create(cpu_list, name, isolated):
+def cpuset_create(cpu_list, name, isolated, memory_nodes=None):
     """Handler for 'tuna cpuset create' command.
 
     Args:
         cpu_list: List of CPU numbers to assign to cpuset
         name: Cpuset name (None for auto-generated tunaN)
         isolated: If True, set CPU partition to isolated
+        memory_nodes: Memory nodes string (None for auto-detect from CPUs)
     """
     # Check cgroup v2 support
     ci = cpuset.CpusetsInit()
@@ -847,6 +850,10 @@ def cpuset_create(cpu_list, name, isolated):
     if name is None:
         name = get_next_tuna_cpuset_name()
 
+    # Auto-detect NUMA memory nodes if not specified
+    if memory_nodes is None:
+        memory_nodes = cpuset.get_numa_nodes_for_cpus(cpu_list)
+
     # Convert CPU list to string format (e.g., [0,1,2,3] -> "0-3")
     cpu_str = tuna.collapse_cpulist(cpu_list)
 
@@ -855,14 +862,14 @@ def cpuset_create(cpu_list, name, isolated):
         cs = cpuset.Cpuset(name)
 
         # Configure it (must set memnode before CPUs in cgroup v2)
-        cs.write_memnode('0')
+        cs.write_memnode(memory_nodes)
         cs.assign_cpus(cpu_str)
 
         # Set isolated partition if requested
         if isolated:
             cs.set_cpu_exclusive()
 
-        print(f"Created cpuset '{name}' with CPUs {cpu_str}" +
+        print(f"Created cpuset '{name}' with CPUs {cpu_str}, memory nodes {memory_nodes}" +
               (f" (isolated)" if isolated else ""))
 
     except (OSError, ValueError) as e:
@@ -1308,7 +1315,7 @@ def main():
     elif args.command == 'cpuset':
         # Handle cpuset subcommands
         if args.cpuset_command == 'create':
-            cpuset_create(args.cpu_list, args.name, args.isolated)
+            cpuset_create(args.cpu_list, args.name, args.isolated, args.memory_nodes)
 
         elif args.cpuset_command == 'list':
             cpuset_list(args.pattern, args.verbose, args.skip_empty, args.recursive)
diff --git a/tuna/cpuset.py b/tuna/cpuset.py
index 1039eb6c2c49..513e1b198c38 100644
--- a/tuna/cpuset.py
+++ b/tuna/cpuset.py
@@ -325,6 +325,115 @@ class TaskMigrate:
         return self.migrated, self.failed
 
 
+#
+# NUMA topology detection (adapted from rteval/systopology.py)
+#
+
+class NumaNode:
+    """Represents a NUMA node with its CPUs.
+
+    Simplified from rteval.systopology.NumaNode for cpuset memory node detection.
+    """
+
+    def __init__(self, nodeid, cpus):
+        """Initialize NUMA node.
+
+        Args:
+            nodeid: NUMA node ID (integer)
+            cpus: Set of CPU numbers in this node
+        """
+        self.nodeid = nodeid
+        self.cpus = cpus
+
+    def __contains__(self, cpu):
+        """Check if CPU is in this NUMA node."""
+        return cpu in self.cpus
+
+    def __int__(self):
+        """Return node ID as integer."""
+        return self.nodeid
+
+
+def discover_numa_nodes():
+    """Discover NUMA topology.
+
+    Returns dict mapping node IDs to NumaNode objects.
+    Handles both multi-node systems and single-node systems.
+
+    Adapted from rteval.systopology.SysTopology.
+    """
+    nodes = {}
+    node_paths = glob('/sys/devices/system/node/node[0-9]*')
+
+    if node_paths:
+        # Multi-node NUMA system
+        for path in sorted(node_paths):
+            nodeid = int(os.path.basename(path)[4:])
+            cpulist_file = os.path.join(path, 'cpulist')
+            try:
+                with open(cpulist_file, 'r', encoding='utf-8') as f:
+                    cpulist_str = f.read().strip()
+                    # Parse CPU list string (e.g., "0-7" or "0,2,4-7")
+                    from tuna import tuna
+                    cpu_list = tuna.cpustring_to_list(cpulist_str)
+                    nodes[nodeid] = NumaNode(nodeid, set(cpu_list))
+            except (OSError, ValueError):
+                # Skip nodes we can't read
+                continue
+    else:
+        # Single-node system (no /sys/devices/system/node/node*)
+        # Fallback like rteval.systopology.SimNumaNode
+        try:
+            with open('/sys/devices/system/cpu/possible', 'r', encoding='utf-8') as f:
+                cpulist_str = f.read().strip()
+                from tuna import tuna
+                cpu_list = tuna.cpustring_to_list(cpulist_str)
+                nodes[0] = NumaNode(0, set(cpu_list))
+        except (OSError, ValueError):
+            # Last resort: assume node 0 exists
+            nodes[0] = NumaNode(0, set())
+
+    return nodes
+
+
+def get_numa_nodes_for_cpus(cpu_list):
+    """Determine which NUMA nodes contain the given CPUs.
+
+    Args:
+        cpu_list: List of CPU numbers (e.g., [0, 1, 8, 9])
+
+    Returns:
+        String suitable for cpuset.mems (e.g., "0", "0-1", "0,2")
+
+    Example:
+        On a 2-node system with CPUs 0-7 on node0, 8-15 on node1:
+        - get_numa_nodes_for_cpus([0,1,2]) returns "0"
+        - get_numa_nodes_for_cpus([8,9,10]) returns "1"
+        - get_numa_nodes_for_cpus([0,1,8,9]) returns "0-1"
+    """
+    if not cpu_list:
+        # No CPUs specified, default to node 0
+        return "0"
+
+    nodes = discover_numa_nodes()
+
+    # Find which nodes contain our CPUs
+    required_nodes = set()
+    for cpu in cpu_list:
+        for nodeid, node in nodes.items():
+            if cpu in node:
+                required_nodes.add(nodeid)
+                break
+
+    if not required_nodes:
+        # Fallback if no matches found (shouldn't happen)
+        return "0"
+
+    # Convert node IDs to string format
+    from tuna import tuna
+    return tuna.collapse_cpulist(sorted(required_nodes))
+
+
 #
 # Tuna-specific utility functions for cpuset discovery and management
 #
-- 
2.54.0

