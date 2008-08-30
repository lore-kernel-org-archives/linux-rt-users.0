From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [RT PATCH v2] seqlock: serialize against writers
Date: Sat, 30 Aug 2008 08:32:13 -0400
Message-ID: <48B93DCD.2010503@novell.com>
References: <20080829154237.1196.66825.stgit@dev.haskins.net>	 <20080829180135.22450.54780.stgit@dev.haskins.net> <1220095043.8426.16.camel@twins>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFCF400B5EFEAECBDDE9AF5F7"
Cc: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	gregory.haskins@gmail.com, andi@firstfloor.org,
	shemminger@vyatta.com
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:57510 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbYH3Men (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Aug 2008 08:34:43 -0400
In-Reply-To: <1220095043.8426.16.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFCF400B5EFEAECBDDE9AF5F7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Peter Zijlstra wrote:
> On Fri, 2008-08-29 at 14:03 -0400, Gregory Haskins wrote:
>  =20
>> *Patch submitted for inclusion in PREEMPT_RT 26-rt4.  Applies to 2.6.2=
6.3-rt3*
>>
>> Hi Ingo, Steven, Thomas,
>>   Please consider for -rt4.  This fixes a nasty deadlock on my systems=
 under
>>   heavy load.
>>
>> [
>> Changelog:
>> 	v2: only touch seqlock_t because raw_seqlock_t doesn't require
>> 	    serialization and userspace cannot modify data during a read
>>
>> 	v1: initial release
>> ]
>>
>> -Greg
>>
>> ----
>> seqlock: serialize against writers
>>
>> Seqlocks have always advertised that readers do not "block", but this =
was
>> never really true.  Readers have always logically blocked at the head =
of
>> the critical section under contention with writers, regardless of whet=
her
>> they were allowed to run code or not.
>>
>> Recent changes in this space (88a411c07b6fedcfc97b8dc51ae18540bd2beda0=
)
>> have turned this into a more explicit blocking operation in mainline.
>> However, this change highlights a short-coming in -rt because the
>> normal seqlock_ts are preemptible.  This means that we can potentially=

>> deadlock should a reader spin waiting for a write critical-section to =
end
>> while the writer is preempted.
>>    =20
>
> Ah, the point I was missing is higher-priority realtime task, in which
> case the write side will never run because it wont preempt.
>  =20

Yep
>  =20
>> This patch changes the internal implementation to use a rwlock and for=
ces
>> the readers to serialize with the writers under contention.  This will=

>> have the advantage that -rt seqlocks_t will sleep the reader if deadlo=
ck
>> were imminent, and it will pi-boost the writer to prevent inversion.
>>
>> This fixes a deadlock discovered under testing where all high prioriti=
y
>> readers were hogging the cpus and preventing a writer from releasing t=
he
>> lock.
>>
>> Since seqlocks are designed to be used as rarely-write locks, this sho=
uld
>> not affect the performance in the fast-path
>>    =20
>
> Still dont like this patch, once you have a rwlock you might as well go=

> all the way.

Why?  A full rwlock will still be much slower since the readers will
always need an atomic op.  This construct only uses atomic ops in the
slow path under contention, which should be rare, and is thus still
superior when retries are permissible to the design.

>  Esp since this half-arsed construct defeats PI in certain
> cases.
>  =20

Ouch.  While I admit that you can still get into inversion scenarios
once the reader leaves the seqbegin, this is the nature of seqlocks.=20
The only ways I can think of to get around this involve atomic ops in
the fast path, which I think should be avoided.  What would you suggest
otherwise?

-Greg






--------------enigFCF400B5EFEAECBDDE9AF5F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki5Pc0ACgkQlOSOBdgZUxllJgCgjH28nzOZaZTtfQ9GHSvBrvFf
jBgAnjzwnpzltDjpmrX8h5HSE96ZK3R4
=qKTm
-----END PGP SIGNATURE-----

--------------enigFCF400B5EFEAECBDDE9AF5F7--
