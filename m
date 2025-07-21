Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4102222BB
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126018; cv=none; b=cRfKSuJGcyG8xmsf0Pu9B0NRvATQMHQrykIiJeHrp3ev54WFkYGe6j59VfEnS+DnBbYJGEIXU0dZr8f3si7S/bpiWV2R1nplnH2GRFhljQBRVss4UA9AqVCLfOGi9oEw2SDJFuyvxxViqnEcCr+voUXFdQZUIUajkm8rDGgpMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126018; c=relaxed/simple;
	bh=no2zAFO6zciTnwE++5HNiQBgI12RPD6nWFryCFvJCCA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kHxzz1GS9Elml0AqX9DdmSuxfOVzLUFDA7ac0CqNxklKh4+BfAxK33ajT5eRAopw0QklksQWtpB4pLYI5JUFFrAy/Ss0MtCYswM3VbRtvNCb3nAYCjMuCw8kJp9n3mwnosvq/G7uzQesX/zfSsKkVEzPrbM6JZvTTceg0Iu/OfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbF0tA4j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbF0tA4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753126015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/DmARPouxm7OFRTjAse2E8Um0phvEFvZJJvxtQfUO7o=;
	b=BbF0tA4j0I6KfyjVQTBfCgKpZy0GQjVv9lzhmvPNgptrzo7ZLHzEcLybKHrnRcijMOp4fs
	e986Ze1HF0SCKJ24hWiW+f3yIpmYM/jovgY63//fKD974SWv7/mBiasXDS2zwIaduLmM1m
	EIvC2jLtpPym1CzboO37dZh4CuxmQrU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-Xuv41I8qO0-RMubQqcuVxQ-1; Mon, 21 Jul 2025 15:26:53 -0400
X-MC-Unique: Xuv41I8qO0-RMubQqcuVxQ-1
X-Mimecast-MFC-AGG-ID: Xuv41I8qO0-RMubQqcuVxQ_1753126013
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e269587d8eso824539585a.3
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753126013; x=1753730813;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DmARPouxm7OFRTjAse2E8Um0phvEFvZJJvxtQfUO7o=;
        b=LtXOV2Sy02MnJm+/X0FvxaBSLTh/Tx7R7p/ppfkPGSJmau1DcDL3yWQm0qvF8pOchP
         AHRsT1hFKSxd34qws1ee2klTqsbyaTaipv/AvUzy2td6AI/K5iVhBplFiymCJWxI3Z1S
         64JSOwgLPtuQNVne9VdenWK8m+W2ePtRqIUh4oIY2ip5NIiZMhFGBFmHgT80isQ+6uQ7
         lcS6ZGQbbLaPLVhRVa2rAu5k0hcs+Pw/LJb3yegOA9rmuz6wM2CiPGQTWIan3UB1aix6
         rRbpB3txeG7RJkhLGf7RfPcuoZme8HKMHXwox9uiG6nZJnE+wL4CzdF70yC/ffp5Qkt1
         QXyQ==
X-Gm-Message-State: AOJu0YzaJTm4y2oW8HwW1mDjVMU843NDvLIMI2z+rbq8aLM4W6WhIfHu
	Mg1TBxy/OVx081HP27iBDCNeFGZzkh9UeLoLlQsknuzihYSd1duCmBJmhHrys7dGg59h+2jJqIU
	iXNTsdXcXdjTRqn5evYgPpUbz/H9RzCs1HLTImPG5lSerN1fbHwowuEVc2UQOwlfmFWVB
X-Gm-Gg: ASbGncutbIvXYG3aIsMNQu/15f41sTIEilYZ8WnfIVfSNvqHdygWlxJUlvro+VNZ3Zy
	rXbUJvPTLme51hZgi2Xcr3RQwmh/e9+3KP0Z7e2qz/4eMQW0n0eMTP61WhWOx41uAyBeQIRLbm8
	UnS3YWt1DSR3vfgQOiKjki66efkVBHfbQp0ugefQg7njsya7a7ZiRKbBkf+m2L59jcVcyUwalf0
	cLP5Ej9CdxUMfUO8urmd+HbQA41pQi6seRbEy730gi82BkN9v3QRP95kqhFU5wxxSHw/m+i8rJ+
	KHX2KKU3uwsRsAAgsTAJNWgykGwIbQ==
X-Received: by 2002:a05:620a:1357:b0:7e3:3e32:e620 with SMTP id af79cd13be357-7e34d9ab6c0mr2295543685a.36.1753126012798;
        Mon, 21 Jul 2025 12:26:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjpXOTb0wURc9nSZ1pFp5mdoD0wbZYwc9S8Pf6owlsBZaSo0r1H7Luz/YCXNA4HsaCOOQXyg==
X-Received: by 2002:a05:620a:1357:b0:7e3:3e32:e620 with SMTP id af79cd13be357-7e34d9ab6c0mr2295538885a.36.1753126012109;
        Mon, 21 Jul 2025 12:26:52 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b4610dsm437776585a.25.2025.07.21.12.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:26:51 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:26:50 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 09/28] cyclictest.8: Separate source sections
In-Reply-To: <20250704132721.13325-10-darwi@linutronix.de>
Message-ID: <3c99cc67-c29f-dacb-a3e9-2cd887c8762d@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-10-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Further work will significantly expand the cyclictest's parameter
> documentation.  Improve the manpage's source readability by separating
> its different sections with newlines.
> 
> Per groff_man_style(7), use groff's empty request (.) for this vertical
> spacing as blank lines shouldn't exist in a manpage source file.
> Authoritative manpages like groff_man(7) is also written this way.
> 
> No output change, as verified before and after by
> "man ./cyclictest.8 | md5sum".
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 47 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 6bf983d..f27fe66 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -1,19 +1,22 @@
>  .\" SPDX-License-Identifier: GPL-2.0-only
>  .\" For a man pages tutorial, check groff_man_style(7)
>  .TH CYCLICTEST 8 "April 22, 2016"
> +.
>  .SH NAME
>  cyclictest \- High resolution test program
> +.
>  .SH SYNOPSIS
>  .SY cyclictest
>  .RI "[ \-fmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
>  [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
>  [\-p " prio " ] [\-t " num " ] [\-D " time " ]"
> -
> +.
>  .SH OPTIONS
>  These programs follow the usual GNU command line syntax, with long
>  options starting with two dashes ('\-\-').
>  .br
>  A summary of options is included below.
> +.
>  .TP
>  .B \-a, \-\-affinity[=PROC-SET]
>  Run threads on the set of processors given by PROC-SET.  If PROC-SET is not
> @@ -28,12 +31,15 @@ as shown in the
>  field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU
>  sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma
>  v1, PROC-SET, if specified, must be a single CPU number.
> +.
>  .TP
>  .B \-A, \-\-align=USEC
>  Align thread wakeups to a specific offset in microseconds
> +.
>  .TP
>  .B \-b, \-\-breaktrace=USEC
>  Send break trace command when latency > USEC
> +.
>  .TP
>  .B \-c, \-\-clock=CLOCK
>  select clock
> @@ -41,155 +47,192 @@ select clock
>  0 = CLOCK_MONOTONIC (default)
>  .br
>  1 = CLOCK_REALTIME
> +.
>  .TP
>  .B \-\-deepest\-idle\-state=n
>  Reduce exit from idle latency by limiting idle state up to n on used cpus
>  (-1 disables all idle states). Power management is not suppresed on other
>  cpus.
> +.
>  .TP
>  .B \-\-default\-system
>  Don't attempt to tune the system from cyclictest. Power management is not
>  suppressed. This might give poorer results, but will allow you to discover
>  if you need to tune the system.
> +.
>  .TP
>  .B \-d, \-\-distance=DIST
>  Distance of thread intervals in us, default = 500
> +.
>  .TP
>  .B \-D, \-\-duration=TIME
>  Specify a length for the test run.
>  .br
>  Append 'm', 'h', or 'd' to specify minutes, hours or days.
> +.
>  .TP
>  .B \-F, \-\-fifo=<path>
>  Create a named pipe at path and write stats to it
> +.
>  .TP
>  .B \-h, \-\-histogram=US
>  Dump latency histogram to stdout after the run. US is the max latency time
>  to be be tracked in microseconds. This option runs all threads at the same
>  priority.
> +.
>  .TP
>  .B \-H, \-\-histofall=MAXLATENCYINUS
>  Same as -h except that an additional histogram column is displayed at the
>  right that contains summary data of all thread histograms. If cyclictest
>  runs a single thread only, the -H option is equivalent to -h.
> +.
>  .TP
>  .B \-\-histfile=<path>
>  Dump the latency histogram to <path> instead of stdout.
> +.
>  .TP
>  .B \-i, \-\-interval=INTV
>  Set the base interval of the thread(s) in microseconds (default is
>  1000us). This sets the interval of the first thread. See also \-d.
> +.
>  .TP
>  .B \-\-json=FILENAME
>  Write final results into FILENAME, JSON formatted.
> +.
>  .TP
>  .B \-\-laptop
>  Save battery when running cyclictest. This will give you poorer realtime
>  results, but will not drain your battery so quickly.
> +.
>  .TP
>  .B \-\-latency=PM_Q0S
>  power management latency target value. This value is written to
>  /dev/cpu_dma_latency and affects c-states. The default is 0
> +.
>  .TP
>  .B \-l, \-\-loops=LOOPS
>  Set the number of loops. The default is 0 (endless). This option is useful
>  for automated tests with a given number of test cycles. Cyclictest is
>  stopped once the number of timer intervals has been reached.
> +.
>  .TP
>  .B \-\-mainaffinity=CPUSET
>  Run the main thread on CPU #N. This only affects the main thread and not
>  the measurement threads
> +.
>  .TP
>  .B \-m, \-\-mlockall
>  Lock current and future memory allocations to prevent being paged out
> +.
>  .TP
>  .B \\-M, \-\-refresh_on_max
>  Delay updating the screen until a new max latency is hit. (useful for
>  running cyclictest on low-bandwidth connections)
> +.
>  .TP
>  .B \-N, \-\-nsecs
>  Show results in nanoseconds instead of microseconds, which is the default
>  unit.
> +.
>  .TP
>  .B \-o, \-\-oscope=RED
>  Oscilloscope mode, reduce verbose output by RED.
> +.
>  .TP
>  .B \-p, \-\-prio=PRIO
>  Set the priority of the first thread. The given priority is set to the
>  first test thread. Each further thread gets a lower priority:
>  Priority(Thread N) = max(Priority(Thread N\-1) \- 1, 0)
> +.
>  .TP
>  .B \-\-policy=NAME
>  set the scheduler policy of the measurement threads where NAME is one of:
>  other, normal, batch, idle, fifo, rr
> +.
>  .TP
>  .B \-\-priospread
>  spread priority levels starting at a specified value
> +.
>  .TP
>  .B \-q, \-\-quiet
>  Print a summary only on exit. Useful for automated tests, where only the
>  summary output needs to be captured.
> +.
>  .TP
>  .B \-r, \-\-relative
>  Use relative timers instead of absolute. The default behaviour of the tests
>  is to use absolute timers. This option is there for completeness and should
>  not be used for reproducible tests.
> +.
>  .TP
>  .B \-R, \-\-resolution
>  Check clock resolution, calling clock_gettime() many times. List of
>  lock_gettime() values will be reported with -X
> +.
>  .TP
>  .B \-\-secaligned [USEC]
>  align thread wakeups to the next full second and apply the optional offset.
> +.
>  .TP
>  .B \-s, \-\-system
>  Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s
>  can only be used with one thread because itimers are per process and not
>  per thread. \-s uses the nanosleep syscall and is not restricted to one
>  thread.
> +.
>  .TP
>  .B \\-S, \-\-smp
>  Set options for standard testing on SMP systems. Equivalent to using the
>  options: "\-t \-a" as well keeping any specified priority equal across all
>  threads
> +.
>  .TP
>  .B \-\-spike=<trigger>
>  record all spikes > trigger
> +.
>  .TP
>  .B \-\-spike-nodes=[num of nodes]
>  These are the maximum number of spikes we can record.
>  .br
>  The default is 1024 if not specified.
> +.
>  .TP
>  .B \\-\-smi
>  Enable SMI count/detection on processors with SMI count support.
> +.
>  .TP
>  .B \-t, \-\-threads[=NUM]
>  Set the number of test threads (default is 1). Create NUM test threads. If
>  NUM is not specified, NUM is set to the number of available CPUs. See \-d,
>  \-i and \-p for further information.
> +.
>  .TP
>  .B \-\-tracemark
>  write a trace mark when \-b latency is exceeded.
> +.
>  .TP
>  .B \-u, \-\-unbuffered
>  force unbuffered output for live processing
> +.
>  .TP
>  .B \-v, \-\-verbose
>  Output values on stdout for statistics. This option is used to gather
>  statistical information about the latency distribution. The output is sent
>  to stdout. The output format is: "n:c:v", where n is the task number, c is
>  the count, and v is the latency value in microseconds.
> +.
>  .TP
>  .B \-\-dbg_cyclictest
>  Print info userful for debugging cyclictest
> +.
>  .TP
>  .B \-x, \-\-posix_timers
>  Use POSIX timers instead of clock_nanosleep.
> -
> +.
>  .SH SEE ALSO
>  .BR numa (3),
>  .BR numactl (8),
> +.
>  .SH AUTHOR
>  cyclictest was written by Thomas Gleixner <tglx@linuxtronix.de>.
>  .PP
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com

