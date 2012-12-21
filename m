From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [PATCH] sched/rt: Move cpu rq properties from "struct rt_rq" to "struct rq"
Date: Fri, 21 Dec 2012 10:35:09 +0400
Message-ID: <545781356071709@web16g.yandex.ru>
References: <4807701355857948@web19f.yandex.ru>
	 <alpine.LFD.2.02.1212201852060.3148@ionos>
	 <401821356041818@web4f.yandex.ru> <1356044865.5896.78.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1356044865.5896.78.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



21.12.2012, 03:07, "Steven Rostedt" <rostedt@goodmis.org>:
> On Fri, 2012-12-21 at 02:16 +0400, Kirill Tkhai wrote:
>
>> =9A20.12.2012, 21:53, "Thomas Gleixner" <tglx@linutronix.de>:
>>> =9AOn Tue, 18 Dec 2012, Kirill Tkhai wrote:
>>>> =9A=9AThe members rt_nr_total, rt_nr_migratory, overloaded and pus=
hable_tasks are
>>>> =9A=9Aproperties of cpu runqueue, not group rt_rq.
>>> =9AWhy?
>> =9ABecause, they depend on number and properties of all processes of=
 rq, not of nested rt_rq.
>
> You're answer is still confusing.
>
> =9A=9A=9A=9A=9A=9A=9A=9Astruct rq {
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A[...]
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Astruct rt_rq rt;
>
> rt_rq is just a part of rq. What's the point?
>
> =9A=9A=9A=9A=9A=9A=9A=9Arq =3D container_of(rt_rq, struct rt_rq, rt);
>
> As the comment above struct rt_rq says:
>
> /* Real-Time classes' related field in a runqueue: */
>
> Those look like fields related to the Real-Time class. I don't see th=
em
> used outside of kernel/sched/rt.c
>
                                   =20
           entity_1->my_q_1
           /                       =20
          /                        =20
rq->rt  -entity_2->my_q_2
          \                         =20
           \                          =20
             entity_n->my_q_n
                                       =20

I say about child rt_rqs (my_q_1....my_q_n). They don't have rt_nr_tota=
l, rt_nr_migratory, overloaded and pushable_tasks.
The only use of overloaded, for example, is "rq->rt.overloaded". The sa=
me with other variables.

Kirill


> -- Steve
>
>>> =9AThanks,
>>>
>>> =9A=9A=9A=9A=9A=9A=9A=9A=9Atglx
