Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD82C3245
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692967; cv=none; b=O/4X8krJ5FWW6jk77vwbiMjALF218nC4nTL3cWaOVSt0TexBlMiG5F6WZ5NZCG7ScFGa8NBrk/AVipAlDCtujJ4nL3lJBrzdhtRXFnjddGZUX3fy9/Nn4XxiIgUvRgPNQsTKXIzjjCrU00fN8MNOqTjNYVHs6pHfIxPSIoUP0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692967; c=relaxed/simple;
	bh=3ztm+09MZv8vs6QuUaYHmGk9U88r7gq6JkJBiBP4G+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3d0DxDGsoBOFYRlSQp40Z0D9DqYKYDh95sWsj54FzHEgW0M9SmpMw5RwQFugXYetHQG7psZlQXIam0yYCvp/hfFNEJ66mdwYrvt17Ekwwlc7raHjlXeUir2t/UamFa+Jt4cVoen36jdaE6U6z4gnR4ZkaoAjtc2l0JZLjahp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONupEh4E; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONupEh4E"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-736eec08c43so825736137.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692965; x=1784297765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BrjTskb71mki9CFYSjM0dmaRK3qAxDh3xN16D71u3nc=;
        b=ONupEh4ERLPLOIsnxHOgNo0R4HRz82cQ+dDqu6yqSnbpf1TRmKntO72brKgweRDdr+
         u1zzwbH/81XiI862+sxVo6hHJYLEjNkyw/nE+kNIAvV5NuegaJNKluD3lgYqNobqfT2W
         Q15oCSOB2oQHQXVr19RNpHUfX3S2Bz0kxTP5adC7/Ooe0ACPTnO/Tq4FMWoQbzteK/lr
         hOBAY/Oo4O5TPYRPrFRM5YM+2unl8mp5jafWbLwbTncE6GeYaxng9wiDtwe7DI/UWZDK
         St4I95ZBlUfcA28c2zMSUNuVwWf+iCO87Owj9LAD8h5WfphAYjJ4Y/vZKoAorCdqjkSB
         g0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692965; x=1784297765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrjTskb71mki9CFYSjM0dmaRK3qAxDh3xN16D71u3nc=;
        b=aqvASnx6NVUX8y+hliuXGNd84bVmxgslclSPar90gYunv6AkG1tCPDwoB0Du6OQQy4
         fU4CMW50M3/NWuIWNgHHQWNkMcHlKnyzl2k6NF2PvaHURrWGdFNhtDoLnOzFKaNOJsl6
         JtWK96v7aNHF/LnCIafTz7PFbLOYdqxqNZzrIn1Jor/wsN8hGBHEamz9U3FaK4rJfjLu
         RdmVRnuizOi32QAMBTRZ0T5JDgrlZ9sXtaSFTXxbyEiktBmfI+1dGg4/hiin45JWVuUi
         Y/+IBdNk8GChhRZlm/LV/lH6z7JNdIKZtwQPhtda+HtQEa+Mh4UA3aGYuSeXxk5jY/8q
         Hgww==
X-Gm-Message-State: AOJu0Yx4VxnOLexznA4lRKUZt0TOhrO1VoOHkpYpmq5bSjBd/OOkIiU1
	OBI11IiX5xSyU4Kf0HGiNcrlAFESw3Cyk5/LT6lfB4KXr8VL97S7IVozGEhNmA==
X-Gm-Gg: AfdE7cmc4GQCbHW8Boy1FRKiXQacCyCOCzG2jtRZ+uWCK5IbrQsT8ZrH6KSBSAWnigQ
	Uz/vFYvKM+5fc1GS2n9cK9sds0/lk3iItxOzkMHP/E8CdshTSZY8ARbauLcUHbnk3mG1Ck/Um6f
	0e7fCPp6XmVd/8gNMJZX+JTiOUaDtHts6Yugruu08c/lMBvRVfM0NbpLbLjvQuFx0ZZ6LTnXz1D
	o8p0G3Sjff/k5pRiAKujiRPDnS4jZ9tJrdrz/0zE7Me4yGlRb+Vxa5Hs5b56c5HxMgg5b1KwvVN
	qVW6V2RgkiNKRGg4KTeTC/Wsq9ADcZqIpnSCb7s9SbtBI/8icIGM2UEkK2PURgvj1GbYVoydhHu
	GfFUx4EvQC/UFndmn4wgavP54I2TImj45aZk6Yo7OJHMz/9sN2EpqCgN3qoUgop9izEpLPobCUw
	+e3MNfb2l85MPbC4xzKoto0Vkxv41RA6kdpUiFCoQLEF/Xij4a86x1+OejnqeCDjPeouUpdpLJK
	w==
X-Received: by 2002:a05:6102:5a86:b0:631:4385:15cc with SMTP id ada2fe7eead31-7450d017b12mr2128671137.1.1783692964707;
        Fri, 10 Jul 2026 07:16:04 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:03 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 12/36] tuna: Add cpuset move command for process migration
Date: Fri, 10 Jul 2026 10:14:50 -0400
Message-ID: <20260710141523.36440-13-jkacur@redhat.com>
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

Implements 'tuna cpuset move' command to move processes into existing
cpusets. Supports two input methods:
- --threads: Thread list with pattern matching (e.g., kworker*)
- --pids: Comma-separated list of PIDs

Key features:
- Validates cpuset exists before attempting moves
- Gracefully handles invalid PIDs (returns False, continues)
- Reports success/failure counts
- Exits with error if all moves fail

Also adds existing_ok parameter to Cpuset class to suppress warnings
when accessing existing cpusets (follows os.makedirs convention).

Changes:
- tuna-cmd.py: Add cpuset move argument parser, handler, and dispatcher
- tuna/cpuset.py: Add existing_ok parameter to Cpuset.__init__() and
  create_cpuset() to allow accessing existing cpusets without warnings

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py    | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tuna/cpuset.py | 22 ++++++++----
 2 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 2ff73426ba4f..0e70b9208665 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -292,6 +292,12 @@ def gen_parser():
     cpuset_destroy.add_argument('--skip-empty', action='store_true', help='When using --pattern, skip cpusets with no CPUs assigned')
     cpuset_destroy.add_argument('--no-recursive', dest='recursive', action='store_false', default=True, help='Only destroy top-level cpusets when using --pattern')
 
+    # cpuset move
+    cpuset_move = cpuset_subparser.add_parser('move', description='Move processes to a cpuset', help='Move processes to a cpuset')
+    cpuset_move.add_argument('-n', '--name', type=str, metavar='NAME', required=True, help='Cpuset name to move processes to')
+    cpuset_move.add_argument('-t', '--threads', **MODS['threads'])
+    cpuset_move.add_argument('-p', '--pids', dest='pid_list', type=str, metavar='PID-LIST', help='Comma-separated list of PIDs to move')
+
     return parser
 
 
@@ -1009,6 +1015,87 @@ def cpuset_destroy(name, pattern, force, skip_empty, recursive):
         sys.exit(1)
 
 
+def cpuset_move(name, thread_list, pid_list):
+    """Handler for 'tuna cpuset move' command.
+
+    Args:
+        name: Cpuset name to move processes to
+        thread_list: Thread list (already converted to list of PIDs by main())
+        pid_list: PID list string (comma-separated PIDs only)
+    """
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
+        sys.exit(1)
+
+    # Validate: must specify at least one of thread_list or pid_list
+    if not thread_list and not pid_list:
+        print("Error: must specify either --threads or --pids", file=sys.stderr)
+        sys.exit(2)
+
+    # Check if cpuset exists
+    cpuset_path = os.path.join('/sys/fs/cgroup', name)
+    if not os.path.exists(cpuset_path):
+        print(f"Error: cpuset '{name}' does not exist", file=sys.stderr)
+        sys.exit(1)
+
+    # Create cpuset object for the target cpuset
+    try:
+        cs = cpuset.Cpuset(name, existing_ok=True)
+    except (OSError, ValueError) as e:
+        print(f"Error accessing cpuset '{name}': {e}", file=sys.stderr)
+        sys.exit(1)
+
+    # Build list of PIDs to move
+    pids = []
+
+    # Process thread_list if provided (already converted to list of PIDs by main())
+    if thread_list:
+        # thread_list is already a list of integers from main()'s conversion
+        pids.extend(thread_list)
+
+    # Process pid_list if provided (simple comma-separated PIDs)
+    if pid_list:
+        import re
+        pid_strings = [s.strip() for s in re.split(r'[,\s]+', pid_list) if s.strip()]
+        for pid_str in pid_strings:
+            if pid_str.isdigit():
+                pids.append(int(pid_str))
+            else:
+                print(f"Warning: ignoring invalid PID '{pid_str}'", file=sys.stderr)
+
+    # Remove duplicates
+    pids = list(set(pids))
+
+    if not pids:
+        print("Error: no valid PIDs to move", file=sys.stderr)
+        sys.exit(2)
+
+    # Move each PID to the cpuset
+    success_count = 0
+    fail_count = 0
+
+    for pid in pids:
+        if cs.write_pid(pid):
+            success_count += 1
+        else:
+            # write_pid returns False on failure
+            print(f"Warning: failed to move PID {pid} to cpuset '{name}'", file=sys.stderr)
+            fail_count += 1
+
+    # Print summary
+    print(f"Moved {success_count} process(es) to cpuset '{name}'", end='')
+    if fail_count > 0:
+        print(f" ({fail_count} failed)")
+    else:
+        print()
+
+    # Exit with error code if all moves failed
+    if success_count == 0:
+        sys.exit(1)
+
+
 def main():
     i18n_init()
     parser = gen_parser()
@@ -1229,6 +1316,9 @@ def main():
         elif args.cpuset_command == 'destroy':
             cpuset_destroy(args.name, args.pattern, args.force, args.skip_empty, args.recursive)
 
+        elif args.cpuset_command == 'move':
+            cpuset_move(args.name, args.thread_list, args.pid_list)
+
 
 if __name__ == '__main__':
     main()
diff --git a/tuna/cpuset.py b/tuna/cpuset.py
index 4a3a71416c53..1039eb6c2c49 100644
--- a/tuna/cpuset.py
+++ b/tuna/cpuset.py
@@ -22,7 +22,7 @@ class Cpuset:
 
     mpath = '/sys/fs/cgroup'
 
-    def __init__(self, name=None, auto_destroy=False):
+    def __init__(self, name=None, auto_destroy=False, existing_ok=False):
         """
         Initialize a cpuset
 
@@ -32,11 +32,14 @@ class Cpuset:
                          exiting a context manager (rteval style).
                          If False (default), cpuset persists after program exits
                          (tuna style).
+            existing_ok: If True, suppress warning when cpuset already exists.
+                        Use this when accessing an existing cpuset rather than
+                        creating a new one (default: False).
         """
         self.cpuset_name = None
         self._cpuset_path = None
         self.auto_destroy = auto_destroy
-        self.create_cpuset(name)
+        self.create_cpuset(name, existing_ok=existing_ok)
 
     @property
     def cpuset_path(self):
@@ -46,12 +49,16 @@ class Cpuset:
     def __str__(self):
         return f'cpuset_name={self.cpuset_name}, cpuset_path={self.cpuset_path}'
 
-    def create_cpuset(self, name=None):
+    def create_cpuset(self, name=None, existing_ok=False):
         """
         Create a cpuset (cgroup) below /sys/fs/cgroup
 
-        If the cpuset already exists, prints a warning and returns without
-        creating a new one.
+        If the cpuset already exists, prints a warning (unless existing_ok=True)
+        and returns without creating a new one.
+
+        Args:
+            name: Name of the cpuset to create
+            existing_ok: If True, don't warn when cpuset already exists
         """
         if name is None:
             raise ValueError("cpuset name cannot be None")
@@ -60,8 +67,9 @@ class Cpuset:
 
         # Check if cpuset already exists
         if os.path.exists(path):
-            logger.warning(f"Cpuset '{name}' already exists at {path}")
-            print(f"Warning: cpuset '{name}' already exists at {path}")
+            if not existing_ok:
+                logger.warning(f"Cpuset '{name}' already exists at {path}")
+                print(f"Warning: cpuset '{name}' already exists at {path}")
             self._cpuset_path = path
             return
 
-- 
2.54.0

