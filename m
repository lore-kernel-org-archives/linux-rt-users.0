From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: cyclictest usage
Date: Fri, 2 Jun 2017 11:59:11 +0200
Message-ID: <20170602095911.wlqcvsi6zf336z5l@linutronix.de>
References: <20170526112502.4f6a49ac@tagon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: RT <linux-rt-users@vger.kernel.org>, John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41334 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdFBJ7N (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Jun 2017 05:59:13 -0400
Content-Disposition: inline
In-Reply-To: <20170526112502.4f6a49ac@tagon>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-05-26 11:25:02 [-0500], Clark Williams wrote:
> What we're looking for is how people are using cyclictest. For example, at Red Hat we use the 'rteval' tool, which puts a large SCHED_OTHER load on the system and then runs cyclictest with a measurement thread on each core. The intent is to put a large load on the scheduler and prove that the RT patchset provides deterministic performance under load. 
> 
> What other types of testing/measurement are people doing with cyclictest?

hackbench, disk I/O, network related ping/traffic for the "normal"
interfaces and some custom ones to poke at the gpio, i2c, … drivers to
ensure that they don't a long off time. Either way, I prefer starting
them independently of cyclictest.

> John Kacur and I are wanting to clean up tracing and make sure that the most commonly used options are on by default. In addition we want to refactor some of the runtime logic. Are there other areas that need to be cleaned up? Features that need to be added/deleted?

I do have (had) a tiny version of cyclictest with a lot things pulled
out simply to get it run a system with 8 MiB RAM in total. Learned from
this: everything out :)
Basically the only interaction between cyclictest and the tracing
infrastructure should be just to stop tracing only if a break value was
specified _and_ was the reason for cyclictest to abort.
This would also reduce the number of command line options which would
_really_ nice. 
As for defaults, it should be have those arguments which are used by
people by default. I guess this includes clock_nanosleep(), mlockall(),
very high priority, one thread per-core and so on.
Not sure about "-d 0 --secaligned 250" but something should be default
so we have the same behaviour on its invocation.
I remember, that there was (or is) an option to figure out if the
hrtimer is working on the system and estimates the resolution of the
clocksource. I would move that into a different tool.
That -M mode is nice, but it should give some kind of indication, that
the system is still alive like update the number of "loop" once in a
while. But this brings me to another topic: The output system. Usually
the console output is enough. Then we have the "histogram" mode to check
the distribution. People often use the histogram mode because the former
can't be used/parsed by script/tool. Here (the histogram) I hear people
complaining about the output which is not (easy)
machine-readable. *I* think it would be okay to use the "histogram" mode
for machine-readable but the output should be better structured.
Something like yaml is probably just fine. However I can't tell if this
will work for everyone or if a plugin-like interface would be best so we
can dock yaml output as well as something that creates xml based output
(for people that dream in XML, too).

> Thanks,
> 
> Clark

Sebastian
