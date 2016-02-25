From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Kernel thread's CPU affinity with isolcpus kernel boot argument
Date: Thu, 25 Feb 2016 17:35:43 +0100
Message-ID: <56CF2D5F.60306@linutronix.de>
References: <5698D4D0.3020907@etas.com> <20160225141806.GB16161@linutronix.de>
 <56CF1A2A.1050203@bristot.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Daniel Bristot de Oliveira <daniel@bristot.me>,
	Mathias Koehrer <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54341 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757854AbcBYQfr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 11:35:47 -0500
In-Reply-To: <56CF1A2A.1050203@bristot.me>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/25/2016 04:13 PM, Daniel Bristot de Oliveira wrote:
> On 02/25/2016 11:18 AM, Sebastian Andrzej Siewior wrote:
>> not that I am aware of. There are a few per-CPU threads which have t=
o
>> stay the way they are. I would have expected that others like kworke=
r/u*
>> respect the isol CPUs and stay away.
>=20
> Isolcpus is applied only for user-space threads. For instance, you
> still need to move rcu offload callbacks away from isolated CPUs, and
> all other kernel threads as well.

RCU is special since this is a per-CPU thread. However Paul did make an
option where you can move those to another CPU.

> In the special case of kworker/u* threads, you need to use a special
> interface to do it. The interface is the following file:
>=20
> /sys/devices/virtual/workqueue/cpumask

I see it documented in "Documentation/ABI". Oh wait=E2=80=A6

> It was implemented on the following commit:
>=20
> 042f7df workqueue: Allow modifying low level unbound workqueue cpumas=
k
>=20
> But the default CPU mask is the "cpu_possible_mask".
>=20
> Sometime ago I sent a patch to modify the default mask of the kworker=
/u*
> threads, to avoid them on isolated CPUs by default, but it was not
> acked. It was not explicitly nacked, though.
>=20
> http://www.gossamer-threads.com/lists/linux/kernel/2218495
>=20
> Should I try it again?

Atleast they do have a default cpumask which you can modify. I don't
see why the kworker should be special here and avoid the isolcpu mask.
I *do* support the default mask being !isolcpus and not cpu_possible.
If you have the time to try again, please do so.

>=20
> -- Daniel
>=20
Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
