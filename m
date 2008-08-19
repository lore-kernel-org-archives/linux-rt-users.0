From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH RT 2/2] ftrace: fix elevated preempt_count in	wakeup-tracer
Date: Tue, 19 Aug 2008 09:21:43 -0400
Message-ID: <48AAC8E7.1030506@novell.com>
References: <20080819091817.21725.81831.stgit@dev.haskins.net>	 <20080819091923.21725.41087.stgit@dev.haskins.net> <1219151556.10800.383.camel@twins>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC878401C36B1637DB7921246"
Cc: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:56470 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbYHSNYJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Aug 2008 09:24:09 -0400
In-Reply-To: <1219151556.10800.383.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC878401C36B1637DB7921246
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Peter Zijlstra wrote:
> On Tue, 2008-08-19 at 05:19 -0400, Gregory Haskins wrote:
>  =20
>> Suggested by Steve Rostedt to fix an observed "+1" in the preempt-coun=
t
>>
>> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
>> ---
>>
>>  kernel/trace/trace_sched_wakeup.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sc=
hed_wakeup.c
>> index c3a15bd..ae523fd 100644
>> --- a/kernel/trace/trace_sched_wakeup.c
>> +++ b/kernel/trace/trace_sched_wakeup.c
>> @@ -70,7 +70,9 @@ wakeup_tracer_call(unsigned long ip, unsigned long p=
arent_ip)
>>  	if (task_cpu(wakeup_task) !=3D cpu)
>>  		goto unlock;
>> =20
>> +	preempt_enable_no_resched_notrace();
>>  	trace_function(tr, data, ip, parent_ip, flags);
>> +	preempt_disable_notrace();
>>    =20
>
> Is preempt_count > 1 at all times here?
>
> If not, it might drop to 0 and any interrupt might cause preemption -
> and its not obvious to me that that is actually correct.
>  =20
According to Steve, we are already in an interrupt-disabled section=20
here, but I will defer to him.  He suggested I try this over an IRC=20
conversation when I noticed a strange wakeup trace, and it seems to have =

solved the problem.

Im really sending this patch more of a reminder to Steve that he was=20
going to fix this, rather than to accept my patch as is.  Of course I=20
don't mind if it is accepted as is, and I can make the prologue/comments =

more descriptive if necessary.  But if Steve wants to do something like=20
fold this into his ftrace series, that is fine too.  I just didn't want=20
it to be forgotten ;)

-Greg



--------------enigC878401C36B1637DB7921246
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkiqyOcACgkQlOSOBdgZUxmLDACfTlvc2CWpJogDCOvz6oEaCnDK
lTMAnivubK1GAQcsHM/6oJdz65pZ9KXN
=wIqa
-----END PGP SIGNATURE-----

--------------enigC878401C36B1637DB7921246--
