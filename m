Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85B1EEE6
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569988; cv=none; b=PkwWulyKdwDag/q7fUW1AoWRfqC+TxTX9x71x/xoJPU0fWcKXmkqVjw9/zQHmnREZmsS7iMlA7EKi4E6BzpjUpJ4SVZEY6yuaz5vDxYI22J9UiKhJU39Ci5uOHSv0P5fQUWM0zlS8VraDofQI5sfE1IaES2t3Cu3wr/19Yseq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569988; c=relaxed/simple;
	bh=QWxDKiCnQ6K2XtY0+jWV0DGzRyLcjnkfjXA8cimjav0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og0hIYM5XKxTR1r7fKgQNkH0IblQWae5n+JW94zeZYDEaWHOF4ZIV24WNfh0tfPtwR1hPghBTdCrG+hhiicPTW4oV5PCcCMkahVeaTPhmhTQm/EWkOWwhn1+If68wzXBMubqknHwOxWqLxHgghJo4bSSHdQGFP7HwO62YOHnnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=lYW9Hu78; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="lYW9Hu78"
Received: from [IPV6:2a01:e34:ec24:52e0:ba49:5fc1:b1a1:93e0] (unknown [IPv6:2a01:e34:ec24:52e0:ba49:5fc1:b1a1:93e0])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 2328E13F8A7;
	Tue,  7 Apr 2026 15:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1775569978;
	bh=QWxDKiCnQ6K2XtY0+jWV0DGzRyLcjnkfjXA8cimjav0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lYW9Hu784ZGf9dy2eCV+5gI9ODLRgkAujRse/eHtMkpHqE4IdVT9dlwTu8vpmLN8l
	 lRLKYveGOudSXrjgl17zVZ0Chz6PDaJeJHfwoih+TJlrUJ5p+jJ+S8ScSp2YhM7t3L
	 fbTTpFkYa86gNEFJXolklRfHP+YZuqP1nvjRO+BRutB4190pkeEjf0qQMzz2K93gZt
	 2FpS6wiPynFsn3K+6vSsTBbdSQvod0NiFQ001rlXWIvGPtj5n5FTmDXjiyqe1WXUe7
	 kCPmw5dvMUvdCK346pvdXii92ECzOkBPZkv9imjP7XoWhEPW/DR0oxiGDk/w51Crp2
	 njJdxEhihz+WQ==
Message-ID: <b73d91c0-2fc8-45fc-959e-5fc2b484e0fe@free.fr>
Date: Tue, 7 Apr 2026 15:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of simple program (part 2)
To: "John D. McCalpin" <john@mccalpin.com>
Cc: linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
 Leon Woestenberg <leon@sidebranch.com>,
 John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Agner Fog <agner@agner.org>,
 Dirk Beyer <dirk.beyer@lmu.de>, Philipp Wendler <philipp.wendler@lmu.de>,
 Matt Godbolt <matt@godbolt.org>
References: <199905cb-04b3-4d3e-aeb3-da2b2d6428eb@free.fr>
 <5397d0cd-9266-44ae-97f2-75164d89bf48@free.fr>
 <b1630867-0e0c-47fd-8de2-ffca2f517da3@free.fr>
 <17537284-FA52-40E5-A70F-1120FCEB8BC6@mccalpin.com>
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <17537284-FA52-40E5-A70F-1120FCEB8BC6@mccalpin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Doctor Bandwidth,

I was secretly hoping you would chime in! :)

You've moved to Spain if I understand correctly?

On 07/04/2026 10:37, John D. McCalpin wrote:

> Going back to the example discussed at [in 2025-09], it looks like
> the benchmark takes ~2500 ns and that you are executing the
> benchmark 2^16 times.   Does that mean you are launching a new
> process 2^16 times?  If so, exactly what mechanism are you using?
> The variation you are reporting of 0.1 to 0.3 microseconds per
> execution seems very small to me.  Are you sure that the variation
> is in the "execution time", or could it be associated with the
> launching of the execution?   If the benchmark code is being
> executed 2^16 times in a loop in a single execution, then the
> situation quite different and performance counters should be very
> effective at determining the cause of the variability.


I understand that process creation is a costly operation.
I do run the benchmark several times from the same process.
(I plan on revisiting your above remarks after I digest them.)


> For the performance counter side of things, I would recommend
> programming the performance counters externally to the benchmark
> process and using inline RDPMC instructions to get the counter
> values (inside the benchmark executable).


Why do you suggest programming the PMCs from outside the benchmark process?
(Is it perhaps because it's simpler than using the kernel API?)

It never occurred to me that I could read the PMCs from user-space!

This is what I've been doing until now:

int open_event(u64 type, u64 config, int fd)
{
	struct perf_event_attr attr = {
		.type = type,
		.size = sizeof(attr),
		.config = config,
		.read_format = PERF_FORMAT_GROUP,
	};

	return syscall(SYS_perf_event_open, &attr, 0, 3, fd, 0);
}

	int main_fd = open_event(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES, -1);
	open_event(PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, main_fd);
	open_event(PERF_TYPE_RAW, UOPS_EXECUTED, main_fd);
	open_event(PERF_TYPE_RAW, EXEC_STALLS, main_fd);

	for (int i = 0; i < 1000000; ++i)
	{
		ioctl(main_fd, PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP);
		for (int i = 0; i < N; ++i) spin(ctx);
		if (read(main_fd, v, sizeof v) < sizeof v) return 2;
		printf("%lu %lu %lu %lu\n", v[1]/N, v[2]/N, v[3]/N, v[4]/N);
	}

The problem with that technique is that the PMCs are "polluted" by
the exit from ioctl & the entry into read.

Reading the PMCs from user-space with RDPMC solves this issue!

Found this interesting suggestion from 10 years ago:
https://community.intel.com/t5/Software-Tuning-Performance/How-to-read-performance-counters-by-rdpmc-instruction/m-p/1009043
I think you might be familiar with the responder ;)


> I am not certain what the lowest overhead mechanism might be for
> getting those performance counter values out of the program — I
> would probably try attaching to a persistent System V shared memory
> segment and simply storing the values in memory for later post-processing.


Are you implying that simply using printf might disturb the caches
from the write calls? (I redirect the output to a tmpfs.)


> On Intel SKX processors I measured the overhead of an RDPMC
> instruction at as low as ~25 cycles, with RDTSCP instructions taking
> a little bit longer (~40 cycles), but most importantly inline RDPMC
> does not involve any uncontrolled code paths or any hardware
> accesses outside the core.  RDTSCP is similar, but might be
> accessing off-core resources — the timing depends on both the core
> and uncore clock frequencies.

Thanks for the great suggestion. I'll be reading up on RDPMC.

Why do you think I would need RDTSCP?
At the moment, I just pin all cores at 2 GHz & count cycles using PMCs.

Reference for myself:
https://www.codestudy.net/blog/difference-between-rdtscp-rdtsc-memory-and-cpuid-rdtsc/

Regards

