From: David Sommerseth <davids@redhat.com>
Subject: Re: [PATCH 1/2] do-not-allow-prio-less-than-one-in-cyclictest.patch
Date: Tue, 09 Mar 2010 19:14:27 +0100
Message-ID: <4B969003.5050204@redhat.com>
References: <20100307203955.895980022@osadl.org>	 <20100307204241.033320249@osadl.org>	 <520f0cf11003071437p13cda9f9n1dba8d01ad33aedd@mail.gmail.com>	 <4B968D3F.3070106@redhat.com> <520f0cf11003091012w6218931fmcb494dd280c96d0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <C.Emde@osadl.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65423 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab0CISOf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Mar 2010 13:14:35 -0500
In-Reply-To: <520f0cf11003091012w6218931fmcb494dd280c96d0f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/03/10 19:12, John Kacur wrote:
> On Tue, Mar 9, 2010 at 7:02 PM, David Sommerseth <davids@redhat.com> wrote:
>> On 07/03/10 23:37, John Kacur wrote:
>>> On Sun, Mar 7, 2010 at 9:39 PM, Carsten Emde <C.Emde@osadl.org> wrote:
>>>> If not in SMP testing mode, the priority may go below 1, if the specified
>>>> priority is lower than the number of threads, e.g.
>>>> # cyclictest -p2 -t3
>>>> T: 0 (21970) P: 2 [..]
>>>> T: 1 (21971) P: 1 [..]
>>>> T: 2 (21972) P: 0 [..]
>>>>
>>>> Do not allow priority to go below 1.
>>>>
>>>> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>>>>
>>>> Index: rt-tests/src/cyclictest/cyclictest.c
>>>> ===================================================================
>>>> --- rt-tests.orig/src/cyclictest/cyclictest.c
>>>> +++ rt-tests/src/cyclictest/cyclictest.c
>>>> @@ -1304,7 +1304,7 @@ int main(int argc, char **argv)
>>>>                }
>>>>
>>>>                par->prio = priority;
>>>> -               if (!sameprio)
>>>> +               if (priority > 1 && !sameprio)
>>>>                        priority--;
>>>>                 if      (priority && policy <= 1) par->policy = SCHED_FIFO;
>>>>                 else if (priority && policy == 2) par->policy = SCHED_RR;
>>>>
>>>> --
>>>
>>> I'm not sure about this, why not allow a priority below 1? The code
>>> below properly sets the third thead to SCHED_OTHER.
>>> I could imagine wanting to test that too. If you don't want to go
>>> below 1 then just set a higher prio, p3 in the scenario you
>>> showed.
>>
>> Maybe I'm misreading and misunderstanding the patch ... but I believe
>> the if statement should say:
>>
>>        if (priority > 0 && !sameprio)
>>                priority--;
>>
>> Just to avoid the situation the commit log says, priority to go below 0.
>>
>>
>> kind regards,
>>
>> David Sommerseth
> 
> The code in general there was buggy, so I reverted the patch that
> caused the problems in the first place.
> (assuming Clark merges it).
> 
> Now the code will read (as it did before)
> 
>  if (priority && !histogram && !smp && !numa)
>                         priority--;

That looks better ... and guess what, I just stumbled upon those patches
right now in the mailing list ... the troubles of catching up after
holidays :)


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuWkAAACgkQIIWEatLf4HeRiQCeMLgoLJHvzHwS+8yRroGBOAAX
zXwAnAmXlY4AFgIGRAzi+33nNwukXdCF
=cPhd
-----END PGP SIGNATURE-----
