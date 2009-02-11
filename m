From: Brian Ford <bsfford@yahoo.co.uk>
Subject: Re: Questions on developing applications...
Date: Wed, 11 Feb 2009 15:18:40 +0000 (GMT)
Message-ID: <356542.3477.qm@web28604.mail.ukl.yahoo.com>
References: <296402.26723.qm@web28616.mail.ukl.yahoo.com> <3efb10970902040449m25379e49l3fe6d08daa2da16c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from n20.bullet.mail.ukl.yahoo.com ([87.248.110.137]:44647 "HELO
	n20.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755405AbZBKPSm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Feb 2009 10:18:42 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Remy,

Thank you for your answers, they have been very helpful in helping me decide if the RT patch is suitable for my application.

I'd be interested in your views on how to implement a cyclic scheduler. My aim is to simulate a scheduler similar to that found in the ARINC 659 standard. This allows the start time and stop time of every process within the schedule to be defined. If a process overruns its end time it will be pre-empted and only allowed to complete at its next allocated time slot. My work is only to simulate this functionality. (There are no safety critical requirements on the simulation timings, although I'm aiming to get as close to the real time performance of the actual system as possible) 

My current design is to make each process in my system wait on an event, which is triggered by the scheduler. The scheduler  fires this event every time a scheduled process is due to start. This works well when every process does not overrun its allocated time slot. However I'm also expecting some processes to overrun timeslots, so I'd like to be able to preempt a process when it overruns.. The only way I've been able to do this is to register each proess id with the scheduler and give a process that is to be preempted a low priority, and the next running process a high priority. However the requires an idle task to stop the low priority process starting again when the high priority process is complete. 

A simpler solution would be to remove a process from the schedule que and only reque in its next time slot. Is there a way to preempt a process, then remove and add processes to the scheduled que? Is there a better way to do this?!

Thanks again for your help, 

Brian



----- Original Message ----
From: Remy Bohmer <linux@bohmer.net>
To: Brian Ford <bsfford@yahoo.co.uk>
Cc: linux-rt-users@vger.kernel.org
Sent: Wednesday, 4 February, 2009 12:49:12
Subject: Re: Questions on developing applications...

Hello Brian,

> I'm new to real time linux programming, apologies if these questions are
> very simple.

There is no such thing as stupid questions, just stupid answers ;-)

> I've recently setup a real time Linux kernel using patch-2.6.24.7-rt26
> and got the simple "Hello World" program working. However, I'm unable
> to find any guides on how to write more complex software.
> Can you tell me how to do real time inter process message passing in linux?
> I'm familiar with shared memory and pipes -- is it ok to use these in
> a real time context?

Yes, shared memory is okay, as long as you make sure the memory is
committed to the RT process.
Related to pipes you can measure the impact of it on the RT-process as
described in the wiki.

> Also, I've read that printf may not provide real time performance.
> (http://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application)
> If I use printf/printk to a X UI terminal, will the output be deterministic (take a fixed time)?

In the wiki I described the behaviour of printf/k related to the
VGA-text console which is giving very annoying behaviour, not because
of determinism, but because of other interferences on X86.
printf __usually__ only gives 1 single pagefault when it is called the
first time in a process, it is _usually_ okay to printf to a
X-based-terminal.

For all the library calls, you cannot assume determinism in the sense
of fixed execution time. Usually all the userspace libraries on a
standard Linux box are written with a general purpose in mind, NOT a
realtime/deterministic mindset.
Implementations can vary between different versions of libraries, and
even bugfix updates.
So, library calls are always RT untrustworthy, until you prove
yourself that it suites your requirements. The lower your realtime
requirements, the higher the chance library calls are suitable.
For example, glibc supports PI-mutexes, but that does not make the
implementation deterministic in the sense of fixed execution time.

Many people talk about realtime when they talk about millisecond
accuracy, others talk about microsecond accuracy.
These are all different areas, with different requirements, different
constraints, and different solutions.

If a certain library call suites your needs, depends completely on
your hardware layout and your realtime requirements.
The closer you build your code to the scheduler, and the lesser you
depend on external code, the more predictable the system becomes.
On Linux, you can only _test_ if a certain solution suits your
requirements, there is no magic book that suits everybody.
You cannot mathematically proof the RT-correctness of the system, it
is too complex, and too variable.

Just be wise and test, test, test... and test again...

> I'm also interested in building a cyclic executive scheduler to control individual process. At
> the moment I'm guessing the only way to do this would be to modify the kernel scheduler.
> Is it possible to do this at the application/process level?

Depends on how 'scheduler' looks like, and what your requirements are.

Kind Regards,

Remy
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



      

