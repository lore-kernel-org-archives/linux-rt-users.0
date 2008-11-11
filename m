From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [RFC PATCH 0/3] Series short description
Date: Tue, 11 Nov 2008 14:50:00 -0500
Message-ID: <4919E1E8.2010505@novell.com>
References: <20081111142323.28477.41235.stgit@dev.haskins.net> <4919DD9B.1070104@nortel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD05C49A89420C291E66D8D40"
Cc: mingo@elte.hu, rostedt@goodmis.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:45260 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbYKKTqO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Nov 2008 14:46:14 -0500
In-Reply-To: <4919DD9B.1070104@nortel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD05C49A89420C291E66D8D40
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Chris Friesen wrote:
> Gregory Haskins wrote:
>> Hi Ingo, Steven, Peter,
>>   This series applies roughly to mainline as an enhancement to the
>> sched_rt
>>   logic.  Peter and I were discussing some of the unecessary overhead =
in
>>   pull_rt_tasks() via IRC, and this is my RFC attempt to address the
>> problem.
>>
>>   I have built/booted this on a 4-way C2D Xeon box and it passes
>> preempt-test.
>
> At first blush it looks reasonable, but do you have any performance
> numbers?

Hi Chris,
  That is a perfectly reasonable request, but unfortunately I do not
have any at this time.  Its currently all based on the observation that
pull_rt_tasks() can cause excessive rq->lock contention and the theory
that this should reduce the cases where that happens.  It still needs to
be proven and quantified, outside of the basic litmus test I gave it
before posting.

I will try to get to this ASAP.

Regards,
-Greg



--------------enigD05C49A89420C291E66D8D40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkkZ4egACgkQlOSOBdgZUxnEEgCfbc6CY1234HeFa+5Srx6/WQb3
GuYAmwW+km5A4ktQMG33EmZ2UuVtvP/F
=XjUL
-----END PGP SIGNATURE-----

--------------enigD05C49A89420C291E66D8D40--
