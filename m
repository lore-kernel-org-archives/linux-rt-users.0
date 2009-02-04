From: Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH 3/3] tracing: Tracers that use CALLER_ADDR macros
	should select FRAME_POINTER
Date: Wed, 04 Feb 2009 10:31:21 -0500
Message-ID: <1233761481.16878.12.camel__37224.5378363461$1233761827$gmane$org@localhost.localdomain>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	 <20090204150840.GC30027@oksana.dev.rtsoft.ru>
	 <c62985530902040726x34aeee7fr3b2937d898d3061e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756209AbZBDPfM@vger.kernel.org>
In-Reply-To: <c62985530902040726x34aeee7fr3b2937d898d3061e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 2009-02-04 at 16:26 +0100, Fr=C3=A9d=C3=A9ric Weisbecker wrote:
> 2009/2/4 Anton Vorontsov <avorontsov@ru.mvista.com>:
> > Irqsoff, switch and preempt tracers use CALLER_ADDR macros, so they
> > should select FRAME_POINTER. Otherwise traces are meaningless.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  kernel/trace/Kconfig |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index e2a4ff6..48f7a37 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -86,6 +86,7 @@ config IRQSOFF_TRACER
> >        select TRACE_IRQFLAGS
> >        select TRACING
> >        select TRACER_MAX_TRACE
> > +       select FRAME_POINTER
> >        help
> >          This option measures the time spent in irqs-off critical
> >          sections, with microsecond accuracy.
> > @@ -108,6 +109,7 @@ config PREEMPT_TRACER
> >        depends on DEBUG_KERNEL
> >        select TRACING
> >        select TRACER_MAX_TRACE
> > +       select FRAME_POINTER
> >        help
> >          This option measures the time spent in preemption off crit=
ical
> >          sections, with microsecond accuracy.
> > @@ -136,6 +138,7 @@ config SCHED_TRACER
> >        select TRACING
> >        select CONTEXT_SWITCH_TRACER
> >        select TRACER_MAX_TRACE
> > +       select FRAME_POINTER
> >        help
> >          This tracer tracks the latency of the highest priority tas=
k
> >          to be scheduled in, starting from the point it has woken u=
p.
> > --
>=20
>=20
> Looks right.
>=20
> BTW, how behaves builtin_return_address in case of !FRAME_POINTERS ?
> I guess it would only work with the first caller builtin_return_addre=
ss(0)


>From ftrace.h:

#ifdef CONFIG_FRAME_POINTER
/* TODO: need to fix this for ARM */
# define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
# define CALLER_ADDR1 ((unsigned long)__builtin_return_address(1))
# define CALLER_ADDR2 ((unsigned long)__builtin_return_address(2))
# define CALLER_ADDR3 ((unsigned long)__builtin_return_address(3))
# define CALLER_ADDR4 ((unsigned long)__builtin_return_address(4))
# define CALLER_ADDR5 ((unsigned long)__builtin_return_address(5))
# define CALLER_ADDR6 ((unsigned long)__builtin_return_address(6))
#else
# define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
# define CALLER_ADDR1 0UL
# define CALLER_ADDR2 0UL
# define CALLER_ADDR3 0UL
# define CALLER_ADDR4 0UL
# define CALLER_ADDR5 0UL
# define CALLER_ADDR6 0UL
#endif

Yep!

-- Steve
