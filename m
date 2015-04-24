From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date: Fri, 24 Apr 2015 11:00:29 +0200
Message-ID: <553A062D.6090608@siemens.com>
References: <552FC1FE.4020406@siemens.com> <552FC6B1.1040000@linutronix.de>	 <552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home>	 <552FD55F.8000105@siemens.com> <552FE320.6050601@siemens.com>	 <1429517036.3226.9.camel@gmail.com> <1429769505.3419.9.camel@gmail.com>	 <55389632.50308@siemens.com> <1429772482.3419.40.camel@gmail.com>	 <55389B67.3000703@siemens.com> <1429773566.3419.42.camel@gmail.com>	 <20150423170026.0de65c90@gandalf.local.home> <1429858489.3461.28.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429858489.3461.28.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2015-04-24 08:54, Mike Galbraith wrote:
> On Thu, 2015-04-23 at 17:00 -0400, Steven Rostedt wrote:
>> On Thu, 23 Apr 2015 09:19:26 +0200
>> Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
>>
>>>>   CC      kernel/irq_work.o
>>>> In file included from ../include/asm-generic/percpu.h:6:0,
>>>>                  from ../arch/x86/include/asm/percpu.h:522,
>>>>                  from ../arch/x86/include/asm/current.h:5,
>>>>                  from ../arch/x86/include/asm/processor.h:15,
>>>>                  from ../arch/x86/include/asm/irq_work.h:4,
>>>>                  from ../include/linux/irq_work.h:47,
>>>>                  from ../kernel/irq_work.c:11:
>>>> ../kernel/irq_work.c: In function =E2=80=98irq_work_queue_on=E2=80=
=99:
>>>> ../kernel/irq_work.c:85:17: error: =E2=80=98hirq_work_list=E2=80=99=
 undeclared=20
>>>> (first use in this function)
>>>>         &per_cpu(hirq_work_list, cpu));
>>>
>>> Aw poo, so that's just what I _thought_ it was for.
>>
>> It helps optimization but does nothing for undefined symbols.
>>
>> That said, why don't we clean up that irq_work code and at least
>> declare both lists, and get rid of all the #ifdefs. I wonder if gcc =
is
>> smart enough to not allocate a static variable if it happens to be
>> optimized out?
>=20
> Nope, it didn't notice a thing.
>=20
> This is a stab at that cleanup.  Usable as is with Jan's ok, or as
> fodder for your bitmaster-9000 patch shredder, or whatever.  Box work=
s
> and it makes line count shrink...
>=20
> I downgraded evolution v3.16->v3.12 to restore its ability to read it=
's
> own fscking "Preformatted" switch, so whitespace should be fine.=20
>=20
> Oh, btw, if anyone (else) makes a 4.1-rt, your rt push work will want
> one of those nifty hirq tags lest box make boom due to trying to do t=
hat
> not only way late, but with irqs enabled which pisses sched all off.
>=20
> Subject: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
> Date:	Thu, 16 Apr 2015 18:28:16 +0200
> From:	Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Instead of turning all irq_work requests into lazy ones on -rt, just
> move their execution from hard into soft-irq context.
>=20
> This resolves deadlocks of ftrace which will queue work from arbitrar=
y
> contexts, including those that have locks held that are needed for
> raising a soft-irq.
>=20
> Mike: cleanup ifdef mess and kill hirq_work_list.  We need two lists,
> and already have them, merely need to select according to work type.
> In -rt all work not tagged for hirq execution is queued to the lazy
> list and runs via irq_work_tick().  Raising SOFTIRQ_TIMER is always
> done via IPI for deadlock safety, if the work item is not a lazy work
> or the tick is stopped, fire IPI immediately, otherwise let it wait.
> IOW, lazy work is lazy in -rt only until someone queues immediate wor=
k.

The approach looks good to me, but the commit log deserves a rework now=
=2E

Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
