From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: LTTng 0.193 fixes RT kernel support
Date: Tue, 23 Feb 2010 21:05:08 +0530
Message-ID: <f5a7b3811002230735p2eb90904l33e8090ade66fc14@mail.gmail.com>
References: <f5a7b3811002160717y65b4577buf53e5784c71575c3@mail.gmail.com>
	 <alpine.LFD.2.00.1002161727570.2811@localhost.localdomain>
	 <20100216164744.GA25115@Krystal>
	 <alpine.LFD.2.00.1002161757050.2811@localhost.localdomain>
	 <20100216170540.GA28039@Krystal>
	 <f5a7b3811002170236i6c560eadp2de7deb10082db4f@mail.gmail.com>
	 <20100217230854.GA25636@Krystal>
	 <f5a7b3811002220737r502e75c1w5ab5a64b6cc27b68@mail.gmail.com>
	 <f5a7b3811002230329w64cabac9lff95a40cb5e7dfa5@mail.gmail.com>
	 <20100223123016.GA12857@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	ltt-dev@lists.casi.polymtl.ca,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59485 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0BWPfK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Feb 2010 10:35:10 -0500
In-Reply-To: <20100223123016.GA12857@Krystal>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 23, 2010 at 6:00 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * naresh kamboju (naresh.kernel@gmail.com) wrote:
>> On Mon, Feb 22, 2010 at 9:07 PM, naresh kamboju <naresh.kernel@gmail=
=2Ecom> wrote:
>> > On Thu, Feb 18, 2010 at 4:38 AM, Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> >> * naresh kamboju (naresh.kernel@gmail.com) wrote:
>> >>> On Tue, Feb 16, 2010 at 10:35 PM, Mathieu Desnoyers <compudj@kry=
stal.dyndns.org> wrote:
>> >>> > Oh, right. Thanks for the explanation. I'll look into moving L=
TTng to a
>> >>> > saner del_timer_sync() scheme to delete the timers.
>>
>> patch trace-clock-32-to-64-use-del-timer-sync.patch is causing above
>> problem on SMP.
>>
>> with out this patch on SMP reported the previous bug as BUG: sleepin=
g
>> function called from invalid context at kernel/rtmutex.c:685
>>
>> However, i'll investigate.
>
> Hrm, we should turn the arch/{arm/mach-omap2,x86/kernel}/trace-clock.=
c:
> trace_clock_lock into a mutex, and kernel/trace/trace-clock-32-to-64.=
c:
> synthetic_tsc_lock into a mutex too.

I have modified kernel/trace/trace-clock-32-to-64.c spin_lock to
mutex_lock to all the calls

-static DEFINE_SPINLOCK(synthetic_tsc_lock);
+static DEFINE_MUTEX(synthetic_tsc_lock);

-       spin_lock(&synthetic_tsc_lock);
+       mutex_lock(&synthetic_tsc_lock);

for arch/{arm/mach-omap2/kernel}/trace-clock.c is already modified as
above from the patch
omap-trace-clock-fix-mutex.patch
from LTTng patches 02-Feb-2009.
this patch was prepared by you to fix
BUG: sleeping function called from invalid context at kernel/mutex.c:20=
7.

Still reporting same bug at my end :-(

let me try in all possible ways.

Best regards
Naresh Kamboju
>
> I used a spinlock previously on ARM because it was called from power
> management resume, but now that the data structures touched by this c=
ode
> path are per-cpu, this lock is not taken there, so it should be OK to
> turn it into a mutex.
>
> Can you try that and tell me if that fixes your issues ?
>
> Thanks,
>
> Mathieu
>
>>
>> Best regards,
>> Naresh Kamboju
>> >> Thanks,
>> >>
>> >> Mathieu
>> >>
>> >> --
>> >> Mathieu Desnoyers
>> >> OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F =A0BA06 3F25 A8=
=46E 3BAE 9A68
>> >>
>> >
>>
>> _______________________________________________
>> ltt-dev mailing list
>> ltt-dev@lists.casi.polymtl.ca
>> http://lists.casi.polymtl.ca/cgi-bin/mailman/listinfo/ltt-dev
>>
>
> --
> Mathieu Desnoyers
> OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F =A0BA06 3F25 A8FE 3=
BAE 9A68
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
