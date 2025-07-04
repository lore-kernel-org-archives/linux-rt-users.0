Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD22FA651
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635677; cv=none; b=TXcv7BYqcaWFEtOwy7BQmfftq4nzUFdyS2tyGCTwzCgiKrMIKlwyUw6ncgqBlx9GhTiHW+IxUZgoh9H7vSGxzYDKAHTCIXIurIIJvwyz9fq/mQp4aznlTjb2JNGmGD2/kGlZx2DXp1PJH05pO+qkhYoxBo9aETW+tTvJMPmrjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635677; c=relaxed/simple;
	bh=oyZ7I8In3OECCqgOIVk2glJ+vdmr5tYeenTgdq8tavk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ec6IUzpvaQ+RGvWebfDqz98l/y+xjN4P0HZPI0Mb/3BTiMOf4G4uiY42aO7QdQx9ECGsuVhTunyxxIaI1CvXqFo7e3wcaLV7upXZAAE9+fTG181NU2lBhwcuSKq17/0KhObDRblKdj2RhkWwrLy71pdhkkEXY0Jr0dLeul3JlmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbIrGyOI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GEXONuLA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbIrGyOI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GEXONuLA"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOQ0rD70ehCCedRoN+SEpr0grbop/V1J/XnPg8HaGO0=;
	b=BbIrGyOItQq+h7H32JPn6C52a6j5QCZ63xz0WVMeg/YMw2+CwkrmJ9WyA9dmT066+AT/Cy
	To+kI4h8dONmovXij1wSfpA18fknxkpMI5jVTrcDUhs2DxVdlQ/dvRfuyMnQIQfAY0Tv92
	wICgcFd+txQfYVWf7BZK8140NeJCYvWRmeGuPTpRp4Ywip4rqlF31oje6ccG1GiMtejDrv
	AaBQSux+cRLnIrSfJcP5sMv057aKYKbKjPd+83j2TVoHh3kA146bgaQFDVkv+ApyMdTgBN
	HuglOj542SA7M5VLqNHmr33SG5s7X276Ja25u4HDYXojh7O5s5DsCK/vaYl0Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOQ0rD70ehCCedRoN+SEpr0grbop/V1J/XnPg8HaGO0=;
	b=GEXONuLAMhKLqoNAweJulCPl+oEVvG1YUSd08G2XoolNvlW7ASnSgqLi7qSxRdvgzvN1up
	ORSsVjNOqQxVDsCw==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 08/28] cyclictest.8: Align source file to 75 columns
Date: Fri,  4 Jul 2025 15:27:01 +0200
Message-ID: <20250704132721.13325-9-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enforce proper column alignment for the whole cyclictest manpage source.
Next commits will significantly expand the parameters' description text,
and without such alignment the expanded text will be hard to read and
review at the source.

Per man-pages(7): "please limit source code line length to no more than
about 75 characters wherever possible."

Note, no content change, as verified before and after by
"man ./cyclictest.8 | md5sum"

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 85 ++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index d4ce648..6bf983d 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -17,16 +17,17 @@ A summary of options is included below.
 .TP
 .B \-a, \-\-affinity[=PROC-SET]
 Run threads on the set of processors given by PROC-SET.  If PROC-SET is not
-specified, all processors will be used.  Threads will be assigned to processors
-in the set in numeric order, in a round\-robin fashion.
+specified, all processors will be used.  Threads will be assigned to
+processors in the set in numeric order, in a round\-robin fashion.
 .br
-The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.
-The ! character can be used to negate a set.  For example, !B-D means to use all
-available CPUs except B through D.  The cpu numbers are the same as shown in the
+The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so
+on*.  The ! character can be used to negate a set.  For example, !B-D means
+to use all available CPUs except B through D.  The cpu numbers are the same
+as shown in the
 .I processor
-field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU sets.
-* Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET,
-if specified, must be a single CPU number.
+field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU
+sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma
+v1, PROC-SET, if specified, must be a single CPU number.
 .TP
 .B \-A, \-\-align=USEC
 Align thread wakeups to a specific offset in microseconds
@@ -42,10 +43,14 @@ select clock
 1 = CLOCK_REALTIME
 .TP
 .B \-\-deepest\-idle\-state=n
-Reduce exit from idle latency by limiting idle state up to n on used cpus (-1 disables all idle states). Power management is not suppresed on other cpus.
+Reduce exit from idle latency by limiting idle state up to n on used cpus
+(-1 disables all idle states). Power management is not suppresed on other
+cpus.
 .TP
 .B \-\-default\-system
-Don't attempt to tune the system from cyclictest. Power management is not suppressed. This might give poorer results, but will allow you to discover if you need to tune the system.
+Don't attempt to tune the system from cyclictest. Power management is not
+suppressed. This might give poorer results, but will allow you to discover
+if you need to tune the system.
 .TP
 .B \-d, \-\-distance=DIST
 Distance of thread intervals in us, default = 500
@@ -59,31 +64,41 @@ Append 'm', 'h', or 'd' to specify minutes, hours or days.
 Create a named pipe at path and write stats to it
 .TP
 .B \-h, \-\-histogram=US
-Dump latency histogram to stdout after the run. US is the max latency time to be be tracked in microseconds. This option runs all threads at the same priority.
+Dump latency histogram to stdout after the run. US is the max latency time
+to be be tracked in microseconds. This option runs all threads at the same
+priority.
 .TP
 .B \-H, \-\-histofall=MAXLATENCYINUS
-Same as -h except that an additional histogram column is displayed at the right that contains summary data of all thread histograms. If cyclictest runs a single thread only, the -H option is equivalent to -h.
+Same as -h except that an additional histogram column is displayed at the
+right that contains summary data of all thread histograms. If cyclictest
+runs a single thread only, the -H option is equivalent to -h.
 .TP
 .B \-\-histfile=<path>
 Dump the latency histogram to <path> instead of stdout.
 .TP
 .B \-i, \-\-interval=INTV
-Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also \-d.
+Set the base interval of the thread(s) in microseconds (default is
+1000us). This sets the interval of the first thread. See also \-d.
 .TP
 .B \-\-json=FILENAME
 Write final results into FILENAME, JSON formatted.
 .TP
 .B \-\-laptop
-Save battery when running cyclictest. This will give you poorer realtime results, but will not drain your battery so quickly.
+Save battery when running cyclictest. This will give you poorer realtime
+results, but will not drain your battery so quickly.
 .TP
 .B \-\-latency=PM_Q0S
-power management latency target value. This value is written to /dev/cpu_dma_latency and affects c-states. The default is 0
+power management latency target value. This value is written to
+/dev/cpu_dma_latency and affects c-states. The default is 0
 .TP
 .B \-l, \-\-loops=LOOPS
-Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. Cyclictest is stopped once the number of timer intervals has been reached.
+Set the number of loops. The default is 0 (endless). This option is useful
+for automated tests with a given number of test cycles. Cyclictest is
+stopped once the number of timer intervals has been reached.
 .TP
 .B \-\-mainaffinity=CPUSET
-Run the main thread on CPU #N. This only affects the main thread and not the measurement threads
+Run the main thread on CPU #N. This only affects the main thread and not
+the measurement threads
 .TP
 .B \-m, \-\-mlockall
 Lock current and future memory allocations to prevent being paged out
@@ -93,41 +108,50 @@ Delay updating the screen until a new max latency is hit. (useful for
 running cyclictest on low-bandwidth connections)
 .TP
 .B \-N, \-\-nsecs
-Show results in nanoseconds instead of microseconds, which is the default unit.
+Show results in nanoseconds instead of microseconds, which is the default
+unit.
 .TP
 .B \-o, \-\-oscope=RED
 Oscilloscope mode, reduce verbose output by RED.
 .TP
 .B \-p, \-\-prio=PRIO
-Set the priority of the first thread. The given priority is set to the first test thread. Each further thread gets a lower priority:
+Set the priority of the first thread. The given priority is set to the
+first test thread. Each further thread gets a lower priority:
 Priority(Thread N) = max(Priority(Thread N\-1) \- 1, 0)
 .TP
 .B \-\-policy=NAME
-set the scheduler policy of the measurement threads
-where NAME is one of: other, normal, batch, idle, fifo, rr
+set the scheduler policy of the measurement threads where NAME is one of:
+other, normal, batch, idle, fifo, rr
 .TP
 .B \-\-priospread
 spread priority levels starting at a specified value
 .TP
 .B \-q, \-\-quiet
-Print a summary only on exit. Useful for automated tests, where only the summary output needs to be captured.
+Print a summary only on exit. Useful for automated tests, where only the
+summary output needs to be captured.
 .TP
 .B \-r, \-\-relative
-Use relative timers instead of absolute. The default behaviour of the tests is to use absolute timers. This option is there for completeness and should not be used for reproducible tests.
+Use relative timers instead of absolute. The default behaviour of the tests
+is to use absolute timers. This option is there for completeness and should
+not be used for reproducible tests.
 .TP
 .B \-R, \-\-resolution
-Check clock resolution, calling clock_gettime() many times. List of lock_gettime() values will be reported with -X
+Check clock resolution, calling clock_gettime() many times. List of
+lock_gettime() values will be reported with -X
 .TP
 .B \-\-secaligned [USEC]
 align thread wakeups to the next full second and apply the optional offset.
 .TP
 .B \-s, \-\-system
-Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s can only be used with one thread because itimers are per process and not per thread. \-s uses the nanosleep syscall and is not restricted to one thread.
+Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s
+can only be used with one thread because itimers are per process and not
+per thread. \-s uses the nanosleep syscall and is not restricted to one
+thread.
 .TP
 .B \\-S, \-\-smp
-Set options for standard testing on SMP systems. Equivalent to using
-the options: "\-t \-a" as well keeping any specified priority
-equal across all threads
+Set options for standard testing on SMP systems. Equivalent to using the
+options: "\-t \-a" as well keeping any specified priority equal across all
+threads
 .TP
 .B \-\-spike=<trigger>
 record all spikes > trigger
@@ -141,8 +165,9 @@ The default is 1024 if not specified.
 Enable SMI count/detection on processors with SMI count support.
 .TP
 .B \-t, \-\-threads[=NUM]
-Set the number of test threads (default is 1). Create NUM test threads. If NUM is not specified, NUM is set to
-the number of available CPUs. See \-d, \-i and \-p for further information.
+Set the number of test threads (default is 1). Create NUM test threads. If
+NUM is not specified, NUM is set to the number of available CPUs. See \-d,
+\-i and \-p for further information.
 .TP
 .B \-\-tracemark
 write a trace mark when \-b latency is exceeded.
-- 
2.49.0

