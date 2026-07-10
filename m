Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938133438A1
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693006; cv=none; b=dUMUFWcCj9lbiG6WyVoRmJJg/BqmTlYcrZ3EpTzW2Nosmd7ngEC25sNN+Ku9vVjgeOAWEyWwE+HbASw4hm3qx6ec/WQSUmtU200t2g4/MpKDAyBcsNG9v4Pu09/Ro6r3xNsoh+Qc1IKfYFttRcgd9BhKCx+wawQudm6xWnqbhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693006; c=relaxed/simple;
	bh=cQR07l6HsNNPsjCttQrvxL3DjOjUoVRUvOEbb8dItdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q55MC9znyEwqyJlFNQhrE13wVM8inrZfkup6YlLfBr4CKdlbfKYVJGpMzpCoEq9yE1RKqReWO+4w/JGj8ymPnBZhUBwg9cfCmNjQqX+aVQ3cYc/707/hTpJcaIK+YmZBAUu/MMp/PEiESg82uTunxkVjitCaIIaFZTxuhAHoXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiXr0hn0; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiXr0hn0"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-725cf9a923aso847470137.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783693003; x=1784297803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYraBPO+52irO9yAiDZd2zrSpdTmr6/L2IUjKhpOIcc=;
        b=GiXr0hn0+FHZu3ndlHO7iGdx3MyD3vnWJlyzmVr3U/VDQ+MdQM8oM3KW/EWAbEdgxK
         KOA+lmjykRVK3/sBsxsDKih8L0Zx1va3bGirXukuTJ2Eq1IGonqOGH8SCELuxv7TKzgm
         YL2kUL0SvU/VjpdsAKJyOOdW7izXqdRWFwr38L89rrj5USxYpMXCgn8stJXjShQC+75b
         7jBRwWesg+r/oSxMUYPZwfDtNyhrTTlYbt7ZdLb3V4Zx3O31v4HjumZxinbK6uJ+vR7L
         hM/GTULeiqxyuFXIJJgWCSfmM3zTnUwcSMdxa/mqT6y8YDZXA+MYOr1eypSMXv406Jnl
         LeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693003; x=1784297803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYraBPO+52irO9yAiDZd2zrSpdTmr6/L2IUjKhpOIcc=;
        b=DxjUFsjTgAxKxTMdJcpWJVRL88tTWy/Ay5XBL37kpMjMt0R1Fd8QDw63qcak4pwmra
         cKWsnLv0eViwLcqLF0PIFLVsIor4mT7JmUriVVf5iJ6CLsXnTU5r2z9wnzUPM7dPHiJu
         NvHlNyuyW7xNZNkWlQxyjwDZ5QnBO/uMtkdcHNcQYTYriZxmx+yGeox1hhELJ28EiXle
         zksOJKylr5xUcDlpV9A/3SdHan5jvzTRpS56MKbwHpKFpA5n/2rRHCANfPo1neqcNI/6
         rw+Qqrfx3n0OK//rDy+sFsOH66OG+eGPxaRcrOlExPodL35IdIWmaoCDURcQLdGgaWVh
         zPow==
X-Gm-Message-State: AOJu0YyMLfuZGXGnnzUj6zuzXWlvSbqvdrmoK4DMTYUQcVBHXAY5yc36
	qytUDg8jV6k16DwF4cQBFjv3QvyRMtZnhRooNaGkBpbbbDhzW/bQVtW+WLgL3w==
X-Gm-Gg: AfdE7cnVdTGKD+3DhdsrbFp086RSekLrICMpe7cxeje6yPZlzbx17ZvpOnyvmncp9W0
	dsDlH3Yuf4qjWyNlhmqZ+F1R2kUlKYMZwp65++9UQ6KcSLVbtniKl+UCfDPuYszYqzJvAciDzY1
	9Uu2X4bEiR2dBJvqqwruT1DOhus6o4u2YcwnbdIEjoZ0O1KczN/3z+D7dy3crk1v3AX0cyYyid9
	CwfHNoedHFuFpleosk3EupguaASjXoyhx/Mld5c0/IOpFtA9N7bINp9sZ5WcFCsR5oGOoemdyJY
	yAer7X3DmTcbv2QmdO03MXBlQEOS3hoSy5zjNp77STKTqkzcYdxNOItBRr+C2YZkeBqHKVDs/Hc
	xK4BIwT0Ue6NJZ/WkMXud+QUA0uBnrbfNBX3n0kGCJ6D64ZmPz9hgQwhfolDtNdaQdPhlJ31E38
	h960Uou88fq6tfIZzlMpSuKc8C0IRkZm6DDiscrRuBvK5NhQ98sA80cNUoTqcRCxfVRZ+8wBSsN
	A==
X-Received: by 2002:a05:6102:2920:b0:71e:39e9:ce5a with SMTP id ada2fe7eead31-744dfff5163mr8419481137.26.1783693003339;
        Fri, 10 Jul 2026 07:16:43 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:42 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 36/36] tuna: Update man page for cpusets and current functionality
Date: Fri, 10 Jul 2026 10:15:14 -0400
Message-ID: <20260710141523.36440-37-jkacur@redhat.com>
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

The man page (docs/tuna.8) was last updated in February 2010 and was
missing documentation for cpuset features and other recent additions.

This update brings the documentation current with the codebase:

Documentation structure changes:
- Updated date from February 2010 to July 2026
- Added SPDX-License-Identifier: GPL-2.0-only header
- Updated description to mention cgroup v2 cpusets support

Global options:
- Added missing -w/--warn flag documentation

Command updates with cpuset support:
- isolate: Added --cpuset and --cpuset-housekeeping options
- move: Added --cpuset option, -U/--no_uthreads, -K/--no_kthreads flags
- spread: Added -U/--no_uthreads, -K/--no_kthreads flags
- run: Added --cpuset option for running commands in cpusets
- show_threads: Added --cpuset filter option and -n/--show_sockets
  with inet_diag module requirement note

Cpuset command documentation:
- Added complete cpuset command section with all 7 subcommands:
  * create: Create cpusets with CPU/memory node assignment
  * list: List cpusets with pattern matching
  * destroy: Destroy cpusets with pattern support
  * move: Move processes to cpusets
  * show: Display detailed cpuset information
  * status: System-wide cpuset overview
  * modify: Modify existing cpusets (add/remove CPUs, change partition)

Modifiers section:
- Added -q/--irqs documentation

Usage examples:
- Added comprehensive cpuset examples demonstrating isolation,
  process migration, and cpuset management workflows

All documentation now accurately reflects the current implementation
as verified by comparing against actual command-line help output.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 docs/tuna.8 | 201 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 190 insertions(+), 11 deletions(-)

diff --git a/docs/tuna.8 b/docs/tuna.8
index 8c15c2ef535c..8d43c3ac73c8 100644
--- a/docs/tuna.8
+++ b/docs/tuna.8
@@ -1,4 +1,5 @@
-.TH TUNA "8" "February 2010" "tuna" "System Administration Utilities"
+.\" SPDX-License-Identifier: GPL-2.0-only
+.TH TUNA "8" "July 2026" "tuna" "System Administration Utilities"
 .SH NAME
 tuna \- program for tuning running processes
 .SH SYNOPSIS
@@ -6,8 +7,8 @@ tuna \- program for tuning running processes
 [\fIOPTIONS\fR]
 .SH DESCRIPTION
 This manual page explains the \fBtuna\fR program. The program can be used to change the attributes of application and kernel threads. \fBtuna\fR can operate on IRQs by name or number, and tasks or threads by process ID or command-line. CPUs and sets of CPUs can be specified by CPU or socket number. IRQ names and process command-lines can include wildcards.
-.PP 
-\fBtuna\fP can change scheduling policy, scheduler priority and processor affinity for processes and process threads. \fBtuna\fR can also change the processor affinity for interrupts.
+.PP
+\fBtuna\fP can change scheduling policy, scheduler priority and processor affinity for processes and process threads. \fBtuna\fR can also change the processor affinity for interrupts. \fBtuna\fR supports cgroup v2 cpusets for CPU and memory node isolation, providing fine-grained control over which processes can run on which CPUs.
 When \fBtuna\fR is invoked without any options it starts up in its graphical interface mode. This manual page explains only the command\-line options for \fBtuna\fR
 .SH "GLOBAL OPTIONS"
 .TP
@@ -22,6 +23,9 @@ Log application details to file for given LOG-LEVEL
 .TP
 \fB\-D\fR, \fB\-\-debug\fR
 Print DEBUG level logging details to console
+.TP
+\fB\-w\fR, \fB\-\-warn\fR
+Warn when thread/IRQ patterns match nothing
 .SH "COMMANDS"
 .TP
 \fBtuna cpu_power\fR
@@ -44,6 +48,7 @@ optional arguments:
 .TP
 \fBtuna isolate\fR
 usage: tuna-cmd.py isolate [-h] (-c CPU-LIST | -S CPU-SOCKET-LIST | -N)
+                           [--cpuset [NAME]] [--cpuset-housekeeping ...]
 
 Move all allowed threads and IRQs away from CPU\-LIST. Requires \fB\-c\fR, \fB-S\fR, or \fB-N\fR.
 
@@ -55,6 +60,11 @@ optional arguments:
                         CPU-SOCKET-LIST affected by commands
   -N, --nohz_full       CPUs in nohz_full kernel command line will be affected
                         by operations
+  --cpuset [NAME]       Use cpusets for isolation with optional name (default: tuna_isolated,
+                        partition=isolated)
+  --cpuset-housekeeping [NAME] CPU-LIST
+                        Create housekeeping cpuset: [NAME] CPU-LIST (default name:
+                        tuna_housekeeping, partition=isolated)
 .TP
 \fBtuna include\fR
 usage: tuna-cmd.py include [-h] (-c CPU-LIST | -S CPU-SOCKET-LIST | -N)
@@ -71,10 +81,10 @@ optional arguments:
                         by operations
 .TP
 \fBtuna move\fR
-usage: tuna-cmd.py move [-h] (-c CPU-LIST | -S CPU-SOCKET-LIST | -N)
-                        [-t THREAD-LIST] [-q IRQ-LIST]
+usage: tuna-cmd.py move [-h] (-c CPU-LIST | -S CPU-SOCKET-LIST | -N | --cpuset CPUSET-NAME)
+                        [-t THREAD-LIST] [-q IRQ-LIST] [-U] [-K]
 
-Move selected entities to CPU\-LIST. Requires \fB\-c\fR, \fB-S\fR, or \fB-N\fR and \fB-t\fR or \fB-q\fR.
+Move selected entities to CPU\-LIST or cpuset. Requires \fB\-c\fR, \fB-S\fR, \fB-N\fR, or \fB--cpuset\fR and \fB-t\fR or \fB-q\fR.
 
 optional arguments:
   -h, --help            show this help message and exit
@@ -84,18 +94,21 @@ optional arguments:
                         CPU-SOCKET-LIST affected by commands
   -N, --nohz_full       CPUs in nohz_full kernel command line will be affected
                         by operations
+  --cpuset CPUSET-NAME  Move threads/IRQs into cpuset (cgroup v2) instead of
+                        setting CPU affinity
   -t THREAD-LIST, --threads THREAD-LIST
                         THREAD-LIST affected by commands
   -q IRQ-LIST, --irqs IRQ-LIST
                         IRQ-LIST affect by commands
+  -U, --no_uthreads     Operations will not affect user threads
+  -K, --no_kthreads     Operations will not affect kernel threads
 .TP
 \fBtuna spread\fR
 usage: tuna-cmd.py spread [-h] (-c CPU-LIST | -S CPU-SOCKET-LIST | -N)
-                          [-t THREAD-LIST] [-q IRQ-LIST]
+                          [-t THREAD-LIST] [-q IRQ-LIST] [-U] [-K]
 
 Spread selected entities over CPU-LIST. The specified threads and IRQs are each assigned to one cpu in CPU-LIST. Requires \fB\-c\fR, \fB-S\fR, or \fB-N\fR and \fB-t\fR or \fB-q\fR.
 
-
 optional arguments:
   -h, --help            show this help message and exit
   -c CPU-LIST, --cpus CPU-LIST
@@ -108,6 +121,8 @@ optional arguments:
                         THREAD-LIST affected by commands
   -q IRQ-LIST, --irqs IRQ-LIST
                         IRQ-LIST affect by commands
+  -U, --no_uthreads     Operations will not affect user threads
+  -K, --no_kthreads     Operations will not affect kernel threads
 .TP
 
 \fBtuna priority\fR
@@ -126,11 +141,11 @@ optional arguments:
                         Operation will affect children threads
 .TP
 \fBtuna run\fR
-usage: tuna-cmd.py run [-h] [-c CPU-LIST | -S CPU-SOCKET-LIST | -N]
+usage: tuna-cmd.py run [-h] [-c CPU-LIST | -S CPU-SOCKET-LIST | -N | --cpuset CPUSET-NAME]
                        [-p PRIORITY] [-b]
                        COMMAND
 
-Run the COMMAND. The entire command line must be provided inside "quotes". Modifiers \fB-c\fR, \fB-S\fR and \fB-p\fR can be used to set the affinity and scheduler tunables of the given COMMAND.
+Run the COMMAND. The entire command line must be provided inside "quotes". Modifiers \fB-c\fR, \fB-S\fR, \fB--cpuset\fR and \fB-p\fR can be used to set the affinity and scheduler tunables of the given COMMAND.
 
 positional arguments:
   COMMAND               fork a new process and run the "COMMAND"
@@ -143,6 +158,8 @@ optional arguments:
                         CPU-SOCKET-LIST affected by commands
   -N, --nohz_full       CPUs in nohz_full kernel command line will be affected
                         by operations
+  --cpuset CPUSET-NAME  Run process in specified cpuset (cgroup v2) instead of
+                        setting CPU affinity
   -p PRIORITY, --priority PRIORITY
                         Set thread scheduler tunables: POLICY and RTPRIO
   -b, --background      Run command as background task
@@ -184,7 +201,7 @@ optional arguments:
 \fBtuna show_threads\fR
 usage: tuna-cmd.py show_threads [-h] [-c CPU-LIST | -N | -S CPU-SOCKET-LIST]
                                 [-t THREAD-LIST | -q IRQ-LIST] [-U] [-K] [-C]
-                                [-G]
+                                [-n] [-G] [--cpuset CPUSET-NAME] [-z]
 
 Show thread list
 
@@ -204,8 +221,10 @@ optional arguments:
   -K, --no_kthreads     Operations will not affect kernel threads
   -C, --affect_children
                         Operation will affect children threads
+  -n, --show_sockets    Show network sockets in use by threads (requires inet_diag module)
   -G, --cgroups         Display the processes with the type of cgroups they
                         are in
+  --cpuset CPUSET-NAME  Show only threads in the specified cpuset
   -z, --spaced          Display spaced view for cgroups
 
 .TP
@@ -267,6 +286,124 @@ optional arguments:
                         CPU-SOCKET-LIST affected by commands
   -U, --no_uthreads     Operations will not affect user threads
   -K, --no_kthreads     Operations will not affect kernel threads
+.TP
+\fB tuna cpuset\fR
+usage: tuna-cmd.py cpuset [-h] {create,list,destroy,move,show,status,modify}
+
+Manage CPU sets (cgroup v2). Cpusets provide fine-grained control over which CPUs processes can run on, with NUMA-aware memory node assignment and kernel-enforced isolation.
+
+subcommands:
+  {create,list,destroy,move,show,status,modify}
+
+.B tuna cpuset create
+usage: tuna-cmd.py cpuset create [-h] -c CPU-LIST [-n NAME] [-i]
+                                 [-m MEM-NODES]
+
+Create a new cpuset with specified CPUs. Memory nodes are auto-detected from CPU topology unless specified manually.
+
+required arguments:
+  -c CPU-LIST, --cpus CPU-LIST
+                        CPU-LIST to assign to the cpuset
+
+optional arguments:
+  -h, --help            show this help message and exit
+  -n NAME, --name NAME  Cpuset name (default: auto-generate tunaN)
+  -i, --isolated        Set CPU partition to isolated (kernel-enforced exclusivity)
+  -m MEM-NODES, --memory-nodes MEM-NODES
+                        Memory nodes (default: auto-detect from CPUs, e.g., "0" or "0-1")
+
+.B tuna cpuset list
+usage: tuna-cmd.py cpuset list [-h] [-p PATTERN] [-v] [--show-empty]
+                               [--no-recursive]
+
+List cpusets. By default, empty cpusets (no CPUs assigned) are skipped.
+
+optional arguments:
+  -h, --help            show this help message and exit
+  -p PATTERN, --pattern PATTERN
+                        Filter by glob pattern (e.g., tuna*)
+  -v, --verbose         Show detailed information (CPUs, tasks, partition type)
+  --show-empty          Include cpusets with no CPUs assigned (default: skip empty)
+  --no-recursive        Only search top-level cpusets
+
+.B tuna cpuset destroy
+usage: tuna-cmd.py cpuset destroy [-h] [NAME] [-p PATTERN] [-f]
+                                  [--include-empty] [--no-recursive]
+
+Destroy cpuset(s). Use either NAME or --pattern, not both.
+
+positional arguments:
+  NAME                  Cpuset name to destroy (use this OR --pattern)
+
+optional arguments:
+  -h, --help            show this help message and exit
+  -p PATTERN, --pattern PATTERN
+                        Glob pattern to destroy multiple cpusets (e.g., tuna*)
+  -f, --force           Migrate tasks to root cgroup before destroying
+  --include-empty       When using --pattern, include cpusets with no CPUs assigned
+  --no-recursive        Only destroy top-level cpusets when using --pattern
+
+.B tuna cpuset move
+usage: tuna-cmd.py cpuset move [-h] [-t THREAD-LIST] [-p PID-LIST] NAME
+
+Move processes to a cpuset
+
+positional arguments:
+  NAME                  Cpuset name to move processes to
+
+optional arguments:
+  -h, --help            show this help message and exit
+  -t THREAD-LIST, --threads THREAD-LIST
+                        THREAD-LIST affected by commands (supports patterns)
+  -p PID-LIST, --pids PID-LIST
+                        Comma-separated list of PIDs to move
+
+.B tuna cpuset show
+usage: tuna-cmd.py cpuset show [-h] [--show-tasks] NAME
+
+Show detailed information about a cpuset
+
+positional arguments:
+  NAME           Cpuset name to show
+
+optional arguments:
+  -h, --help     show this help message and exit
+  --show-tasks   Show detailed list of tasks/processes
+
+.B tuna cpuset status
+usage: tuna-cmd.py cpuset status [-h] [-p PATTERN] [--show-empty]
+                                 [--no-recursive]
+
+Show system-wide cpuset overview with statistics
+
+optional arguments:
+  -h, --help            show this help message and exit
+  -p PATTERN, --pattern PATTERN
+                        Filter by glob pattern (e.g., tuna*)
+  --show-empty          Include cpusets with no CPUs assigned (default: skip empty)
+  --no-recursive        Only show top-level cpusets
+
+.B tuna cpuset modify
+usage: tuna-cmd.py cpuset modify [-h] [--add-cpus CPU-LIST]
+                                 [--remove-cpus CPU-LIST] [-m MEM-NODES]
+                                 [--isolated | --no-isolated]
+                                 NAME
+
+Modify an existing cpuset without destroying it
+
+positional arguments:
+  NAME                  Cpuset name to modify
+
+optional arguments:
+  -h, --help            show this help message and exit
+  --add-cpus CPU-LIST   CPUs to add to the cpuset (e.g., 4-7 or 4,5,6,7)
+  --remove-cpus CPU-LIST
+                        CPUs to remove from the cpuset (e.g., 0-1 or 0,1)
+  -m MEM-NODES, --memory-nodes MEM-NODES
+                        Set memory nodes (e.g., "0" or "0-1")
+  --isolated            Set CPU partition to isolated
+  --no-isolated         Set CPU partition to member (not isolated)
+
 .IP \fIModifiers\fR
 .TP
 \fB\-c\fR, \fB\-\-cpus\fR=\fICPU\-LIST\fR
@@ -278,7 +415,10 @@ CPU\-SOCKET\-LIST affected by commands. Requires a socket number or a comma-sepa
 \fB\-t\fR, \fB\-\-threads\fR=\fITHREAD\-LIST\fR
 THREAD\-LIST affected by commands. Requires a thread number or thread name, or a comma-separated list of thread numbers and/or names. Thread names may contain wildcards. Be sure to quote or escape any wildcard specifications.
 .TP
+\fB\-q\fR, \fB\-\-irqs\fR=\fIIRQ\-LIST\fR
+IRQ\-LIST affected by commands. Requires an IRQ number or IRQ user name, or a comma-separated list of IRQ numbers and/or user names. IRQ user names may contain wildcards. Be sure to quote or escape any wildcard specifications.
 .SH USAGE EXAMPLES
+.SS CPU Affinity Examples
 If for instance the Ethernet NICs have multiple queues for both receive and transmit, each with its own IRQ, the Ethernet IRQs can be associated with a CPU socket:
 .TP
 .B tuna isolate -S 2
@@ -286,3 +426,42 @@ If for instance the Ethernet NICs have multiple queues for both receive and tran
 .B tuna spread -q 'eth*' -S 2
 
 Move everything off the CPUs in socket 2, then spread the IRQs for the Ethernet devices across those same CPUs.
+
+.SS Cpuset Examples
+Create an isolated cpuset for real-time workloads:
+.TP
+.B tuna cpuset create -c 2-5 -n rt_workload -i
+
+Create a cpuset named 'rt_workload' with CPUs 2-5, set to isolated partition. Memory nodes are auto-detected from CPU topology.
+
+.TP
+.B tuna run --cpuset rt_workload -p FIFO:80 'my_rt_app'
+
+Launch a real-time application in the rt_workload cpuset with FIFO scheduler and priority 80.
+
+.TP
+Isolate CPUs using cpusets (more powerful than traditional affinity):
+.TP
+.B tuna isolate -c 4-7 --cpuset my_isolated --cpuset-housekeeping my_hk 0-3
+
+Isolate CPUs 4-7 by creating 'my_isolated' cpuset with kernel-enforced exclusivity, and move all existing processes to 'my_hk' cpuset on CPUs 0-3. Both cpusets use partition=isolated for kernel enforcement.
+
+.TP
+.B tuna move --cpuset rt_workload -t 'kworker/*'
+
+Move all kworker threads to the rt_workload cpuset.
+
+.TP
+.B tuna show_threads --cpuset rt_workload
+
+Show only processes running in the rt_workload cpuset.
+
+.TP
+.B tuna cpuset modify rt_workload --add-cpus 6-7
+
+Add CPUs 6-7 to the rt_workload cpuset without disrupting running processes.
+
+.TP
+.B tuna cpuset status
+
+Display system-wide overview of all cpusets with statistics.
-- 
2.54.0

