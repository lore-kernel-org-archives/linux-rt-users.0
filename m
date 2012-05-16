From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: good load / stress suite?
Date: Tue, 15 May 2012 21:55:37 -0400
Message-ID: <1337133337.6724.24.camel@gandalf.stny.rr.com>
References: <4FB2E1DD.7020203@gmto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Clark Williams <clark@redhat.com>
To: Matthieu Bec <mbec@gmto.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14570 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527Ab2EPBzi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 21:55:38 -0400
In-Reply-To: <4FB2E1DD.7020203@gmto.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-05-15 at 16:08 -0700, Matthieu Bec wrote:
> Hello all,
> 
> I was wondering what people used to check RT_PREEMPT behavior under 
> load/stress?

There is a test suite that Red Hat uses called rt-eval (I believe).
Clark can give you more info on that.

> 
> I'm trying to test the accuracy of my timers and have a test where I 
> setup a kernel module with an hr-timer flipping RTS bit on serial COM0 
> periodically, which I can look on an oscilloscope. the scope triggers on 
> rising edge, I call jitter what shows on the falling side:
> under no specific load I get ~ 10 us (worst case waiting a long time)
> 
> 
> My initial idea for stressing the system was to compile a kernel, make 
> -j 8 (#cores) that I thought would exercise CPU and IO if anything. As 
> it happens, it's "mostly good" but I do get occasional (but repeatable) 
> wild excursions (>100us)

The tests I do is the following:

I run "cyclictest -n -p 80 -t -i 250" then in another window I run a
kernel compile using distcc (to stress the network as well) with make
-j40, it basically does:

while :; make clean; make -j40; done

Then I also run hackbench (written by Rusty Russell), with:

while :; hackbench 50 ; done

I run the above on a single machine, while on another machine I run
ktest against the -rt kernel to test different configs (with and without
PREEMPT_RT enabled and such). I do this for both i386 and x86_64.


> 
> Looking around, I found a tool called 'stress' - 
> http://weather.ou.edu/~apw/projects/stress/
> Under these new conditions, the system behaves really well again ~20 us 
> stable all the way.
> 
> So both tests give different result, I'm not sure which to trust.
> I was thinking maybe there is some weird interaction with the kernel and 
> building the kernel that make the 'bad' test invalid?
> 
> I have RT_PREEMPT 3.0.18-rt34 SMP x86_64
> 

Now, I run the above stress tests that I mentioned for several hours
before I release a stable kernel. I run this on a 2.6GHz xeon core2, and
I may hit at most 70us latency with cyclictest. That's a high, it
usually stays below 50us. We consider >100us on this type of hardware a
bug which needs to be fixed.

-- Steve


