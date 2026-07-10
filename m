Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFD33FE0D
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692989; cv=none; b=ASTkzaW4tEIwlXutfcAp0Go76dNZpbFxCvcNXwkXr+zJknJIOneNQ7WzS9Hx7QCXHpK6m48iFJjK2Ouoebmz8n3ZZfTZIR2/7P53lV6HUDGA7u/7a42a1gXiPOpjkSL3kCNnKjoBwVsdQoG+uQN7NCBFfg2Hn9BDmALABSaV9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692989; c=relaxed/simple;
	bh=rIO14qXs+iGT2JJ13ErmypDgUFOGPahQ+QkEqgaw4EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY2xBYdXaqpPqpBj3t/V6LKSNL1A+8LHaM4YeWkXGjd9uoRoNrFmn/UFNpsk29g1JuUtDLMvZZR/E2i8/bg7uu8Ss/Sw7s4wXzJKdxueDHKSa8lZ//AYdPnXqbrdOSZCG1B+QP1dwBeWmWZHjVXgGd/xSbA3GHToYokbHuz/gdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kz/nF2OR; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz/nF2OR"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-735f73287e2so674228137.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692987; x=1784297787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6oflIfduHzeirZwdKe+k+h0Spk/0az2MrVysOXhi4+o=;
        b=kz/nF2ORZNRpQIdYsimtBDITQQ1twY5iA6ETt/B5B8qJOBfCV5sMFrzYyWb7WutgR6
         5TXREd2XbwkmbCcixTLdRK/abfjFQSDe0RQEWAuItz1Soq3hbYXr+vEQ4wtMWICBxBuM
         Kzd2Puca5oNJsc3fJl64Pu3Vh2/1XVA7VNBQpswGmbyO/+3VXxly/y1Sit4b2oxOvsvP
         kSY1JBkoVWX8UlFSSFriyvnPAnRbEBjONluB9Wjw7LEWTYcnVNm97rXXhPp3rR/mREGw
         wsr/uo+MYRXO/VNvpe3iZXVmwp+Ohq4c86nGknCI2ZK1HSNwzAApuPyF3Ao7TF58LrjL
         WJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692987; x=1784297787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oflIfduHzeirZwdKe+k+h0Spk/0az2MrVysOXhi4+o=;
        b=gEgenS+LNairJQnDpyA0lSLSbjVU8LW7j3KPX6Vt78/AEkXx7PmlwTBob2VCy1HHDq
         x+6ftGGs282G4//jqJoQsGzW9YYT/2xclH2gTA2gohbWUChQ8eBe9HvZQKgjxLs/PHtZ
         x46zdWIqUn2Rfj1Z0tEypuw/k7ZiiovSJ4XKGxHPreyEkN1/dWsGpP9btjZ/WKmj2ZfB
         azWOp+Z66r1Ff9jBhEaw6MqCMZPwqvbfaXpWL/1uiKSf6b+1khwZLp1w7DJ2mFmtNEZv
         LUiz6QGW2OCo4nIY3bp9NA9hze61Z23NnOMV0q8O48EzKFp0kDVoAnNaAatO7ZJwSJ3q
         KuFQ==
X-Gm-Message-State: AOJu0YxSP42Nd/N05rXns+44FNtjgwafk79IzowM4c82gOruDZBi7h5U
	0TfE2DLOKyX25qusfSsB2Iw7z54VNVp/I+Dmj6uORRmLq1GTsOa5QHeZxtcxCg==
X-Gm-Gg: AfdE7cl6fz7HsEDxj3XnVEeFEW5ZPCTHaNPP38kMI1FpzWuqEZVXknOonGhaIY3tc3O
	Uvq64h8KNjlUqz5yPu8hHujQVLd1GWZCZ1Bgj0oiTYSSSv1EDefZDXW0kFppmEjms7fhXRlm3zO
	MDZwlLryHnHEGuZSLiLs+TTX2ON2e58xMIGwi6+BCHMU36d7LWjAye9c6KoMYmJ+ZuBKao4mrh9
	2ABFVqjzf6p/+T15LcdOzGzMbChSxuL+f6rbvr09cZYWySlQiZ5K1ex3H3hxrPgYBxm0VFONXZJ
	ujun71YchddcfWZdX4LGny8Z2uZp/UgDPAd+KCLlYjbLdotuo8TpEUZWJ2YUu+gHWwfnrIrNt5G
	RZXYGAfnQs6yfkkh63BAtYHBlXhaF1pYa1TsdZPQX+T3e2AzJbWhF/SN9uRcv2osHOKgq4BBLYd
	DIQKGHIu03iXcMBLSFEwiY5/1JYHMXxmlC57Xd2z3tsZMa/D7xdyKmIr+NluJj+L31cDC16WGLk
	Q==
X-Received: by 2002:a05:6102:2923:b0:6c1:85f8:29b3 with SMTP id ada2fe7eead31-744dff7a44emr7149027137.6.1783692986684;
        Fri, 10 Jul 2026 07:16:26 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:25 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 25/36] tuna: Add --cpuset option to move command
Date: Fri, 10 Jul 2026 10:15:03 -0400
Message-ID: <20260710141523.36440-26-jkacur@redhat.com>
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

Add cpuset integration to the tuna move command, allowing users to move
threads and IRQs into cpusets (cgroup v2) instead of just setting CPU
affinity. This brings cpuset support to tuna's existing rich entity
selection mechanisms (IRQ patterns, thread patterns, sockets, nohz_full).

Changes:
- Add --cpuset option to move command parser (mutually exclusive with
  -c/--cpus, -S/--sockets, -N/--nohz_full)
- Implement cpuset-based move logic for threads and IRQ handler threads
- Verify cpuset exists before attempting to move processes
- Honor process blocklist to protect critical system processes
- Provide success/failure summary output
- Update move command help text to reflect new cpuset capability

Example usage:
  tuna move --cpuset tuna0 -t 1234,5678
  tuna move --cpuset tuna0 -q eth0*
  tuna move --cpuset tuna0 -t systemd*

The --cpuset option cannot be used with the spread command (argparse
enforces mutual exclusion, defensive check remains in code).

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 70 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 557a07891183..b50691fa2d05 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -159,8 +159,8 @@ def gen_parser():
                                     help="Move all allowed threads and IRQs away from CPU-LIST")
     include = subparser.add_parser('include', description="Allow all threads to run on CPU-LIST",
                                      help="Allow all threads to run on CPU-LIST")
-    move = subparser.add_parser('move', description="Move selected entities to CPU-LIST",
-                                    help="Move selected entities to CPU-LIST")
+    move = subparser.add_parser('move', description="Move selected threads/IRQs to specified CPUs, sockets, or cpusets",
+                                    help="Move selected threads/IRQs to specified CPUs, sockets, or cpusets")
     spread = subparser.add_parser('spread', description="Spread selected entities to CPU-LIST",
                                     help="Spread selected entities over CPU-LIST")
     priority = subparser.add_parser('priority', description="Set thread scheduler tunables: POLICY and RTPRIO",
@@ -192,6 +192,7 @@ def gen_parser():
     move_group.add_argument('-c', '--cpus', **MODS['cpus'])
     move_group.add_argument('-S', '--sockets', **MODS['sockets'])
     move_group.add_argument('-N', '--nohz_full', **MODS['nohz_full'])
+    move_group.add_argument('--cpuset', type=str, metavar='CPUSET-NAME', help='Move threads/IRQs into cpuset (cgroup v2) instead of setting CPU affinity')
     move.add_argument('-t', '--threads', **MODS['threads'])
     move.add_argument('-q', '--irqs', **MODS['irqs'])
     move.add_argument('-U', '--no_uthreads', **MODS['no_uthreads'])
@@ -1662,11 +1663,68 @@ def main():
         if not (args.thread_list or args.irq_list):
             parser.error(f"tuna: {args.command} requires a thread/irq list!\n")
 
-        if args.thread_list:
-            tuna.move_threads_to_cpu(args.cpu_list, args.thread_list, args.uthreads, args.kthreads, spread=spread)
+        # Check if using cpuset mode
+        if hasattr(args, 'cpuset') and args.cpuset:
+            # Cpuset mode: move entities to a cpuset instead of setting affinity
+            if spread:
+                print("Error: --cpuset cannot be used with spread command", file=sys.stderr)
+                sys.exit(2)
+
+            # Verify cpuset exists
+            cpuset_path = os.path.join('/sys/fs/cgroup', args.cpuset)
+            if not os.path.exists(cpuset_path):
+                print(f"Error: cpuset '{args.cpuset}' does not exist", file=sys.stderr)
+                sys.exit(1)
+
+            # Create cpuset object
+            try:
+                cs = cpuset.Cpuset(args.cpuset, existing_ok=True)
+            except (OSError, ValueError) as e:
+                print(f"Error accessing cpuset '{args.cpuset}': {e}", file=sys.stderr)
+                sys.exit(1)
+
+            success_count = 0
+            fail_count = 0
+
+            # Move threads to cpuset
+            if args.thread_list:
+                for pid in args.thread_list:
+                    if cs.write_pid(pid):
+                        success_count += 1
+                    else:
+                        fail_count += 1
+
+            # Move IRQ threads to cpuset
+            if args.irq_list:
+                if not ps:
+                    ps = procfs.pidstats()
+                irqs = procfs.interrupts()
+
+                for irq in args.irq_list:
+                    # Find IRQ thread for this IRQ number
+                    irq_re = tuna.threaded_irq_re(irq)
+                    irq_threads = ps.find_by_regex(irq_re)
+
+                    for irq_pid in irq_threads:
+                        if cs.write_pid(irq_pid):
+                            success_count += 1
+                        else:
+                            fail_count += 1
+
+            # Print summary
+            print(f"Moved {success_count} task(s) to cpuset '{args.cpuset}'", end='')
+            if fail_count > 0:
+                print(f" ({fail_count} failed)")
+            else:
+                print()
+
+        else:
+            # Original affinity mode
+            if args.thread_list:
+                tuna.move_threads_to_cpu(args.cpu_list, args.thread_list, args.uthreads, args.kthreads, spread=spread)
 
-        if args.irq_list:
-            tuna.move_irqs_to_cpu(args.cpu_list, args.irq_list, spread=spread)
+            if args.irq_list:
+                tuna.move_irqs_to_cpu(args.cpu_list, args.irq_list, spread=spread)
 
     elif args.command in ['s', 'save']:
         save(args.cpu_list, args.thread_list, args.filename)
-- 
2.54.0

