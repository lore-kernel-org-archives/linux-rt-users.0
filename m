From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.23.1-rt9 (and others)
Date: Wed, 07 Nov 2007 21:04:10 +0000
Message-ID: <4732284A.6070501@gmx.net>
References: <1194413959.8827.66.camel@localhost.localdomain> <473222E2.8030007@gmx.net> <Pine.LNX.4.58.0711071454450.1040@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753445AbXKGUHf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2007 15:07:35 -0500
In-Reply-To: <Pine.LNX.4.58.0711071454450.1040@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven Rostedt wrote:
> On Wed, 7 Nov 2007, Dragan Noveski wrote:
>
>   
>> Steven Rostedt wrote:
>>     
>>> Currently, what we do to test RT latencies is to run Thomas Gleixner's
>>> cyclictest
>>> (http://git.kernel.org/?p=linux/kernel/git/tglx/rt-tests.git;a=summary)
>>> as well as hackbench, to see what the maximum latencies we get are.
>>>
>>>       
>> hallo, can please someone suggest for how long time you are running
>> cyclictest?
>> if i run it for about 3 min. i get a feeling that the values will not
>> change anymore, so is there any recommended time for how long to run it?
>>     
>
> Actually, you want to run it for a long time, and under very heavy load.
> I'm currently running it while doing a "make -j128" on a kernel tree. This
> takes several hours to complete the make. So far with -rt11 I have a max
> latency with one RT thread at the prio of 98 68us.
>
> When you do run cyclic test, make sure you run it at a higher priority
> than the irq threads. And also use the -n option since the default is to
> test signals, and that part of the test isn't working so well.
>
> Here's what I'm running right now:
>
> ./cyclictest -n -p98 -t1 -i250
>   

ok, i was trying like './cyclictest -n -t3 -p99' but i ll have a look 
into -t and -i options more deeper now. but i was running it always for 
about 3-4 minutes....
> While doing that "make -j120"
>
>   
>> another thing i do not know is, if i run cyclictest for lets say 3
>> minutes, than stop ('ctrl+c') and than start again, i get often
>> different values. so is it recommended to run it more times and than to
>> pick up the best/worst cases.
>>
>> i have done some tests already with rt7,8 and 10 but i am not sure if
>> the tests make any sense - thats why i would really appreciate some
>> answers on the both questions.
>>
>>     
>
> Actually I didn't want to discourage you. For UP, -rt7,8 and 10 really
> should be exactly the same (with some noise factures apart). The changes
> that were made supposable only affect SMP boxes. But, I'm glad you are
> doing the tests, since we also would like to know if anything creeped into
> te UP side, and has caused any regressions.
>   

i was expecting this part about 'smp boxes' but anyway, as now i know 
how to run cyclictest, i will be able to do again and again as the 
development goes on.
> Thanks, for taking the time to test this.
>
> -- Steve
>
>   
i thank you to for this very informative response!

cheers,
doc
