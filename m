Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6ECA5E
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Sep 2025 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029553; cv=none; b=hFtlO3VdUcel7gGjhkss31lAomi94GOVCprx9tLHfSlBwYB301gia446acdb2ruI9QjejRKBphDKisIZpDFk67nZ8J3ForjzlRQXsEGDYitH3TF2a7RDxVBv6hvUJzp+3IyN2EfDEL0Vc68aA65TrwgFGjPJPwIw6yUwCU4wD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029553; c=relaxed/simple;
	bh=trrQ9vFTRbURuzBe42qBpSnJoKu9sp1OQ2w9Rz5PH/M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cxujUOypvsHPVZnF53+mmiJz4zoxDENm0RRripjmh/BPwGbhZiaOkV2tk0hoQmP9Auakqe2qIxP8sp/+Vt8p3qqyzdtu+djQkTfIu9nKpDH/0WpdbGJ6Jo20Ex7YMP45Qxkv15HCITIiWww9RLzsGxlWUstNAJOzgIvtdYG1c4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=KDYNkc4E; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="KDYNkc4E"
Received: from [IPV6:2a01:e34:ec24:52e0:a9ac:7419:683:57d6] (unknown [IPv6:2a01:e34:ec24:52e0:a9ac:7419:683:57d6])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 9A36F60150;
	Fri,  5 Sep 2025 01:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757029542;
	bh=trrQ9vFTRbURuzBe42qBpSnJoKu9sp1OQ2w9Rz5PH/M=;
	h=Date:To:Cc:From:Subject:From;
	b=KDYNkc4Ek0Mfva1auJCHEyr6PjIZ7mm5AMNvIUZyWhOunKnwcKD/C47p2f+xUPOUj
	 vG61jkjKXYaorG57CHfbKZ2v9iW9KA0T+9uDqEZEncPZUh2K2JbkUH006GvXIwsJ38
	 vXxkBkaN1WXGTr0xIZQCrB4hoRExXNZHZtI/EUpX5wSmz+WNlFryzsVoR+qFjylmF0
	 FlA+on2kTiglN2qBPo+lwc49kGnbQKPMCWjSuN61mEL/zPXBvGP/0e210GUmwm5czj
	 Mask9/NICwVYMc67ItOqTBYLfShTZ9DC4xLlV5LQVeqvBz+kaxnHkm5SRr8xtz3FEL
	 Te4idhilAH4Rg==
Message-ID: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
Date: Fri, 5 Sep 2025 01:45:31 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-rt-users@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Daniel Wagner <daniel.wagner@suse.com>, Clark Williams
 <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Large(ish) variance induced by SCHED_FIFO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

I am currently *NOT* running a PREEMPT_RT kernel.

I am trying to get reproducible / deterministic / low variance results
using a vendor kernel (6.8.0-79-generic #79-Ubuntu SMP PREEMPT_DYNAMIC).

I have removed all sources of noise / variance I could think of:

- SMT is disabled in BIOS
lscpu reports "Thread(s) per core: 1"
cat /sys/devices/system/cpu/smt/active returns 0

- Kernel boots in single user mode
No GUI, just a text terminal
Nothing running other than system daemons & bash

- Kernel runs with threadirqs command-line parameter
ISRs run as SCHED_FIFO processes with prio 50
$ ps -e -o pid,cls,pri,args --sort pri
    PID CLS PRI COMMAND
     18  FF 139 [migration/0]
     23  FF 139 [migration/1]
     29  FF 139 [migration/2]
     35  FF 139 [migration/3]
     19  FF  90 [idle_inject/0]
     22  FF  90 [idle_inject/1]
     28  FF  90 [idle_inject/2]
     34  FF  90 [idle_inject/3]
     54  FF  90 [irq/9-acpi]
     62  FF  90 [watchdogd]
     68  FF  90 [irq/24-PCIe PME]
     69  FF  90 [irq/24-pciehp]
     70  FF  90 [irq/24-s-pciehp]
     71  FF  90 [irq/25-PCIe PME]
     74  FF  90 [irq/8-rtc0]
     75  FF  90 [irq/16-ehci_hcd:usb1]
     82  FF  90 [irq/23-ehci_hcd:usb2]
    162  FF  90 [irq/26-xhci_hcd]
    164  FF  90 [irq/28-ahci[0000:00:1f.2]]
    377  FF  90 [irq/18-i801_smbus]
    384  FF  90 [irq/29-mei_me]
    411  FF  90 [card1-crtc0]
    412  FF  90 [card1-crtc1]
    413  FF  90 [irq/30-i915]
    463  FF  90 [irq/31-snd_hda_intel:card0]
    466  FF  90 [irq/32-snd_hda_intel:card1]
    335  FF  41 [psimon]
   1076  FF  41 [psimon]

- Frequency of CPUs is "pinned" at 3 GHz
No "turbo boost" (frequency varies with temperature).
Slightly below nominal freq to avoid temp throttling.
(Intel Core i5-4590 CPU @ 3.30GHz)
for I in 0 1 2 3; do
  echo userspace > /sys/devices/system/cpu/cpu$I/cpufreq/scaling_governor
  echo   3000000 > /sys/devices/system/cpu/cpu$I/cpufreq/scaling_setspeed
done

- Program is pinned to CPU #1
Avoid any cache ping pong.
Avoid CPU #0 in case it handles more interrupts.
$ taskset -c 1 ./a.out

And the last thing I wanted to do is:

- Run benchmark as SCHED_FIFO 99 to make sure NOTHING could interrupt it
bench is strictly computational:
no system calls, no I/O, no sleeping, just number crunching.

However, I noticed that the results have MORE variance when
the program runs as SCHED_FIFO than when it runs as SCHED_OTHER.

Here is my testcase:

Toy benchmark:
# define N (1 << 30)
int main(void)
{
	for (volatile int i = 0; i < N; ++i);
	return 0;
}

Compiled with gcc -O3 toy.c

Then I run this script as root:
#!/bin/bash

CMD="taskset -c 1 ./a.out"
if [ "$1" = "fifo" ]; then CMD="chrt -f 99 $CMD"; fi

for I in $(seq 1 30); do
  T0=$(date "+%s.%N")
  $CMD
  T1=$(date "+%s.%N")
  echo "$T1-$T0" | bc -l
done

Once without fifo (SCHED_OTHER), once with fifo (SCHED_FIFO).

(Full results at the end of the message)

For SCHED_OTHER:
MIN_RUNTIME=2.158045784 seconds
MAX_RUNTIME=2.158515466 seconds
i.e. all runs are within +/- 109 ppm (MAX-MIN)/(MAX+MIN)

For SCHED_FIFO:
MIN_RUNTIME=2.247394425 seconds
MAX_RUNTIME=2.305229091 seconds
i.e. all runs are within +/- 12700 ppm
i.e. 100 times WORSE than SCHED_OTHER... :(

HOWEVER, if we sort SCHED_FIFO results, we clearly see 3 "islands":
first run-time is the minimum outlier = 2.247394425
21 results in [2.253636818, 2.254797674] => 257 ppm
 8 results in [2.304188238, 2.305229091] => 226 ppm
Still not as good as SCHED_FIFO but nowhere near as bad.


Questions I have no answers for at this time:

What could explain this behavior?
Why several "islands" of results when running as SCHED_FIFO 99?
Why is the variance still greater within an island?

Thanks for reading me this far!! :)

Regards


Raw results for reference:

SCHED_OTHER
2.158171245
2.158127633
2.158129497
2.158109551
2.158089224
2.158515466
2.158083084
2.158127232
2.158282178
2.158135800
2.158123891
2.158045784
2.158174865
2.158141835
2.158184503
2.158118620
2.158096101
2.158150349
2.158150868
2.158076309
2.158179210
2.158134907
2.158202927
2.158108137
2.158182418
2.158088121
2.158095718
2.158165650
2.158134169
2.158119635

SCHED_FIFO
2.247394425
2.254726778
2.305229091
2.253719228
2.254658938
2.254744883
2.304188238
2.254670366
2.254683699
2.254683326
2.304284105
2.253755218
2.254756793
2.304288106
2.254756981
2.253636818
2.254797674
2.304240533
2.254630310
2.254659655
2.254696007
2.304234345
2.254739714
2.254766850
2.254620088
2.304224451
2.254608929
2.254732058
2.304227047
2.254665694


