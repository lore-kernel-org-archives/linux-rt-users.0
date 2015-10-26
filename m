From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v3 1/4] wait.[ch]: Introduce the simple waitqueue (swait)
 implementation
Date: Mon, 26 Oct 2015 22:19:49 +0800
Message-ID: <20151026141949.GA26372@fixme-laptop.cn.ibm.com>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-2-git-send-email-daniel.wagner@bmw-carit.de>
 <20151026120426.GA1497@fixme-laptop.cn.ibm.com>
 <562E23C0.9000500@bmw-carit.de>
 <20151026132601.GV2508@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151026132601.GV2508@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 02:26:01PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 26, 2015 at 01:59:44PM +0100, Daniel Wagner wrote:
> > Hi Boqun,
> >=20
> > On 10/26/2015 01:04 PM, Boqun Feng wrote:
> > > On Tue, Oct 20, 2015 at 09:28:07AM +0200, Daniel Wagner wrote:
> > >> +
> > >> +/*
> > >> + * The thing about the wake_up_state() return value; I think we can=
 ignore it.
> > >> + *
> > >> + * If for some reason it would return 0, that means the previously =
waiting
> > >> + * task is already running, so it will observe condition true (or h=
as already).
> > >> + */
> > >> +void swake_up_locked(struct swait_queue_head *q)
> > >> +{
> > >> +	struct swait_queue *curr;
> > >> +
> > >> +	list_for_each_entry(curr, &q->task_list, task_list) {
> > >> +		wake_up_process(curr->task);
> > >> +		list_del_init(&curr->task_list);
> > >> +		break;
> > >=20
> > > Just be curious, what's this break for? Or what's this loop(?) for?
> >=20
> > I have to guess here, since Peter wrote it. It looks like the function
> > is based on __wake_up_common(). Though I agree the loop is not necessary
> > and something like below should the trick. Unless I do not see something
> > important.
> >=20
> > 	void swake_up_locked(struct swait_queue_head *q)
> > 	{
> > 		struct swait_queue *curr;
> >=20
> > 		if (list_emtpy(&q))
> > 			return;
> >=20
> > 		curr =3D list_first_entry(&q, typeof(*curr), task_list);
> > 		wake_up_process(curr->task);
> > 		list_del_init(&curr->task_list);
> > 	}
> >=20
> > If Peter is not complaining I change swake_up_locked() for the next ver=
sion.

This gains better readability, I think ;-)

>=20
> Yes, that is equivalent, just more code. As I wrote in my last email; I
> was lazy :-)

;-)

Maybe introduce a list_pick_one_if_any() macro for convenience:

	#define list_pick_one_if_any(pos, list, member) 	\
	if (!list_empty(list) && (pos =3D list_first_entry(list, typeof(*pos), mem=
ber), 1))=20

then

	void swake_up_locked(struct swait_queue_head *q)
	{
		struct swait_queue *curr;

		list_pick_one_if_any(curr, q->task_list, task_list) {
			wake_up_process(curr->task);
			list_del_init(&curr->task_list);
		}
	}
=09


Anyway, thank you both for going through this.

Regards,
Boqun

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWLjaBAAoJEEl56MO1B/q43PUIALbAkrCt3w/Ac6EU3wm6pvAi
L5cKrgzX7I3fwQ0lC/LVmC2sqO5I7NOpZ+KWDuqVlW0iOcRq43ongc9iq1bBM2DM
sZ+wBFMIic5Id9lYN+vQ4e0Krb4cFTs9rYns7jVrOnKrUGLP3mFHBu00w3jVsoOE
xqE2CAbfjEg9y53hxKG5KPYMtOK2tgpLsz0BUbarCKGf/CAPM/zU5iFDbfleBAML
kKM82pZYf3LClc9LCrB/DBlSplj5ko+m6QAeBWxzDzL4W0sjV4r6IOOAInQFHvsT
UCbcdibSOcB27k1cfmGhOLc8S8QjQ/sY8431Nn9ByQwl/iMDc3GPk4nYyB3/0P8=
=Q3RD
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
