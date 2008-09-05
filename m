From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Question regarding sched_setaffinity
Date: Fri, 5 Sep 2008 15:24:50 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0809051523270.23959@gandalf.stny.rr.com>
References: <1ca41c0f0808312012v4c52576cw307929992781eeca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Karthik Singaram Lakshmanan <karthiksingaram@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:33559 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYIETYw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Sep 2008 15:24:52 -0400
In-Reply-To: <1ca41c0f0808312012v4c52576cw307929992781eeca@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sun, 31 Aug 2008, Karthik Singaram Lakshmanan wrote:

> Hi,
>  I am a noob to SMP real-time scheduling in linux, I have a question of
> sched_setaffinity(). If I restrict an application to a single CPU
> using the appropriate cpumask for sched_setaffinity(), Is it
> guaranteed that the kernel will never schedule it on any other CPU? I
> am asking this because looking at kernel/sched.c seems to use
> cpu_clear during load balancing. I am interested in knowing whether the
> cache will be invalidated when my task is assigned to a single CPU.
> Are there exceptions where the cpu-mask will be overridden?
> Thanks for taking the time to answer my query.

A task should never be scheduled on a CPU that is not in its affinity. 
(although I hear a rumor that if a task is bound to a single CPU, and that 
CPU is taken offline, it will be migrated. But I doubt this is true, since 
there are tasks that would crash the system if this were true).

-- Steve

