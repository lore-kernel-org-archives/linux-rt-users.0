Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbeJKVO6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Oct 2018 17:14:58 -0400
Date: Thu, 11 Oct 2018 08:47:39 -0500
From: Clark Williams <williams@redhat.com>
Subject: Re: cyclictest: possible bugs in CPU enumeration
Message-ID: <20181011084739.71b7ac91@tagon>
In-Reply-To: <48452eff-7071-a83f-1bd5-25d45410f323@oth-regensburg.de>
References: <48452eff-7071-a83f-1bd5-25d45410f323@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users <linux-rt-users@vger.kernel.org>, Daniel Wagner <wagi@monom.org>

Comments below.

BTW Ralf, I do appreciate the work. Sorry for being slow responding but for
some reason my manager expects me to do work... :)

On Fri, 28 Sep 2018 15:25:17 +0200
Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de> wrote:

> Hi,
> 
> I think I might have trapped into some bugs in cyclictest's CPU enumeration.
> 
> a) If cyclictest is parameterised with "-a 0,2", then in
> process_options() we will run into:
> 
>     [...]
>     if (optarg != NULL) {
>             parse_cpumask(optarg, max_cpus);
>             setaffinity = AFFINITY_SPECIFIED;
>     } else if (optind<argc && atoi(argv[optind])) {
> >                             ^^^^
> >                             |- atoi will be 0, and this case fails  
>             parse_cpumask(argv[optind], max_cpus);
>             setaffinity = AFFINITY_SPECIFIED;
>     } else {
>             setaffinity = AFFINITY_USEALL;
>     }
> 
> Though we should, we won't enter this case and end up with
> AFFINITY_USEALL. So I have to reverse the argument to "-a 2,0" as a
> quick workaround.
> 
> Isn't the atoi() check superfluous? We're not relying on its result in
> any case.
> 
> 
> b) I boot with nosmt on a 2 core / 2 threads x86 machine where I can not
> disable SMT via firmware. nosmt results in offlining SMT siblings:
>     # cat /sys/devices/system/cpu/o{ff,n}line
>     1,3-7
>     0,2
> 
> As mentioned before, I have to reverse the CPU mask, so I run
>     # ./cyclictest -p 99 -m -t 2 --affinity 2,0
>     Bug in cpu mask handling code.
> 
> This bug is hidden in max_cpus. For getting max_cpu, cyclictest uses:
>         int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> 
> But if some CPUs are offlined, then NRPROC_ONLN !=
> max_cpus_available... Later, when cyclictest tries to assign threads
> to CPUs, max_cpus is the highest CPU# that will be considered in
> enumeration. I think that's wrong, if some CPUs are offline.
> 
> The dirty steam hammer quickfix of hard-coding max_cpus = 4 works for
> my setup atm.
> 
> A fix could be to somehow retrieve the number of present CPUs. Is
> there some API available, besides parsing sysfs?


Ah, I see. We may need to change that call to be:

	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);

That way we'll have the correct max value, but that means we need to insert
an online check for each cpu when we get passed a cpulist.

I'm torn on whether we should just punt if we get passed an offline cpu or
whether we should just drop it from the list and run with the ones that actually
are online. Thoughts?

> 
> 
> c) On a 4 core arm64 system, where numa.h is not available, cyclictest
> uses its own implementation in rt_numa.h. In my configuration, all
> available cores are up and running. Let's say I want to spawn
> three threads allocated on the uppermost three CPUS:
>   # cyclictest -p 99 -m -a 1-3 -t 3 -v
> 
> Though -a is provided, cyclictest will move all threads to CPU 1:
>     Max CPUs = 4
>     # /dev/cpu_dma_latency set to 0us
>     Thread 0 Interval: 1500
>     Thread 0 using cpu 1.
>     Thread 1 Interval: 2000
>     Thread 1 using cpu 1.
>     Thread 2 Interval: 2500
>     Thread 2 using cpu 1.
> 
> Digging a beet deeper, I think rt_numa.h's rt_numa_parse_cpustring()
> is broken (or incomplete?) in rt_numa.h:230:
>     cpu = atoi(s);
> 
> where s = "1-3". Of course, this will fail. AFAICT,
> rt_numa_parse_cpustring() currently doesn't support cpu strings like
> "1-3" and silently fails.
> 
> Again, my dirty workaround to get things running is to hardcode
> enumeration.
> 
> 
> I'm not aware of the history of cyclictest, and maybe there are some
> reasons for this behavior. If so, please let me know!
> 
> IMHO, at least bug a) should be easy to fix. I tried to implement a
> proper fix for b) and c), but I have to admit that CPU enumeration is
> a beast.
>

Yeah, the parsing of cpu ranges is a PITA, no question. I'm not surprised
that we don't handle ranges properly. We just need to take a harder look
a the parsing code. 

Could I trouble you to open a BZ on bugzilla.kernel.org for cyclictest?

Clark



-- 
The United States Coast Guard
Ruining Natural Selection since 1790
