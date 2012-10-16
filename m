From: Bhavesh Davda <bhavesh@vmware.com>
Subject: Re: cyclictest overflow instance tracking -- irc continued
Date: Tue, 16 Oct 2012 09:11:15 -0700
Message-ID: <490E56CB-B2C1-4B58-A9FA-C3D37BD84F52@vmware.com>
References: <507CAF63.7080703@am.sony.com>
 <alpine.LFD.2.02.1210161251190.3137@tycho>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:55942 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754357Ab2JPQLQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Oct 2012 12:11:16 -0400
In-Reply-To: <alpine.LFD.2.02.1210161251190.3137@tycho>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry about that John, Frank! Don't know how that happened=85

Please look for two separate patches against the right ToT: one for whi=
tespace cleanup, and the other with this feature, in the next few hours=
=85

Thanks

- Bhavesh

On Oct 16, 2012, at 3:56 AM, John Kacur wrote:

>=20
>=20
> On Mon, 15 Oct 2012, Frank Rowand wrote:
>=20
> Thanks for your further review Frank. Bhavesh - I think the right thi=
ng to=20
> do here, is to ask you to respin your patch. Can you make sure you ar=
e=20
> applying and testing against the latest. (0.84). Also, please put any=
=20
> white space clean-ups in a separate patch to make it easier to read t=
he=20
> important patch. Oh, and send these in a new thread. If people could=20
> preface their mail with [PATCH RT-TESTS] that would also help.
>=20
> Thank You.
>=20
> John Kacur
>=20
>>=20
>> 16:13	jkacur	frowand_bot: would you like a Reviewed-by: credit for t=
he cyclictest histogram overflow instance tracking patch?
>> 16:13	jkacur	can I just add that or is the reviewer supposed to requ=
est it?
>> 17:02	frowand	jkacur: sure, you can add my reviewed-by (at least for=
 the first version, i didn't really look at the second version in detai=
l)
>>=20
>> For the first version, it was a drive-by review, just obvious stuff.
>>=20
>> Now that I look at the second version a little closer (but still not=
 in detail), it
>> looks like he did some white space clean up, which should probably b=
e a separate patch.
>>=20
>> It also looks like he created his patch against an old version of cy=
clictest,
>> because he has:
>>=20
>> @@ -154,6 +155,7 @@ struct thread_stat {
>> 	long redmax;
>> 	long cycleofmax;
>> 	long hist_overflow;
>> +        long num_outliers;
>> };
>>=20
>>=20
>> but struct thread_stat currently has another field:
>>=20
>>        long redmax;
>>        long cycleofmax;
>>        long hist_overflow;
>>        unsigned long now_after_next;
>> };
>>=20
>> and also the line numbers in the patch are off.
>>=20
>>> from #linux-rt:
>>>=20
>>> 17:07	jkacur	frowand: hmm, the patch doesn't appear to be working f=
or me
>>> 17:07	jkacur	I'll look at it more tomorrow
>>> 17:08	jkacur	Thread 0: 18446744073709551615 00000 00001 00002 00003=
 00004 00005 00006 00007 00008 # 02841 others
>>> 17:08	jkacur	is an example of broken output
>>=20
>> 18446744073709551615 is 0xffffffffffffffff (or -1LL)
>>=20
>> It looks like in timerthread(), the line:
>>=20
>> +					stat->outliers[stat->num_outliers++] =3D stat->cycles - 1;
>>=20
>> is picking up stat->cycles =3D=3D zero.  Looking at the current vers=
ion of cyclictest, for the
>> first event cycles should already be one at this point.  But given t=
hat the line numbers in
>> the patch are not consistent with the current cyclictest, I don't kn=
ow where that chunk
>> actually got inserted.
>>=20
>>=20
>> -Frank
>>=20
>>=20

--
Bhavesh Davda
bhavesh@vmware.com






--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
