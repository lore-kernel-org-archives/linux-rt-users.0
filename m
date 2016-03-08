From: Josh Cartwright <joshc@ni.com>
Subject: Re: [RFC v0] Use swait in completion
Date: Tue, 8 Mar 2016 12:26:56 -0600
Message-ID: <20160308182656.GA27081@jcartwri.amer.corp.natinst.com>
References: <1457452754-24029-1-git-send-email-wagi@monom.org>
 <20160308175206.GD21842@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Cc: Daniel Wagner <wagi@monom.org>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:48807 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750819AbcCHS1k (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Mar 2016 13:27:40 -0500
In-Reply-To: <20160308175206.GD21842@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 08, 2016 at 06:52:06PM +0100, Sebastian Andrzej Siewior wrote:
> * Daniel Wagner | 2016-03-08 16:59:13 [+0100]:
>=20
> >Hi,
> Hi,
>=20
> >As Peter correctly pointed out in [1] a simple conversion from
> >wait to swait in completion.c wont work. I played a bit around and
> >came up with this rather ugly idea.
>=20
> besides all the things I mentioned privatly, here is what I have
> currently in -RT:
>=20
> +void swake_up_all_locked(struct swait_queue_head *q)
> +{
> +       struct swait_queue *curr;
> +       int wakes =3D 0;
> +
> +       while (!list_empty(&q->task_list)) {
> +
> +               curr =3D list_first_entry(&q->task_list, typeof(*curr),
> +                                       task_list);
> +               wake_up_process(curr->task);
> +               list_del_init(&curr->task_list);
> +               wakes++;
> +       }
> +       WARN_ON(wakes > 2);
> +}
> +EXPORT_SYMBOL(swake_up_all_locked);
>=20
> the remaining part is what you have. The only user so far is complete()
> and currently I see ony complete_all() with zero or one waiter.
> If none of my boxes die over the night, I intend to release this
> tomorrow in -RT and see if someone else triggers the limit.
>=20
> However I don't think if your DEFER flag solution is all that bad.  I
> have also the block-mq in -RT using swait and they perform wakes with
> irqs-off. Not in -RT but mainline. So me might need something to make
> it work properly. But if we defer the wakeup they might come at us and
> complain about the latency???

Is it really just about latency?  Does this deferral not lead to an
inversion in the case where the single woken task isn't the highest
priority waiter on the completion (and doesn't run due to a
middle-priority thing spinning)?

In order for this to work, it seems like the chosen waiter would need to
inherit the highest priority of all waiters (which AFAICT isn't
happening).

  Josh

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW3xltAAoJEKp7ZBKwQFArZsMIAJXlXHCf5HNRlx7pFxpUj7ft
9/U2QZSOlNL/2FH1hx+STYaDAO8pDbuNxT+qgdjTo2d08LouX4dqzNPRHIHOtQ1Y
+D9Y5pWC/y7KCN9r7d8hjJTuBWmVVU9WsruFVZ6bT5G9Oum8IF4PH8+YPU5ZGoD0
vCV0l8lEZG+WbF8Y5+9Y60pyHopsahXixy2lcHbGUMuZapwg/DfAC1bwUVGr5OBb
e4hHSzUcEmQu96ivjLdndxTuUpqOLB3W4hTvODsW7wAfqAouZ7Ejvc6RJg//Aebh
MyWp5EE1/5AbQ++y8hKwQmBR3ZlNjbVw90eCYq2a7vUE2HxexSm9rU1XqbCOX1k=
=SWpj
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
