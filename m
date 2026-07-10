Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969F344D80
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693003; cv=none; b=O9TzTUn9VfBy7ATLEWOQKc9INC5PDcC/jUmGbXrZbdcGgU8GuA2hJZxF7oYDGsWO8AOClF37RmMVCaofrFsWoC5dhw14ZsNmsOtG5rIpVI5EfUobUtZFAQ8cF1tVWFTb1kNoYz+JEWQEKjNRGZGC+Gsf1y2iny8co0wNrqC89tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693003; c=relaxed/simple;
	bh=EAPxIKiMFABlF4G2MMXfnf7VAOGfuId7XN2sCD6GDWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTvUVEcup5kygIVsqAdBMfgJ648ceiHbbwsDEvnXDbpHhf4AN/otOcPhpRXHMwwu3Wct7mZfWyx3BfrsJ78O29yxFdyzatey7Sa5MFr0Qehk6t1AyxRVr9+q0sEb1XgPahZzY0/A0TEVQrb/hlxewcvu6m1kOtGi6Yoh8j56hng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wgr4GZAl; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgr4GZAl"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-966d4748ad5so622439241.3
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783693001; x=1784297801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zb2CORDUnJW6BRuryhHxa1NJ+1JoiXeJ3wpsQOIK9e4=;
        b=Wgr4GZAlacghC8fSTOh0ejV9QIkRLJzuu9W2MwzfiI+DR7b2D0kMDL+a0FXk3TtN6f
         w7iNqwxXIHVlqPWpKTW71a49OMA62bO3tDvTRPPSCeVzGqx4Ovo8kiRGHqnkuYROZJTf
         5GqVgaZpW+anUfDS622iLDskU9//xJtpUvVhK6gLSLnMMKwE2hZc8eRffI8ThNOORe87
         2q/a1gtJvnK2QwHtFLWLkU47pt6vyfmN+6Ml7wR1JhqjH5mKstkq/yjNP5FVe0gmA8P+
         iYTN9dXJclSxbcQkEOCVdeWSPgC51czRJmAurHqpdfkl0LWE/UoTYsHPZxdQcF7lSsgF
         J05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693001; x=1784297801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zb2CORDUnJW6BRuryhHxa1NJ+1JoiXeJ3wpsQOIK9e4=;
        b=ErGhfwh2N84zseQkzAKCwr0NyrL1F0bEBj+2ZF72LqnEfCKoBCzBfoN3sVWFaVT+vJ
         vXk/9/SqJeXVvxrlaHQtJmezvdXiprY4Z5/tSjPTbIUiGEhU/cvpbBfXuOloMIoH/Bn1
         9VuOP4Tz+Z8NVMOGTClRy/HhAeMyHTCiuF78gUJaZ+Gf0918zI4kN89le9chCt2oy/52
         xUg0kHV4JgbA3cSipPlXYuXZ6UgRk1QPxZQLkNYhVH+D7gqanMlyBIKVMhFYbKIhJSew
         88s+L8KR6s0wyZVhxo+pTYLCIh0H5yEsj3OnC2W7UD3mmxzKiUeHxn0EzeKLWZAga82/
         /oJg==
X-Gm-Message-State: AOJu0Yx8P+eVEA+6EoE1yuS9mL0mvxoouqT38s5GcEhP1eUeUVdHmCDv
	i+c6nDQX9y3Xvnr2hBZcISyBKWiHI1TsvEyYwXvaIuPSfXLPRHKMtP/wNlUFNg==
X-Gm-Gg: AfdE7ck+gQIEWcoO3m7Wn09LRPDjEw5Yyjzq+FMlgID5eT7Wksiy957e+ungvOwLKqx
	IF5RsF+d4mho11Yfm73qBATqLtQcs2g/m/51mqnAMIdjrhXjT5sxNraHVhjgE46g3ID6dmc6AlH
	1IsaR4AMHcQmyzdgqtFIkBk4VJstZk654gET3pATOosA+zX4AmKFX/Bppk2c9S/QLrU3GeGX8vR
	rdaknP/0uc16RiBBrJo2fkglpMm8GQkYDqUGrfW9Nc6EFzvSUCvWrp9UZSYxNO3+Wa0UjObcdFh
	VT6v+ZQT5tZ/uwIhUoVdVtRjNnfRSgnusxA+kJ8QpsHkfidQqrDCJqitLeXO1oEvR6z5BVu1sX7
	3knKeblHoYiLOmzqywtiAArjMuvDUu+X87Z+bNCOV/cpWMr0ZMolQM3+LzKZ6orjfTNjuosFZif
	kkKcxvebjlqL1BjgG7fqxs7Hu9Du2CuIOovPZ+Jc5EbcOBz32hmGwzymrEk6NwqKpRVL2X11olp
	Qgx9/oo7U7d
X-Received: by 2002:a05:6102:598c:b0:726:8813:2078 with SMTP id ada2fe7eead31-744dfebf3c1mr7138226137.11.1783693000601;
        Fri, 10 Jul 2026 07:16:40 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:39 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 34/36] tuna: Add --cpuset option to run command
Date: Fri, 10 Jul 2026 10:15:12 -0400
Message-ID: <20260710141523.36440-35-jkacur@redhat.com>
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

Add support for running commands directly in cpusets using the
--cpuset option. This allows launching processes with both CPU
isolation (via cpusets) and scheduling priority settings.

The implementation:
- Adds --cpuset CPUSET-NAME option to run command parser
- Makes --cpuset mutually exclusive with CPU affinity options (-c, -S, -N)
- Validates cpuset exists before launching the process
- Extends run_command() to accept cpuset_name parameter
- Implements parent-child coordination: child sets priority/affinity
  and execs command, parent migrates child to cpuset
- Handles race condition where fast commands finish before migration
  by checking process existence with signal 0
- Adds signal import for SIGTERM handling

Example usage:
  tuna run --cpuset my_rt 'taskset -pc $$ && sleep 5'
  tuna run --cpuset my_rt -p FIFO:50 'stress-ng --cpu 1'

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py  | 14 ++++++++++++--
 tuna/tuna.py | 28 +++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 4703ea41f8d4..25257c465532 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -221,6 +221,7 @@ def gen_parser():
     run_group.add_argument('-c', '--cpus', **MODS['cpus'])
     run_group.add_argument('-S', '--sockets', **MODS['sockets'])
     run_group.add_argument('-N', '--nohz_full', **MODS['nohz_full'])
+    run_group.add_argument('--cpuset', type=str, metavar='CPUSET-NAME', help='Run process in specified cpuset (cgroup v2) instead of setting CPU affinity')
     run.add_argument('-p', '--priority', **MODS['priority'])
     run.add_argument('-b', '--background', **MODS['background'])
 
@@ -1659,7 +1660,7 @@ def main():
                         print(f"[ERROR] Invalid RT priority: {rtprio}. RT priorities must be 1-99", file=sys.stderr)
                         sys.exit(2)
                 # If only priority specified (no policy), assume RT and validate
-                elif policy is None and rtprio != 0:
+                elif policy is None and rtprio is not None and rtprio != 0:
                     if rtprio < 1 or rtprio > 99:
                         print(f"[ERROR] Invalid RT priority: {rtprio}. RT priorities must be 1-99", file=sys.stderr)
                         sys.exit(2)
@@ -1738,8 +1739,17 @@ def main():
                 sys.exit(1)
 
     elif args.command in ['run', 'r']:
+        # Check if using cpuset mode
+        cpuset_name = None
+        if hasattr(args, 'cpuset') and args.cpuset:
+            # Verify cpuset exists
+            cpuset_path = os.path.join('/sys/fs/cgroup', args.cpuset)
+            if not os.path.exists(cpuset_path):
+                print(f"Error: cpuset '{args.cpuset}' does not exist", file=sys.stderr)
+                sys.exit(1)
+            cpuset_name = args.cpuset
 
-        tuna.run_command(args.run_command, args.priority[0], args.priority[1], args.cpu_list, args.background)
+        tuna.run_command(args.run_command, args.priority[0], args.priority[1], args.cpu_list, args.background, cpuset_name)
 
     elif args.command in ['priority', 'p']:
 
diff --git a/tuna/tuna.py b/tuna/tuna.py
index 5e5f5578fbe4..fd08b5efe1ae 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -6,6 +6,7 @@ import copy
 import errno
 import os
 import re
+import signal
 import sys
 import shlex
 import fnmatch
@@ -708,7 +709,7 @@ def get_kthread_sched_tunings(proc=None):
 
     return kthreads
 
-def run_command(cmd, policy, rtprio, cpu_list, background):
+def run_command(cmd, policy, rtprio, cpu_list, background, cpuset_name=None):
     newpid = os.fork()
     if newpid == 0:
         cmd_list = shlex.split(cmd)
@@ -732,6 +733,31 @@ def run_command(cmd, policy, rtprio, cpu_list, background):
             print(f"tuna: {err}")
             sys.exit(2)
     else:
+        # If cpuset mode, move the child process to the cpuset
+        if cpuset_name:
+            from tuna import cpuset
+            try:
+                cs = cpuset.Cpuset(cpuset_name, existing_ok=True)
+                if not cs.write_pid(newpid):
+                    # Check if process still exists - if it exited quickly, that's okay
+                    try:
+                        os.kill(newpid, 0)  # Signal 0 just checks if process exists
+                        # Process still exists but couldn't be moved to cpuset - this is an error
+                        print(f"tuna: failed to move process {newpid} to cpuset '{cpuset_name}'", file=sys.stderr)
+                        os.kill(newpid, signal.SIGTERM)
+                        sys.exit(1)
+                    except OSError:
+                        # Process already exited - that's okay, it just ran quickly
+                        pass
+            except (OSError, ValueError) as e:
+                print(f"tuna: error accessing cpuset '{cpuset_name}': {e}", file=sys.stderr)
+                # Try to kill the child process if it still exists
+                try:
+                    os.kill(newpid, signal.SIGTERM)
+                except OSError:
+                    pass
+                sys.exit(1)
+
         if not background:
             os.waitpid(newpid, 0)
 
-- 
2.54.0

