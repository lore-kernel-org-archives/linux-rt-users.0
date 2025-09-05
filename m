Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81232F7ABB
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Sep 2025 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086490; cv=none; b=T+HxY0gbgdQvw5UG3871hL5qKLPikiNQdxvrpuv8dyQ3z01C+KGLjdqslcwB0IAgvBJFd+GpCAORNrxFqCnHpuOQWEI1T6HOQ+Pu5pzzINhuc+aHTGZUjedjzKAQTDqBG2hBYIVJOOcj67vVhRgSWiXhNLZML1eemJo59lB34sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086490; c=relaxed/simple;
	bh=ZEspRa7OUlKzTrkjpsH/XAPO/dEr2p92EJdITLyKVYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bf4XO/qNDp8Jnkaqq9zV2O8QjQUl11mstiFObTS/78pd+YwM+ZJNeA1PvWUohe6hyGZFG6D54gMzuWIn3906EGXBRFdENiUPDhsDAS5ipZ8kZeyxve+z/tfcBovA6dCgOk/wv4jHCqtgGmVCS+kYsg56FcNHtC+pOAhix6UCGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=MttFa0rz; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="MttFa0rz"
Received: from [IPV6:2a01:e34:ec24:52e0:f5ae:e894:8298:679c] (unknown [IPv6:2a01:e34:ec24:52e0:f5ae:e894:8298:679c])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id EFEEC60129;
	Fri,  5 Sep 2025 17:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757086486;
	bh=ZEspRa7OUlKzTrkjpsH/XAPO/dEr2p92EJdITLyKVYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MttFa0rzlBKyJ/1OS0qKvuTzgiBR+wZpq2HoRxvkfl7kUWhkrPCNfS04L25LJwFtp
	 w8KXAk5RmDB8J59qMY0ndNRl9vkBlsFDu8t9isFJh3w8h0S0oIxYEQgVqqM3CtkrMG
	 Kjhnaa4n54joNRT0gMFCQPTTNYbA1dcz+SlaqqCQvv1aLA1SN+J2p9XbWimONQEvXe
	 6Mc2hLGEVZzNDINy+tvfrk6DVeK+6HKzqKI77IyduJoyXVCLHqqARtIYR4OYWpxjBE
	 s3ToqGw5FkgrS8dEgrlwYrqs08g8EJ9m7aq0ymoAH7wKr+t/mNjgeuE3vOWhWAHh7c
	 oHMZuIDuRMAmQ==
Message-ID: <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
Date: Fri, 5 Sep 2025 17:34:33 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Large(ish) variance induced by SCHED_FIFO
To: John Ogness <john.ogness@linutronix.de>, Daniel Wagner <dwagner@suse.de>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Daniel Wagner <daniel.wagner@suse.com>, Clark Williams
 <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <841polf13z.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 16:03, John Ogness wrote:

> On 2025-09-05, Marc Gonzalez wrote:
>
>> (I used CLOCK_MONOTONIC_RAW.)
> 
> Not really relevant to your issue, but you should always use CLOCK_MONOTONIC.

Could you provide some insight as to why CLOCK_MONOTONIC is preferable?

https://www.man7.org/linux/man-pages/man3/clock_gettime.3.html

CLOCK_MONOTONIC

A non-settable system-wide clock that represents monotonic time since
(as described by POSIX) "some unspecified point in the past". On Linux,
that point corresponds to the number of seconds that the system has been
running since it was booted.

The CLOCK_MONOTONIC clock is not affected by discontinuous jumps in the
system time (e.g., if the system administrator manually changes the clock),
but is affected by the incremental adjustments performed by adjtime(3) and NTP.
This clock does not count time that the system is suspended.
All CLOCK_MONOTONIC variants guarantee that the time returned by
consecutive calls will not go backwards, but successive calls may
(depending on the architecture) return identical (not-increased)
time values.


CLOCK_MONOTONIC_RAW (since Linux 2.6.28; Linux-specific)

Similar to CLOCK_MONOTONIC, but provides access to a raw hardware-based time
that is not subject to NTP adjustments or the incremental adjustments performed
by adjtime(3). This clock does not count time that the system is suspended.


CLOCK_MONOTONIC_RAW seemed less susceptible to "interference" :)

>> It looks like there is some kind of 50 millisecond quantum
>> involved somewhere somehow.
> 
> Did you forget to disable RT throttling?
> 
> $ sudo sysctl -w kernel.sched_rt_runtime_us=-1
> 
> If you check the kernel logs, you would see a message about throttling:
> 
> "sched: RT throttling activated"

YES!!!

I didn't think to look at dmesg :(

And I had looked at sched-related proc nodes...

$ grep "" /proc/sys/kernel/sched_*
/proc/sys/kernel/sched_autogroup_enabled:1
/proc/sys/kernel/sched_cfs_bandwidth_slice_us:5000
/proc/sys/kernel/sched_deadline_period_max_us:4194304
/proc/sys/kernel/sched_deadline_period_min_us:100
/proc/sys/kernel/sched_rr_timeslice_ms:100
/proc/sys/kernel/sched_rt_period_us:1000000
/proc/sys/kernel/sched_rt_runtime_us:950000
/proc/sys/kernel/sched_schedstats:0
/proc/sys/kernel/sched_util_clamp_max:1024
/proc/sys/kernel/sched_util_clamp_min:1024
/proc/sys/kernel/sched_util_clamp_min_rt_default:1024

... but my brain didn't register the obvious clue,
although it was right there: 1000000 - 950000 = 50 ms !!

Now everything works as expected, even in multi-user mode:

$ sudo ./run_benchmark.sh fifo
2155899243
2155930350
2155925344
2155545153
2155520262
2155520647
2155531815
2155586328
2155501088
2155887042
2155937889
2155990740
2155939605
2155509468
2155898441
2155615316
2155498933
2155968150
2155493295
2155496287
2155949449
2155488499
2155932900
2155498135
2155531294
2156047123
2156035893
2155926392
2155917489
2155482792

EXCEPT... that my mouse is sluggish as molasses when the script
runs on CPU1 (but not when it runs on other cores).

I'm probably starving an important ISR :)

[migration/0] pid 18's current affinity list: 0
[migration/1] pid 23's current affinity list: 1
[migration/2] pid 29's current affinity list: 2
[migration/3] pid 35's current affinity list: 3
[idle_inject/0] pid 19's current affinity list: 0
[idle_inject/1] pid 22's current affinity list: 1
[idle_inject/2] pid 28's current affinity list: 2
[idle_inject/3] pid 34's current affinity list: 3
[irq/9-acpi] pid 54's current affinity list: 1
[watchdogd] pid 62's current affinity list: 0-3
[irq/24-PCIe PME] pid 68's current affinity list: 2
[irq/24-pciehp] pid 69's current affinity list: 2
[irq/24-s-pciehp] pid 70's current affinity list: 2
[irq/25-PCIe PME] pid 71's current affinity list: 3
[irq/8-rtc0] pid 74's current affinity list: 0
[irq/23-ehci_hcd:usb1] pid 75's current affinity list: 1
[irq/16-ehci_hcd:usb2] pid 81's current affinity list: 2
[irq/26-xhci_hcd] pid 159's current affinity list: 1
[irq/27-ahci[0000:00:1f.2]] pid 162's current affinity list: 1
[irq/18-i801_smbus] pid 388's current affinity list: 1
[irq/29-mei_me] pid 411's current affinity list: 2
[card1-crtc0] pid 461's current affinity list: 0-3
[card1-crtc1] pid 462's current affinity list: 0-3
[irq/30-i915] pid 463's current affinity list: 3
[irq/31-snd_hda_intel:card0] pid 514's current affinity list: 0
[irq/32-snd_hda_intel:card1] pid 518's current affinity list: 1
[psimon] pid 334's current affinity list: 0-3
[psimon] pid 1075's current affinity list: 0-3

Most of the USB ISRs run on core 1, no wonder my USB mouse feels limp :)

Thanks David & John for pointing me in the right direction!

Regards


