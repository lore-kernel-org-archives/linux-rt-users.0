From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Question regarding sched_setaffinity
Date: Fri, 5 Sep 2008 16:28:54 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0809051625590.31439@gandalf.stny.rr.com>
References: <1ca41c0f0808312012v4c52576cw307929992781eeca@mail.gmail.com> <alpine.DEB.1.10.0809051523270.23959@gandalf.stny.rr.com> <48C190CC.10400@compro.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Karthik Singaram Lakshmanan <karthiksingaram@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Mark Hounschell <markh@compro.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:46358 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbYIEU25 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Sep 2008 16:28:57 -0400
In-Reply-To: <48C190CC.10400@compro.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Fri, 5 Sep 2008, Mark Hounschell wrote:

> Steven Rostedt wrote:
> > On Sun, 31 Aug 2008, Karthik Singaram Lakshmanan wrote:
> > 
> > > Hi,
> > >  I am a noob to SMP real-time scheduling in linux, I have a question of
> > > sched_setaffinity(). If I restrict an application to a single CPU
> > > using the appropriate cpumask for sched_setaffinity(), Is it
> > > guaranteed that the kernel will never schedule it on any other CPU? I
> > > am asking this because looking at kernel/sched.c seems to use
> > > cpu_clear during load balancing. I am interested in knowing whether the
> > > cache will be invalidated when my task is assigned to a single CPU.
> > > Are there exceptions where the cpu-mask will be overridden?
> > > Thanks for taking the time to answer my query.
> > 
> > A task should never be scheduled on a CPU that is not in its affinity.
> > (although I hear a rumor that if a task is bound to a single CPU, and that
> > CPU is taken offline, it will be migrated. But I doubt this is true, since
> > there are tasks that would crash the system if this were true).
> > 
> > -- Steve
> > 
> 
> It seems to be true. It's affinity mask gets changed to the CPUs left online.
> At least according to sched_getaffinity.


Hmm, it is true:

[root@bxrhel51 bin]# ps ax |grep yes
 6560 pts/1    R+     0:31 yes
 6566 pts/0    S+     0:00 grep yes
[root@bxrhel51 bin]# taskset -p 8 6560
pid 6560's current affinity mask: f
pid 6560's new affinity mask: 8
[root@bxrhel51 bin]# taskset -p 6560
pid 6560's current affinity mask: 8
[root@bxrhel51 bin]# echo 0 > /sys/devices/system/cpu/cpu3/online
[root@bxrhel51 bin]# taskset -p 6560
pid 6560's current affinity mask: 7


I ran "yes" and made the affinity set to CPU3. Then I took CPU3 offline 
and this just made the task move to _all_ other online CPUS.

-- Steve

