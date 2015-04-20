From: Clark Williams <williams@redhat.com>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 11:35:54 -0500
Message-ID: <20150420113554.598e503f@sluggy>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
	<20150418130340.GA26931@gmail.com>
	<20150418133444.GD23685@linux.vnet.ibm.com>
	<20150418143238.GA2337@gmail.com>
	<20150419020541.GA5561@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/8GewWi3Q2kuB.E5BBd5tyPH"; protocol="application/pgp-signature"
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
	akpm@linux-foundation.org, linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150419020541.GA5561@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/8GewWi3Q2kuB.E5BBd5tyPH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Apr 2015 19:05:42 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > 	Real-time priority to use for RCU worker threads (RCU_KTHREAD_PRIO=
) [0] (NEW)=20
> > >=20
> > > Indeed, Linus complained about this one.  ;-)
> >=20
> > :-) Yes, it's an essentially unanswerable question.
> >=20
> > > This Kconfig parameter is a stopgap, and needs a real solution. =20
> > > People with crazy-heavy workloads involving realtime cannot live=20
> > > without it, but that means that most people don't have to care.  I=20
> > > have had solving this on my list, and this clearly increases its=20
> > > priority.
> >=20
> > So what value do they use, prio 99? 98? It might be better to offer=20
> > this option as a binary choice, and set a given priority. If -rt=20
> > people complain then they might help us in solving it properly.
>=20
> I honestly do not remember what priority they were using, it is
> not in email, and I don't keep IRC logs that far back.  Adding
> linux-rt-users@vger.kernel.org on CC.

As I recall, we started out using fifo:1, but when you get heavy
workloads running at higher fifo priorities, we wanted to boost the rcu
worker threads over those workloads.=20

Currently the irq threads default to fifo:50, so maybe a good
default choice for the rcu threads on RT is fifo:49. That of course
presumes rational behavior on the part of application developers.=20

I seem to recall that you and I had a discussion about making this
value a runtime knob in /sys but that didn't go anywhere. Do we need to
crank that up again and just use the config as a default/starting
value? If so then we could just default to fifo:1 and let sysadmins
tweak the value to match up with the workload.=20

Clark

--Sig_/8GewWi3Q2kuB.E5BBd5tyPH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVNSrvAAoJEEersVlSw9Nzv+cQAKWpoXUcGgxYNkVaFx9HWSPU
AmvFpGweT7dAPZfju/itZx9TnSSYXl9oEET5ptAGZuFMo9+cgEfE+PZ5KZxE7i0A
j92tWAsSXDqER0OG/a7pN8LyxvBQgnKsnUibnJ3Q2T2okn4eYx17d2eoQj1bKN0y
zJ/lqyrQ0dYIcA0EUfHi4/voEcxjRuueGa3GxgT/f8wNyy9VnRqYtK3OfR9a8Z7d
7ZH6wiWOK1JyTNOKfAr2XbYtPWbN36I635n3178IQVtnmD6rnF/QUEcs9/3aBZWz
A2sYQmgZqO3F+vehlED5AbfsP4rk1H2VCcZ6ITgwPCmRU0ZvmgLE9lfOa1KHReAU
2W+N7EZz+yNSRWcYd4DQRNbH2CxxBW1skAsdtAw4+8P8XoHBrEYn9bBTPzxMcZ2U
ZjTZVVNq8wLrCEp0Cv9TGN3HqKEkoKuMqf/ieypY+4qChPVFmK6DDRN2pldVDv6E
sPph38fI1eLPmQ3uXlxXSaazhePE9VMhohgF0LdTomSKOG/JFSs25B5b89wfQ05x
Q7KR94/QrE5yqRARj24KZ5X5zWFQdoe75AIYA6sTBmIU+sgbVQgOvoD5eVqH1PFJ
6FrulPWAyE4PNGEDsCbqjyV74gNvNOz1lbciidsaAO7KE+llg2yyNOXMYkWdeEff
2ykHpZgH+atMcE3gnA5w
=Issc
-----END PGP SIGNATURE-----

--Sig_/8GewWi3Q2kuB.E5BBd5tyPH--
