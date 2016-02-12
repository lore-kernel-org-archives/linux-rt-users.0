From: Tim Sander <tim@krieglstein.org>
Subject: Re: [ANNOUNCE] 4.1.5-rt5 meant to reply to 4.4.1-rt5
Date: Fri, 12 Feb 2016 15:36:16 +0100
Message-ID: <7138155.u6nNkmxGuH@dabox>
References: <20150816135630.GE7004@linutronix.de> <1614199.PesBpXyHut@dabox> <56BDA0EF.7090503@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56BDA0EF.7090503@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian

As you got correctly i was talking about 4.4.1-rt5 and not 4.1 i replie=
d to by=20
accident.

Am Freitag, 12. Februar 2016, 10:07:59 schrieb Sebastian Andrzej Siewio=
r:
> On 02/12/2016 09:28 AM, Tim Sander wrote:
> > Hi Sebastian
>=20
> Hi Tim,
>=20
> > Am Sonntag, 16. August 2015, 15:56:30 schrieb Sebastian Andrzej Sie=
wior:
> >> I'm pleased to announce the v4.1.5-rt5 patch set.
> >=20
> > I have just tested it with a Altera SoC ARM v7. The latencies seem =
to have
> > gotten a little bit worse with each release. The first core has alw=
ays
> > been
> > worse (presumably due to interrupt load) but now it dropped to 111=B5=
s (rt5)
> > from 76=B5s(rt3) and 54=B5s(rt2).
>=20
> in -rt2 we had bug in migrate disable code which means each task was
> running on CPU0. This got partly fixed in -rt3. In -rt3 the scheduler
> could assign a task to CPU1 but the task should stay there for ever.
> This little detail was fixed in -rt5.
> This is one thing that comes to mind.
> Lazy-preempt should have been fixed in -rt3, too. This should not giv=
e
> you higher latencies but higher throughput.
>=20
> What about rt4? It is only the stable update so you should see here t=
he
> numbers from rt3. If that is true and your numbers are stable it shou=
ld
> be easy to run git bisect between rt4 and rt5. And looking at
>   https://git.kernel.org/rt/linux-rt-devel/h/v4.4.1-rt5
> the only non-cosmetic change in -rt5 that should affect you is the
> migrate-disable fixup from Mike.
Ok, each run takes a couple of hours so bisecting should take quite som=
e time
but i will give it a try. I started a test with 4.4.1-rt4, if the numbe=
rs are=20
within the 70=B5s ballpark bisecting seems the way to go. If the number=
s are=20
higher i suspect that stable update might have a play here. But we will=
 see.

Best regards
Tim
