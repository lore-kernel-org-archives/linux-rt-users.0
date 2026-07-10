Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903931716B
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692974; cv=none; b=VO26V2NVEzKj/j2j7pgYv+iTb+b8Ts7GWe2leoxShswXVLMJ9iDUH7w5YITmDIh+m1QkbY9/KFPdlWwKDIvxdxsjnLiFigmr0uYPOZ7665atzI1chuDY9LC3nnSCdStrqNAxZPALdayqorfvTIQY4tA0B2L1w6sfDZt2AnvNGCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692974; c=relaxed/simple;
	bh=yOXQt6XbHqMVt4k0aEQduDj1eyqE5pO7fdCXzPa7zrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea1TgHjFIAxlNQxoSQkp8rNXQDHRXsOTXhIzL/23snQ1zbZ+O3rFWuw3fY5Ez8fgRNLYYPnvl+TiBARuWfUIPqx2Z5GZz3s9R+zfqHS1dzNeW/lqQQPUvrIFFM2n84WXLLXIpZdDMjdEZ+jyReCUXkjEqMZ+2yEF7NSd2qF510g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfEsesH9; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfEsesH9"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-971de219a85so440143241.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692972; x=1784297772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UCLicLwurbhg+P3MivNYjSrqcVWIlIfZlxELC2/ajvo=;
        b=SfEsesH9wk0tZZmt50ZqnwHoeOnQStKs3LRXRQYRrU1H8x2cxQDyDncVpf+Q7PVZyG
         HshV3QaLO4JiFCPdNZ5jvl9fliz7oVEPPOwBqOwU/avF+zjc/bJveVVW5y2aYTO7TCkc
         zirweh1GbU203hbyPpLMUbwMfOCronyBzk2+DPHJBMLjZCXdJDzuJpaVVf+QNvqBBD/Y
         8ZLH8EzVX5uUlhkxhzB3IcZnz4KFjp13zW9adu7sogi/PKax21cMYkx44+7VCZwrVe4D
         nDJaHAMeToVEgsRleEF8n6FwZKvqlX/L55nUuyfZ8fn6AdmtJtlOYcj59Kn59dmylj9y
         h3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692972; x=1784297772;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCLicLwurbhg+P3MivNYjSrqcVWIlIfZlxELC2/ajvo=;
        b=srJ+SfI3auV9H7vpCBaoL4geS62MX+qAtd1rrQFtrWgowneKM/pCZo1waXRZ01u769
         WE8bA3E6K3p0wQxaxvnMiiJUKCMUcW1scIDFOrSToJ5lJcJo8yC01dV2pq/qR744vj2T
         OI5RhuM/WXTDorrudkan+D+f/gDLRAF0tAeKLxSHdefS12TMgH/oxlFUsosqXOGgu4Jd
         WVc+83eZq1OQlWN/ZHyrKjdi9WAuJ7qtwTURHhUiQSkFfq6+K7wPnKvJ1QtsZ61NzzeJ
         Nbdc84X7XunT9EnGtUr/X9hsv8eFaEIDoHctILS7OgAFMHA8estlvN1xjZCF4viSHY0Q
         NitA==
X-Gm-Message-State: AOJu0YxU3783zkwxVkWeR6gaJUYu0RFN8iy4r/LkBwCDt7ECYkWbQxCj
	qICTYoDL64ypY4M3XwGEUOOftdf8FBQ7IGTrt5wQ+gmw1H2ODjdGGAVfhvdPaw==
X-Gm-Gg: AfdE7ckLD+ENDzGiaPcWWGFNuTvS8uX0pwehPyvS1Nqam9uQ1PqASpXO2X5+1C8Ds7/
	IyM4Sp2xc4UA+HzllrZ6a1NfTzu0K1r7yMIkIq+n4isfaf86+cuEZqMbap/mHNbiTyOH5p2lBWc
	7SILBd5b8It6N8f1TDyw21mLHHb7udUBt/aFWTa3PIsLTa0JrqhwwEgs4fimKAB/shyLR0ZGJHs
	pJYhIqBfxDjX4kivV6AOf0wyBtfo6QvJ1TmBcExzMdnnFuH2gJYIn3TvkIGP222ThkASdziSBxe
	4LOd5MMTVcGcBhx+ezFTRzWVqzbrBv7fUFbPT2OTTvWeyVUUJY+lOkwEapFpLeRs6Okmb2afxTd
	U3E4DgjlU6LkEkXW6QErYCWXFot6KXIzeiFleB5HPRGpL5ohi6S+enei8+zH87iw5JOO8wPnjH9
	cPiYbAR2D0LV5Z7eKpytoeKYPWWMgI1rNhi3NnTDQM0tdF6kwho7m1k6jD0ADO1g9t0+1wHKlRE
	w==
X-Received: by 2002:a05:6102:290b:b0:740:178:7724 with SMTP id ada2fe7eead31-7450d211f7dmr2015781137.14.1783692971607;
        Fri, 10 Jul 2026 07:16:11 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:10 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 17/36] tuna: Add memory nodes and blocklist warnings to cpuset list
Date: Fri, 10 Jul 2026 10:14:55 -0400
Message-ID: <20260710141523.36440-18-jkacur@redhat.com>
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

The cpuset list command now displays NUMA memory node assignments in
verbose mode and warns if critical system processes are found in
user-created cpusets.

Changes:
- Added MEMS column to verbose output showing cpuset.mems (memory nodes)
- Added blocklist checking after listing cpusets
- Warns if systemd, systemd-logind, or other critical processes are
  found in user-created cpusets (tuna*, rteval_*, etc.)
- Skips system cgroups (*.mount, *.scope, *.slice) to avoid false
  warnings about systemd in init.scope

The memory nodes display is especially useful on NUMA systems since we
recently added NUMA-aware memory node assignment. The blocklist warnings
help verify that the blocklist protection is working correctly and catch
any cases where critical processes end up in custom cpusets despite
protection.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 50e6e9f9d937..5c21d54bc2bf 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -882,7 +882,7 @@ def cpuset_list(pattern, verbose, skip_empty, recursive):
 
     Args:
         pattern: Glob pattern to filter cpusets (None for all)
-        verbose: If True, show detailed info (CPUs, tasks, partition)
+        verbose: If True, show detailed info (CPUs, memory nodes, tasks, partition)
         skip_empty: If True, skip cpusets with no CPUs assigned
         recursive: If True, search nested cpusets
     """
@@ -918,9 +918,9 @@ def cpuset_list(pattern, verbose, skip_empty, recursive):
         return
 
     if verbose:
-        # Verbose output: NAME, CPUS, TASKS, PARTITION
-        print(f"{'NAME':<20} {'CPUS':<15} {'TASKS':<7} {'PARTITION':<10}")
-        print("-" * 55)
+        # Verbose output: NAME, CPUS, MEMS, TASKS, PARTITION
+        print(f"{'NAME':<20} {'CPUS':<15} {'MEMS':<10} {'TASKS':<7} {'PARTITION':<10}")
+        print("-" * 65)
 
         for cs_name in cpusets:
             cs_path = os.path.join('/sys/fs/cgroup', cs_name)
@@ -930,6 +930,10 @@ def cpuset_list(pattern, verbose, skip_empty, recursive):
                 with open(os.path.join(cs_path, 'cpuset.cpus'), 'r', encoding='utf-8') as f:
                     cpus = f.read().strip() or "(none)"
 
+                # Read memory nodes
+                with open(os.path.join(cs_path, 'cpuset.mems'), 'r', encoding='utf-8') as f:
+                    mems = f.read().strip() or "(none)"
+
                 # Read tasks count
                 with open(os.path.join(cs_path, 'cgroup.procs'), 'r', encoding='utf-8') as f:
                     tasks = [line.strip() for line in f if line.strip()]
@@ -943,7 +947,7 @@ def cpuset_list(pattern, verbose, skip_empty, recursive):
                 else:
                     partition = "n/a"
 
-                print(f"{cs_name:<20} {cpus:<15} {task_count:<7} {partition:<10}")
+                print(f"{cs_name:<20} {cpus:<15} {mems:<10} {task_count:<7} {partition:<10}")
 
             except (OSError, IOError) as e:
                 print(f"{cs_name:<20} (error reading: {e})", file=sys.stderr)
@@ -952,6 +956,39 @@ def cpuset_list(pattern, verbose, skip_empty, recursive):
         for cs_name in cpusets:
             print(cs_name)
 
+    # Check for blocklisted processes in cpusets
+    # Skip system cgroups (*.mount, *.scope, *.slice) - these are managed by systemd
+    warnings = []
+    for cs_name in cpusets:
+        # Skip system cgroups - only check user-created cpusets
+        if cs_name.endswith(('.mount', '.scope', '.slice')):
+            continue
+
+        cs_path = os.path.join('/sys/fs/cgroup', cs_name)
+        try:
+            with open(os.path.join(cs_path, 'cgroup.procs'), 'r', encoding='utf-8') as f:
+                pids = [line.strip() for line in f if line.strip()]
+                for pid_str in pids:
+                    try:
+                        pid = int(pid_str)
+                        if cpuset.Cpuset._is_process_blocklisted(pid):
+                            comm = cpuset.Cpuset._get_process_name(pid)
+                            warnings.append(f"⚠️  WARNING: Blocklisted process PID {pid} ({comm}) found in cpuset '{cs_name}'")
+                    except ValueError:
+                        # Invalid PID, skip
+                        pass
+        except (OSError, IOError):
+            # Can't read procs, skip
+            pass
+
+    # Display warnings if any
+    if warnings:
+        print()
+        for warning in warnings:
+            print(warning, file=sys.stderr)
+        print("\nBlocklisted processes should not be in custom cpusets!", file=sys.stderr)
+        print("This may indicate a problem with blocklist protection.", file=sys.stderr)
+
 
 def cpuset_destroy(name, pattern, force, skip_empty, recursive):
     """Handler for 'tuna cpuset destroy' command.
-- 
2.54.0

