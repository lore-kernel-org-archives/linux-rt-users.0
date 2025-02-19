Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCCF1FCFD2
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Feb 2025 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989395; cv=none; b=HA73vP5m7tT80fcQk7LR+WcOM4HRXsqBbY0ey2uVhNLsZ74aOS+H76kc2XXN5Zgp+AE5lhligof1DowMfQ7sRqjB0u12DZBhKg8afCEaa0Ta4RqRPrdhtBLX9gD0SjkSh8q7c3tMmWp5lcHYsVoBwXiuktgacMlSC6tYI1HQWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989395; c=relaxed/simple;
	bh=rptsHEFZDW3Jl3kl71tlorDC0CK+QufUxtp5+1t+txg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGsQY8WvtwYQwF4q2JLznXHgZgbdMVdbdivY+4g/M5DFWah3GUgmO2IaGzUpIxeARreH0hkQrHTJWA2G2Jx/bSU/bQVcAha2r0VVvuHWxMHn0XzOe4glJJcvZUMqOrTX7pG2/F1oH6gzfuH+AaeTZ0QcO68BTwZE27LTBGfe1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMISEpeh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMISEpeh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739989392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ot5rt8hwxUdjyGKdFZWEtVeWU5GcmDWAPr3n4vKCKiI=;
	b=MMISEpehV2PmSqnXwSoqM7W5m6PGD3OJkHVUBNZX4lpbBjVy6yBC5bKdqlBJkR1C9A/baE
	JTrB3ykpOuKA6WdqpaSRWOgVT0DnpuySaGpy+Lnoengg3lN/VrTpI+G3ag9fb/WuCxJwGT
	VHvpSad/GOPefWCT6KSA7eypVXvRLQk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-xNpzze1iOUiJECsYz5oiaA-1; Wed, 19 Feb 2025 13:23:10 -0500
X-MC-Unique: xNpzze1iOUiJECsYz5oiaA-1
X-Mimecast-MFC-AGG-ID: xNpzze1iOUiJECsYz5oiaA_1739989390
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e65e656c41so562246d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Feb 2025 10:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989390; x=1740594190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ot5rt8hwxUdjyGKdFZWEtVeWU5GcmDWAPr3n4vKCKiI=;
        b=BmyWPAz0Lf6XXYilN3Vgl436vwRMwc1ii74PDyJQC5A6kObMyjKL+6D6OdC5565ju4
         8ZFFgyR1GFxIKGSwFBONuQerEAo8ZlaX0h+ny3lsY9ubbc72W7j8c+g8+JkO/E9FgDFB
         tasVHNA5ASv0pum/H+JU+Voni9wB0Nl3y+Ca2uYC4v7QFxep0eARQs0Nj/3qQojNEJR1
         X5Nm03vCndtVaCR+5oa1JCC5P+fHh9cNnLj6tNYbhg7Q0AcH4m7lEpcOQt09KXRoqnoq
         C+bC+QVMC3sbpdU45cdjXA/iPag+c1mmjdasbp4wclA62pDEo3IZsBjyXLv0XDJUoB1p
         e76Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlNGDuIx1eTok4bwW+5COSJDHY643rvmN2u5xLd5IVsOdUpnOcoUyc3TcUxg73vB9pMPBKgqCnis1tN88olQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NyBnNzX++2He+64+x19XzHgFNbOSapcGUGfEZqij4PnDzD2E
	Hcs7YeyH+6vOnN5YrP1uOF3T+i7d45kyW/1fm4x7Pu/3V6nMKE1erZVwFt/LCiBxAgPPTec2QoY
	6xQE57xTKNsIQZucfVLjF3pCFEIRR36hKRfXNEp3DV6yZl4swfhuT7KwrS3D1guuzozYCHXH9PC
	E=
X-Gm-Gg: ASbGncs1iHIYIzEMAASkRPpbvVUEL1MOezJC/2kI1GEEH63N0/1WrFibqpR4JaHKFmq
	xsUlPkrVXTmOQqVvMDKCaBu3AJgWrqzYvjKjjcx4azRNoPVkPIzvZolCefHEJs9OSZw1ZrHYhml
	tvZPjom401s0UmkFdsIpMcFjD04/cKp27D/zkREu45tYtudDrQMNr0oK5g/eJ9uSmuYzjlsUVHD
	6N3mCddbJBGamcX0RmqQ6f71gBJdrOnLHLebC/YtY0TRLCbEvzuFqsJWir52Q5PtJ8l29qeJvNO
X-Received: by 2002:a05:6214:124d:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e6975757d6mr76380846d6.38.1739989389857;
        Wed, 19 Feb 2025 10:23:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE31teyLJY3lVGCgLKlAu9DP+wGEMQjyurnG6wDOy0mlVASLBOAosqClGyV2fbWgzWirszj4g==
X-Received: by 2002:a05:6214:124d:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e6975757d6mr76380326d6.38.1739989389356;
        Wed, 19 Feb 2025 10:23:09 -0800 (PST)
Received: from thinkpad2024 ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f325fsm77357466d6.76.2025.02.19.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:23:08 -0800 (PST)
Date: Wed, 19 Feb 2025 13:23:06 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 2/2] tuna: Add idle-state control functionality
Message-ID: <Z7YhirJ4PIZtkSbi@thinkpad2024>
References: <20250128014551.15058-1-jwyatt@redhat.com>
 <20250128014551.15058-3-jwyatt@redhat.com>
 <988719a1f124a548dc5c93fbce88dceaaa322e28.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988719a1f124a548dc5c93fbce88dceaaa322e28.camel@redhat.com>

On Thu, Feb 13, 2025 at 05:09:18PM -0600, Crystal Wood wrote:
> On Mon, 2025-01-27 at 20:45 -0500, John B. Wyatt IV wrote:
> > Allows Tuna to control cpu idle-state functionality on the system,
> > including querying, enabling, disabling of cpu idle-states to control
> > power usage or to test functionality.
> > 
> > This requires cpupower, a utility in the Linux kernel repository and
> > the cpupower Python bindings added in Linux 6.12 to control cpu
> > idle-states. If cpupower is missing Tuna as a whole will continue to
> > function and idle-set functionality will error out.
> > 
> > Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> > Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> > ---
> >  tuna-cmd.py      |  33 +++++++-
> >  tuna/cpupower.py | 202 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 233 insertions(+), 2 deletions(-)
> >  create mode 100755 tuna/cpupower.py
> > 
> > diff --git a/tuna-cmd.py b/tuna-cmd.py
> > index d0323f5..81d0f48 100755
> > --- a/tuna-cmd.py
> > +++ b/tuna-cmd.py
> > @@ -25,6 +25,7 @@ from tuna import tuna, sysfs, utils
> >  import logging
> >  import time
> >  import shutil
> > +import tuna.cpupower as cpw
> 
> >  def get_loglevel(level):
> >      if level.isdigit() and int(level) in range(0,5):
> > @@ -115,8 +116,12 @@ def gen_parser():
> >              "disable_perf": dict(action='store_true', help="Explicitly disable usage of perf in GUI for process view"),
> >              "refresh": dict(default=2500, metavar='MSEC', type=int, help="Refresh the GUI every MSEC milliseconds"),
> >              "priority": dict(default=(None, None), metavar="POLICY:RTPRIO", type=tuna.get_policy_and_rtprio, help="Set thread scheduler tunables: POLICY and RTPRIO"),
> > -            "background": dict(action='store_true', help="Run command as background task")
> > -         }
> > +            "background": dict(action='store_true', help="Run command as background task"),
> > +            "idle_state_disabled_status": dict(dest='idle_state_disabled_status', metavar='IDLESTATEDISABLEDSTATUS', type=int, help='Print if cpu idle state of the cpus in CPU-LIST is enabled or disabled. If CPU-LIST is not specified, default to all cpus.'),
> > +            "idle_info": dict(dest='idle_info', action='store_const', const=True, help='Print general idle information on cpus in CPU-LIST. If CPU-LIST is not specified, default to all cpus.'),
> > +            "disable_idle_state": dict(dest='disable_idle_state', metavar='IDLESTATEINDEX', type=int, help='Disable cpus in CPU-LIST\'s cpu idle (cpu sleep state). If CPU-LIST is not specified, default to all cpus.'),
> > +            "enable_idle_state": dict(dest='enable_idle_state', metavar='IDLESTATEINDEX', type=int, help='Enable cpus in CPU-LIST\'s cpu idle (cpu sleep state). If CPU-LIST is not specified, default to all cpus.')
> > +    }
> >  
> >      parser = HelpMessageParser(description="tuna - Application Tuning Program")
> >  
> > @@ -147,6 +152,10 @@ def gen_parser():
> >      show_irqs = subparser.add_parser('show_irqs', description='Show IRQ list', help='Show IRQ list')
> >      show_configs = subparser.add_parser('show_configs', description='List preloaded profiles', help='List preloaded profiles')
> >  
> > +    idle_set = subparser.add_parser('idle-set',
> > +                                    description='Query and set all idle states on a given CPU list. Requires libcpupower to be installed',
> > +                                    help='Set all idle states on a given CPU-LIST.')
> 
> idle_state would be a better name (or idle-state, but underscores are
> already used elsewhere...), since it can both set and get.

Being used elsewhere is why I used it. Nothing else to add.

> 
> It also mostly operates on individual states (-i being the exception),
> not all at once.  How about just:
> 
> Manage CPU idle state disabling (requires libcpupower)

Will do.

> 
> Also, don't forget to update the man page.

The man page will be in a future patch.

> 
> > @@ -635,6 +651,19 @@ def main():
> >          my_logger.addHandler(add_handler("DEBUG", tofile=False))
> >          my_logger.info("Debug option set")
> >  
> > +    if args.command == 'idle-set':
> > +        if not cpw.have_cpupower:
> > +            print(f"Error: libcpupower bindings are not detected; need {cpw.cpupower_required_kernel} at a minimum.")
> > +            sys.exit(1)
> > +
> > +        if not args.cpu_list or args.cpu_list == []:
> > +            args.cpu_list = cpw.Cpupower().get_all_cpu_list()
> > +
> > +        my_cpupower = cpw.Cpupower(args.cpu_list)
> > +        ret = my_cpupower.idle_state_handler(args)
> > +        if ret > 0:
> > +            sys.exit(ret)
> 
> Why not just pass in cpu_list as is, and have cpw understand what
> an empty or absent list is?  And it looks like it already partially
> does check for None...  If the user specifically does something
> like --cpu '' should we really treat that as equivalent to not
> specifing --cpu?  I don't see other commands doing this.

Will move the logic to the class.

I do not understand what you wrote for the second part with checking for
--cpu. Would you please rephase?

Note I am still learning argparse; if you know of a better way, an
example would be welcome. :-)

> 
> Especially if you're going to delegate all other option parsing...
> Why is cpulist special?  Just do something like:
> 
> elif args.command == 'idle_state'
>     cpw.idle_state(args)
> 
> >      if args.loglevel:
> >          if not args.debug:
> >              my_logger = setup_logging("my_logger")
> 
> Why did you put the new command before log handling, rather than with
> all the other commands?

Will amend this. Looks like I misapplied a commit hunk.

> 
> > diff --git a/tuna/cpupower.py b/tuna/cpupower.py
> > new file mode 100755
> > index 0000000..b09dc2f
> > --- /dev/null
> > +++ b/tuna/cpupower.py
> > @@ -0,0 +1,202 @@
> > +# Copyright (C) 2024 John B. Wyatt IV
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +from typing import List
> > +import tuna.utils as utils
> > +
> > +cpupower_required_kernel = "6.12"
> > +have_cpupower = None
> > +
> > +
> > +import raw_pylibcpupower as cpw
> 
> This is a bit confusing since you import this module as cpw
> elsewhere...
> 
> Also, I got this even without trying to use the new functionality:
> 
> $ ./tuna-cmd.py 
> Traceback (most recent call last):
>   File "/home/crwood/git/tuna/./tuna-cmd.py", line 28, in <module>
>     import tuna.cpupower as cpw
>   File "/home/crwood/git/tuna/tuna/cpupower.py", line 11, in <module>
>     import raw_pylibcpupower as cpw
> ModuleNotFoundError: No module named 'raw_pylibcpupower'
> 

This was pointed out to me in a separate email. I have already fixed it
for the v2 I will send.

> Maybe something like:
> 
> try:
>     import raw_pylibcpupower as lcpw
>     lcpw.cpufreq_get_available_frequencies(0)
> except:
>     lcpw = None

pylint does not like a module to be dynamically imported this way, but I
found a workaround using importlib. pylint's messaging is very valuable
so I rather not have to disable it. It gives a warning every time cpw is
used otherwise.

> 
> > +        You must use have_cpupower variable to determine if the bindings were
> > +        detected in your code."""
> 
> Instead of doing to the class/module user what SWIG did to the binding
> user, why not just throw an exception if the binding is missing?  This
> will automatically happen if lcpw is None, though you may want a
> friendlier error message in the main entry point.

Please see above.

> 
> > +        def __init__(self, cpulist=None):
> > +            if cpulist == None:
> > +                self.__cpulist = self.get_all_cpu_list()
> > +            else:
> > +                self.__cpulist = cpulist
> > +
> > +        @classmethod
> > +        def get_all_cpu_list(cls):
> > +            return list(range(cls.get_idle_info()["all_cpus"]))
> 
> Is this really idle-state-specific?  Maybe just something like this
> in tuna/utils.py:

It is in the cpupower.py file, not an idle-state.py file. The only part
specific to idle-state is idle-set is the only user.

I was thinking of that, but that can be a future patch. I wanted this
implementation to be kept simple.

> 
> def get_all_cpu_list():
>     return list(range(get_nr_cpus()))
> 
> We shouldn't need to get all the idle state information just to get a
> cpu list.

I mimicked the way cpupower reports this information. The information is
useful to report. I am not sure what your objection is.

> 
> And all these class methods make me wonder why this is a class to begin
> with, rather than just module functions.

I plan to add future functionality down the road; a class would be
appropriate for handling this.

> 
> > +
> > +        @classmethod
> > +        def get_idle_info(cls, cpu=0):
> 
> Why is cpu 0 special?

cpupower itself for this functionality picks a random cpu thread to report.
I choose cpu 0 as a stopgap until I find/upstream better functionality to
handle this. I did not feel a random cpu was any better.

> 
> > +            idle_states, idle_states_amt = cls.get_idle_states(cpu)
> > +            idle_states_list = []
> > +            for idle_state in range(0, len(idle_states)):
> > +                idle_states_list.append(
> > +                    {
> > +                        "CPU ID": cpu,
> > +                        "Idle State Name": idle_states[idle_state],
> > +                        "Flags/Description": cpw.cpuidle_state_desc(cpu, idle_state),
> > +                        "Latency": cpw.cpuidle_state_latency(cpu, idle_state),
> > +                        "Usage": cpw.cpuidle_state_usage(cpu, idle_state),
> > +                        "Duration": cpw.cpuidle_state_time(cpu, idle_state)
> > +                    }
> > +                )
> > +            idle_info = {
> > +                "all_cpus": utils.get_nr_cpus(),
> > +                "CPUidle-driver": cpw.cpuidle_get_driver(),
> > +                "CPUidle-governor": cpw.cpuidle_get_governor(),
> > +                "idle-states-count": idle_states_amt,
> > +                "available-idle-states": idle_states,
> > +                "cpu-states": idle_states_list
> > +            }
> > +            return idle_info
> 
> This seems overly complicated.  Why do you bundle all this stuff up
> just to extract it elsewhere?  The call to get the data is simpler than
> the data structure lookup.

I do not understand. There are multiple calls to get the data.

As I said above, I was mimicking how cpupower reports this information.
I thought it would be useful to report. I wrap this data up into a
hashmap that I hope may be useful to export as json for scripting in the
future.

> 
> > +
> > +        @classmethod
> > +        def print_idle_info(cls, cpu_list=[0]):
> 
> The only thing that instantiating this class does is to store a cpu
> list, and here you're passing it into a class method instead...

Yes, please see above.

> 
> > +        def idle_state_handler(self, args) -> int:
> > +            if args.idle_state_disabled_status != None:
> > +                cstate_index = args.idle_state_disabled_status
> > +                cstate_list, cstate_amt = self.get_idle_states(args.cpu_list[0]) # Assumption, that all cpus have the same idle state
> 
> The API doesn't make that assumption, so why should we?  Systems exist
> with heterogeneous CPUs... could be a reason to support looking up states
> by name, if and when there are systems we care about that actually have
> different cpuidle states.

Heterogeneous CPU support will come in a future patch once I have
upstreamed some more work.

Note that the libcpupower API offers a way to get the number of cores of a
system (get_cpu_topology()), but the code to do this is commented out (see
the missing curly brace?) and returns a 0 for the number of cores
currently.

https://elixir.bootlin.com/linux/v6.13.3/source/tools/power/cpupower/lib/cpupower.c#L206-L213

> 
> And you don't need this lookup anyay -- libcpupower already does the
> bounds check, and you can get the name inside the loop.

I will check on that.

> 
> > +                if cstate_index < 0 or cstate_index >= cstate_amt:
> > +                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
> > +                    return 1
> 
> "this cpu"?

Will amend.

> 
> > +                cstate_name = cstate_list[cstate_index]
> > +                ret = self.is_disabled_idle_state(cstate_index)
> > +                for i, e in enumerate(ret):
> > +                    match e:
> > +                        case 1:
> > +                            print(f"CPU: {args.cpu_list[i]} Idle state \"{cstate_name}\" is disabled.")
> > +                        case 0:
> > +                            print(f"CPU: {args.cpu_list[i]} Idle state \"{cstate_name}\" is enabled.")
> > +                        case -1:
> > +                            print(f"Idlestate not available")
> > +                        case -2:
> > +                            print(f"Disabling is not supported by the kernel")
> > +                        case _:
> > +                            print(f"Not documented: {e}")
> > +            elif args.idle_info != None:
> > +                self.print_idle_info(args.cpu_list)
> > +                return 0
> > +            elif args.disable_idle_state != None:
> > +                cstate_index = args.disable_idle_state
> > +                cstate_list, cstate_amt = self.get_idle_states(args.cpu_list[0]) # Assumption, that all cpus have the same idle state
> > +                if cstate_index < 0 or cstate_index >= cstate_amt:
> > +                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
> > +                    return 1
> > +                cstate_name = cstate_list[cstate_index]
> > +                ret = self.disable_idle_state(cstate_index, 1)
> > +                for i, e in enumerate(ret):
> > +                    match e:
> > +                        case 0:
> > +                            print(f"CPU: {args.cpu_list[i]} Idle state \"{cstate_name}\" is disabled.")
> > +                        case -1:
> > +                            print(f"Idlestate not available")
> > +                        case -2:
> > +                            print(f"Disabling is not supported by the kernel")
> > +                        case -3:
> > +                            print(f"No write access to disable/enable C-states: try using sudo")
> > +                        case _:
> > +                            print(f"Not documented: {e}")
> > +            elif args.enable_idle_state != None:
> > +                cstate_index = args.enable_idle_state
> > +                cstate_list, cstate_amt = self.get_idle_states(args.cpu_list[0]) # Assumption, that all cpus have the same idle state
> > +                if cstate_index < 0 or cstate_index >= cstate_amt:
> > +                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
> > +                    return 1
> > +                cstate_name = cstate_list[cstate_index]
> > +                ret = self.disable_idle_state(cstate_index, 0)
> > +                for i, e in enumerate(ret):
> > +                    match e:
> > +                        case 0:
> > +                            print(f"CPU: {args.cpu_list[i]} Idle state \"{cstate_name}\" is enabled.")
> > +                        case -1:
> > +                            print(f"Idlestate not available")
> > +                        case -2:
> > +                            print(f"Disabling is not supported by the kernel")
> > +                        case -3:
> > +                            print(f"No write access to disable/enable C-states: try using sudo")
> > +                        case _:
> > +                            print(f"Not documented: {e}")
> 
> Factor out the error messages so they're not duplicated between
> suboperations.  Actually, pretty much the whole thing is duplicated between
> enable/disable...

Will do.

> 
> Do we want to print anything at all on success?  It looks like tuna
> generally follows the Unix philosophy of not doing so.

Good point. That will also make it easier to script.

> 
> And the error messages are a bit vague... imagine running a script and
> something deep inside it spits out "Disabling is not supported by the
> kernel".  Disabling what?
> 
> > +            else:
> > +                print(args)
> > +                print("idle-set error: you should not get here!")
> 
> "you should not get here" is not a useful error message... jut throw
> an exception.

Will amend.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

