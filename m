Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D72D661C
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692981; cv=none; b=PvMU+KFriPrWSZucBhh1+HRbrAsKrYTlue0cfdLWd1xAyHbh/dGpZmguViQcf8hJs0FuwdF1U2lpDxxH2+2PLQ13jpveyFIfll/8KDc3d88Ef8TVLNcxytSLYUYAT42PHjl2z8P5KR3shj9WQWUkkVWDIu2aMzhDOhZ8qzbkAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692981; c=relaxed/simple;
	bh=mTvL259gWnuLRa3EamXSzNB0ZMx2Q7Sb+Fd7wDO8iSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvzDTYQq0DglLSs8EBYL8Koy1bsp9e/5mAJ85E20+ElcyxVcz6nnXEWOGEZDrgWIMigMRgggNGfWv8wryXO8WTsZaeaUZg644czMbFu9kzYEH9LxLOVvCtoY8RhsIe0+4KO+Yife9FGA1dEyjme3nqRWpwuBn5aoSATZvBQYkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIvR9pVg; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIvR9pVg"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-738b39dad22so385184137.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692979; x=1784297779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GisZ1cQBfekCcDTTI8zSkKiugzMs+0Zy3pq/x38dulo=;
        b=OIvR9pVgL1XIO73l6BZtI8qd5sCcAb4UN7z+a5OigGNBoGirzfrSNQEoSByP86DIEs
         EYdc1qYwQjYAWm+2LNgwkLZWuiVGk0fC8R9pSS6w4o+um2rARzUPAGCXVuqIdq60HA8C
         4iDIDqkyJVQgq3I8UDsWxgBANdXxqwkoik9wBfTb3SC8620vsSaMQRDMtQl/K16qBoNr
         k+gZGl8+w29tyCnTtBmMQqmQi+f2hDnw1HxRtDbAcxClZ4vP1KR+GrkqjyR5922UUesu
         /kw9F1fO+3N76c+oZbCtmy7O/jvCIiHKWBHK+MoET8yVOGU2wfPZHOZbIB9yl83MO4X+
         Ta3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692979; x=1784297779;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GisZ1cQBfekCcDTTI8zSkKiugzMs+0Zy3pq/x38dulo=;
        b=igoJeSeyh/LdORuG7YxE8dLQFy5VrpJRPjVPrEul2pdzG2gkqTuxHeTFQ7gk/A5FFp
         NT0dzdtBwemLLpc/NGOjsmRbyjVt7KKait9tv2FdGJPIwM6MResWV0GKSnWWSRntLdNP
         zyZPpNaFqF77j/7s5yX80rfpesdzcwKUgNXcC6Qr1d4n4q1GTbHF/5y1HJbOG1Laoe/1
         qx0gqFSED/Q3SpFEt6toXmakWb7CqCidqc7K//g0wEecLl2udgwF8PNAv1+LXmoucf2s
         zpTIZQaYHVmwNAGDWqbrMUTq3uHhruACLSetbiK3VHtpP/rGw69We3AMJrsPa1ipNNxa
         TVcg==
X-Gm-Message-State: AOJu0YwO8lNOupOmsHPSeWfWSUmNAjZ4eBTYzKP28qxhKtsOxbEtRVOQ
	/M9Q6dZXYeDkH/TScOY8DZ1wiHP+pxXdFO90J7GvsKdNW2m//8lLy6SZjeA4sw==
X-Gm-Gg: AfdE7ckraZ5399poHVWUz7yqHs3USydRYk32Ff75DSuG0Jrqkro248fKivjxRHCZDBK
	2M8bH2w5kDPeBeiTU1To3QMWfBh1gfhWDCCgyZMfRR82zv6sFTQKZvUTpMRMkmK3LjfDgrTNI03
	nOiHY587xmfD5b9dZlRWGa2sLTTtbc/OtEtvwAQ39ieCwHZSddHvAerHCYWzuzR50enTfzHWbJn
	OP7fZIFIEO9QTwTJXrEhNKHyVXT2Lwy9hSm1U76AxGcmC82iTdYIR6Mdt+kyrVkfmBrHMVHs23Y
	D0o7SjP3LiC3hdPRAfS1EpFDhidsDbSZRRXaUmRCb0oiqnxEQ0szJme6Rn9ZfVPSnPz9NmfZCmi
	GA5DLpXHdRTYj8sYzOOqGfsebnU0+RgkD58r8wCmNPWDuE2uM7aYD5EFjHSs9iXkapuj9BfB7ER
	d24wSqE4Cd9BTHg6z9pn+W/3xRDg90FgqFmoaq/YMX1EOkDglEuHLY3HbszFTgSWqarYNSr/lkp
	A==
X-Received: by 2002:a05:6102:6882:b0:73a:128c:4e3d with SMTP id ada2fe7eead31-744dffa40c9mr6374134137.8.1783692978672;
        Fri, 10 Jul 2026 07:16:18 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:17 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 22/36] tuna: Add cpuset modify command
Date: Fri, 10 Jul 2026 10:15:00 -0400
Message-ID: <20260710141523.36440-23-jkacur@redhat.com>
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

Add ability to modify existing cpusets without destroying them:

- Add/remove CPUs: --add-cpus and --remove-cpus options
- Change memory nodes: -m/--memory-nodes option
- Toggle partition type: --isolated/--no-isolated options
- Multiple modifications can be combined in a single command
- Shows before/after summary of changes

New Cpuset class methods:
- get_cpus(): Get current CPU assignment
- get_memnode(): Get current memory node assignment
- get_partition_type(): Get current partition type
- modify_cpus(add_cpus, remove_cpus): Atomically modify CPU assignment
  (CPUs are added before removal to avoid zero-CPU scenarios)

Example usage:
  tuna cpuset modify tuna0 --add-cpus 8-11
  tuna cpuset modify tuna0 --remove-cpus 0-1 --add-cpus 4-7
  tuna cpuset modify tuna0 --memory-nodes 0-1 --isolated

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py    | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tuna/cpuset.py | 66 ++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 62553bf51869..557a07891183 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -311,6 +311,19 @@ def gen_parser():
     cpuset_status.add_argument('--show-empty', action='store_true', help='Include cpusets with no CPUs assigned (default: skip empty)')
     cpuset_status.add_argument('--no-recursive', dest='recursive', action='store_false', default=True, help='Only show top-level cpusets')
 
+    # cpuset modify
+    cpuset_modify = cpuset_subparser.add_parser('modify', description='Modify an existing cpuset', help='Modify cpuset configuration')
+    cpuset_modify.add_argument('name', type=str, metavar='NAME', help='Cpuset name to modify')
+    cpuset_modify.add_argument('--add-cpus', dest='add_cpu_list', type=str, metavar='CPU-LIST',
+                                help='CPUs to add to the cpuset (e.g., 4-7 or 4,5,6,7)')
+    cpuset_modify.add_argument('--remove-cpus', dest='remove_cpu_list', type=str, metavar='CPU-LIST',
+                                help='CPUs to remove from the cpuset (e.g., 0-1 or 0,1)')
+    cpuset_modify.add_argument('-m', '--memory-nodes', type=str, metavar='MEM-NODES', dest='memory_nodes',
+                                help='Set memory nodes (e.g., "0" or "0-1")')
+    partition_group = cpuset_modify.add_mutually_exclusive_group()
+    partition_group.add_argument('--isolated', action='store_true', help='Set CPU partition to isolated')
+    partition_group.add_argument('--no-isolated', action='store_true', help='Set CPU partition to member (not isolated)')
+
     return parser
 
 
@@ -1410,6 +1423,79 @@ def cpuset_status(pattern, show_empty, recursive):
         print("  These critical system processes should not be in custom cpusets!", file=sys.stderr)
 
 
+def cpuset_modify(name, add_cpus, remove_cpus, memory_nodes, isolated, no_isolated):
+    """Handler for 'tuna cpuset modify' command.
+
+    Args:
+        name: Cpuset name to modify
+        add_cpus: List of CPU numbers to add (or None)
+        remove_cpus: List of CPU numbers to remove (or None)
+        memory_nodes: Memory nodes string to set (or None to keep current)
+        isolated: If True, set partition to isolated
+        no_isolated: If True, set partition to member
+    """
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
+        sys.exit(1)
+
+    # Validate name
+    cpuset_path = os.path.join('/sys/fs/cgroup', name)
+    if not os.path.exists(cpuset_path):
+        print(f"Error: cpuset '{name}' does not exist", file=sys.stderr)
+        sys.exit(1)
+
+    # At least one modification must be specified
+    if not any([add_cpus, remove_cpus, memory_nodes is not None, isolated, no_isolated]):
+        print("Error: at least one modification option must be specified", file=sys.stderr)
+        print("  --add-cpus, --remove-cpus, --memory-nodes, --isolated, or --no-isolated", file=sys.stderr)
+        sys.exit(1)
+
+    # Can't specify both --isolated and --no-isolated
+    if isolated and no_isolated:
+        print("Error: --isolated and --no-isolated are mutually exclusive", file=sys.stderr)
+        sys.exit(1)
+
+    try:
+        # Create Cpuset object for existing cpuset
+        cs = cpuset.Cpuset(name, existing_ok=True)
+
+        changes = []
+
+        # Modify CPUs if requested
+        if add_cpus or remove_cpus:
+            old_cpus = cs.get_cpus()
+            cs.modify_cpus(add_cpus=add_cpus, remove_cpus=remove_cpus)
+            new_cpus = cs.get_cpus()
+            changes.append(f"CPUs: {old_cpus or '(none)'} → {new_cpus or '(none)'}")
+
+        # Modify memory nodes if requested
+        if memory_nodes is not None:
+            old_mems = cs.get_memnode()
+            cs.write_memnode(memory_nodes)
+            changes.append(f"Memory nodes: {old_mems or '(none)'} → {memory_nodes}")
+
+        # Modify partition type if requested
+        if isolated:
+            old_partition = cs.get_partition_type()
+            cs.set_cpu_exclusive()
+            changes.append(f"Partition: {old_partition} → isolated")
+        elif no_isolated:
+            old_partition = cs.get_partition_type()
+            cs.unset_cpu_exclusive()
+            changes.append(f"Partition: {old_partition} → member")
+
+        # Print summary of changes
+        print(f"Modified cpuset '{name}':")
+        for change in changes:
+            print(f"  {change}")
+
+    except (OSError, ValueError) as e:
+        print(f"Error modifying cpuset: {e}", file=sys.stderr)
+        sys.exit(1)
+
+
 def main():
     i18n_init()
     parser = gen_parser()
@@ -1639,6 +1725,18 @@ def main():
         elif args.cpuset_command == 'status':
             cpuset_status(args.pattern, args.show_empty, args.recursive)
 
+        elif args.cpuset_command == 'modify':
+            # Parse CPU lists if provided
+            add_cpus = None
+            remove_cpus = None
+            if args.add_cpu_list:
+                add_cpus = tuna.cpustring_to_list(args.add_cpu_list)
+            if args.remove_cpu_list:
+                remove_cpus = tuna.cpustring_to_list(args.remove_cpu_list)
+
+            cpuset_modify(args.name, add_cpus, remove_cpus, args.memory_nodes,
+                         args.isolated, args.no_isolated)
+
 
 if __name__ == '__main__':
     main()
diff --git a/tuna/cpuset.py b/tuna/cpuset.py
index 79f86d8cfe9f..3f9b0534a397 100644
--- a/tuna/cpuset.py
+++ b/tuna/cpuset.py
@@ -264,6 +264,72 @@ class Cpuset:
         with open(path, 'r', encoding='utf-8') as f:
             return [line.strip() for line in f if line.strip()]
 
+    def get_cpus(self):
+        """
+        Get the current CPU assignment as a string
+        Returns string like "0-3" or "0,2,4-7" or empty string if none assigned
+        """
+        path = os.path.join(self._cpuset_path, "cpuset.cpus")
+        with open(path, 'r', encoding='utf-8') as f:
+            return f.read().strip()
+
+    def get_memnode(self):
+        """
+        Get the current memory node assignment as a string
+        Returns string like "0" or "0-1" or empty string if none assigned
+        """
+        path = os.path.join(self._cpuset_path, "cpuset.mems")
+        with open(path, 'r', encoding='utf-8') as f:
+            return f.read().strip()
+
+    def get_partition_type(self):
+        """
+        Get the current partition type
+        Returns 'isolated', 'member', or 'root' depending on cpuset.cpus.partition
+        Returns None if partition file doesn't exist
+        """
+        path = os.path.join(self._cpuset_path, "cpuset.cpus.partition")
+        if not os.path.exists(path):
+            return None
+        with open(path, 'r', encoding='utf-8') as f:
+            return f.read().strip()
+
+    def modify_cpus(self, add_cpus=None, remove_cpus=None):
+        """
+        Modify CPU assignment by adding and/or removing CPUs
+
+        Args:
+            add_cpus: List of CPU numbers to add (e.g., [4, 5, 6, 7])
+            remove_cpus: List of CPU numbers to remove (e.g., [0, 1])
+
+        Note: CPUs are added before removal. This is important when replacing CPUs
+        to avoid having zero CPUs assigned (which may cause errors).
+        """
+        from tuna import tuna
+
+        # Get current CPUs
+        current_cpus_str = self.get_cpus()
+        if current_cpus_str:
+            current_cpus = set(tuna.cpustring_to_list(current_cpus_str))
+        else:
+            current_cpus = set()
+
+        # Add new CPUs
+        if add_cpus:
+            current_cpus.update(add_cpus)
+
+        # Remove CPUs
+        if remove_cpus:
+            current_cpus.difference_update(remove_cpus)
+
+        # Convert back to string and assign
+        if current_cpus:
+            new_cpus_str = tuna.collapse_cpulist(sorted(current_cpus))
+            self.assign_cpus(new_cpus_str)
+        else:
+            # If no CPUs left, assign empty string
+            self.assign_cpus("")
+
 
 class CpusetsInit(Cpuset):
     """
-- 
2.54.0

