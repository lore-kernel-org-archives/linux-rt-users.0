Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C743030C
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229039; cv=none; b=acYqGFb3UojMAiU3F0/NX411zhEjyiC5cS1dtwEbn19X9kX3Sm/U1b3orv/s/7DAvDlCw0LgmX3D8KKtjpwKmbaLFavoWvIQQiqkm6FVqK7W92Zn9oNadPeSjFyKdv4DDTxbBQLyeeLDGM7enaeZpf46QrTRtT7I8gJB9QD21cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229039; c=relaxed/simple;
	bh=p8KBzG8+7BIqKs4hKJDa/9R3P6T8jmt8hjg6OPuoC7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZlmwPVoC4e3hZbQ7RnekzyfdD/CLHqC7cRGQihAXo8PD6HUoyM49irT6wiCuAsAhd+RIatiUwkhzsbTqZBQp9LmVoRn2ObHIB/n52P2JSlDurItav6g/mqzAllupMLkkTOQrPzV2pbHxWz8JXa+LK1pZ6EL7nJJv+WE94uotIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNtPDVLS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNtPDVLS"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51bfbe05683so59630111cf.2
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784229036; x=1784833836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ukGt0dIj1lcTTNoIPJtcJzg0t/aQWt057ALxOmtURA=;
        b=iNtPDVLScMp3oO0UBW8QTkJvuBukOA97D3HsUMe3pPEoTJMDWFBSXXbTGJ+TmY1hmU
         c55Id4jsSKqxlVuLewrEUNC/1RmvtDyjeZ0/lpmuUXsGK+IwvzKIW0Z94Xd6cZZ7jttZ
         IclIrRdkS2nbcvtnqCxRB73Z3DRJCoh0Yd5/AyM/5q8kYeqq1qyKeYp5bKO5lLWsIQvS
         9ZTavZu78oW9zxkUdwnN+cy+ndriNaR+1y3sI7bweDfSVTycTAibpG8o6EyL5/js0KAi
         GpwIo8EYJYeLfQOLKHJv/XGYJJKD0+8QgHYPJATPRCbXnx91C8i4lVFDVCf8KIcDhXkE
         thOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784229036; x=1784833836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ukGt0dIj1lcTTNoIPJtcJzg0t/aQWt057ALxOmtURA=;
        b=Vyn40Jbuss1P6g4KRdLVVHRIzgMk5KA7IeK1ecGrrVrsYpg3pAYlks49+V4CS76fW9
         5xcRG8k/HZ/zD4lW0lHveA5d7C6GwmHoEtsv+H09ch0k2z9br8fSkjYeE/7XgKvfKbda
         QRt4OjuRTzta4FSmnhfB3vQ0Os2VwSS6HzO6eDuasleX8wKbxR39dNO+qGIcbb1fNaoG
         Lseu4Aqh/7qsHxbtsl3IZBVxhrQVqkcSWskBI0m7ZBveQ195EqfsCp9isTnoVzVG8JzL
         7f/aqlsipdVY99xkHW43GjEHq7tBEbyazAW6eObnU9pUMkYTFX21vEDsFMTj210TDvA3
         LmRQ==
X-Gm-Message-State: AOJu0Yy8Ar+cu5BUZvn8dSCfgadC76kOImmhv9LR03g7G5w2DndqAOI/
	EV5Pgs8P3OW/igkayZzSOHJRMY7rvcMc1ydHxiF9vKJxzrIj1Lp7sPIPf+hn3w==
X-Gm-Gg: AfdE7cnpZqOKOY09sxVSKaju2fXUGmAcipZDTLyMvhpu4X5s8Vu6EpcDaVfZVV+NXuc
	r7uFHSwaREB5zHM0Q1DsJZPQ+ssr0Hg5f3HQ5IC3P8Nh82VW6F7M554VcZMXyOV74UUH6c2MOjX
	wjoVKtA5Emdt/95W4h0K7UsWFbHAC8zScoVkUfkAOwYTB2To9C/EMAtnmUzb96Rid1YiXdjpyY1
	bF1lQrFUrwwuadC2jP7ywokYYwGdEQfe3sjSkdQ9EHzep2hVW8ETECcENVCfYWUoyLXHcqXB0iy
	J+Ktvb7AjOX7Fzkz3KImQvk0Dv3dNJWLeUHZli1EhGBifeYdywGJidbQmy87eh0OHyBNVYBIKgR
	pKBrUAgyCBA35nsfDCzMZrUO8eAv7AEfWz89oMrScAOAqMA2sZFA+JoV0SvHTdhBal4cJ4V+14O
	1i9Z8cztMksirYxu8Dl2FnIPNHEEbCMOIfUhlPUV8vvcYSvw+xAOduSF2bhxdvyiStsR2crLlng
	9wEPeGb0ycQQH0TAGKZBs1BNLWJKExAkYecDJIKny3NRDlYKTnDhDkjVTB2
X-Received: by 2002:a05:622a:15d3:b0:51c:14f5:8f9c with SMTP id d75a77b69052e-51e3c1ce153mr152419001cf.27.1784229036094;
        Thu, 16 Jul 2026 12:10:36 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6ed34sm158236771cf.4.2026.07.16.12.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:10:35 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 2/3] tuna: Allow cpuset destroy to accept multiple names
Date: Thu, 16 Jul 2026 15:10:27 -0400
Message-ID: <20260716191028.152934-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716191028.152934-1-jkacur@redhat.com>
References: <20260716191028.152934-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changed 'tuna cpuset destroy' to accept multiple cpuset names in a single
command, improving usability and consistency with other commands.

Previous behavior:
  tuna cpuset destroy NAME          # Single cpuset only
  tuna cpuset destroy --pattern '*' # Multiple via pattern

New behavior:
  tuna cpuset destroy NAME1 NAME2 NAME3  # Multiple by name
  tuna cpuset destroy --pattern '*'      # Multiple via pattern (unchanged)

This change makes the command more flexible and allows users to destroy
specific cpusets without needing to use pattern matching. The implementation
changed the 'name' argument from nargs='?' to 'names' with nargs='*', and
updated the handler function to iterate over the list.

Also added parser_class=HelpMessageParser to subparsers to improve error
message context (though argparse still shows top-level help for some
unrecognized argument errors due to internal behavior).

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index ae02f2d50936..d2ba0238ab28 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -149,7 +149,7 @@ def gen_parser():
     parser.add_argument('-D', '--debug', **MODS['debug'])
     parser.add_argument('-w', '--warn', **MODS['warn'])
 
-    subparser = parser.add_subparsers(dest='command')
+    subparser = parser.add_subparsers(dest='command', parser_class=HelpMessageParser)
 
     idle_set = subparser.add_parser('cpu_power',
                                     description='Manage CPU idle state disabling (requires libcpupower and it\'s Python bindings)',
@@ -265,7 +265,7 @@ def gen_parser():
     gui.add_argument('-K', '--no_kthreads', **MODS['no_kthreads'])
 
     # Cpuset nested subcommands
-    cpuset_subparser = cpuset.add_subparsers(dest='cpuset_command', required=True)
+    cpuset_subparser = cpuset.add_subparsers(dest='cpuset_command', required=True, parser_class=HelpMessageParser)
 
     # cpuset create
     cpuset_create = cpuset_subparser.add_parser('create', description='Create a new cpuset', help='Create a new cpuset')
@@ -285,7 +285,7 @@ def gen_parser():
 
     # cpuset destroy
     cpuset_destroy = cpuset_subparser.add_parser('destroy', description='Destroy cpuset(s)', help='Destroy cpuset(s)')
-    cpuset_destroy.add_argument('name', nargs='?', type=str, metavar='NAME', help='Cpuset name to destroy (use this OR --pattern)')
+    cpuset_destroy.add_argument('names', nargs='*', type=str, metavar='NAME', help='Cpuset name(s) to destroy (one or more, OR use --pattern)')
     cpuset_destroy.add_argument('-p', '--pattern', type=str, metavar='PATTERN', help='Glob pattern to destroy multiple cpusets (e.g., tuna*)')
     cpuset_destroy.add_argument('-f', '--force', action='store_true', help='Migrate tasks to root cgroup before destroying')
     cpuset_destroy.add_argument('--include-empty', action='store_true', help='When using --pattern, include cpusets with no CPUs assigned (default: skip empty)')
@@ -1140,12 +1140,12 @@ def cpuset_list(pattern, verbose, show_empty, show_system, recursive):
         print("This may indicate a problem with blocklist protection.", file=sys.stderr)
 
 
-def cpuset_destroy(name, pattern, force, include_empty, recursive):
+def cpuset_destroy(names, pattern, force, include_empty, recursive):
     """Handler for 'tuna cpuset destroy' command.
 
     Args:
-        name: Cpuset name to destroy (single cpuset, mutually exclusive with pattern)
-        pattern: Glob pattern for cpusets to destroy (mutually exclusive with name)
+        names: List of cpuset names to destroy (mutually exclusive with pattern)
+        pattern: Glob pattern for cpusets to destroy (mutually exclusive with names)
         force: If True, migrate tasks to root before destroying
         include_empty: If True, include cpusets with no CPUs assigned (default: skip empty, only used with pattern)
         recursive: If True, find and clean nested cpusets (only used with pattern)
@@ -1156,19 +1156,20 @@ def cpuset_destroy(name, pattern, force, include_empty, recursive):
         print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
         sys.exit(1)
 
-    # Validate: must have either name OR pattern, not both, not neither
-    if name and pattern:
-        print("Error: specify either NAME or --pattern, not both", file=sys.stderr)
+    # Validate: must have either names OR pattern, not both, not neither
+    if names and pattern:
+        print("Error: specify either NAME(s) or --pattern, not both", file=sys.stderr)
         sys.exit(2)
-    if not name and not pattern:
-        print("Error: must specify either NAME or --pattern", file=sys.stderr)
+    if not names and not pattern:
+        print("Error: must specify either NAME(s) or --pattern", file=sys.stderr)
         sys.exit(2)
 
     try:
-        if name:
-            # Single cpuset destroy (include_empty not applicable)
-            cpuset.destroy_cpuset(name, force=force)
-            print(f"Destroyed cpuset '{name}'")
+        if names:
+            # Destroy specified cpusets by name (one or more)
+            for name in names:
+                cpuset.destroy_cpuset(name, force=force)
+                print(f"Destroyed cpuset '{name}'")
         else:
             # Pattern-based cleanup
             if not include_empty:
@@ -1879,7 +1880,7 @@ def main():
             cpuset_list(args.pattern, args.verbose, args.show_empty, args.show_system, args.recursive)
 
         elif args.cpuset_command == 'destroy':
-            cpuset_destroy(args.name, args.pattern, args.force, args.include_empty, args.recursive)
+            cpuset_destroy(args.names, args.pattern, args.force, args.include_empty, args.recursive)
 
         elif args.cpuset_command == 'move':
             cpuset_move(args.name, args.thread_list, args.pid_list)
-- 
2.55.0

