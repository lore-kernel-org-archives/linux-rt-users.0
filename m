From: Mark Hounschell <markh@compro.net>
Subject: Re: Question regarding sched_setaffinity
Date: Mon, 08 Sep 2008 08:28:19 -0400
Message-ID: <48C51A63.1070700@compro.net>
References: <1ca41c0f0808312012v4c52576cw307929992781eeca@mail.gmail.com> <alpine.DEB.1.10.0809051523270.23959@gandalf.stny.rr.com> <48C190CC.10400@compro.net> <alpine.DEB.1.10.0809051642200.31439@gandalf.stny.rr.com>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Karthik Singaram Lakshmanan <karthiksingaram@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.compro.net ([216.54.166.4]:38675 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbYIHM2U (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Sep 2008 08:28:20 -0400
In-Reply-To: <alpine.DEB.1.10.0809051642200.31439@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> On Fri, 5 Sep 2008, Mark Hounschell wrote:
> 
>> Steven Rostedt wrote:
>>> On Sun, 31 Aug 2008, Karthik Singaram Lakshmanan wrote:
>>>
>>>> Hi,
>>>>  I am a noob to SMP real-time scheduling in linux, I have a question of
>>>> sched_setaffinity(). If I restrict an application to a single CPU
>>>> using the appropriate cpumask for sched_setaffinity(), Is it
>>>> guaranteed that the kernel will never schedule it on any other CPU? I
>>>> am asking this because looking at kernel/sched.c seems to use
>>>> cpu_clear during load balancing. I am interested in knowing whether the
>>>> cache will be invalidated when my task is assigned to a single CPU.
>>>> Are there exceptions where the cpu-mask will be overridden?
>>>> Thanks for taking the time to answer my query.
>>> A task should never be scheduled on a CPU that is not in its affinity.
>>> (although I hear a rumor that if a task is bound to a single CPU, and that
>>> CPU is taken offline, it will be migrated. But I doubt this is true, since
>>> there are tasks that would crash the system if this were true).
>>>
>>> -- Steve
>>>
>> It seems to be true. It's affinity mask gets changed to the CPUs left online.
>> At least according to sched_getaffinity.
> 
> 
> Note, I'm not just talking about that affinity being masked off, I'm 
> talking about a task that is bounded to only that cpu that is about to go 
> offline.
> 
> If you have a mask (bit mask) 0xf to be on all 4 cpus, and cpu 3 goes 
> offline, all those tasks will now be 0x7. But if you started with a task 
> with a affinity of mask 0x8, then when it goes offline, it too will be 
> 0x7. The difference here is that this task is now running on CPUS that it 
> wasn't able to run on before going down.
> 
> At least there's a warning about it in dmesg:
> 
> "process 6560 (yes) no longer affine to cpu3"
> 
> -- Steve
> 
> 

Right, thats what I was referring to also. A task bound to a single cpu
all by its self.

Mark
