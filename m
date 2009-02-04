From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/3] tracing: Tracers that use CALLER_ADDR macros
	should select FRAME_POINTER
Date: Wed, 4 Feb 2009 18:36:43 +0300
Message-ID: <20090204153643.GA16681@oksana.dev.rtsoft.ru>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru> <20090204150840.GC30027@oksana.dev.rtsoft.ru> <c62985530902040726x34aeee7fr3b2937d898d3061e@mail.gmail.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: =?utf8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:60333 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753170AbZBDPgp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 10:36:45 -0500
Content-Disposition: inline
In-Reply-To: <c62985530902040726x34aeee7fr3b2937d898d3061e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 04, 2009 at 04:26:15PM +0100, Fr=C3=A9d=C3=A9ric Weisbecker=
 wrote:
[...]
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

It depends on the architecture. On PowerPC we always have frame pointer=
s,
thus __builtin_return_address(1..) will always work. On x86 it won't wo=
rk
that way.

Thanks,

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
