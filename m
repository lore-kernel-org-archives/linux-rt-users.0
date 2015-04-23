From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date: Thu, 23 Apr 2015 17:00:26 -0400
Message-ID: <20150423170026.0de65c90@gandalf.local.home>
References: <552FC1FE.4020406@siemens.com>
	<552FC6B1.1040000@linutronix.de>
	<552FC72A.8060709@siemens.com>
	<20150416111041.66043164@gandalf.local.home>
	<552FD55F.8000105@siemens.com>
	<552FE320.6050601@siemens.com>
	<1429517036.3226.9.camel@gmail.com>
	<1429769505.3419.9.camel@gmail.com>
	<55389632.50308@siemens.com>
	<1429772482.3419.40.camel@gmail.com>
	<55389B67.3000703@siemens.com>
	<1429773566.3419.42.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429773566.3419.42.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 23 Apr 2015 09:19:26 +0200
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:

> >   CC      kernel/irq_work.o
> > In file included from ../include/asm-generic/percpu.h:6:0,
> >                  from ../arch/x86/include/asm/percpu.h:522,
> >                  from ../arch/x86/include/asm/current.h:5,
> >                  from ../arch/x86/include/asm/processor.h:15,
> >                  from ../arch/x86/include/asm/irq_work.h:4,
> >                  from ../include/linux/irq_work.h:47,
> >                  from ../kernel/irq_work.c:11:
> > ../kernel/irq_work.c: In function =E2=80=98irq_work_queue_on=E2=80=99=
:
> > ../kernel/irq_work.c:85:17: error: =E2=80=98hirq_work_list=E2=80=99=
 undeclared=20
> > (first use in this function)
> >         &per_cpu(hirq_work_list, cpu));
>=20
> Aw poo, so that's just what I _thought_ it was for.

It helps optimization but does nothing for undefined symbols.

That said, why don't we clean up that irq_work code and at least
declare both lists, and get rid of all the #ifdefs. I wonder if gcc is
smart enough to not allocate a static variable if it happens to be
optimized out?

-- Steve
