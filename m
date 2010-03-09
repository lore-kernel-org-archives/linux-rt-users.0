From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/2] do-not-allow-prio-less-than-one-in-cyclictest.patch
Date: Tue, 9 Mar 2010 19:12:36 +0100
Message-ID: <520f0cf11003091012w6218931fmcb494dd280c96d0f@mail.gmail.com>
References: <20100307203955.895980022@osadl.org>
	 <20100307204241.033320249@osadl.org>
	 <520f0cf11003071437p13cda9f9n1dba8d01ad33aedd@mail.gmail.com>
	 <4B968D3F.3070106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carsten Emde <C.Emde@osadl.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: David Sommerseth <davids@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:20668 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227Ab0CISMh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Mar 2010 13:12:37 -0500
Received: by ey-out-2122.google.com with SMTP id 25so990903eya.19
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Mar 2010 10:12:36 -0800 (PST)
In-Reply-To: <4B968D3F.3070106@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 9, 2010 at 7:02 PM, David Sommerseth <davids@redhat.com> wr=
ote:
> On 07/03/10 23:37, John Kacur wrote:
>> On Sun, Mar 7, 2010 at 9:39 PM, Carsten Emde <C.Emde@osadl.org> wrot=
e:
>>> If not in SMP testing mode, the priority may go below 1, if the spe=
cified
>>> priority is lower than the number of threads, e.g.
>>> # cyclictest -p2 -t3
>>> T: 0 (21970) P: 2 [..]
>>> T: 1 (21971) P: 1 [..]
>>> T: 2 (21972) P: 0 [..]
>>>
>>> Do not allow priority to go below 1.
>>>
>>> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>>>
>>> Index: rt-tests/src/cyclictest/cyclictest.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- rt-tests.orig/src/cyclictest/cyclictest.c
>>> +++ rt-tests/src/cyclictest/cyclictest.c
>>> @@ -1304,7 +1304,7 @@ int main(int argc, char **argv)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0par->prio =3D priority;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!sameprio)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (priority > 1 && !sameprio)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priority--;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =A0 =A0 =A0(priority && policy <=
=3D 1) par->policy =3D SCHED_FIFO;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (priority && policy =3D=3D =
2) par->policy =3D SCHED_RR;
>>>
>>> --
>>
>> I'm not sure about this, why not allow a priority below 1? The code
>> below properly sets the third thead to SCHED_OTHER.
>> I could imagine wanting to test that too. If you don't want to go
>> below 1 then just set a higher prio, p3 in the scenario you
>> showed.
>
> Maybe I'm misreading and misunderstanding the patch ... but I believe
> the if statement should say:
>
> =A0 =A0 =A0 =A0if (priority > 0 && !sameprio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priority--;
>
> Just to avoid the situation the commit log says, priority to go below=
 0.
>
>
> kind regards,
>
> David Sommerseth

The code in general there was buggy, so I reverted the patch that
caused the problems in the first place.
(assuming Clark merges it).

Now the code will read (as it did before)

 if (priority && !histogram && !smp && !numa)
                        priority--;
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
