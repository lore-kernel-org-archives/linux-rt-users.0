From: Remy Bohmer <linux@bohmer.net>
Subject: Re: System lockup with 2.6.26.8-rt16 on ARM9 [Solved]
Date: Sun, 30 Aug 2009 11:34:21 +0200
Message-ID: <3efb10970908300234q60e56418kbab64ef9a1dd23e3@mail.gmail.com>
References: <3efb10970908290047k6f4d5a14of148db7f2b179f18@mail.gmail.com>
	 <1251556965.9909.10.camel@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Daniel Walker <dwalker@fifo99.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752870AbZH3JeX@vger.kernel.org>
In-Reply-To: <1251556965.9909.10.camel@desktop>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Daniel,


2009/8/29 Daniel Walker <dwalker@fifo99.com>:
> On Sat, 2009-08-29 at 09:47 +0200, Remy Bohmer wrote:
>
>> Well, we found the root cause of this problem.
>> It turned out to be caused by sched_clock() that made disjunct time =
jumps.
>> This caused this check to become true in kernel/sched_rt.c:370:
>> =A0 =A0 =A0 =A0 =A0if (rt_rq->rt_time > runtime) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_rq->rt_throttled =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rt_rq_throttled(rt_rq)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sched_rt_rq_dequeue(=
rt_rq);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 }
>>
>> The end results is that all realtime tasks got throttled for a long
>> time, and that time got extended every time sched_clock() made such =
a
>> jump. I would never have expected the scheduler would show this kind
>> of behaviour while CONFIG_RT_GROUP_SCHED is _not_ set...
>>
>> The root-cause of the sched_clock being faulty was a synchronisation
>> issue between 2 clock domains. The CPU clock and the clock domain of
>> the peripheral (GPT) on which the sched_clock() implementation was
>> based. The GPT made jumps backwards which triggered a false wraparou=
nd
>> detection in the conversion of 32->64 bit timestamps, causing the ti=
me
>> to jump about 356 seconds in the future...
>>
>
> Can you tell us more about what type of board this was? I've never he=
ard
> of a ARM board having an unstable clocksource before ..

It was a Freescale iMX25 based board... (hmm, looking at it, it was a
driver build by Montavista that configured the GPT as clocksource, so
it might be interesting info for you too, notice that the EPIT turns
out to be much more stable in this processor. I also never seen this
problem on iMX35 based boards for which the same driver was used.)

Remy
