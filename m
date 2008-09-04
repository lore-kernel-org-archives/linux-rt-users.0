From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [TIP/SCHED/DEVEL PATCH v3 4/6] sched: add sched_class->needs_post_schedule()
 member
Date: Thu, 04 Sep 2008 16:36:04 -0400
Message-ID: <48C046B4.1030706@gmail.com>
References: <20080904125029.23633.88210.stgit@dev.haskins.net> <20080904125520.23633.64862.stgit@dev.haskins.net> <alpine.DEB.1.10.0809041634580.3849@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9C69CD301550FD5010A619EB"
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	peterz@infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, npiggin@suse.de
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:43142 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760885AbYIDUic (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Sep 2008 16:38:32 -0400
Received: by gxk9 with SMTP id 9so6736694gxk.13
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Sep 2008 13:38:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0809041634580.3849@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C69CD301550FD5010A619EB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Rostedt wrote:
> On Thu, 4 Sep 2008, Gregory Haskins wrote:
>  =20
>> diff --git a/kernel/sched.c b/kernel/sched.c
>> index af4c6fa..ddc3877 100644
>> --- a/kernel/sched.c
>> +++ b/kernel/sched.c
>> @@ -2525,6 +2525,14 @@ static void finish_task_switch(struct rq *rq, s=
truct task_struct *prev)
>>  {
>>  	struct mm_struct *mm =3D rq->prev_mm;
>>  	long prev_state;
>> +#ifdef CONFIG_SMP
>> +	int post_schedule =3D 0;
>> +
>> +	if (current->sched_class->needs_post_schedule) {
>> +		BUG_ON(!current->sched_class->post_schedule);
>>    =20
>
> The only one to ever hit this BUG_ON is a kernel developer creating a n=
ew
> sched class. Since they should be smart enough to figure out why they g=
et=20
> a segv later on, we really don't need it. Because this BUG_ON is also i=
n=20
> a hot path, I strongly suggest nuking it.
>  =20
Ack.  Will do a respin after you review the last few patches.

-Greg



--------------enig9C69CD301550FD5010A619EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjARrQACgkQP5K2CMvXmqHPywCeMhLmUghAk/vujVXeMta+VtOR
KfoAnjBisOzJN0ovtwlSAOdgve2baDEX
=8cE1
-----END PGP SIGNATURE-----

--------------enig9C69CD301550FD5010A619EB--
