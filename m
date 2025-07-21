Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A75A95C
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125051; cv=none; b=HZNA9oIvxQ+rIk0/58mNkSKG5bMDs1b6H6IxXge4BGAvR8Rvj5HRQfY1PCF7ZjopqJoWGbX0jPiC3gs+T1WDNdN8a5KKgSM2Xkll9Dr/vm+wz7qoS6mGsfoUiC57uKKfvdm5Cg6khyP6fkWwDWR2lZxjPJDh919xUo7vMJEkCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125051; c=relaxed/simple;
	bh=u8EcgOUIsOXSQ1RjgI1V6go25Ud9kZAsbdK3rFGEEDM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SMagXaa5wWPRlcYecD11JBOQWPNQnXL5QlbYopXpBZ287YlUuJIHeWiA2pSw7oHVtfqLCKHY8bo/AyUm/zIQAXG9Q2hQz8tBu5Xpx07824WVK6knNiRWF4sKmDx2wk6zC7ouNVmSkFUETkjUhoCjS5+kNjxoVoQ5CcuQsSxMyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ivg7m4Xb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ivg7m4Xb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753125048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcKw0HlPtN1s4wV7709bBAPfQN2a/LY8QO0iLa7YpfI=;
	b=Ivg7m4XbH76PI6tw4Z9cUz/4rsXnJIba2sTVA0ApIjkCqL3IDHPUEGQ3tuUTBPsDj9JYZL
	ELUkbJ8cTRoGC2YGsBNI1/PJVD2hL9BIo/DCff8lprcFpeyVf2s0a0zXvAjcsx/FDy1Fav
	wRgB2eQwZtqFdWYXbZJA0KZrQx607/8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-LNhtC95BP8CJQBk50gpIUw-1; Mon, 21 Jul 2025 15:10:45 -0400
X-MC-Unique: LNhtC95BP8CJQBk50gpIUw-1
X-Mimecast-MFC-AGG-ID: LNhtC95BP8CJQBk50gpIUw_1753125045
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fd5e0bc378so81356636d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753125045; x=1753729845;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcKw0HlPtN1s4wV7709bBAPfQN2a/LY8QO0iLa7YpfI=;
        b=UfK2mw5Q7RJQ9xcnX9Cn4GdQVzjqixhhHWt2EpXKhy0qDCsOo/BMGXM+x+Ao0rLihR
         FgGA+0YvGrb4MUYAmx/jGuPKWIx3eB4inadz3oAnjkULH+AUzprBrEzwlxqAvs/VSqM8
         5n4SveidrH4196GdhERaxns9Y9r/cJsL3YOcYiaR+HEVXyETgYU4jRJaCJpB6DfwzEB9
         KDPqzcQFO/Oi+e/5aYRmASIfTS6OUf7Gy4AW5lr1q5CEuGXQWcl5XczJoRzIStkaeIw0
         SbbeYpv1FquBgtdldRxtegzTS4aPW2e2Rs+g7KLve0W6vQ457rd6KQFwlBxB6A2CjSRJ
         hGKA==
X-Gm-Message-State: AOJu0YyHe/7v1FmvAwrC4ZedxISs5yuS+rkDGjT4jjrArcEwIAvb7FCV
	v0lIHrzthuOzAas5nFxVOQPA5dpGQ6rd8q4/ODbYN7KR0ZAx4KCzMz7LNx8VWz/N5zUGnJsLLJi
	em6JLVdB+U/zF6QmuzJnP/K/1oseYxKNOExX0nxfGvyw2TA/xQoDAXX04lQgWb5ZaDMDnKBtuXc
	Ju
X-Gm-Gg: ASbGncshVnCAZV8hq8ZM9xJ+Lly/Cgzs3XoVxBFCdnlulXpvpJECL4ICfXdWU9ggXir
	474AUTFKBOQpx/cYbspmMUu3k/E4hpZdi9PoofpbSkSW1yUSjefV5uiJRqbu7onsyGnzygiw8hU
	jKK3T579hKMXQm/s53if4AUtBFf4/f81pJ+rUOWMxOQpYIaRPhQG4TRaniC++9wlOKCQRnV5T6V
	J4YCJOKdNmEl+HA75fjPKIDh24naV+fd8i3XLmvb4d4outumgEaNvijZtoKwJSgl0MwyVxcev0V
	uEdtz8a8qbxwgBSGlkXwuJplNKNdVw==
X-Received: by 2002:a05:6214:ccc:b0:706:c5f3:1d9c with SMTP id 6a1803df08f44-706c5f32da9mr105232956d6.0.1753125044744;
        Mon, 21 Jul 2025 12:10:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHAPSEpdbY+jqCoAbSrB3z/YbVig1j96ZfhWz4VO6nqsPAn4rpjA2SxuWgq+Q9/r3Lwnsl6g==
X-Received: by 2002:a05:6214:ccc:b0:706:c5f3:1d9c with SMTP id 6a1803df08f44-706c5f32da9mr105232516d6.0.1753125044196;
        Mon, 21 Jul 2025 12:10:44 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b0fasm42003266d6.65.2025.07.21.12.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:10:43 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:10:42 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 08/28] cyclictest.8: Align source file to 75 columns
In-Reply-To: <20250704132721.13325-9-darwi@linutronix.de>
Message-ID: <0e5f1084-f1ab-d8cf-f77e-2b29d2730804@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-9-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Enforce proper column alignment for the whole cyclictest manpage source.
> Next commits will significantly expand the parameters' description text,
> and without such alignment the expanded text will be hard to read and
> review at the source.
> 
> Per man-pages(7): "please limit source code line length to no more than
> about 75 characters wherever possible."
> 
> Note, no content change, as verified before and after by
> "man ./cyclictest.8 | md5sum"
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 85 ++++++++++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 30 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index d4ce648..6bf983d 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -17,16 +17,17 @@ A summary of options is included below.
>  .TP
>  .B \-a, \-\-affinity[=PROC-SET]
>  Run threads on the set of processors given by PROC-SET.  If PROC-SET is not
> -specified, all processors will be used.  Threads will be assigned to processors
> -in the set in numeric order, in a round\-robin fashion.
> +specified, all processors will be used.  Threads will be assigned to
> +processors in the set in numeric order, in a round\-robin fashion.
>  .br
> -The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.
> -The ! character can be used to negate a set.  For example, !B-D means to use all
> -available CPUs except B through D.  The cpu numbers are the same as shown in the
> +The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so
> +on*.  The ! character can be used to negate a set.  For example, !B-D means
> +to use all available CPUs except B through D.  The cpu numbers are the same
> +as shown in the
>  .I processor
> -field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU sets.
> -* Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET,
> -if specified, must be a single CPU number.
> +field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU
> +sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma
> +v1, PROC-SET, if specified, must be a single CPU number.
>  .TP
>  .B \-A, \-\-align=USEC
>  Align thread wakeups to a specific offset in microseconds
> @@ -42,10 +43,14 @@ select clock
>  1 = CLOCK_REALTIME
>  .TP
>  .B \-\-deepest\-idle\-state=n
> -Reduce exit from idle latency by limiting idle state up to n on used cpus (-1 disables all idle states). Power management is not suppresed on other cpus.
> +Reduce exit from idle latency by limiting idle state up to n on used cpus
> +(-1 disables all idle states). Power management is not suppresed on other
> +cpus.
>  .TP
>  .B \-\-default\-system
> -Don't attempt to tune the system from cyclictest. Power management is not suppressed. This might give poorer results, but will allow you to discover if you need to tune the system.
> +Don't attempt to tune the system from cyclictest. Power management is not
> +suppressed. This might give poorer results, but will allow you to discover
> +if you need to tune the system.
>  .TP
>  .B \-d, \-\-distance=DIST
>  Distance of thread intervals in us, default = 500
> @@ -59,31 +64,41 @@ Append 'm', 'h', or 'd' to specify minutes, hours or days.
>  Create a named pipe at path and write stats to it
>  .TP
>  .B \-h, \-\-histogram=US
> -Dump latency histogram to stdout after the run. US is the max latency time to be be tracked in microseconds. This option runs all threads at the same priority.
> +Dump latency histogram to stdout after the run. US is the max latency time
> +to be be tracked in microseconds. This option runs all threads at the same
> +priority.
>  .TP
>  .B \-H, \-\-histofall=MAXLATENCYINUS
> -Same as -h except that an additional histogram column is displayed at the right that contains summary data of all thread histograms. If cyclictest runs a single thread only, the -H option is equivalent to -h.
> +Same as -h except that an additional histogram column is displayed at the
> +right that contains summary data of all thread histograms. If cyclictest
> +runs a single thread only, the -H option is equivalent to -h.
>  .TP
>  .B \-\-histfile=<path>
>  Dump the latency histogram to <path> instead of stdout.
>  .TP
>  .B \-i, \-\-interval=INTV
> -Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also \-d.
> +Set the base interval of the thread(s) in microseconds (default is
> +1000us). This sets the interval of the first thread. See also \-d.
>  .TP
>  .B \-\-json=FILENAME
>  Write final results into FILENAME, JSON formatted.
>  .TP
>  .B \-\-laptop
> -Save battery when running cyclictest. This will give you poorer realtime results, but will not drain your battery so quickly.
> +Save battery when running cyclictest. This will give you poorer realtime
> +results, but will not drain your battery so quickly.
>  .TP
>  .B \-\-latency=PM_Q0S
> -power management latency target value. This value is written to /dev/cpu_dma_latency and affects c-states. The default is 0
> +power management latency target value. This value is written to
> +/dev/cpu_dma_latency and affects c-states. The default is 0
>  .TP
>  .B \-l, \-\-loops=LOOPS
> -Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. Cyclictest is stopped once the number of timer intervals has been reached.
> +Set the number of loops. The default is 0 (endless). This option is useful
> +for automated tests with a given number of test cycles. Cyclictest is
> +stopped once the number of timer intervals has been reached.
>  .TP
>  .B \-\-mainaffinity=CPUSET
> -Run the main thread on CPU #N. This only affects the main thread and not the measurement threads
> +Run the main thread on CPU #N. This only affects the main thread and not
> +the measurement threads
>  .TP
>  .B \-m, \-\-mlockall
>  Lock current and future memory allocations to prevent being paged out
> @@ -93,41 +108,50 @@ Delay updating the screen until a new max latency is hit. (useful for
>  running cyclictest on low-bandwidth connections)
>  .TP
>  .B \-N, \-\-nsecs
> -Show results in nanoseconds instead of microseconds, which is the default unit.
> +Show results in nanoseconds instead of microseconds, which is the default
> +unit.
>  .TP
>  .B \-o, \-\-oscope=RED
>  Oscilloscope mode, reduce verbose output by RED.
>  .TP
>  .B \-p, \-\-prio=PRIO
> -Set the priority of the first thread. The given priority is set to the first test thread. Each further thread gets a lower priority:
> +Set the priority of the first thread. The given priority is set to the
> +first test thread. Each further thread gets a lower priority:
>  Priority(Thread N) = max(Priority(Thread N\-1) \- 1, 0)
>  .TP
>  .B \-\-policy=NAME
> -set the scheduler policy of the measurement threads
> -where NAME is one of: other, normal, batch, idle, fifo, rr
> +set the scheduler policy of the measurement threads where NAME is one of:
> +other, normal, batch, idle, fifo, rr
>  .TP
>  .B \-\-priospread
>  spread priority levels starting at a specified value
>  .TP
>  .B \-q, \-\-quiet
> -Print a summary only on exit. Useful for automated tests, where only the summary output needs to be captured.
> +Print a summary only on exit. Useful for automated tests, where only the
> +summary output needs to be captured.
>  .TP
>  .B \-r, \-\-relative
> -Use relative timers instead of absolute. The default behaviour of the tests is to use absolute timers. This option is there for completeness and should not be used for reproducible tests.
> +Use relative timers instead of absolute. The default behaviour of the tests
> +is to use absolute timers. This option is there for completeness and should
> +not be used for reproducible tests.
>  .TP
>  .B \-R, \-\-resolution
> -Check clock resolution, calling clock_gettime() many times. List of lock_gettime() values will be reported with -X
> +Check clock resolution, calling clock_gettime() many times. List of
> +lock_gettime() values will be reported with -X
>  .TP
>  .B \-\-secaligned [USEC]
>  align thread wakeups to the next full second and apply the optional offset.
>  .TP
>  .B \-s, \-\-system
> -Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s can only be used with one thread because itimers are per process and not per thread. \-s uses the nanosleep syscall and is not restricted to one thread.
> +Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s
> +can only be used with one thread because itimers are per process and not
> +per thread. \-s uses the nanosleep syscall and is not restricted to one
> +thread.
>  .TP
>  .B \\-S, \-\-smp
> -Set options for standard testing on SMP systems. Equivalent to using
> -the options: "\-t \-a" as well keeping any specified priority
> -equal across all threads
> +Set options for standard testing on SMP systems. Equivalent to using the
> +options: "\-t \-a" as well keeping any specified priority equal across all
> +threads
>  .TP
>  .B \-\-spike=<trigger>
>  record all spikes > trigger
> @@ -141,8 +165,9 @@ The default is 1024 if not specified.
>  Enable SMI count/detection on processors with SMI count support.
>  .TP
>  .B \-t, \-\-threads[=NUM]
> -Set the number of test threads (default is 1). Create NUM test threads. If NUM is not specified, NUM is set to
> -the number of available CPUs. See \-d, \-i and \-p for further information.
> +Set the number of test threads (default is 1). Create NUM test threads. If
> +NUM is not specified, NUM is set to the number of available CPUs. See \-d,
> +\-i and \-p for further information.
>  .TP
>  .B \-\-tracemark
>  write a trace mark when \-b latency is exceeded.
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

