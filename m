From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.1.5-rt5
Date: Fri, 12 Feb 2016 10:07:59 +0100
Message-ID: <56BDA0EF.7090503@linutronix.de>
References: <20150816135630.GE7004@linutronix.de> <1614199.PesBpXyHut@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Tim Sander <tim@krieglstein.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1614199.PesBpXyHut@dabox>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/12/2016 09:28 AM, Tim Sander wrote:
> Hi Sebastian

Hi Tim,

> Am Sonntag, 16. August 2015, 15:56:30 schrieb Sebastian Andrzej Siewi=
or:
>> I'm pleased to announce the v4.1.5-rt5 patch set.
> I have just tested it with a Altera SoC ARM v7. The latencies seem to=
 have=20
> gotten a little bit worse with each release. The first core has alway=
s been=20
> worse (presumably due to interrupt load) but now it dropped to 111=B5=
s (rt5)=20
> from 76=B5s(rt3) and 54=B5s(rt2).=20

in -rt2 we had bug in migrate disable code which means each task was
running on CPU0. This got partly fixed in -rt3. In -rt3 the scheduler
could assign a task to CPU1 but the task should stay there for ever.
This little detail was fixed in -rt5.
This is one thing that comes to mind.
Lazy-preempt should have been fixed in -rt3, too. This should not give
you higher latencies but higher throughput.

What about rt4? It is only the stable update so you should see here the
numbers from rt3. If that is true and your numbers are stable it should
be easy to run git bisect between rt4 and rt5. And looking at
  https://git.kernel.org/rt/linux-rt-devel/h/v4.4.1-rt5
the only non-cosmetic change in -rt5 that should affect you is the
migrate-disable fixup from Mike.

> Best regards
> Tim

Sebastian
