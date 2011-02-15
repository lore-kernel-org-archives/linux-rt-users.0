From: Frank Rowand <frank.rowand@gmail.com>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Tue, 15 Feb 2011 11:35:34 -0800
Message-ID: <AANLkTin7ui0JDyfFCdHFAOdtL5c=d0-51Wf3PcB-X5c2@mail.gmail.com>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
	<AANLkTimGvJWgeEXHFdVBJCidL8ctbAxKJZ8V9KeMxRUX@mail.gmail.com>
	<AANLkTinpxPMVPCw0ND_1t1orEHaYBRfEfruv1v0rws-b@mail.gmail.com>
	<AANLkTimvEy8VE5564CWLeDMHLV8cVBmor8weJos8+ovU@mail.gmail.com>
	<AANLkTikCXF8BY+gh3P0kZPuUFvSp80acF8kH5CRmykRQ@mail.gmail.com>
	<4D5AC80F.1090205@am.sony.com>
	<AANLkTi=ajLEV2S_6RcHKE8w82DSTMObg3TXFOjoZCdmF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: frank.rowand@am.sony.com, linux-rt-users@vger.kernel.org
To: Peter LaDow <petela@gocougs.wsu.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59781 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab1BOTfh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Feb 2011 14:35:37 -0500
Received: by qyk12 with SMTP id 12so455444qyk.19
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Feb 2011 11:35:36 -0800 (PST)
In-Reply-To: <AANLkTi=ajLEV2S_6RcHKE8w82DSTMObg3TXFOjoZCdmF@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 15, 2011 at 11:12 AM, Peter LaDow <petela@gocougs.wsu.edu> =
wrote:
> I made an error in my last post. =A0My call tree wasn't accurate sinc=
e I
> was looking at unpatched code. =A0After applying the RT patch, the ca=
ll
> tree changes a bit:
>
> timer_interrupt
> =A0|
> =A0+ hrtimer_interrupt
> =A0 =A0 |
> =A0 =A0 + raise_softirq_irqoff
> =A0 =A0 =A0 =A0|
> =A0 =A0 =A0 + wakeup_softirqd
> =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0 =A0 =A0+ wake_up_process
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ try_to_wakeup
>
> It indeed does offload the timer expirations to the hrtimer softirq.
> And the only task that try_to_wakeup works on is the softirq handler.
> So this overhead is even less than I thought. =A0Indeed it is quite
> light.
>
> So it seems that I was on track before. =A0The hrtimer softirq task i=
s
> running at a priority of 50:
>
> # ps | grep irq
> =A0 10 root =A0 =A0 =A0 =A0 0 SW< =A0[sirq-hrtimer/0]
> # chrt -p 10
> pid 10's current scheduling policy: SCHED_FIFO
> pid 10's current scheduling priority: 50
>
> And I run my program with 'chrt -f 99'. =A0So it does seem that the
> hrtimer softirq task should not interfere.
>
> So I'm back to the scenarios you described earlier. =A0I suppose if t=
he
> timers are close in proximity, there would be a flurry of interrupts
> frequently occurring. =A0Each of these could in fact slow things down=
=2E
> So to prevent this deluge, we tried something. =A0We bumped up the
> minimum resolution on the decrementer to something closer to 1ms.
> This means the decrementer would interrupt us no more often than 1ms.
> We modified arch/powerpc/kernel/time.c to set the min_delta_ns of the
> decrement to a larger value (large enough to equal about 1ms) rather
> than the default 2. =A0The jitter disappeared. =A0Now, I know that do=
ing
> this effectively eliminates their use as "high resolution", but it
> proves the point that it is the flurry of interrupts causing the
> problems.
>
> So it does seem that it is the interrupt overhead that is the problem=
=2E
> =A0So if we want high resolution, but low overhead, we have to get
> around the problem of lots of tasks using clock_nanosleep. =A0In our
> real-world system, we have only 1 high priority task that must run
> every 500us. =A0More than 99% of the time, it gets to run and complet=
es
> its work very quickly. =A0However, than <1% of the time, it doesn't r=
un
> for 1ms to 2ms, breaking our requirements. =A0We have several lower
> priority tasks running, each using clock_nanosleep or pending on an
> I/O event. =A0It may be in our system that the relatively large numbe=
r
> of timers is occasionally causing a flurry of interrupts increasing
> the jitter. =A0So how do we get rid of it?
>
> I see only 2 ways: =A01) stop using clock_nanosleep or 2) stop using
> high resolution timers. =A0Implementation of both is problematic.
> Eliminating use of clock_nanosleep would require replacing it with
> something that didn't resolve to an underlying nanosleep system call,
> which I think is impossible (except for using sleep, but that only
> gives us 1sec resolution). =A0And turning off the high resolution tim=
ers
> makes it impossible for us to wake every 500us.

You might be able to use range timers to solve your problem:

   http://lwn.net/Articles/296578/


>
> Hmmm....I guess this really is a limitation of our platform. =A0We ar=
e
> just up against the wall in terms of burden and processing power.
> There just isn't enough horsepower to do everything we want at the
> time we want.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
