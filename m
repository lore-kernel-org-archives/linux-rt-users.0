From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCH] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 12:35:25 -0400
Message-ID: <48B8254D.1010206@gmail.com>
References: <20080829154237.1196.66825.stgit@dev.haskins.net> <87abevpzv7.fsf@basil.nowhere.org> <48B81F60.3080409@gmail.com> <20080829162216.GW26610@one.firstfloor.org> <48B82349.1020109@gmail.com> <alpine.DEB.1.10.0808291233280.17917@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC537A9119F95D7DADBC68DF2"
Cc: Andi Kleen <andi@firstfloor.org>,
	Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:42489 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbYH2Qhs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Aug 2008 12:37:48 -0400
Received: by gxk9 with SMTP id 9so5209890gxk.13
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Aug 2008 09:37:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0808291233280.17917@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC537A9119F95D7DADBC68DF2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Rostedt wrote:
> On Fri, 29 Aug 2008, Gregory Haskins wrote:
>
>  =20
>> Andi Kleen wrote:
>>    =20
>>>> Im running it on a x86_64 box as we speak.  How can I tell if there =
is a
>>>> certain mode that is permitting this?
>>>>    =20
>>>>        =20
>>> If the boot up says you're running with PMtimer then it uses the fall=
back
>>> (usually happens on pre Fam10h AMD boxes). A typical Intel box
>>> would use the faster ring 3 only TSC path and then explode with your
>>> change I bet.=20
>>>
>>> Or step with gdb through gettimeofday() and see if it does a syscall.=

>>>
>>> -Andi
>>>  =20
>>>      =20
>> It seems to be running fine with no indication it has fallen back.=20
>> Perhaps I need a certain workload to bring out the issue?
>>    =20
>
> Perhaps you never hit the slow path in userland. That's the only place =
it=20
> would write. Perhaps add a dummy static variable in the fast path, and =

> write to it. See if that crashes you apps.
>
> -- Steve
>  =20

Yeah, ideas crossed in the mail ;)

I could just force all of the seqbegins to hit the slowpath by hacking
the code and see what happens (aside from slowing down, of course ;)

Question: Which seqlock_t does userspace use?  I assume it uses
seqlock_t and not raw_seqlock_t.  But the only reason that I ask is that
I converted raw_seqlock_t to use the new style as well to be consistent,
even though it is not strictly necessary for the same reasons.  So if
perchance userspace uses the raw variant, I could solve this issue by
only re-working the seqlock_t variant.  Kind of a long shot, but figured
I would mention it :)

-Greg




--------------enigC537A9119F95D7DADBC68DF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki4JU0ACgkQP5K2CMvXmqERwQCfXTxV8DQlmO3Zbi58bk58lEFA
6AQAnAomtElSoo6OXBAIQwgMaZEhSNyl
=FIv4
-----END PGP SIGNATURE-----

--------------enigC537A9119F95D7DADBC68DF2--
