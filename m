From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 18:21:53 +0300
Message-ID: <84144f020908260821n5b0b9f7ejec8bbe9586150f37@mail.gmail.com>
References: <1250983671.5688.21.camel@raz>
	 <1251012621.14003.71.camel@marge.simson.net>
	 <1251025557.3810.65.camel@raz>
	 <1251021133.14003.172.camel@marge.simson.net>
	 <alpine.DEB.1.10.0908251122020.26329@gentwo.org>
	 <1251222993.7023.53.camel@marge.simson.net>
	 <alpine.DEB.1.10.0908251402300.17963@gentwo.org>
	 <1251227322.7538.1172.camel@twins> <4A943A00.9080609@nortel.com>
	 <1251264700.7538.1178.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Friesen <cfriesen@nortel.com>,
	Christoph Lameter <cl@linux-foundation.org>,
	Mike Galbraith <efault@gmx.de>,
	raz ben yehuda <raziebe@gmail.com>, riel@redhat.com,
	mingo@elte.hu, andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751074AbZHZPVy@vger.kernel.org>
In-Reply-To: <1251264700.7538.1178.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Peter,

On Wed, Aug 26, 2009 at 8:31 AM, Peter Zijlstra<peterz@infradead.org> w=
rote:
>> Is it the whole concept of isolating one or more cpus from all norma=
l
>> kernel tasks that you don't like, or just this particular implementa=
tion?
>>
>> I ask because I know of at least one project that would have used th=
is
>> capability had it been available. =A0As it stands they have to live =
with
>> the usual kernel threads running on the cpu that they're trying to
>> dedicate to their app.
>
> Its the simple fact of going around the kernel instead of using the
> kernel.
>
> Going around the kernel doesn't benefit anybody, least of all Linux.
>
> So its the concept of running stuff on a CPU outside of Linux that I
> don't like. I mean, if you want that, go ahead and run RTLinux, RTAI,
> L4-Linux etc.. lots of special non-Linux hypervisor/exo-kernel like
> things around for you to run things outside Linux with.

Out of curiosity, what's the problem with it? Why can't the scheduler
be taught to bind one user-space thread on a given CPU and make sure
no other threads are scheduled on that CPU? I'm not a scheduler expert
but that seems like a logical extension to the current cpuset logic
and would help the low-latency workload Christoph has described in the
past.

                        Pekka
