From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: Arm me with info - root != real-time
Date: Mon, 23 Feb 2009 18:01:55 -0500
Message-ID: <49A32AE3.7020408@novell.com>
References: <5bdc1c8b0902231429r320efb5by507f3cb26c2d5162@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig37680709904327506653BAE0"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:43910 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbZBWW7V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2009 17:59:21 -0500
In-Reply-To: <5bdc1c8b0902231429r320efb5by507f3cb26c2d5162@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig37680709904327506653BAE0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Mark Knecht wrote:
> Hi Ingo, Steven, Thomas and other RT developers,
>   As always, thanks for what you do. I've been subscribed here for a
> few years. Don't say much. Do read a lot.
>
>    As a user type I've run the RT kernels for years now. 5 years ago
> it was really crucial for my music work. I still use it faithfully.
> However on many lists now I'm seeing new people say there's no need
> for the RT kernel because they run their applications as root and feel
> they get the 'same' or 'good enough' results. I wonder how they know
> if they don't run both and compare but that's their business. I'm
> suspect but not technically deep enough in this subject to have a
> conversation so I thought I'd ask for a little simple (if possible)
> education.
>
> I PROCLAIM - Running an application as root on the standard kernel is
> not as real time capable as running the same application as a normal
> user with proper priorities & permissions on the RT kernel.
>
> True or false?
>  =20
True

Running as root, even on preempt-rt, doesnt really buy you anything
w.r.t. real-time response.  What it does do (aside from introduce the
security/stability concerns you mention) is give you implicit permission
to change your scheduling policy/priority, which is part of what is
needed to actually _become_ real-time.  Being a root user itself doesn't
actually change anything w.r.t. your scheduling response.  And as you
noted, there are other preferable ways to give this capability to a user
without requiring root, and this is generally advised as a better IT poli=
cy.

That said: Note that all recent mainline kernels generally employ the
same real-time scheduler as the one used in PREEMPT_RT and have a fairly
high degree of preempt-ability (when suitably configured).  Therefore,
you *could* conceivably configure mainline with CONFIG_PREEMPT and set
your scheduler policy/priorities appropriately to achieve a moderate
amount of deterministic behavior.  However, note that mainline to date
does not have some of the more fancy RT features found in PREEMPT_RT
such as threaded-irqs (read: priortizable), "sleeping spinlocks", and PI
mutexes that allow you to get the _really_ low latencies.  But it may be
"good enough", as your pollees put it, for a given application.=20
"Acceptable latency" is in the eye of the beholder. ;)

So the short answer is: Running as root doesnt really do anything for
you, but you may be able to get "acceptable" (determined by your app)
real-time performance out of mainline without PREEMPT_RT if you know
what you are doing. YMMV.

HTH
-Greg

>    Is there a source of measured data to show this is true or false?
>
>    I know a lot of what you've done over the years is now mainline but
> I don't know how much of it is turned on by default.
>
>    Clearly, I think folks don't have their head screwed on tight if
> they are running development apps as root, but people are doing it.
> They don't seem to care about security or the obvious fact that
> running as root might allow an app to erase their hard drive, etc.
> Their minds will change when something goes wrong, but in the meantime
> what can I tell them about this subject to get them to use the RT
> kernel and be as happy as I am with it.
>
> Thanks,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20



--------------enig37680709904327506653BAE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmjKuMACgkQlOSOBdgZUxkDUwCfdR2n8rlvsD0oSytlctPHGeV7
0AMAn0mOzr0LiAS56Iy+nvdQgXAANX5u
=nSbW
-----END PGP SIGNATURE-----

--------------enig37680709904327506653BAE0--
