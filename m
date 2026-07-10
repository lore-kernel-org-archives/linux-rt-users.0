Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC533CEA2
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692992; cv=none; b=gqVNji8x5fm+WVjDCPbSCeDXjIHKoGopakHQ5coidYVXVbdsxQKaCKWS05fBucqSlOuRTE2QkXHXKPvHH2dhgufwP0+6A0kfeHc3wIQkfm4nb/EMHyHXNbZxOX6dr286TNsqRuoryBnGCs5+pUuT/TBAyJfMkwfiSc5NShlQ55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692992; c=relaxed/simple;
	bh=28SHLvC8gkY25xva8RZmJvT0tjGtmwoS/yYYBjBTeGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5IGhW2sLJz13w0OV4JMzjp60kS+fcTPUA/lYhnejgxlW217npNZQkUkgy8SFKZZVxEQBqqgOX8Ult0hO2VVqFzerSEm4kXkA+X4PROp44W54qqeWHiT5PD3GtM3Wgi4WblgQ6a4a17IFUr1HYGjaE/9KwQgAZZA44aEFz4PHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbBF9Mqv; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbBF9Mqv"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-966d4da9fa6so250509241.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692989; x=1784297789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOGQCk2gHj8zC4jmmcyOjkVmGCwfqxQN2IAjlnvu21o=;
        b=pbBF9MqvKtQjEP5VLleQ/Vb4jSgGttnrK97BZs62TeAZLbWhmfpKZeRcBYzPb7WVjR
         zFKzUPW3mDJUg5UnImdqbegfC/eG6Wl3dSSBIF79ZCQLk/wIDW98VbqgnMdX0q4Aj+T4
         JvUa1Td10frazFYPD0IbKFueeLw1SVLHbHbBzsru79rIHZff9e3XNVZrl53TGr1svX3O
         15RIJcdmcj5jF6qt6c+KQzyJGluFcwqrTb3vvJVhSrYvI/f/zZQB2WLo41PeYmXdS96a
         LA1DjOqFwoQBhFfvLSZzT23bNhA8MLKU3G1UJOf+Mb+n+vjV14g/B+2w8Z+BDGtTtIvx
         zV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692989; x=1784297789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOGQCk2gHj8zC4jmmcyOjkVmGCwfqxQN2IAjlnvu21o=;
        b=GH0VBbGt59zHrv4DYEBRFv8LvPsss9/5R4ivc5CeGnapK3Nm5xRvkA4Agud8Q7feHW
         6LXyfU0er5zu5cHZSzxg9xaVBt2QP9RBCZEz/RbnnXRbM11DYBRubH1EE2ioOsOLP0kj
         JecSbMfYiVOQkm17SCAr2b0hxbgOEK/XCO8oMMtV0u/5bb+oroItB/rAzofJ3MHNwftZ
         T8YhQkBa8dYSAgW2CSGyNx/FAXJaZCxv9Cb1fFcEO0J/b1sugJF5UFMatpehLDuDzcv+
         BlI9lWUYL0S/pbkcw8DDl5dPADM7zzvmlLWI25k4mEzx5lRnOZp+lxHLDQyy1Jn1xJr9
         N4YQ==
X-Gm-Message-State: AOJu0YylTEurBFFpqRr0EQ7c/fIeobQxC2VcnP9Fi0Clikb4FHmw7IO8
	Q1HAuRgiiMCLQGWf8lv04LgdEXdMdmcgCi6jMKm/H3rtQIJdNY+mtX6kyOtKEg==
X-Gm-Gg: AfdE7ckt9R5nbZwFTQz/BVjcpoQ/pdIpqDORDq/vysU2fg0bj9sW1u0dyzo8qSZD4Px
	T0yMDpZeRZIMPWNXdpvjfMemvht77iczfQLTwMpgxjnrgazAgNL2YWKhfY50YtkOYC409jCGnF9
	Nag4u+VLiyHyuIRlN6IexDUpPTMQPmvd8Z26+Vijr+32XYkPsLkykFgI78GHdeCMgbC9XT146Da
	u07t9ZppKlxcNQMIpLV9mMhf8cwu73zbnTY8acOjAV/7DPzeMbgtXZo1ELGYNLXKSfBc/h+TryV
	EnHlisAkML03i8OXVHIgmYr0j6wpYVGaVDsnqmY/KrZ0DQAiMAeKiFyQG2UewSmQtnJMnuAA0Im
	qLhYdgjJPc7IzUxRsDjZC0xYq/z4YZQX9/pTcuDuDeVNOlqIWw2u7bg5U/s6rlvDOoNAP8zTXzL
	7esP8OpptOHej1nEcB8bu8Dzow6iIy8eeuSUHOI0wcL7+tCPdtFw4EH0pVRvmacv2hNMMFgLpcI
	w==
X-Received: by 2002:a05:6102:c4d:b0:6a2:b2a1:f16a with SMTP id ada2fe7eead31-744dfc5834dmr6598316137.2.1783692989342;
        Fri, 10 Jul 2026 07:16:29 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:28 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 27/36] tuna: Add --cpuset option to isolate command
Date: Fri, 10 Jul 2026 10:15:05 -0400
Message-ID: <20260710141523.36440-28-jkacur@redhat.com>
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

Add support for cpuset-based CPU isolation using cgroup v2 isolated
partitions. This provides stronger, kernel-enforced CPU isolation
compared to traditional affinity-based isolation.

The new --cpuset option creates an isolated cpuset (partition=isolated)
for RT applications after performing traditional affinity-based isolation.
An optional --cpuset-housekeeping option creates a second isolated cpuset
and migrates non-blocklisted processes from the root cgroup to it.

This implements a 3-tier CPU model:
- Isolated cpuset: CPUs for RT applications (kernel-enforced exclusive)
- Housekeeping cpuset: CPUs for system tasks (optional, isolated partition)
- Root cgroup: Remaining CPUs for normal workloads

Features:
- NUMA-aware memory node assignment for both cpusets
- Automatic process migration with blocklist protection
- Backward compatible (opt-in via --cpuset flag)
- Customizable cpuset names

Usage:
  tuna isolate -c 0-3 --cpuset
    Creates tuna_isolated cpuset with partition=isolated

  tuna isolate -c 0-3 --cpuset my_rt
    Creates my_rt cpuset with custom name

  tuna isolate -c 0-3 --cpuset --cpuset-housekeeping 4-7
    Creates both tuna_isolated and tuna_housekeeping cpusets,
    migrates processes to housekeeping

  tuna isolate -c 0-3 --cpuset my_rt --cpuset-housekeeping my_hk 4-7
    Custom names for both cpusets

Both isolated and housekeeping cpusets use partition=isolated for
kernel-enforced CPU exclusivity. Critical system processes (systemd,
systemd-logind, etc.) are protected by the existing blocklist and
remain in the root cgroup.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index b50691fa2d05..ce34aee8e909 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -182,6 +182,11 @@ def gen_parser():
     isolate_group.add_argument('-c', '--cpus', **MODS['cpus'])
     isolate_group.add_argument('-S', '--sockets', **MODS['sockets'])
     isolate_group.add_argument('-N', '--nohz_full', **MODS['nohz_full'])
+    isolate.add_argument('--cpuset', type=str, nargs='?', const='tuna_isolated',
+                        metavar='NAME', default=None,
+                        help='Use cpusets for isolation with optional name (default: tuna_isolated, partition=isolated)')
+    isolate.add_argument('--cpuset-housekeeping', nargs='+', metavar='...',
+                        help='Create housekeeping cpuset: [NAME] CPU-LIST (default name: tuna_housekeeping, partition=isolated)')
 
     include_group = include.add_mutually_exclusive_group(required=True)
     include_group.add_argument('-c', '--cpus', **MODS['cpus'])
@@ -1613,8 +1618,72 @@ def main():
         tuna.include_cpus(args.cpu_list, utils.get_nr_cpus())
 
     elif args.command in ['isolate', 'i']:
+        # Parse --cpuset-housekeeping arguments
+        housekeeping_name = None
+        housekeeping_cpus = None
+
+        if args.cpuset_housekeeping:
+            # Validate that --cpuset is also specified
+            if not args.cpuset:
+                print("Error: --cpuset-housekeeping requires --cpuset", file=sys.stderr)
+                sys.exit(1)
+
+            # Parse: [NAME] CPU-LIST or just CPU-LIST
+            if len(args.cpuset_housekeeping) == 1:
+                housekeeping_name = 'tuna_housekeeping'
+                housekeeping_cpus = args.cpuset_housekeeping[0]
+            elif len(args.cpuset_housekeeping) == 2:
+                housekeeping_name = args.cpuset_housekeeping[0]
+                housekeeping_cpus = args.cpuset_housekeeping[1]
+            else:
+                print("Error: --cpuset-housekeeping takes 1 or 2 arguments: [NAME] CPU-LIST", file=sys.stderr)
+                sys.exit(1)
+
+        # Traditional affinity-based isolation (existing behavior)
         tuna.isolate_cpus(args.cpu_list, utils.get_nr_cpus())
 
+        # Create cpusets if requested
+        if args.cpuset:
+            try:
+                # Check cgroup v2 support
+                cpusets_init = cpuset.CpusetsInit()
+                if not cpusets_init.supported:
+                    print("Error: cgroup v2 cpuset controller not available", file=sys.stderr)
+                    sys.exit(1)
+
+                # Get NUMA nodes for isolated CPUs
+                isolated_numa = cpuset.get_numa_nodes_for_cpus(args.cpu_list)
+
+                # Create isolated cpuset (partition=isolated, empty)
+                print(f"Creating isolated cpuset '{args.cpuset}' with CPUs {tuna.collapse_cpulist(args.cpu_list)}")
+                isolated_cpuset = cpuset.Cpuset(args.cpuset)
+                isolated_cpuset.write_memnode(isolated_numa)
+                isolated_cpuset.assign_cpus(tuna.collapse_cpulist(args.cpu_list))
+                isolated_cpuset.write_cpu_exclusive(True)  # partition=isolated
+                print(f"Isolated cpuset '{args.cpuset}' created successfully")
+
+                # Create housekeeping cpuset if requested
+                if housekeeping_cpus:
+                    # Parse housekeeping CPU list from string to list
+                    hk_cpu_list = tuna.cpustring_to_list(housekeeping_cpus)
+                    hk_numa = cpuset.get_numa_nodes_for_cpus(hk_cpu_list)
+
+                    print(f"Creating housekeeping cpuset '{housekeeping_name}' with CPUs {housekeeping_cpus}")
+                    hk_cpuset = cpuset.Cpuset(housekeeping_name)
+                    hk_cpuset.write_memnode(hk_numa)
+                    hk_cpuset.assign_cpus(housekeeping_cpus)
+                    hk_cpuset.write_cpu_exclusive(True)  # partition=isolated
+
+                    # Migrate processes from root to housekeeping
+                    print(f"Migrating processes to housekeeping cpuset...")
+                    tm = cpuset.TaskMigrate(cpusets_init, hk_cpuset)
+                    migrated, failed = tm.migrate()
+                    print(f"Migrated {migrated} processes to '{housekeeping_name}' (failed: {failed})")
+
+            except Exception as e:
+                print(f"Error creating cpusets: {e}", file=sys.stderr)
+                sys.exit(1)
+
     elif args.command in ['run', 'r']:
 
         tuna.run_command(args.run_command, args.priority[0], args.priority[1], args.cpu_list, args.background)
-- 
2.54.0

