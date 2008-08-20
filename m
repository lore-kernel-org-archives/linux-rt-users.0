From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH 1/2] [RT] hrtimers stuck in waitqueue
Date: Wed, 20 Aug 2008 06:57:37 -0400
Message-ID: <48ABF8A1.9080009@novell.com>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net> <1219070552-30783-2-git-send-email-gilles.carry@bull.net> <48AAD44D.8050000@novell.com> <789E827C-DB3F-451E-BFFF-4210433029DF@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE42818D669E5C7CB078B2B6D"
Cc: Gilles Carry <gilles.carry@bull.net>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net
To: Gilles Carry <glscarry@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:43521 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbYHTK7z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Aug 2008 06:59:55 -0400
In-Reply-To: <789E827C-DB3F-451E-BFFF-4210433029DF@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE42818D669E5C7CB078B2B6D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

Gilles Carry wrote:
>
> Le 19 ao=FBt 08 =E0 16:10, Gregory Haskins a =E9crit :
>
>> Hi Gilles,
>>
>> Gilles Carry wrote:
>>> This patch makes hrtimers initialized with hrtimer_init_sleeper
>>> to use another mode and then not be stuck in waitqueues when
>>> hrtimer_interrupt is very busy.
>>> =20
>>
>> Not sure if this is related, but I just posted a patch to fix a=20
>> condition where hrtimer_interrupt could get artificially busy for=20
>> *very* long periods of time (I observed 500ms).
>>
>> http://article.gmane.org/gmane.linux.rt.user/3357
>>
>> This bug was specific to 26-rt1.  Did you investigate the cause of=20
>> the busy hrtimer_interrupt?  If not, its possible that your issue=20
>> would be indirectly fixed now that the HRT subsystem doesn't=20
>> spike-out like that.  Or do you believe these are orthogonal issues=20
>> and we should still protect against non-pathological cases of=20
>> hrtimer_interrupt running hot?
>
> Hello Greg,
> The cause of busy hrtimer interrupt is the test that stresses the=20
> system. Many timers expire and are treated in a single interrupt run.
>
> Anyway looking at __run_hrtimer we can see:
> spin_unlock (&cpu_base->lock);
> restart =3D fn(timer);
> spin_lock(&cpu_base->lock);
>
> I guess It is the point where awaken threads might migrate to another c=
pu and reach hrtimer_cancel *before* __run_hrtimer has changed the timer =
state. (at the bottom of the function)
> This is why a new state machine is needed.

It sounds reasonable that both fixes are needed, then.  Thanks.

-Greg

>
> Regards,
> Gilles.
>
>>
>>
>> Regards,
>> -Greg
>>
>>
>>
>



--------------enigE42818D669E5C7CB078B2B6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkir+KEACgkQlOSOBdgZUxktiwCdGumk6pRtgTJQDLhGVD3ORn5i
FE8AoIsNNUbBbhqDjBofIaZi9nMjnlwR
=drjO
-----END PGP SIGNATURE-----

--------------enigE42818D669E5C7CB078B2B6D--
