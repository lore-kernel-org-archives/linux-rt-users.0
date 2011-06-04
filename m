From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: I/O operations priority in RTOS
Date: Sun, 5 Jun 2011 01:42:14 +0200
Message-ID: <20110604234214.GA30640@opentech.at>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Monica Puig-Pey <puigpeym@unican.es>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:48571 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755049Ab1FDXwk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Jun 2011 19:52:40 -0400
Content-Disposition: inline
In-Reply-To: <4DEA1F22.6000603@unican.es>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 04 Jun 2011, Monica Puig-Pey wrote:

> Hello,
> I'm studying how to develop drivers in a real time OS and how do they  
> work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed.
> I would like to know the priority when executing open(), read(), write()  
> and close() operations.
> In my example the thread which is using the driver runs with 10 RTPRIO,  
> but I don't know what happens in kernel context with the priority when  
> running the I/O operations.
> Thank you for your help, I don't know where to learn about this.
>

Priorities are not associated with functions but rather with processes/threads
so the priority with which the functions open/read/write are executed depend
on the process that invokes these functions.

That said there is an indirect impact of the function on priority as soon as
the funciton needs to share any resources that need protection by locking. The
moment that happens the effective execution priority of the function no longer only depends on the task that calls open but may indirectly depedn on a totally
unrelated task that happens to hold a lock protecting some shared resource.

So the consequence for rt-drivers is that they must ensure that they minimize
critical sections, or prevent them all together (i.e. by using lock free 
methods). Notably this puts restrictions on the use of dynamic resources at 
runtime, that is after the driver was initialized - basically you want all 
resources that the rt-driver needs allocated at driver initialization time. 
Also when using bottom half mechanisms you need to take into account the 
priority of the kernel thread that manages the defered work items, so 
rt-drivers may have a different structure than normal drivers.

hofrat
