Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EEF33F8BE
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692996; cv=none; b=Flqcxgkt/uhuB6qVgxrkbw0Ha/mEC+ph+PI4oKmMxfHBJHvXLTVPqMPEbjp4igGl/CjpPVn7h9WBCEZ/KzoSZ1MiuSSE6Fwy2CN+DBiLvFPyL8wKkVduRiQN567HRfcrah9rCj7IAP1G8hRhsddjS+ktuyT/gBATteaVDqEeOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692996; c=relaxed/simple;
	bh=Og5104LmSkmV0bsOYukbqWet5lKUVc5kjVKDbSLKn6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4ftdzlErTrnd3LNme5wBxZp4eP5fVAuvJBEoAIpbLn0JfsY6OL40AUXNsoj1lCPyb4Ww3niZZ3ABmXV3EKJf/S6gEfMKI/ZsWuZClnPFfL05Qdx3QmhkSlX9oO3Ef4W+bU3TCgsajv53VckJNrQgMNaEIBp8/lH9CpUoghGyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCekEOz5; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCekEOz5"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bbc717c52aso405024e0c.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692994; x=1784297794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5wii7pQLjq2vIKvZ8pVOJ+0QFexs3gCeS/q1VwuGJG8=;
        b=sCekEOz51jupJ0kG2h5xY69Cp88DW3oMsze5LcBDgPtTan8CnjkcIFBV50Yt2CuN6x
         mJOouR9LJyUWroLjdGmY5wsgOti9K4ux4VaK3/xMh4D1r2OWfM5sN+S3xVxJB+6XgILF
         TxOqJWKprLVeiZxu6gZyfp9rSl042HYZecZTZ/CSTawWpZptKazg2JSE79BXYh89KClh
         3bgFrUcRIh2Yg6FqQAQeJnu0VgVP6H+v9Ya/pyTQAjcpePRJef86oz/BkRDpyIGIIUWz
         87YqwGTAFtswD8CBdAWovUACYHIk1KXz4LmX8kjUPBdPIHcUDaZs4N2bQVTWu/IhjNw8
         C7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692994; x=1784297794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5wii7pQLjq2vIKvZ8pVOJ+0QFexs3gCeS/q1VwuGJG8=;
        b=M0DW6mEonHo+KMbRwXrh/OXIkI7jEvo+FHpHLVD9Wbbjco+qB6+t0osVRPPOvLt2E4
         /b2awvSEIibr4MSg31phk3W1LNdmTndH1MXex/bpfBdiZgXG419vhAJXqJx2b4lZ0C+S
         4P8gEWumKM/Eo5ew5ZvlrS+jMMzz9jYJfb5zWYpTDWzrd+queNqfVZf2XDylY+0hix7S
         Eb3hGw8tS7R6xkOxiscYmi2Ai9wspa1ZlF1RPVV58/UhPNF0oEet3jI9O2dnY9G+p4/T
         F5GCdkIvZ2vF/bh1f8r7R/f7wISJzaR5w18QLLK9YliyXySYo1Hog0EiW7HAc5KTkk/T
         HuKg==
X-Gm-Message-State: AOJu0Yzfe3IHXndbqjTO0+KGeEv997nBqkchldao79L62cF4pVXxny8K
	YcqNEOx6RmBHv/XH0+JApzvdXxq/NGPcjMqL9cMopXUfDKwkpJd6tS/WwUGDCA==
X-Gm-Gg: AfdE7cmIk3o55Pu1cwN/lO9CWOkkWguW5190zsbb9OPPYWxLJKQSdVSAqBkUPFntWmC
	0qIpWrqw6/zejxHJYwRupt6Px+1BdRYmWa8wjZ45TTGw9qE04sh+V5qRNdqYGMgOkEYRbxdR/Do
	W4e2YBnqxbVv94bitrXgXjQJDXeQ/ZTWbi9BsYN94o2m6Hb+JvJo8uv5JwRyhXYmQ5w1PWfQTWg
	lJY74QoYSzyG4Moy/+26Vk/NKVGRvY7DYbakCcbGXfYkisNUzPHuvN3WXo07wu6nXvVxyHaq7G8
	kC+jQmveKRaOJZbGUogqB/y7hqGxy8Xtq/pc4xKvXzDDdU0AWb7WsO9h/QMrntOO1/+WkZuBrmN
	45R49WLOFx2GjLVdfmbdziC11vDT6yBDWK8Zb/sa7lbEdkrdiy1AetY2OsS2q6ix4uq7eNbbIuP
	MqNtM70As3rGmnwdPk9lukQ2L2ElcmRTi87nanbeCJ5Ajg1WiFCKOjYahRIcDq+Ckrj8pxvkqmy
	DJ2uqhlIlYQ
X-Received: by 2002:a05:6102:5492:b0:744:c068:438a with SMTP id ada2fe7eead31-744dff52b72mr7187361137.5.1783692993643;
        Fri, 10 Jul 2026 07:16:33 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 30/36] tuna: Add --cpuset filter option to show_threads command
Date: Fri, 10 Jul 2026 10:15:08 -0400
Message-ID: <20260710141523.36440-31-jkacur@redhat.com>
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

Add a --cpuset option to the show_threads command to filter and display
only processes that belong to a specific cpuset. This makes it easy to
monitor which processes are running in a particular cpuset without
manually inspecting cgroup paths.

The filter works by parsing the cgroup path from /proc/[pid]/cgroup and
extracting the cpuset name. Processes are only displayed if they match
the requested cpuset name.

Usage:
  tuna show_threads --cpuset <name>    Show processes in cpuset
  tuna show_threads --cpuset ""        Show processes in root cgroup

The option can be combined with other filters:
  tuna show_threads --cpuset tuna0 -t <pattern>   Filter by cpuset and thread
  tuna show_threads --cpuset tuna0 -G             Show with cgroup info
  tuna show_threads --cpuset tuna0 -c 0-3         Filter by cpuset and CPUs

This completes the third integration feature for cpusets (Enhancement #5c),
providing a convenient way to verify which processes are in a cpuset after
using 'tuna move --cpuset' or 'tuna isolate --cpuset'.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index ce34aee8e909..c2208e268c97 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -247,6 +247,7 @@ def gen_parser():
     if have_inet_diag:
         show_threads.add_argument('-n', '--show_sockets', **MODS['show_sockets'])
     show_threads.add_argument('-G', '--cgroups', **MODS['cgroups'])
+    show_threads.add_argument('--cpuset', type=str, metavar='CPUSET-NAME', help='Show only threads in the specified cpuset')
     show_threads.add_argument('-z', '--spaced', **MODS['spaced'])
 
 
@@ -469,7 +470,7 @@ def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
 
 def ps_show(ps, affect_children, thread_list, cpu_list,
             irq_list_numbers, show_uthreads, show_kthreads,
-            has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact, match_requested, irqs):
+            has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact, match_requested, irqs, cpuset_filter=None):
 
     ps_list = []
     for pid in list(ps.keys()):
@@ -502,6 +503,22 @@ def ps_show(ps, affect_children, thread_list, cpu_list,
             raise e
         if cpu_list and not set(cpu_list).intersection(set(affinity)):
             continue
+        # Filter by cpuset if requested
+        if cpuset_filter:
+            # Extract cpuset name from cgroup path
+            # Format: "0::/cpuset_name" or "0::/" for root
+            cgroup_path = ps[pid]["cgroups"]
+            if cgroup_path.startswith("0::"):
+                cgroup_path = cgroup_path[3:]  # Remove "0::" prefix
+            # Remove leading slash to get cpuset name
+            if cgroup_path.startswith("/"):
+                cgroup_path = cgroup_path[1:]
+            # Get the first component (cpuset name)
+            # For nested cpusets like "parent/child", this gets "parent"
+            cpuset_name = cgroup_path.split('/')[0] if cgroup_path else ""
+            # Check if process is in the requested cpuset
+            if cpuset_name != cpuset_filter:
+                continue
         if match_requested and thread_list and pid in thread_list:
             ps_list.append(pid)
         elif not match_requested:
@@ -540,7 +557,7 @@ def load_sockets():
 
 
 def do_ps(thread_list, cpu_list, irq_list, show_uthreads, show_kthreads,
-          affect_children, show_sockets, cgroups, compact, match_requested):
+          affect_children, show_sockets, cgroups, compact, match_requested, cpuset_filter=None):
     ps = procfs.pidstats()
     if affect_children:
         ps.reload_threads()
@@ -559,7 +576,7 @@ def do_ps(thread_list, cpu_list, irq_list, show_uthreads, show_kthreads,
             ps_show_header(has_ctxt_switch_info, cgroups)
         ps_show(ps, affect_children, thread_list,
                 cpu_list, irq_list, show_uthreads, show_kthreads,
-                has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact, match_requested, irqs)
+                has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact, match_requested, irqs, cpuset_filter)
     except IOError:
         # 'tuna -P | head' for instance
         pass
@@ -1712,7 +1729,7 @@ def main():
 
         if has_content:
             do_ps(args.thread_list, args.cpu_list, args.irq_list, args.uthreads,
-                    args.kthreads, args.affect_children, args.show_sockets if "show_sockets" in args else None, args.cgroups, args.compact, match_requested)
+                    args.kthreads, args.affect_children, args.show_sockets if "show_sockets" in args else None, args.cgroups, args.compact, match_requested, args.cpuset if "cpuset" in args else None)
 
     elif args.command in ['show_irqs']:
         # Skip display if pattern matched nothing (warning already shown)
-- 
2.54.0

