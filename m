Received: from spamshark02.webhero.com (spamshark02.webhero.com [216.57.225.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4903A7839
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Apr 2026 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.57.225.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641126; cv=none; b=nZQo/Tgut1YGmxRPsLhCRZp2/rld7etCU7OLlXI2XMhC2AFjDiioodjgh7D8VxscXrpUSwzX7Bc60mfahJoKNUctNUhdN/DHqPIFUDAeEbon/3VKD4ixBPtpncZVb961LSRfsm9m9UqN2Cd+EB0yVCZnajVBd8H68q+9Oj8miKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641126; c=relaxed/simple;
	bh=IW0WQ6761a4zGv/TwCYgx0loB1ahkPeQtW+6E7Pomck=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Kd58GVCEUCdT+bbk9iGbFWi32j9vxf68xDpb2tE0hNvJRNR/2O6Zg4dqxAdEeeqvM22QqdHcbu9qe9Kf6Cy0Ka43wAL+4P9Jb/GdzeTHp5Qqg/V52joiHM6URQyqY+/QKQhQvHPhyrIWSGIAK/pzyDsVauv3/qUfrsAI/6/RB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mccalpin.com; spf=pass smtp.mailfrom=mccalpin.com; dkim=pass (2048-bit key) header.d=mccalpin.com header.i=@mccalpin.com header.b=kc9MXRLO; arc=none smtp.client-ip=216.57.225.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mccalpin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mccalpin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mccalpin.com header.i=@mccalpin.com header.b="kc9MXRLO"
Received: from spamshark02.webhero.com (wh-spamfilter-02 [127.0.0.1])
	by spamshark02.webhero.com (Webhero, Inc.) with ESMTP id AAD1637F4D2
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Apr 2026 04:29:42 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mccalpin.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=spamshark; bh=etQNpORE2f3I0BO
	ZQxFVY7fQMYVJDVFPT7WAvXRPs54=; b=kc9MXRLOmHaTs+fEg+NHhcHOc3WfKqP
	vg7fkM7zCKoybhkrVg3tlchq2a/LD4gQEW387TbPakZ3lt48y6luewxFYXvKCMCL
	pSqS90tjFKVX7m8QlxN2X8pHlILcYtB1imEazo/iXmzbyO+IqZmnUVpIXanoMkFN
	mHWQpjgJor49U9jBycxf2eebRevi/0qe8fd55xMrddTVSC2GT1dowqXPNYKnUd3K
	0IJ20yHBDPXuPVRhHXM3NnU4oD5tewbbiA0WnZi1JOLQ4xNR1Nx+x8bWBTWIXOla
	eTQWjG77MopFUPYOfmiMmaL3X6ync1hdSCMjs+Py/GWZR7IDz+hKpzw==
Received: from qmail09.webhero.com (unknown [192.168.42.19])
	by spamshark02.webhero.com (Webhero, Inc.) with ESMTPS id 0150C37F4C1
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Apr 2026 04:29:38 -0500 (CDT)
Received: (qmail 16778 invoked by uid 10000); 8 Apr 2026 09:29:37 -0000
Received: from unknown (HELO smtpclient.apple) (john@mccalpin.com@79.153.3.165)
  by qmail09.webhero.com with ESMTPA; 8 Apr 2026 09:29:37 -0000
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: Unexplained variance in run-time of simple program (part 2)
From: "John D. McCalpin" <john@mccalpin.com>
In-Reply-To: <b73d91c0-2fc8-45fc-959e-5fc2b484e0fe@free.fr>
Date: Wed, 8 Apr 2026 11:29:19 +0200
Cc: linux-rt-users@vger.kernel.org,
 Daniel Wagner <dwagner@suse.de>,
 Leon Woestenberg <leon@sidebranch.com>,
 John Ogness <john.ogness@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>,
 Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Agner Fog <agner@agner.org>,
 Dirk Beyer <dirk.beyer@lmu.de>,
 Philipp Wendler <philipp.wendler@lmu.de>,
 Matt Godbolt <matt@godbolt.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FA25B6F-71A1-4B2B-9488-46D91445DAF3@mccalpin.com>
References: <199905cb-04b3-4d3e-aeb3-da2b2d6428eb@free.fr>
 <5397d0cd-9266-44ae-97f2-75164d89bf48@free.fr>
 <b1630867-0e0c-47fd-8de2-ffca2f517da3@free.fr>
 <17537284-FA52-40E5-A70F-1120FCEB8BC6@mccalpin.com>
 <b73d91c0-2fc8-45fc-959e-5fc2b484e0fe@free.fr>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Responses inline.


> On Apr 7, 2026, at 3:52=E2=80=AFPM, Marc Gonzalez =
<marc.w.gonzalez@free.fr> wrote:
>=20
> Hello Doctor Bandwidth,
>=20
> I was secretly hoping you would chime in! :)
>=20
> You've moved to Spain if I understand correctly?

I moved to Spain last year and have been working at the Barcelona =
Supercomputing Center for about 9 months.


>=20
> On 07/04/2026 10:37, John D. McCalpin wrote:
>=20
>> Going back to the example discussed at [in 2025-09], it looks like
>> the benchmark takes ~2500 ns and that you are executing the
>> benchmark 2^16 times.   Does that mean you are launching a new
>> process 2^16 times?  If so, exactly what mechanism are you using?
>> The variation you are reporting of 0.1 to 0.3 microseconds per
>> execution seems very small to me.  Are you sure that the variation
>> is in the "execution time", or could it be associated with the
>> launching of the execution?   If the benchmark code is being
>> executed 2^16 times in a loop in a single execution, then the
>> situation quite different and performance counters should be very
>> effective at determining the cause of the variability.
>=20
>=20
> I understand that process creation is a costly operation.
> I do run the benchmark several times from the same process.
> (I plan on revisiting your above remarks after I digest them.)

I am still not clear on exactly what you mean by =E2=80=9Cexecuting the =
benchmark 2^16 times=E2=80=9D.
Are you forking a new process 2^16 times, or is a single process =
executing a block of code 2^16 times.
The difference is critical for determining where to look for sources of =
performance variability.


>> For the performance counter side of things, I would recommend
>> programming the performance counters externally to the benchmark
>> process and using inline RDPMC instructions to get the counter
>> values (inside the benchmark executable).
>=20
>=20
> Why do you suggest programming the PMCs from outside the benchmark =
process?
> (Is it perhaps because it's simpler than using the kernel API?)
>=20
> It never occurred to me that I could read the PMCs from user-space!
>=20
> This is what I've been doing until now:
>=20
> int open_event(u64 type, u64 config, int fd)
> {
> struct perf_event_attr attr =3D {
> .type =3D type,
> .size =3D sizeof(attr),
> .config =3D config,
> .read_format =3D PERF_FORMAT_GROUP,
> };
>=20
> return syscall(SYS_perf_event_open, &attr, 0, 3, fd, 0);
> }
>=20
> int main_fd =3D open_event(PERF_TYPE_HARDWARE, =
PERF_COUNT_HW_CPU_CYCLES, -1);
> open_event(PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, main_fd);
> open_event(PERF_TYPE_RAW, UOPS_EXECUTED, main_fd);
> open_event(PERF_TYPE_RAW, EXEC_STALLS, main_fd);
>=20
> for (int i =3D 0; i < 1000000; ++i)
> {
> ioctl(main_fd, PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP);
> for (int i =3D 0; i < N; ++i) spin(ctx);
> if (read(main_fd, v, sizeof v) < sizeof v) return 2;
> printf("%lu %lu %lu %lu\n", v[1]/N, v[2]/N, v[3]/N, v[4]/N);
> }
>=20
> The problem with that technique is that the PMCs are "polluted" by
> the exit from ioctl & the entry into read.
>=20
> Reading the PMCs from user-space with RDPMC solves this issue!

The perf_event subsystem is able to read the performance counters =
without requiring a kernel transition at every read, but internally the =
process is rather complex.  For fine-grain measurements on code that (1) =
can be bound to a single logical processor and (2) be read frequently =
enough that overflows can be unambiguously detected, there is no reason =
not to use the RDPMC instruction directly.  (Recent versions of the =
Linux kernel have started disabling the RDPMC instruction for user mode =
by clearing CR4.PCE by default, and only enabling it when the perf_event =
library wants to use it.  This irritates me more than I can easily =
express, but it can be overridden (in the kernels I have been using) by =
echoing a value of =E2=80=9C2=E2=80=9D to /sys/devices/cpu/rdpmc.)




> Found this interesting suggestion from 10 years ago:
> =
https://community.intel.com/t5/Software-Tuning-Performance/How-to-read-per=
formance-counters-by-rdpmc-instruction/m-p/1009043
> I think you might be familiar with the responder ;)
>=20
>=20
>> I am not certain what the lowest overhead mechanism might be for
>> getting those performance counter values out of the program =E2=80=94 =
I
>> would probably try attaching to a persistent System V shared memory
>> segment and simply storing the values in memory for later =
post-processing.
>=20
>=20
> Are you implying that simply using printf might disturb the caches
> from the write calls? (I redirect the output to a tmpfs.)

The degree of disturbance depends on the size of the =E2=80=9Cbenchmark=E2=
=80=9D being measured.  If the code executes millions of instructions =
between output points, then it is probably OK to just use =
=E2=80=9Cprintf()=E2=80=9D, but if you are reading performance counters =
around loops of a thousand cycles then you need to be more careful about =
how the data is output (especially if the code under test is measuring =
access to the caches).

A technique I commonly use is to allocate a small output buffer (much =
smaller than the L1 DCache) and zero it immediately before the first =
performance counter reads so that it will be resident in the L1 cache in =
a writable state.  I then run a block of iterations and save the =
performance counter values in the buffer.  Once the buffer is filled I =
copy the contents to a larger buffer in memory, re-zero the small output =
buffer, and start the next block of iterations.  If I want to be careful =
not to cause extra cache pollution, I copy the small output buffer to =
the large output buffer using streaming stores.=20
This approach is useful for getting ensembles of performance counter =
results for repetitions of an identical code loop, or for collecting =
performance counter results for the same loop with different loop =
bounds, strides, or offsets. =20

Changing the performance counter programming is always expensive (since =
the WRMSR instruction can only be executed in kernel mode), so I either =
change those externally to my program or internally but only around very =
large (millions of cycles) blocks of tests.   If the counters need to be =
changed at finer granularity the benchmark can be embedded in a loadable =
kernel module, but the execution time of the required process binding =
and WRMSR instructions is still substantial.=20


>=20
>> On Intel SKX processors I measured the overhead of an RDPMC
>> instruction at as low as ~25 cycles, with RDTSCP instructions taking
>> a little bit longer (~40 cycles), but most importantly inline RDPMC
>> does not involve any uncontrolled code paths or any hardware
>> accesses outside the core.  RDTSCP is similar, but might be
>> accessing off-core resources =E2=80=94 the timing depends on both the =
core
>> and uncore clock frequencies.
>=20
> Thanks for the great suggestion. I'll be reading up on RDPMC.
>=20
> Why do you think I would need RDTSCP?
> At the moment, I just pin all cores at 2 GHz & count cycles using =
PMCs.

RDTSCP is useful to have in the toolbox because (1) it is almost never =
disabled (via CR4.TSD), (2) it has lower overhead than other timers, (3) =
it has some ordering restrictions on execution, (4) the instruction also =
returns the contents of MSR IA32_TSC_AUX in the %ecx register.  The =
interfaces that I use are available at =
https://github.com/jdmccalpin/low-overhead-timers.

There is one exception to (2) and that is using one of the CYCLES events =
in the programmable core performance counters.  On SKX processors, for =
example, the programmable event CPU_CLK_UNHALTED can be read in about 24 =
cycles, while RDSTCP takes about 40 cycles and RDTSC is in the middle =
somewhere.  CPU_CLK_UNHALTED is quite useful for interval measurements =
inside a benchmark because the processor is almost always going to be =
active all the time during the benchmark execution, and =E2=80=9Ccore =
cycles=E2=80=9D is often the most convenient unit of measurement.  (I =
often set the core frequency to match the TSC frequency to minimize the =
probability of unwanted frequency transitions and to make the arithmetic =
easier.  You still need to watch out for unexpected stalls and frequency =
transitions if you are using 256-bit or 512-bit SIMD instructions.)

RDTSCP is =E2=80=9Chalf-ordered=E2=80=9D with respect to other =
instructions.  It will not execute until all prior instructions have =
executed, but it does not prevent future instructions from being started =
earlier than the RDTSCP executes.  The CPUID instruction in the =
reference below is *very expensive* and not recommended for fine-grain =
timing.  If you want to ensure that no instructions have started =
execution before you read the timer, then use the sequence:
	mfence
	lfence
	rdtscp (or rdtsc in this particular case)
before the code being monitored, and the sequence:
	rdtscp
	lfence
after the code being monitored.  =20
I very rarely find a need for the lfence instructions.  It prevents =
later instructions from starting early (which could add cycles before =
the RDTSCP instruction grabs the TSC), but I have never found a case =
where this biased the results by an amount that was visible above the =
background noise.  (RDTSC and RDTSCP are microcoded instructions that =
have variable execution times because they need to communicate with =
off-core resources to obtain a TSC value that is independent of the CPU =
core frequency and the history of CPU active and halted cycles.)

On Linux systems, IA32_TSC_AUX is programmed to contain the socket =
number and logical processor number in concatenated 12-bit fields, and =
the RDTSCP instruction guarantees that the TSC value (returned as two =
32-bit values in registers %eax and %ebx) and the IA32_TSC_AUX value =
were collected atomically on the same logical processor.  So RDTSCP =
provides an extremely low-overhead mechanism to determine the logical =
processor number where the process is currently executing.  As a simple =
hardware instruction, it won=E2=80=99t do anything that might encourage =
the OS to consider re-scheduling the process (while calling a system =
library routine like sched_get_affinity() might).  This can be very =
helpful when trying to debug process affinity problems, e.g., in =
software environments with multiple agents able to make affinity =
requests, e.g., SLURM + OpenMP runtime + MPI runtime.



> Reference for myself:
> =
https://www.codestudy.net/blog/difference-between-rdtscp-rdtsc-memory-and-=
cpuid-rdtsc/
>=20
> Regards
>=20
>=20


