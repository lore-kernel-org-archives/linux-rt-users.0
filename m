From: Matthieu Bec <mbec@gmto.org>
Subject: Re: good load / stress suite?
Date: Fri, 18 May 2012 17:17:27 -0700
Message-ID: <4FB6E697.6010709@gmto.org>
References: <4FB2E1DD.7020203@gmto.org> <1337133337.6724.24.camel@gandalf.stny.rr.com> <20120516105501.17018110@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rainbow.obs.carnegiescience.edu ([192.91.178.46]:46887 "EHLO
	rainbow.gmto.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab2ESARc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 May 2012 20:17:32 -0400
In-Reply-To: <20120516105501.17018110@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello,

Thanks for the tip for testing.

I guess I should open a new thread because what follows is more about 
the result that the testing procedure.

Quick recap on my original test, I have a kernel module timer (clock 
monotonic, absolute) flipping a bit with some outb(val, 0x3f8 + COM_MCR)

I ran 'cyclictest' in parallel with all the load (make -jN) with a local 
kernel tree and another on nfs, both give similar results: cyclictest is 
spot on, my timer does occasional excursion.

So I looked at cyclictest and thought let's do it the same way. now I 
have now another cdev module giving user land access to flip COM0  with 
some IOCTL... and to my surprise: that does perform well.

I'm a new comer to these matters but I find it counter-intuitive my RT 
tasks (set priority 99) "works better" than my kernel timer. I'm looking 
at understanding this better. Is it just expected? some params I can set 
to harden things in my kernel timer? any pointers to understand this 
would be great.

Regards,
Matthieu



On 05/16/12 08:55, Clark Williams wrote:
> On Tue, 15 May 2012 21:55:37 -0400
> Steven Rostedt<rostedt@goodmis.org>  wrote:
>
>> On Tue, 2012-05-15 at 16:08 -0700, Matthieu Bec wrote:
>>> Hello all,
>>>
>>> I was wondering what people used to check RT_PREEMPT behavior under
>>> load/stress?
>>
>> There is a test suite that Red Hat uses called rt-eval (I believe).
>> Clark can give you more info on that.
>
> It's called rteval and I have a git tree here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rteval.git
>
> It's basically some python scripting to do much of what Steven describes
> below. When it starts up it kicks off a kernel make with 2* the number
> of available processors (make -j<n*2>) and runs hackbench, both in
> loop. Then it kicks off cyclictest to measure the system latency under
> load.
>
> I usually run it like this:
>
> 	$ sudo rteval --duration=12h
>
> At the end it summarizes the results of the run.
>
>>
>>>
>>> I'm trying to test the accuracy of my timers and have a test where I
>>> setup a kernel module with an hr-timer flipping RTS bit on serial COM0
>>> periodically, which I can look on an oscilloscope. the scope triggers on
>>> rising edge, I call jitter what shows on the falling side:
>>> under no specific load I get ~ 10 us (worst case waiting a long time)
>>>
>>>
>>> My initial idea for stressing the system was to compile a kernel, make
>>> -j 8 (#cores) that I thought would exercise CPU and IO if anything. As
>>> it happens, it's "mostly good" but I do get occasional (but repeatable)
>>> wild excursions (>100us)
>>
>> The tests I do is the following:
>>
>> I run "cyclictest -n -p 80 -t -i 250" then in another window I run a
>> kernel compile using distcc (to stress the network as well) with make
>> -j40, it basically does:
>>
>> while :; make clean; make -j40; done
>>
>> Then I also run hackbench (written by Rusty Russell), with:
>>
>> while :; hackbench 50 ; done
>>
>> I run the above on a single machine, while on another machine I run
>> ktest against the -rt kernel to test different configs (with and without
>> PREEMPT_RT enabled and such). I do this for both i386 and x86_64.
>>
>>
>>>
>>> Looking around, I found a tool called 'stress' -
>>> http://weather.ou.edu/~apw/projects/stress/
>>> Under these new conditions, the system behaves really well again ~20 us
>>> stable all the way.
>>>
>>> So both tests give different result, I'm not sure which to trust.
>>> I was thinking maybe there is some weird interaction with the kernel and
>>> building the kernel that make the 'bad' test invalid?
>>>
>>> I have RT_PREEMPT 3.0.18-rt34 SMP x86_64
>>>
>>
>> Now, I run the above stress tests that I mentioned for several hours
>> before I release a stable kernel. I run this on a 2.6GHz xeon core2, and
>> I may hit at most 70us latency with cyclictest. That's a high, it
>> usually stays below 50us. We consider>100us on this type of hardware a
>> bug which needs to be fixed.
>>
>> -- Steve
>>
>>


-- 
Matthieu Bec                GMTO Corp.
cell:  +1 626 354 9367      P.O. Box 90933
phone: +1 626 204 0527      Pasadena, CA 91109-0933

