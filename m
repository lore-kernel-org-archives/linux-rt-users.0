From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCH] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 12:10:08 -0400
Message-ID: <48B81F60.3080409@gmail.com>
References: <20080829154237.1196.66825.stgit@dev.haskins.net> <87abevpzv7.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7A6370587E8DC5E9411ED3A7"
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:57610 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbYH2QMc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Aug 2008 12:12:32 -0400
Received: by gxk9 with SMTP id 9so5192471gxk.13
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Aug 2008 09:12:31 -0700 (PDT)
In-Reply-To: <87abevpzv7.fsf@basil.nowhere.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7A6370587E8DC5E9411ED3A7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andi Kleen wrote:
> Gregory Haskins <ghaskins@novell.com> writes:
>
>  =20
>> *Patch submitted for inclusion in PREEMPT_RT 26-rt4.  Applies to 2.6.2=
6.3-rt3*
>>
>> Hi Ingo, Steven, Thomas,
>>   Please consider for -rt4.  This fixes a nasty deadlock on my systems=
 under
>>   heavy load.
>>    =20
>
> Does this even work under x86-64? x86-64 uses seqlocks in user space
> in its vsyscalls. And read_lock() definitely doesn't work there because=
=20
> it writes.
>
> You would need at least to disable vsyscall gettimeofday(), making
> it much much slower.
>
> Perhaps you tested on one of the systems where the vsyscalls need
> to fallback for other reasons? (e.g. one using pmtimer for timing).
>
> -Andi
>  =20

Im running it on a x86_64 box as we speak.  How can I tell if there is a
certain mode that is permitting this?

-Greg


--------------enig7A6370587E8DC5E9411ED3A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki4H2AACgkQP5K2CMvXmqFBQgCePglzOP7J5+EKmwAQimHviHjh
jpIAnimyoSV8C7qYlXvDR5Wh0YqU4DD0
=Nz7b
-----END PGP SIGNATURE-----

--------------enig7A6370587E8DC5E9411ED3A7--
