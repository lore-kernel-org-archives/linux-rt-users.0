From: Pedro R <eusou15@yahoo.com>
Subject: Re: Strange spikes using linux-rt kernel
Date: Fri, 3 Jul 2009 08:50:39 -0700 (PDT)
Message-ID: <190013.60215.qm@web112503.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <mcguire@lzu.edu.cn>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web112503.mail.gq1.yahoo.com ([98.137.26.130]:34942 "HELO
	web112503.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756278AbZGCPug convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Jul 2009 11:50:36 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Nicholas,

I think you are right on the spot with the scheduling. Here are my SCHE=
D_FIFO tasks running:

    3     3 FF   89 ?        00:00:00 sirq-high/0
    4     4 FF   89 ?        00:00:00 sirq-timer/0
    5     5 FF   89 ?        00:00:00 sirq-net-tx/0
    6     6 FF   89 ?        00:00:00 sirq-net-rx/0
    7     7 FF   89 ?        00:00:00 sirq-block/0
    8     8 FF   89 ?        00:00:00 sirq-tasklet/0
    9     9 FF   89 ?        00:00:00 sirq-sched/0
   10    10 FF   89 ?        00:00:00 sirq-hrtimer/0
   11    11 FF   89 ?        00:00:00 sirq-rcu/0
   12    12 FF  139 ?        00:00:00 posixcputmr/0
   13    13 FF  139 ?        00:00:00 watchdog/0
   16    16 FF   41 ?        00:00:00 events/0
  185   185 FF   90 ?        00:00:00 IRQ-9
  453   453 FF   90 ?        00:00:00 IRQ-7
  519   519 FF   90 ?        00:00:00 IRQ-14
  520   520 FF   90 ?        00:00:00 IRQ-15
  542   542 FF   90 ?        00:00:00 IRQ-20
  545   545 FF   90 ?        00:00:00 IRQ-16
  553   553 FF   90 ?        00:00:00 IRQ-23
  570   570 FF   90 ?        00:00:00 IRQ-19
  578   578 FF   90 ?        00:00:00 IRQ-18
  589   589 FF   90 ?        00:00:00 IRQ-12
  590   590 FF   90 ?        00:00:00 IRQ-1
  604   604 FF   90 ?        00:00:00 IRQ-8
  663   663 FF   90 ?        00:00:00 IRQ-17
 1406  1406 FF   90 ?        00:00:00 IRQ-22
 2861  2861 FF   90 ?        00:00:00 IRQ-21
 3766  3767 FF  120 pts/1    00:00:00 cyclictest
 3766  3768 FF  119 pts/1    00:00:00 cyclictest
 3766  3769 FF  118 pts/1    00:00:00 cyclictest
 3766  3770 FF  117 pts/1    00:00:00 cyclictest
 3766  3771 FF  116 pts/1    00:00:00 cyclictest

The posixcputmr/0 and watchdog/0 seem to be running at a higher priorit=
y! Is this normal?

About the firewire thing, all these tests were made with firewire disab=
led. These spikes always happen, either with or without the device conn=
ected. The driver developer told me these spikes were the direct cause =
of the audio underruns, since they can cause problems to the firewire d=
river.

I looked at the distribution of the jitter and these are very rare spik=
es. I ran cyclictest with 5 threads for 30000 cycles and the delay is a=
lways around 10-35 us except when there is a spike, which goes from 100=
0 to 7000us. These spikes are one-time ocurrences - they only last for =
one sample and sometimes only one of the threads is delayed, on other o=
ccasions 2 or 3 threads are delayed...

Thanks for your help.
Pedro



--- On Fri, 3/7/09, Nicholas Mc Guire <mcguire@lzu.edu.cn> wrote:

> From: Nicholas Mc Guire <mcguire@lzu.edu.cn>
> Subject: Re: Strange spikes using linux-rt kernel
> To: "Pedro R" <eusou15@yahoo.com>
> Cc: linux-rt-users@vger.kernel.org
> Date: Friday, 3 July, 2009, 7:18 PM
> On Fri, 03 Jul 2009, Pedro R wrote:
>=20
> >=20
> > Hi!
> >=20
> > I'll resume my problem: in CyclicTest I have an
> average of about 20-30us and peaks of 5000-6000us. These
> peaks are really annoying, since i'm using this system for
> firewire audio and each time there is a peak, an underrun in
> jackd causes a drop in sound. I have confirmed that these
> peaks are the direct cause of the underruns.
> > The peaks appear to occur randomly, most of the time
> in less than a minute of using CyclicTest and continue every
> minute or twice a minute (hard to say, since when CyclicTest
> hits a max value like 6000us, i'm not quick enough to read
> the actual peaks which achieve less than that - but the
> peaks continue).
> >=20
> > I left my system running the hwlat_detector module for
> 8 hours and all i got in the sample file was a bunch of 1's
> along with their timestamps, so the problem must not be the
> SMI.
> >=20
> > This problem also happens without the rt patch. I have
> tried using 2.6.26.2 (non-rt) kernel and I have the same
> problem. I also tried using 2.6.23-rt and 2.6.26-rt and it
> also happens.
> >
>=20
> two thoughts:
>  - first it might be that you are runing a SCHED_FIFO task
> with
> =A0 a priority above the interrupt threads in which case
> you might
> =A0 be starving the data processing=20
> - second it might be a driver problem of the firewire
> driver you
> =A0 are using.
>=20
> so to detect case two with resonable likelyhood could you
> run cyclictest on an=20
> idle system for some time and on a loaded system not using
> the firewire ?=20
> but write the entire log into a file (sorry forgot which
> flag to cyclictest=20
> that was -v or -o I think) - look at the distribution of
> jitter not only the
> maxima. regarding the first case - check the priority of
> the SCHED_FIFO tasks
> in the system to make sure you are not simply starving the
> irq threads.=20
>=20
> hofrat
>=20


     =20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
