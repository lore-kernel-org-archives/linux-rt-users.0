From: David Sommerseth <davids@redhat.com>
Subject: Re: [PATCH 1/2] do-not-allow-prio-less-than-one-in-cyclictest.patch
Date: Tue, 09 Mar 2010 19:02:39 +0100
Message-ID: <4B968D3F.3070106@redhat.com>
References: <20100307203955.895980022@osadl.org>	 <20100307204241.033320249@osadl.org> <520f0cf11003071437p13cda9f9n1dba8d01ad33aedd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <C.Emde@osadl.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15637 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab0CISCr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Mar 2010 13:02:47 -0500
In-Reply-To: <520f0cf11003071437p13cda9f9n1dba8d01ad33aedd@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/03/10 23:37, John Kacur wrote:
> On Sun, Mar 7, 2010 at 9:39 PM, Carsten Emde <C.Emde@osadl.org> wrote:
>> If not in SMP testing mode, the priority may go below 1, if the specified
>> priority is lower than the number of threads, e.g.
>> # cyclictest -p2 -t3
>> T: 0 (21970) P: 2 [..]
>> T: 1 (21971) P: 1 [..]
>> T: 2 (21972) P: 0 [..]
>>
>> Do not allow priority to go below 1.
>>
>> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>>
>> Index: rt-tests/src/cyclictest/cyclictest.c
>> ===================================================================
>> --- rt-tests.orig/src/cyclictest/cyclictest.c
>> +++ rt-tests/src/cyclictest/cyclictest.c
>> @@ -1304,7 +1304,7 @@ int main(int argc, char **argv)
>>                }
>>
>>                par->prio = priority;
>> -               if (!sameprio)
>> +               if (priority > 1 && !sameprio)
>>                        priority--;
>>                 if      (priority && policy <= 1) par->policy = SCHED_FIFO;
>>                 else if (priority && policy == 2) par->policy = SCHED_RR;
>>
>> --
> 
> I'm not sure about this, why not allow a priority below 1? The code
> below properly sets the third thead to SCHED_OTHER.
> I could imagine wanting to test that too. If you don't want to go
> below 1 then just set a higher prio, p3 in the scenario you
> showed.

Maybe I'm misreading and misunderstanding the patch ... but I believe
the if statement should say:

	if (priority > 0 && !sameprio)
		priority--;

Just to avoid the situation the commit log says, priority to go below 0.


kind regards,

David Sommerseth

