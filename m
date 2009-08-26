From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 17:45:10 +0300
Message-ID: <1251297910.1791.22.camel@maxim-laptop>
References: <1250983671.5688.21.camel@raz>
	 <1251004897.7043.70.camel@marge.simson.net> <1251018551.3810.35.camel@raz>
	 <1251012621.14003.71.camel@marge.simson.net> <1251025557.3810.65.camel@raz>
	 <1251021133.14003.172.camel@marge.simson.net>
	 <alpine.DEB.1.10.0908251122020.26329@gentwo.org>
	 <1251222993.7023.53.camel@marge.simson.net>
	 <alpine.DEB.1.10.0908251402300.17963@gentwo.org>
	 <1251227322.7538.1172.camel@twins>  <4A943A00.9080609@nortel.com>
	 <1251264700.7538.1178.camel@twins> <1251282598.3514.20.camel@raz>
	 <alpine.DEB.1.10.0908260943090.9924@gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: raz ben yehuda <raziebe@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chris Friesen <cfriesen@nortel.com>,
	Mike Galbraith <efault@gmx.de>, riel@redhat.com, mingo@elte.hu,
	andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Christoph Lameter <cl@linux-foundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:36894 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbZHZOpP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Aug 2009 10:45:15 -0400
In-Reply-To: <alpine.DEB.1.10.0908260943090.9924@gentwo.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2009-08-26 at 09:47 -0400, Christoph Lameter wrote:
> On Wed, 26 Aug 2009, raz ben yehuda wrote:
> 
> > How will the kernel is going to handle 32 processors machines ?  These
> > numbers are no longer a science-fiction.
> 
> The kernel is already running on 4096 processor machines. Dont worry about
> that.
> 
> > What i am suggesting is merely a different approach of how to handle
> > multiple core systems. instead of thinking in processes, threads and so
> > on i am thinking in services. Why not take  a processor and define this
> > processor to do just firewalling ? encryption ? routing ? transmission ?
> > video processing... and so on...
> 
> I think that is a valuable avenue to explore. What we do so far is
> treating each processor equally. Dedicating a processor has benefits in
> terms of cache hotness and limits OS noise.
> 
> Most of the large processor configurations already partition the system
> using cpusets in order to limit the disturbance by OS processing. A set of
> cpus is used for OS activities and system daemons are put into that set.
> But what can be done is limited because the OS threads as well as
> interrupt and timer processing etc cannot currently be moved. The ideas
> that you are proposing are particularly usedful for applications that
> require low latencies and cannot tolerate OS noise easily (Infiniband MPI
> base jobs f.e.)

My 0.2 cents:

I have always been fascinated by the idea of controlling another cpu
from the main CPU.

Usually these cpus are custom, run proprietary software, and have no
datasheet on their I/O interfaces.

But, being able to turn an ordinary CPU into something like that seems
to be very nice.

For example, It might help with profiling. Think about a program that
can run uninterrupted how much it wants.

I might even be better, if the dedicated CPU would use a predefined
reserved memory range (I wish there was a way to actually lock it to
that range)

On the other hand, I could see this as a jump platform for more
proprietary code, something like that: we use linux in out server
platform, but out "insert buzzword here" network stack pro+ can handle
100% more load that linux does, and it runs on a dedicated core....

In the other words, we might see 'firmwares' that take an entire cpu for
their usage.

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

