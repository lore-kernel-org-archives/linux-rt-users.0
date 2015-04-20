From: Clark Williams <williams@redhat.com>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 12:59:22 -0500
Message-ID: <20150420125922.35243e90@sluggy>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
	<20150418130340.GA26931@gmail.com>
	<20150418133444.GD23685@linux.vnet.ibm.com>
	<20150418143238.GA2337@gmail.com>
	<20150419020541.GA5561@linux.vnet.ibm.com>
	<20150420113554.598e503f@sluggy>
	<20150420170902.GU5561@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/MM8j6AKw6LkSSg+kBdtll1w"; protocol="application/pgp-signature"
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
	akpm@linux-foundation.org, linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150420170902.GU5561@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/MM8j6AKw6LkSSg+kBdtll1w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Apr 2015 10:09:03 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Mon, Apr 20, 2015 at 11:35:54AM -0500, Clark Williams wrote:
> > On Sat, 18 Apr 2015 19:05:42 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > > 	Real-time priority to use for RCU worker threads (RCU_KTHREAD_=
PRIO) [0] (NEW)=20
> > > > >=20
> > > > > Indeed, Linus complained about this one.  ;-)
> > > >=20
> > > > :-) Yes, it's an essentially unanswerable question.
> > > >=20
> > > > > This Kconfig parameter is a stopgap, and needs a real solution. =
=20
> > > > > People with crazy-heavy workloads involving realtime cannot live=
=20
> > > > > without it, but that means that most people don't have to care.  =
I=20
> > > > > have had solving this on my list, and this clearly increases its=
=20
> > > > > priority.
> > > >=20
> > > > So what value do they use, prio 99? 98? It might be better to offer=
=20
> > > > this option as a binary choice, and set a given priority. If -rt=20
> > > > people complain then they might help us in solving it properly.
> > >=20
> > > I honestly do not remember what priority they were using, it is
> > > not in email, and I don't keep IRC logs that far back.  Adding
> > > linux-rt-users@vger.kernel.org on CC.
> >=20
> > As I recall, we started out using fifo:1, but when you get heavy
> > workloads running at higher fifo priorities, we wanted to boost the rcu
> > worker threads over those workloads.=20
> >=20
> > Currently the irq threads default to fifo:50, so maybe a good
> > default choice for the rcu threads on RT is fifo:49. That of course
> > presumes rational behavior on the part of application developers.=20
> >=20
> > I seem to recall that you and I had a discussion about making this
> > value a runtime knob in /sys but that didn't go anywhere. Do we need to
> > crank that up again and just use the config as a default/starting
> > value? If so then we could just default to fifo:1 and let sysadmins
> > tweak the value to match up with the workload.=20
>=20
> The sysfs knob might be nice, but as far as I know nobody has been
> complaining about it.
>=20
> Besides, we already have the rcutree.kthread_prio=3D kernel-boot paramete=
r.
> So how about if the Kconfig parameter selects either SCHED_OTHER
> (the default) or SCHED_FIFO:1, and then the boot parameter can be used
> to select other values.

Yeah, that will work.=20

>=20
> That said, if the lack of a sysfs knob has been causing real problems,
> let's make that happen.

I'll talk to the other RT-ers and get back to you on that. I suspect
most folks would like it just to not have to reboot while tuning, but
not sure it's worth the extra code.=20

Clark

--Sig_/MM8j6AKw6LkSSg+kBdtll1w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVNT5+AAoJEEersVlSw9NzZscQANdZS1+3/zU2BDhFidVuwhWC
ypjTLwqe0HxDPkrhHIuBVsw2l700ggSodZniUA56uw90rq5j5kSKCWOoCuZkEITq
lllatG5Wr1yS2Isl7n9yKWae9KjAcnnEJNxWiLwWOp4T3tkdRyT+ECOa73orRbw6
hvNWS377xVL9Gy39gS96BEa2sj4BF+R21FlUJzonRxOSUOmWUmLHU/pNSEgKC0vl
QyUP6eHBJxMzQ/HkBzTGzeIPw0wZpgMgg4A8HQcbwG8OxAzDG9PlgOxBRGY55kHk
tsc+Q+Fh7Fq2NJcpof/4HhQlJOXjBqx2gZSCqLAfw80v3UMy2Nbwq+3p56wuZO4f
WpRJEFRawV6lRttqtaodmhWwvWYOnWeFz/YVXkCwr8xlEDdzj9rMmXPLGWYALGLs
EsOpoe4o2YDpvzyyX2DZT0olnq7IvOEL7NFZOndQv2lMk76jpKpWsVmaxiw2oHDi
mqpS9m86GjgGB9txJnOVafs8c/JjXKA9VaCPghiJ02UrQVIC4RTMvvGJwfBxJ4pn
5mZCMPIMTw2hQpwFdP1bGPn6N/NPxEB+dkqh1d1qrcriWFrYz4pVqBtmo5y8TEhB
AYFzuC9j4/TAFPB+7veesJrh7Inv+klJ9qtJ78pMWQAOJcDh4hizfOolUUsOST2p
LPjp82gIxNrInzU7PC8t
=z6mQ
-----END PGP SIGNATURE-----

--Sig_/MM8j6AKw6LkSSg+kBdtll1w--
