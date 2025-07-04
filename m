Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6F2F94A7
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635681; cv=none; b=KTM4VsVEmbgn1PLsMUMUWTfokFhKHN1pPNlIb5wTh0qklRBBdRK0pHjfLPOTspCkaNMIarxzu4PMTj8dPGNxYmr6jp7WHQbl46lT4tsrzrco+HS2u3x8s9Bcx/RIuJIhyb/h/AFeapwSd8rJkYzNxHFYkKdA4xPv77F1keh6k14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635681; c=relaxed/simple;
	bh=Z9JHGTSh4TuOKwZ7i8eRPaG8r88FaU/Ky7kAMWuUBBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoG5wd5mD9iLakNB+S5cmS4wS5GZVOoXetbze+nHvTEh3CsDIEELi6PvIDIQ8XUNhNuxBkY8O6PX8I9hpNhmZBWwYC+4pqS1H14MfJ72SLp7LArc5GENRHtwqhUR21WjPuVx53kJDW9lc0mFMWkv1457KqxZWn5YE3+EOtTHD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j7U1ls5Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eca20M1X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j7U1ls5Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eca20M1X"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZXzcmmM+Typq8EHH6XckQRro1IQjG1Sg4HgdjE87O8=;
	b=j7U1ls5QWKhtjyAsvOcMv8kH+n4jXtE0dHhR8s7tBhePKa8BCohEVvQEpHghCmYMj8+r2F
	BdGyvWX9fGNiLVPfSi+y+qnTwVP4buD4j0M49QvqjKTh7VOp3NmU16JSCvw+lCPG/HXOxL
	HfW4oooK77nj/8MooYKx74EdUo7RQ1DE4vMlJMvsPYA2+qmflu9492198d3dGHHaVny5nH
	DcfL/s7PIui3ksr18GijbTWqjonNSmF3nP55v70cjX6ZN0rKSip/nyPgSzXC9+wI8BQVRJ
	2vsITcqCwRf4jY+bQvyNTh4rn1bJuLHA7KwaKF4w97GPKZJIloUtYr/dpfzVpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZXzcmmM+Typq8EHH6XckQRro1IQjG1Sg4HgdjE87O8=;
	b=eca20M1XAgE0vQTgZqemzO2S7A8Pv6k9xbf+rfasvFuSyXbm9eSaYtreC7I/zJSuwSPtaK
	WgWeYFsLSoT2hYDQ==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 09/28] cyclictest.8: Separate source sections
Date: Fri,  4 Jul 2025 15:27:02 +0200
Message-ID: <20250704132721.13325-10-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Further work will significantly expand the cyclictest's parameter
documentation.  Improve the manpage's source readability by separating
its different sections with newlines.

Per groff_man_style(7), use groff's empty request (.) for this vertical
spacing as blank lines shouldn't exist in a manpage source file.
Authoritative manpages like groff_man(7) is also written this way.

No output change, as verified before and after by
"man ./cyclictest.8 | md5sum".

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 47 +++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 6bf983d..f27fe66 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -1,19 +1,22 @@
 .\" SPDX-License-Identifier: GPL-2.0-only
 .\" For a man pages tutorial, check groff_man_style(7)
 .TH CYCLICTEST 8 "April 22, 2016"
+.
 .SH NAME
 cyclictest \- High resolution test program
+.
 .SH SYNOPSIS
 .SY cyclictest
 .RI "[ \-fmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
 [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
 [\-p " prio " ] [\-t " num " ] [\-D " time " ]"
-
+.
 .SH OPTIONS
 These programs follow the usual GNU command line syntax, with long
 options starting with two dashes ('\-\-').
 .br
 A summary of options is included below.
+.
 .TP
 .B \-a, \-\-affinity[=PROC-SET]
 Run threads on the set of processors given by PROC-SET.  If PROC-SET is not
@@ -28,12 +31,15 @@ as shown in the
 field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU
 sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma
 v1, PROC-SET, if specified, must be a single CPU number.
+.
 .TP
 .B \-A, \-\-align=USEC
 Align thread wakeups to a specific offset in microseconds
+.
 .TP
 .B \-b, \-\-breaktrace=USEC
 Send break trace command when latency > USEC
+.
 .TP
 .B \-c, \-\-clock=CLOCK
 select clock
@@ -41,155 +47,192 @@ select clock
 0 = CLOCK_MONOTONIC (default)
 .br
 1 = CLOCK_REALTIME
+.
 .TP
 .B \-\-deepest\-idle\-state=n
 Reduce exit from idle latency by limiting idle state up to n on used cpus
 (-1 disables all idle states). Power management is not suppresed on other
 cpus.
+.
 .TP
 .B \-\-default\-system
 Don't attempt to tune the system from cyclictest. Power management is not
 suppressed. This might give poorer results, but will allow you to discover
 if you need to tune the system.
+.
 .TP
 .B \-d, \-\-distance=DIST
 Distance of thread intervals in us, default = 500
+.
 .TP
 .B \-D, \-\-duration=TIME
 Specify a length for the test run.
 .br
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
+.
 .TP
 .B \-F, \-\-fifo=<path>
 Create a named pipe at path and write stats to it
+.
 .TP
 .B \-h, \-\-histogram=US
 Dump latency histogram to stdout after the run. US is the max latency time
 to be be tracked in microseconds. This option runs all threads at the same
 priority.
+.
 .TP
 .B \-H, \-\-histofall=MAXLATENCYINUS
 Same as -h except that an additional histogram column is displayed at the
 right that contains summary data of all thread histograms. If cyclictest
 runs a single thread only, the -H option is equivalent to -h.
+.
 .TP
 .B \-\-histfile=<path>
 Dump the latency histogram to <path> instead of stdout.
+.
 .TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is
 1000us). This sets the interval of the first thread. See also \-d.
+.
 .TP
 .B \-\-json=FILENAME
 Write final results into FILENAME, JSON formatted.
+.
 .TP
 .B \-\-laptop
 Save battery when running cyclictest. This will give you poorer realtime
 results, but will not drain your battery so quickly.
+.
 .TP
 .B \-\-latency=PM_Q0S
 power management latency target value. This value is written to
 /dev/cpu_dma_latency and affects c-states. The default is 0
+.
 .TP
 .B \-l, \-\-loops=LOOPS
 Set the number of loops. The default is 0 (endless). This option is useful
 for automated tests with a given number of test cycles. Cyclictest is
 stopped once the number of timer intervals has been reached.
+.
 .TP
 .B \-\-mainaffinity=CPUSET
 Run the main thread on CPU #N. This only affects the main thread and not
 the measurement threads
+.
 .TP
 .B \-m, \-\-mlockall
 Lock current and future memory allocations to prevent being paged out
+.
 .TP
 .B \\-M, \-\-refresh_on_max
 Delay updating the screen until a new max latency is hit. (useful for
 running cyclictest on low-bandwidth connections)
+.
 .TP
 .B \-N, \-\-nsecs
 Show results in nanoseconds instead of microseconds, which is the default
 unit.
+.
 .TP
 .B \-o, \-\-oscope=RED
 Oscilloscope mode, reduce verbose output by RED.
+.
 .TP
 .B \-p, \-\-prio=PRIO
 Set the priority of the first thread. The given priority is set to the
 first test thread. Each further thread gets a lower priority:
 Priority(Thread N) = max(Priority(Thread N\-1) \- 1, 0)
+.
 .TP
 .B \-\-policy=NAME
 set the scheduler policy of the measurement threads where NAME is one of:
 other, normal, batch, idle, fifo, rr
+.
 .TP
 .B \-\-priospread
 spread priority levels starting at a specified value
+.
 .TP
 .B \-q, \-\-quiet
 Print a summary only on exit. Useful for automated tests, where only the
 summary output needs to be captured.
+.
 .TP
 .B \-r, \-\-relative
 Use relative timers instead of absolute. The default behaviour of the tests
 is to use absolute timers. This option is there for completeness and should
 not be used for reproducible tests.
+.
 .TP
 .B \-R, \-\-resolution
 Check clock resolution, calling clock_gettime() many times. List of
 lock_gettime() values will be reported with -X
+.
 .TP
 .B \-\-secaligned [USEC]
 align thread wakeups to the next full second and apply the optional offset.
+.
 .TP
 .B \-s, \-\-system
 Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s
 can only be used with one thread because itimers are per process and not
 per thread. \-s uses the nanosleep syscall and is not restricted to one
 thread.
+.
 .TP
 .B \\-S, \-\-smp
 Set options for standard testing on SMP systems. Equivalent to using the
 options: "\-t \-a" as well keeping any specified priority equal across all
 threads
+.
 .TP
 .B \-\-spike=<trigger>
 record all spikes > trigger
+.
 .TP
 .B \-\-spike-nodes=[num of nodes]
 These are the maximum number of spikes we can record.
 .br
 The default is 1024 if not specified.
+.
 .TP
 .B \\-\-smi
 Enable SMI count/detection on processors with SMI count support.
+.
 .TP
 .B \-t, \-\-threads[=NUM]
 Set the number of test threads (default is 1). Create NUM test threads. If
 NUM is not specified, NUM is set to the number of available CPUs. See \-d,
 \-i and \-p for further information.
+.
 .TP
 .B \-\-tracemark
 write a trace mark when \-b latency is exceeded.
+.
 .TP
 .B \-u, \-\-unbuffered
 force unbuffered output for live processing
+.
 .TP
 .B \-v, \-\-verbose
 Output values on stdout for statistics. This option is used to gather
 statistical information about the latency distribution. The output is sent
 to stdout. The output format is: "n:c:v", where n is the task number, c is
 the count, and v is the latency value in microseconds.
+.
 .TP
 .B \-\-dbg_cyclictest
 Print info userful for debugging cyclictest
+.
 .TP
 .B \-x, \-\-posix_timers
 Use POSIX timers instead of clock_nanosleep.
-
+.
 .SH SEE ALSO
 .BR numa (3),
 .BR numactl (8),
+.
 .SH AUTHOR
 cyclictest was written by Thomas Gleixner <tglx@linuxtronix.de>.
 .PP
-- 
2.49.0

