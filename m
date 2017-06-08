From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: cyclictest usage
Date: Thu, 8 Jun 2017 10:40:11 +0200
Message-ID: <20170608084011.axd5w5gj73hrympj@linutronix.de>
References: <20170526112502.4f6a49ac@tagon>
 <20170602095911.wlqcvsi6zf336z5l@linutronix.de>
 <20170602092612.4069fe8f@tagon.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42063 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdFHIkN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2017 04:40:13 -0400
Content-Disposition: inline
In-Reply-To: <20170602092612.4069fe8f@tagon.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-02 09:26:12 [-0500], Clark Williams wrote:
> > As for defaults, it should be have those arguments which are used by
> > people by default. I guess this includes clock_nanosleep(), mlockall(),
> > very high priority, one thread per-core and so on.
> > Not sure about "-d 0 --secaligned 250" but something should be default
> > so we have the same behaviour on its invocation.
> 
> When rteval starts cyclictest it uses '-d0 -i100'. I know that's the worst case of having every timer interrupt fire at the same time, but when we started this that's what we wanted to see. Do we need to have two meta-arguments: --worst-case / --best-case? The --worst-case would do things most normal deployers of a realtime app wouldn't do, while the --best-case would stagger timer starts, isolate to numa nodes, etc. 



> 
> > I remember, that there was (or is) an option to figure out if the
> > hrtimer is working on the system and estimates the resolution of the
> > clocksource. I would move that into a different tool.
> > That -M mode is nice, but it should give some kind of indication, that
> > the system is still alive like update the number of "loop" once in a
> > while. But this brings me to another topic: The output system. Usually
> > the console output is enough. Then we have the "histogram" mode to check
> > the distribution. People often use the histogram mode because the former
> > can't be used/parsed by script/tool. Here (the histogram) I hear people
> > complaining about the output which is not (easy)
> > machine-readable. *I* think it would be okay to use the "histogram" mode
> > for machine-readable but the output should be better structured.
> > Something like yaml is probably just fine. However I can't tell if this
> > will work for everyone or if a plugin-like interface would be best so we
> > can dock yaml output as well as something that creates xml based output
> > (for people that dream in XML, too).
> 
> I don't have a problem generating XML or JSON or some sort of structured output. I'll put that on the list. Hmmm, plugins...
I remember Steven said some about plugins, I don't really care. It is
just libxml2 has ~2MiB, libjson-c3 85KiB and libyaml 156KiB I would
prefer both (json & yaml) over xml. I don't want to make things more
complicated (with plugins).

> Regarding periodic updates, what do you think about providing a way for an app to query the current state of a run? Possibly a memory region that can be mmapped by a process? Or possibly a UNIX domain socket? I'm thinking of the case where you're doing a 48 hour test run on a box where you don't have easy access to the console and would just like to know if a) the box is alive and b) is still showing reasonable values for max latency and jitter. 

The memory mapped output is probably fine for the local usage. I think
now we have a unix domain socket / pipe or something. Another use case
would be where you have a limited box and you want obtain the cyclictest
information over network and provide a real time view of the data and
another box.
 
> I kinda like the memory region since that's how cyclictest handles output: the measurement threads all dump their data into a cpu-specific memory area and a display thread (running at a low priority) is the one that wakes up, reads the update and printf's to the screen. If we exported that region so that another process could mmap it read-only, that would provide a way to get a snapshot of the run, without actually depending on cyclictest to *do* anything out of the ordinary. 

So if we would have "naked" cyclictest which dumps data then we could
attach a console output which is what we have now _or_ network output
which sends the output via network. Sounds good.

> 
> Clark

Sebastian
