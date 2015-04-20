From: Clark Williams <williams@redhat.com>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 16:50:07 -0500
Message-ID: <20150420165007.295f3fe0@sluggy>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
	<20150418130340.GA26931@gmail.com>
	<20150418133444.GD23685@linux.vnet.ibm.com>
	<20150418143238.GA2337@gmail.com>
	<20150419020541.GA5561@linux.vnet.ibm.com>
	<20150420113554.598e503f@sluggy>
	<20150420170902.GU5561@linux.vnet.ibm.com>
	<20150420204049.GF24936@home.goodmis.org>
	<20150420211504.GW5561@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/JKrBEQ.1ymI_ewgtnxAtDTz"; protocol="application/pgp-signature"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
	akpm@linux-foundation.org, linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150420211504.GW5561@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/JKrBEQ.1ymI_ewgtnxAtDTz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Apr 2015 14:15:04 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Mon, Apr 20, 2015 at 04:40:49PM -0400, Steven Rostedt wrote:
> > On Mon, Apr 20, 2015 at 10:09:03AM -0700, Paul E. McKenney wrote:
> > >=20
> > > The sysfs knob might be nice, but as far as I know nobody has been
> > > complaining about it.
> > >=20
> > > Besides, we already have the rcutree.kthread_prio=3D kernel-boot para=
meter.
> > > So how about if the Kconfig parameter selects either SCHED_OTHER
> > > (the default) or SCHED_FIFO:1, and then the boot parameter can be used
> > > to select other values.
> >=20
> > Hmm, what priority is this for anyway. To change the priority of the bo=
ost
> > value at run time, do we only need to change the priority of the rcub t=
hreads?
> >=20
> > And the priority of the other rcu threads can change as well with a sim=
ple
> > chrt?
> >=20
> > If that's the case, then we don't need a sysctl knob at all.
>=20
> For the grace-period kthreads and the boost kthread, that is the case.
> It is also the case for the per-CPU kthreads that invoke RCU callbacks
> for the non-offloaded RCU_BOOST configuration (and that replace all
> softirq RCU work in -rt).
>=20
> So, should I just ditch all of the priority-setting within RCU and tell
> users to just use chrt?

Looks to me like all we need to do is tell people if they need a boost
higher than the compiled in default (RCU_KTHREAD_PRIO), then chrt the
priority of the rcub thread to the desired priority.=20

--Sig_/JKrBEQ.1ymI_ewgtnxAtDTz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVNXSTAAoJEEersVlSw9Nz0FkP/0b62J7adK0R+1H6sPNQRRkx
SXkxs3KAnpZyAuzoedHjZEjt7lrdR5Y6pewZbwaEwEY8Da0Z5SPGv+zQTt0C1ul+
BBsDDIueh1L8Dun2kyQE2oWDcQr6O2MBZzvzVeaReM8EW9FvMdX4zA7MrCh/fCbD
61jmn+allUPE6sJvHa6/1BVnqMVZSc9+HSZctaoHFyC32ifvbWZ7x8QpQOIk9dx2
bEULFiDLkSo76sXBGQcGLp4PoB9G0BcLrg+LVELD8fz5LvO4xi7wOwcmafSngymX
ZSsKrUibQlyAMEMzx1Wd4ttjagWdS2hFFbNAVEVeTcGZJzfCPTxsvtRTgwfJJbAs
kbLL2/2+rO2l4uNlNhkWs1cYfwpkFoOAXHkRg7kwaBOxmprx77rdPbmEUs7vhxDS
i2avut8RblN/y+YcZzUSCf2/2rU2AXJRuEkXFfa/OzORN+1k/TPTfQUfWk8KKhwh
1Mupk/E0ZupJtXISR7/g43sjExtBguSBjI8gO+920UDycIPYDw71+wNznmFZo/2R
zm8WRiWygIYZ71xiOCdUwCNj+dj/4SxMZlN6u39PdO8J4AEYbkjXJpJxUfPw1JqC
+mwdSbt1obsHkXMYrktHlM4S7+DoZ892fRSUl3s3sF15b8sBXnDv0fS4PMXFlG6S
Z3peNZSb5YgJiN5ZGY8e
=0KlH
-----END PGP SIGNATURE-----

--Sig_/JKrBEQ.1ymI_ewgtnxAtDTz--
