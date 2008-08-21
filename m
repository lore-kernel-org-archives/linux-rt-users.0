From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.26.3-rt2
Date: Thu, 21 Aug 2008 14:02:06 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808211401200.678@gandalf.stny.rr.com>
References: <1219339082.22710.16.camel@localhost.localdomain> <a3d4028e0808211056m1cc2a7a8gfbe453d65adc561c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2101232868-1219341727=:678"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:37273 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbYHUSCI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Aug 2008 14:02:08 -0400
In-Reply-To: <a3d4028e0808211056m1cc2a7a8gfbe453d65adc561c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2101232868-1219341727=:678
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Thu, 21 Aug 2008, Javier Sanz wrote:

> Hello,
>=20
> I got the following compiling problem with 2.6.23-rt2:
>=20
> =A0<....>
> =A0 CC=A0=A0=A0=A0=A0 kernel/ns_cgroup.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/utsname.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/user_namespace.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/pid_namespace.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/res_counter.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/stop_machine.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/audit.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/auditfilter.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/auditsc.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/audit_tree.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/kprobes.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/softlockup.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/seccomp.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/rcupreempt.o
> =A0 CC=A0=A0=A0=A0=A0 kernel/rcupreempt-boost.o
> kernel/rcupreempt-boost.c: In function '__rcu_preempt_unboost':
> kernel/rcupreempt-boost.c:328: error: too few arguments to function
> 'rcu_trace_boost_unboost_called'
> make[1]: *** [kernel/rcupreempt-boost.o] Error 1
> make: *** [kernel] Error 2
>=20
> am i doing something wrong ?

Probably not, I'll work on getting a -rt3 out today. There's several=20
patches that need to go in.

Thanks,

-- Steve

--8323328-2101232868-1219341727=:678--
