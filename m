From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: Cyclictest usage
Date: Mon, 11 Aug 2008 09:55:55 -0400
Message-ID: <48A044EB.7010508@novell.com>
References: <ccb913ac0808110200m7a34b361j5a60e9ef31ebb0f4@mail.gmail.com>	 <48A03517.40708@novell.com> <ccb913ac0808110638v79283450j8d4953bc0820e747@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF6D8F8688281640CBA55E576"
Cc: linux-rt-users@vger.kernel.org
To: Tobias Knutsson <tobias.knutsson@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:51842 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbYHKN6H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Aug 2008 09:58:07 -0400
In-Reply-To: <ccb913ac0808110638v79283450j8d4953bc0820e747@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6D8F8688281640CBA55E576
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Tobias,

  Some more questions (inline)

Tobias Knutsson wrote:
> 2.6.25.8-rt7 and 2.6.25.8
>
> On Mon, Aug 11, 2008 at 14:48, Gregory Haskins <ghaskins@novell.com> wr=
ote:
>  =20
>> Tobias Knutsson wrote:
>>    =20
>>> Hello,
>>>
>>> I'm trying to do some initial benchmarking on a rt-kernel versus a
>>> vanilla kernel. On the rt the results are stable in between test runs=

>>> using the following command:
>>>
>>> cyclictest -t 1 -p 80 -c 1 -n -i 10000 -l 10000
>>>      =20

What architecture is this?  And what do you see for ave/max in the=20
cyclictest output on -rt (so we have a reference)


>>> However, using the same command while running the vanilla kernel, I
>>> get very varying results. And I would completely understand if it was=

>>> due to increased jitter. The thing is, the jitter is very low (0%
>>> load) but the average times varies from 600 us to 6500 us depending o=
n
>>> when the test is initiated.
>>>      =20

What are you considering "jitter" when you say it is very low?  Are the=20
600-6500us values truly from the "ave" output of cyclictest, or are=20
these an average of the "max" output?


>>> I imagine this might have something to do with not having high res
>>> timers in the vanilla kernel.

I will defer to Thomas, but my understanding is that 2.6.25 vanilla=20
should have HRT as an option (though I am not sure if you enabled it or=20
not).

>>>  If that is what's causing my problems.
>>>      =20

Cyclictest will report that it cannot access the HRT when it cannot find =

it (at least it does on my system, but I might have an older version=20
running).  Do you see any such warnings?

>>> What is the best way of comparing the two kernels?
>>>      =20

This is a pretty good way, as long as you have HRT in the vanilla=20
kernel.  Assuming for a second that you do, your results are showing you =

what I would expect to see for vanilla (600-6500us spikes).

HTH

-Greg


--------------enigF6D8F8688281640CBA55E576
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkigROsACgkQlOSOBdgZUxn5OwCeOxfQcrhBnxwAojB3PMIpdweF
/OYAn2ZYD4pG/C4ksGLElQmO2lFs0IxV
=0ZsN
-----END PGP SIGNATURE-----

--------------enigF6D8F8688281640CBA55E576--
