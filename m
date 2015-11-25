From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH tip v4 4/5] rcu: Do not call rcu_nocb_gp_cleanup() while
 holding rnp->lock
Date: Wed, 25 Nov 2015 09:01:34 +0800
Message-ID: <20151125010118.GB1165@fixme-laptop.cn.ibm.com>
References: <1448370187-10075-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1448370187-10075-5-git-send-email-daniel.wagner@bmw-carit.de>
 <20151124155212.GA1165@fixme-laptop.cn.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36814 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbbKYBCL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Nov 2015 20:02:11 -0500
Content-Disposition: inline
In-Reply-To: <20151124155212.GA1165@fixme-laptop.cn.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 11:52:12PM +0800, Boqun Feng wrote:
> Hi Daniel,
>=20
> On Tue, Nov 24, 2015 at 02:03:06PM +0100, Daniel Wagner wrote:
> > rcu_nocb_gp_cleanup() is called while holding rnp->lock. Currently,
> > this is okay because the wake_up_all() in rcu_nocb_gp_cleanup() will
> > not enable the IRQs. lockdep is happy.
> >=20
> > By switching over using swait this is not true anymore. swake_up_all()
> > enables the IRQs while processing the waiters. __do_softirq() can now
> > run and will eventually call rcu_process_callbacks() which wants to
> > grap nrp->lock.
> >=20
> > Let's move the rcu_nocb_gp_cleanup() call outside the lock before we
> > switch over to swait.
> >=20
>=20
> But you did introduce swait in this patch ;-)
>=20
> [snip]
>=20
> >=20
> > Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/rcu/tree.c        |  4 +++-
> >  kernel/rcu/tree.h        |  3 ++-
> >  kernel/rcu/tree_plugin.h | 16 +++++++++++++---
> >  3 files changed, 18 insertions(+), 5 deletions(-)
> >=20
>=20
> So I tried to build this patch with a config having RCU_EXPERT=3Dy and
> RCU_NOCB_CPU=3Dy, but I got:
>=20
> In file included from include/linux/completion.h:11:0,
>                  from include/linux/rcupdate.h:43,
>                  from include/linux/sysctl.h:25,
>                  from include/linux/timer.h:242,
>                  from include/linux/workqueue.h:8,
>                  from include/linux/pm.h:25,
>                  from ./arch/x86/include/asm/apic.h:5,
>                  from ./arch/x86/include/asm/smp.h:12,
>                  from include/linux/smp.h:59,
>                  from kernel/rcu/tree.c:34:
> kernel/rcu/tree_plugin.h: In function =E2=80=98rcu_nocb_gp_cleanup=E2=80=
=99:
> kernel/rcu/tree_plugin.h:1782:14: warning: passing argument 1 of =E2=80=
=98__wake_up=E2=80=99 from incompatible pointer type [-Wincompatible-pointe=
r-types]
>   wake_up_all(sq);
>               ^
> include/linux/wait.h:168:36: note: in definition of macro =E2=80=98wake_u=
p_all=E2=80=99
>  #define wake_up_all(x)   __wake_up(x, TASK_NORMAL, 0, NULL)
>=20
>=20

Just to be clear, I saw this build error when I applied only the first
four patches of this series. When I applied the whole series, I didn't
see any build error.

Regards,
Boqun

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWVQhnAAoJEEl56MO1B/q4yfUIAKnTl1V1ClJBy4YpyWHpkPZt
GM3vZwBw4dhW6dPNRKETk58Koi+j8qQu1oOTVcqiWoe/rJwVSclYmov/L5dFUEG/
EgAbtQC2OZP3It97VsHQlAw/JTIEx8xpfovxxFt0yNQ90Nq25POziMYazTMdX5es
W7AAvA8v77Gq+8fuH/ORfyN7/d00dsjbEZ+GjD2aZiGgTCcozDXdnw8f/nSeY66P
cOgHYM69k0OKtfJUzlAPspEBs3EIwA7X2LRSMbXU0ZzqmTEphfa/GBmlMMJGckkD
2H+7xy1N58N/RbxTflNAP5CaAZ9r12kjmh6WZp9lHuwXlDeUe5VtyYERLzb3y3E=
=7ECM
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
