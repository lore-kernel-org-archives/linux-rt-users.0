From: Dhaval Giani <dhaval.giani@gmail.com>
Subject: Re: RFC for a new Scheduling policy/class in the Linux-kernel
Date: Thu, 16 Jul 2009 04:09:18 +0530
Message-ID: <8aa016e10907151539t16fb1d7fk3122d77e69ac7de5@mail.gmail.com>
References: <1247412708.6704.105.camel@laptop> <4A5B61DF.8090101@nortel.com>
	 <1247568455.9086.115.camel@Palantir> <4A5C9ABA.9070909@nortel.com>
	 <alpine.LRH.2.00.0907141109190.16818@anderson.cs.unc.edu>
	 <1247589099.7500.191.camel@twins>
	 <alpine.LRH.2.00.0907141234280.16818@anderson.cs.unc.edu>
	 <20090715205503.GA14993@cs.fsu.edu> <4A5E4FDD.7090307@nortel.com>
	 <20090715223400.GF14993@cs.fsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Friesen <cfriesen@nortel.com>,
	"James H. Anderson" <anderson@cs.unc.edu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Raistlin <raistlin@linux.it>,
	Douglas Niehaus <niehaus@ittc.ku.edu>,
	Henrik Austad <henrik@austad.us>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Bill Huey <billh@gnuppy.monkey.org>,
	Linux RT <linux-rt-users@vger.kernel.org>,
	Fabio Checconi <fabio@gandalf.sssup.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Noah Watkins <jayhawk@soe.ucsc.edu>,
	KUSP Google Group <kusp@googlegroups.com>,
	Tommaso Cucinotta <cucinotta@sssup.it>,
	Giuseppe Lipari <lipari@retis.sssup.it>,
	Bjoern Brandenburg <bbb@cs.unc.edu>
To: Ted Baker <baker@cs.fsu.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:55110 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042AbZGOWjU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Jul 2009 18:39:20 -0400
In-Reply-To: <20090715223400.GF14993@cs.fsu.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jul 16, 2009 at 4:04 AM, Ted Baker<baker@cs.fsu.edu> wrote:
> On Wed, Jul 15, 2009 at 03:53:33PM -0600, Chris Friesen wrote:
>
>> >From an API standpoint, the "group scheduling" functionality in lin=
ux
>> allows for the creation of an arbitrary hierarchy of groups, each of
>> which may contain zero or more tasks. =A0(Each task is associated wi=
th
>> exactly one group.)
>>
>> There is a distinction between groups containing realtime tasks, and
>> groups containing non-realtime tasks. =A0For realtime groups, each g=
roup
>> is allocated a specific amount of cpu time. =A0For non-realtime grou=
ps,
>> each group is allocated a specific weight.
>>
>> A realtime group may use up to its specified amount of cpu time. =A0=
Any
>> cpu time not used by a realtime group is distributed to the non-real=
time
>> groups according to their relative weights.
>>
>> This does add a whole different API to the mix, but allows for contr=
ols
>> to be set by the administrator on existing POSIX apps without needin=
g to
>> recompile them.
>
> This is in the right direction, but there is a lot about Linux groups
> that I either do not understand or which falls short of what is neede=
d.
> Perhaps you can point me to an up to date detailed explanation of
> how they work?
>
> From what I've been able to infer from my brief foray into that
> part of the kernel code (a year ago), there seemed to be several
> aspects of the group scheduling that did not seem to admit
> schedulability analysis. =A0(I admit that I may have read it wrong,
> and these statements are false.)
>
> 1) The priority of a group seemed to be defined by the priority of
> the highest-priority thread in the group's run-queue, which means
> it varies dynamically according to which threads in the group are
> contending.
>

This is true, but it also ensures that the time allocated to the group
is also consumed by group if it wants to.

> 2) Budget enforcement seemed to only occur at system tick
> boundaries, which means precision can only be achieved at the cost
> of frequent clock interrupts.
>
> 3) It seemed that a thread could belong to more than one group,
> and so distributed charges arbitrarily between groups.
> If so, budget allocation would seem very difficult.
>

No. A thread can only be a part of one group at a time.

> 4) On an SMP, more than one thread could be running against
> the same budget at the same time, resulting in budget over-charges.
>

The rt group scheduler does split the budget per cpu. On expiring the
budget, it tries to borrow from other CPUs if possible.

Thanks,
Dhaval
--=20

Spike Milligan  - "All I ask is the chance to prove that money can't
make me happy." -
http://www.brainyquote.com/quotes/authors/s/spike_milligan.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
