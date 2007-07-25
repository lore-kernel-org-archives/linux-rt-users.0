From: John Sigler <linux.kernel@free.fr>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 15:04:24 +0200
Message-ID: <46A74A58.1070704@free.fr>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu> <46A4B7C2.1070304@free.fr> <20070723160442.GA7995@elte.hu> <46A5B8E3.4060004@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, oprofile-list@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:48615 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758854AbXGYNE2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 09:04:28 -0400
In-Reply-To: <46A5B8E3.4060004@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

John Sigler wrote:

> Ingo Molnar wrote:
>=20
>> add 'notrace' to the definition of read_tsc in arch/i386/kernel/tsc.=
c
>=20
> ( check_dektec_in-1095 |#0): new 271 us user-latency.
> ( check_dektec_in-1095 |#0): new 275 us user-latency.
> ( check_dektec_in-1095 |#0): new 290 us user-latency.
> ( check_dektec_in-1095 |#0): new 297 us user-latency.
> ( check_dektec_in-1095 |#0): new 345 us user-latency.
> ( check_dektec_in-1095 |#0): new 358 us user-latency.
> ( check_dektec_in-1095 |#0): new 384 us user-latency.
> ( check_dektec_in-1095 |#0): new 392 us user-latency.
> ( check_dektec_in-1095 |#0): new 395 us user-latency.
> ( check_dektec_in-1095 |#0): new 396 us user-latency.
> ( check_dektec_in-1095 |#0): new 1031 us user-latency.
> ( check_dektec_in-1095 |#0): new 1100 us user-latency.
> ( check_dektec_in-1095 |#0): new 1105 us user-latency.
> ( check_dektec_in-1095 |#0): new 1106 us user-latency.
>=20
> Here's the function trace for the 1106-=B5s latency:
>=20
> http://linux.kernel.free.fr/latency/1106-us-trace.txt
>=20
> These two lines repeat ~2000 times for ~800 =B5s:
>=20
> softirq--4     0....  272us : __lock_text_start (rt_run_flush)
> softirq--4     0....  272us : rt_spin_unlock (rt_run_flush)
>=20
> With a pair of the following in the middle:
>=20
> softirq--4     0....  670us : call_rcu (rt_run_flush)
> softirq--4     0D..1  670us : __rcu_advance_callbacks (call_rcu)
>=20
> PID 4 is [softirq-timer/0] and has priority 50 in SCHED_FIFO.
> My process has priority 80 in SCHED_RR. It is waiting for IRQ10.
>=20
> # cat /proc/interrupts
>            CPU0
>   0:         37    XT-PIC-XT        timer
>   1:          2    XT-PIC-XT        i8042
>   2:          0    XT-PIC-XT        cascade
>   7:          0    XT-PIC-XT        acpi
>  10:  151250933    XT-PIC-XT        eth2, Dta1xx
>  11:      12435    XT-PIC-XT        eth0
>  12:          4    XT-PIC-XT        eth1
>  14:      17154    XT-PIC-XT        ide0
> NMI:          0
> LOC:    5786548
> ERR:          0
> MIS:          0

Any idea what went wrong in the above function trace?
Why is the kernel spinning in circles that way?

Regards.
