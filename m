From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: AW: [PATCH RT RFC v4 1/8] add generalized priority-inheritance
 interface
Date: Tue, 19 Aug 2008 04:34:37 -0400
Message-ID: <48AA859D.4030005@novell.com>
References: <20080815202408.668.23736.stgit@dev.haskins.net> <20080815202823.668.26199.stgit@dev.haskins.net> <073b01c8ffb5$5c597870$150c6950$@de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD7C1ED69123020A7324850ED"
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	gregory.haskins@gmail.com, mingo@elte.hu, David.Holmes@sun.com,
	jkacur@gmail.com, paulmck@linux.vnet.ibm.com, peterz@infradead.org,
	tglx@linutronix.de, rostedt@goodmis.org
To: Matthias Behr <linux@mcbehr.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:59226 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbYHSIgz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Aug 2008 04:36:55 -0400
In-Reply-To: <073b01c8ffb5$5c597870$150c6950$@de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD7C1ED69123020A7324850ED
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

Matthias Behr wrote:
> Hi Greg,
>
> I got a few review comments/questions. Pls see below.
>
> Best Regards,
> Matthias
>
> P.S. I'm a kernel newbie so don't hesitate to tell me if I'm wrong ;-)
>
>  =20
>> +/**
>> + * pi_sink_init - initialize a pi_sink before use
>> + * @sink: a sink context
>> + * @ops: pointer to an pi_sink_ops structure
>> + */
>> +static inline void
>> +pi_sink_init(struct pi_sink *sink, struct pi_sink_ops *ops)
>> +{
>> +	atomic_set(&sink->refs, 0);
>> +	sink->ops =3D ops;
>> +}
>>    =20
>
> Shouldn't ops be tested for 0 here? (ASSERT/BUG_ON/...) (get's derefere=
nced later quite often in the form "if (sink->ops->...)".
>  =20

This is a good idea.  I will add this.

>  =20
>> +/**
>> + * pi_sink_put - down the reference count, freeing the sink if 0
>> + * @node: the node context
>> + * @flags: optional flags to modify behavior.  Reserved, must be 0.
>> + *
>> + * Returns: none
>> + */
>> +static inline void
>> +pi_sink_put(struct pi_sink *sink, unsigned int flags)
>> +{
>> +	if (atomic_dec_and_test(&sink->refs)) {
>> +		if (sink->ops->free)
>> +			sink->ops->free(sink, flags);
>> +	}
>> +}
>>    =20
>
> Shouldn't the atomic/locked part cover the ...->free(...) as well?

Actually, it already does.  The free can only be called by the last=20
reference dropping the ref-count.


>  A pi_get right after the atomic_dec_and_test but before the free() cou=
ld lead to a free() with refs>0?
>  =20

A pi_get() after the ref could have already dropped to zero is broken at =

a higher layer.  E.g. the caller of pi_get() has to ensure that there=20
are no races against the reference dropping to begin with.  This is the=20
same as any reference-counted object (for instance, see get_task_struct()=
).

Thanks for the review, Matthias!

Regards,
-Greg



--------------enigD7C1ED69123020A7324850ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkiqhZ0ACgkQlOSOBdgZUxl2VACePOr4XiDXkWqyddD8I6Uw5j9i
J98AoIAJXu0rmnYq/dbVf8weyMqXlgSU
=1Y6x
-----END PGP SIGNATURE-----

--------------enigD7C1ED69123020A7324850ED--
