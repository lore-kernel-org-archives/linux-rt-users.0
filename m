From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 8 Apr 2016 12:30:23 +0200
Message-ID: <5707883F.4080302@linutronix.de>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
 <alpine.DEB.2.11.1603241140510.3978@nanos>
 <1459405903.14336.64.camel@gmail.com> <20160401211105.GE29603@linutronix.de>
 <1459566735.3779.36.camel@gmail.com> <57068F28.8010409@linutronix.de>
 <1460055880.4435.61.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460055880.4435.61.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/07/2016 09:04 PM, Mike Galbraith wrote:
>> just to be clear: The patch I attached did _not_ work for you.
> 
> Sorry, I didn't test.  Marathon stress test session convinced me that
> the lock added by -rt absolutely had to die.

Okay. And the patch did that. I removed the lock.

>>> If that lock dies, we can unpin when entering lock slow path and pin
>>> again post acquisition with no ABBA worries as well, and not only does
>>> existing hotplug work heaping truckloads better, -rt can perhaps help
>>> spot trouble as the rewrite proceeds.
>>>
>>> Current state is more broken than ever.. if that's possible.
>>
>> And the two patches you attached here did?
> 
> I've killed way too many NOPREEMPT kernels to make any rash -rt claims.
>  What I can tell you is that my 64 core DL980 running 4.6-rc2-rt13 plus
> the two posted patches survived for ~20 hours before I had to break it
> off because I needed the box. 
> 
> These two haven't been through _as_ much pounding as the two targeted
> bandaids I showed have, but have been through quite a bit.  Other folks
> beating the living crap outta their boxen too would not be a bad idea.

I see. So what I don't like are all the exceptions you have: one for
RCU and one kernfs. There might come more in the future. So what I aim
is the removal of the lock.

> 
> 	-Mike
> 
Sebastian
