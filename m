Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0A237703B
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796013; cv=none; b=KG58aC9P9nSYFezWU5zatLRjwwnxb51eAzcalGXUhDmdyK/po3ijNQhGlSwJhxLqxsqE4Ft0UZ50N4ZUXXTN3vjV4Z5qyqkDgnhopbdhNQptZ4MbQWPFfwK1Zvp/vPb+gwxPGuxOCzMTDbWvHUua11Wi4cH3d1FfjG/+QtIPS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796013; c=relaxed/simple;
	bh=nvBgiXgcBcylJ+pM9MQFXOngcwryk9Nct3/FpSAFPeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZsAoYYsOY4o6sK9w0zcy5r8Nv8f6wGnRNsZDb5Lk77EQgXsR6kNQHAlx8iCmQBerDqCkmHSiERQK9ZOdJo4cGEQKbZi9gO3VXv/eBaV8nM97Iqt9XNI1NyL9HGNj3+0a0l1F0ybnm97SVzPkWX53c5EsKrLtqpeVhffD+4i/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXYvRAMt; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXYvRAMt"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ef0ba61d46so62534885a.2
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795994; x=1777400794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzy6ZBZNBC/fcW8GQ8ZXzxlpSejYNCCHSyac/ROXrbk=;
        b=nXYvRAMt3YZHdc1y6BZvMVgro6c0EntXMNWCMPLat7eJwUT5OTRpN6v0etFXLKqVZy
         LB3Tb9TjCYoSTkEHYqbA26lLr5Nyes6jPANDNs1Vnz+cy4E7pjwg6kOExqou/mkxm4/B
         vpARDLKVLPJwpEa86i3t6PGPF2E+oi8Offq7V+2LS0GwhIx80BOt9EVw/Ku5Iz/tx0aB
         FkHursE5jG8cjkOZmjljRG2OvnreodfoL4LED26ABCApRCDotoG8HFGNU/U53B3AnvNr
         LNAJFsZ0GvysW+/mjECVT1TKgnheL1SjxgxFsSNxQV+WiIX9oStG3bBlamo/fWIh6aYO
         7F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795994; x=1777400794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzy6ZBZNBC/fcW8GQ8ZXzxlpSejYNCCHSyac/ROXrbk=;
        b=flDPBBB019Q+OT6/PPq5vNAjZaugy2N3fhFmvkdLdaaCuySdyypmcy9Rg0Pf//VUWu
         6wlaW2pZbcVaNdGqABP16mCF11geMh5LGR6vsg/JKfWINCuDW9sJ3neOMZF9eoyYcvT9
         FqTWHwqY5Hji650w4EtQNnlFcFARsW/+S9rWs8G18Y0jeWwgtVH94dWba2qKoukT88+Z
         1F2nySqeRa3EuWwDtIQBJag+FgbQPyhmf5IEB1zQGAyMchJWMDHCPJV9xpGPP+Hn3oZV
         dTwtWTHP/ioPxP5j84ShY5x7gykzZbIAgyuYENBSYNkh3hikNJAewmybe3oF8PO8+M07
         5bxg==
X-Gm-Message-State: AOJu0YyLw5AdJt+fnO5gzKMQDLFXyHdS0ApvuNMeHjee66ydIuff+rx9
	d9Pe09H/TJk06Ug9ECEXIjEr4x6fXlr4rtC9ZaJpu5R/RVOc56ResZQTtM+Tjg==
X-Gm-Gg: AeBDies3UgkxFlYcEaKoCG60jytcbymcoefGsDTIIjJxBYK2QMbdVmUp5vGouC9O2yl
	bzTZmrLZ84+XI7czzEvvrqFMy68tJNFPQv2AIz+AmfmPj/wAR9zzY97howYCS+W3JnUiFZncYSB
	5OxFdpeWtaebj+OMx7EUQGlrpPAUqE8zge1Zx/o82DsZMRDhzMMFLmzZbAVHl2CSPIlsZSa81jC
	jCwBhFwS6cyXGW04abDSU1OFuQtbELTv3tsKxRiBniWf6fMlF9S3TOTpz8y1xyZO9JFvQkXQgvM
	T+KoFOo9uJq37Cn3Rpl6kMPTysZZxn/yBLjFuFkSYbt9q41MGlIWXkivT6d7SsG1ns9r9WJLV9V
	Z2zgPrsV6O4P8Lp6UsE99d3D0mxD0qxcq+Rc9OMe2Lj7nWJ34VRAoZJkwpNDAXh7fk/+U8xm4JO
	OgBwXundSBxA+lHP6X4Ptt9mvpQHIz4+tkEmIOw71J0Eb2O1DBr1bxOwMAjQsOsJ6qgPhJavNtP
	9XhFISv9DzWzRY7+nwdHDlOZH+8WFfXeEYDVcUsp56WJfHCwskMA2+3A8E5BbszCh5t+7j3BOU5
	QO+BOaiHg1s0uSrPKmhDS7evtHvIxA==
X-Received: by 2002:a05:620a:29c8:b0:8cd:8569:b957 with SMTP id af79cd13be357-8e79217c725mr2693909285a.43.1776795994355;
        Tue, 21 Apr 2026 11:26:34 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1112713685a.11.2026.04.21.11.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:26:33 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/7] rteval: Add CoreSiblings class for CPU core topology queries
Date: Tue, 21 Apr 2026 14:26:12 -0400
Message-ID: <20260421182618.261347-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421182618.261347-1-jkacur@redhat.com>
References: <20260421182618.261347-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new CoreSiblings class in rteval/sysinfo/coresiblings.py that
provides a simple interface for querying which CPUs share physical cores.

The class reads /sys/devices/system/cpu/cpu*/topology/thread_siblings_list
to build a mapping of CPU core siblings and provides three methods:

- share_core(cpu1, cpu2): Check if two CPUs share a physical core
- get_siblings(cpu): Get all CPUs that share a core with a given CPU
- get_core_groups(): Get all unique core sibling groups

The implementation is generic and works with any SMT configuration:
- No SMT (1 CPU per core)
- 2-way SMT (typical Intel hyperthreading)
- 4-way SMT (some IBM POWER processors)
- 8-way SMT (IBM POWER8/9)

This provides a foundation for cpuset management features where we need
to understand CPU core topology for proper isolation.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/coresiblings.py | 110 +++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 rteval/sysinfo/coresiblings.py

diff --git a/rteval/sysinfo/coresiblings.py b/rteval/sysinfo/coresiblings.py
new file mode 100644
index 000000000000..3c97439d0a39
--- /dev/null
+++ b/rteval/sysinfo/coresiblings.py
@@ -0,0 +1,110 @@
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   Copyright 2026   John Kacur <jkacur@redhat.com>
+#
+
+import os
+from rteval.cpulist_utils import expand_cpulist
+
+class CoreSiblings:
+    """Query CPU core topology to determine which CPUs share physical cores"""
+
+    def __init__(self, root="/"):
+        self.sysdir = os.path.join(root, 'sys', 'devices', 'system', 'cpu')
+        self.core_map = {}  # Maps cpu -> set of sibling cpus
+        self._parse()
+
+    def _parse(self):
+        """Parse thread_siblings_list for each CPU"""
+        for dirname in os.listdir(self.sysdir):
+            # Only parse cpu<integer> directories
+            if dirname.startswith('cpu') and os.path.isdir(os.path.join(self.sysdir, dirname)):
+                try:
+                    cpu_id = int(dirname[3:])
+                except ValueError:
+                    continue
+
+                siblings_file = os.path.join(self.sysdir, dirname, 'topology', 'thread_siblings_list')
+                if os.path.exists(siblings_file):
+                    with open(siblings_file, 'r') as f:
+                        siblings_str = f.read().strip()
+                        # expand_cpulist returns a list of cpu numbers
+                        siblings = set(expand_cpulist(siblings_str))
+                        self.core_map[cpu_id] = siblings
+
+    def share_core(self, cpu1, cpu2):
+        """
+        Check if two CPUs share the same physical core.
+
+        Args:
+            cpu1: First CPU ID (int)
+            cpu2: Second CPU ID (int)
+
+        Returns:
+            True if CPUs share a core, False otherwise
+        """
+        if cpu1 not in self.core_map:
+            return False
+        return cpu2 in self.core_map[cpu1]
+
+    def get_siblings(self, cpu):
+        """
+        Get all CPUs that share a core with the given CPU.
+
+        Args:
+            cpu: CPU ID (int)
+
+        Returns:
+            Set of CPU IDs that share a core with cpu (includes cpu itself)
+        """
+        return self.core_map.get(cpu, set())
+
+    def get_core_groups(self):
+        """
+        Get all unique core sibling groups.
+
+        Returns:
+            List of sets, where each set contains CPUs that share a core
+        """
+        seen = set()
+        groups = []
+
+        for cpu, siblings in self.core_map.items():
+            # Use frozenset as a hashable representation
+            group_key = frozenset(siblings)
+            if group_key not in seen:
+                seen.add(group_key)
+                groups.append(siblings)
+
+        return groups
+
+
+def unit_test():
+    """Simple unit test"""
+    try:
+        cs = CoreSiblings()
+
+        print("Core Sibling Groups:")
+        for i, group in enumerate(cs.get_core_groups()):
+            print(f"  Core {i}: {sorted(group)}")
+
+        # Test share_core with first two CPUs if they exist
+        if len(cs.core_map) >= 2:
+            cpus = sorted(cs.core_map.keys())
+            cpu1, cpu2 = cpus[0], cpus[1]
+            print(f"\nDo CPU {cpu1} and CPU {cpu2} share a core? {cs.share_core(cpu1, cpu2)}")
+            print(f"CPU {cpu1} siblings: {sorted(cs.get_siblings(cpu1))}")
+            print(f"CPU {cpu2} siblings: {sorted(cs.get_siblings(cpu2))}")
+
+        return 0
+    except Exception as e:
+        print(f"** EXCEPTION: {e}")
+        import traceback
+        traceback.print_exc()
+        return 1
+
+
+if __name__ == '__main__':
+    import sys
+    sys.exit(unit_test())
-- 
2.53.0

