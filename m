Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A407157C8E
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Jul 2024 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936328; cv=none; b=SPovpHxZnEZP6IoDD8UDEuAU1xiHCHvZz6bOUp1VZyRE9dk0yvkkZpAlrxaIdaYU6y0Xfl0mqO/FyFaojOcMurJaiM+sf6QP84o7OMg5Jqgh0a4kbF7wSyUqVfsSKqD3jXOkrylimGGpklyNBVynSMQ8h82zSwc6YeUVdzUYbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936328; c=relaxed/simple;
	bh=EyoAque7eVLBnNv0xvjWVR+jqRgaRFoWN436OP1+Hx0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CDo+bpf3GSYpXP+Puy3lCR+TpeLLkxpi19loiMRC4mWb+4OOGA0X924hA0P3IFrhI6+u9zifpFgXpW7mxt6PHAeB6c9L8az+s/AIhf2S3/LcmfZmji5rdHUCNGgOxkuYyOLojA5cg9qLtH2lInuA/wmuBmsGR/xEET92cViHDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GupEEU3A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GupEEU3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721936325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7syutIAYpbhVj1C3AKMqokQfAPiMyY0GzdgcH2CcV6E=;
	b=GupEEU3A/BfIEeIViMK48Wdvf7RHz9hmMUytjaoEEk0uNfw2ZrXcGo1aibXdkGQ9JN+O2g
	geDBghrKv/OkZHUUJF4SMjBp2E2o0VeIPknPmZ/q6VKDmLa9Gofm/k7u0fdPwMssGYghIe
	l3y8NzcqKZbM9/L6OurhTHljLRcFOEo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-kjFm0RVlME6CP-i0Jh386g-1; Thu, 25 Jul 2024 15:38:44 -0400
X-MC-Unique: kjFm0RVlME6CP-i0Jh386g-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b7a1c45abbso48377606d6.0
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Jul 2024 12:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721936324; x=1722541124;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7syutIAYpbhVj1C3AKMqokQfAPiMyY0GzdgcH2CcV6E=;
        b=M/AZMAPhLQsHdU79BXs8uhk9t+s8Kzs/HmNPeZFgQ+s6IY65iRCbbFiYyVl9pGfXsR
         VsOR1GhktdFoJNHaGKJXBAmSwHcdfrrl0abl3MtGuzjWrtHuxfW5w7z8OVGEVhZFbPRw
         T2whE4u4EtcRf6/4wTzXPvhiynwf0S7eOgz0lRxespaFaiQlhPewHlaDppC7S+BsXksc
         yAW/elspTRbYFVLeEQIVbmHbzFsYSSmrDezSszemJgikYjpoG5s+5GV3FO764jFCtG9n
         SEpibo0ptFRugHPxSzJ6SEk4iwpPJEWE5nAt70meuVb2XuvjMSQyGSidLC6jxhzHSuU3
         yxJw==
X-Gm-Message-State: AOJu0YyVXikKqtuLVuWC5Rj/NILRXfhZbHfPzs9BZo8sOG8+xhjQE2LT
	7CjwtAXkCxHliATqbzm1+JnSp7uH3Oh/D/90ZPwvpvVXADA8c/kzTCqf0xb/Yx48HyoEUW1U0+N
	MhUV5Co0wC1XfSDGXkmxdL+aHEbCOHZbGly3l7Q6TOc0Tdd+zGJYHLINNaXowJK1u
X-Received: by 2002:ad4:4dcc:0:b0:6b7:551b:7800 with SMTP id 6a1803df08f44-6b99154d478mr103483966d6.19.1721936323656;
        Thu, 25 Jul 2024 12:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlAmbTYCCW8EOQeESPlQZk999tvMiRq8p/zKcdMWToGY0UTij3cRPZJtmuZ0/useIwGv4xtQ==
X-Received: by 2002:ad4:4dcc:0:b0:6b7:551b:7800 with SMTP id 6a1803df08f44-6b99154d478mr103483576d6.19.1721936323193;
        Thu, 25 Jul 2024 12:38:43 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94cddsm9974246d6.100.2024.07.25.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 12:38:42 -0700 (PDT)
Date: Thu, 25 Jul 2024 15:38:42 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Anubhav Shelat <ashelat@redhat.com>
cc: linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH v5 1/2] rteval: Added functionality to allow user to set
 the cstate of specified cpus when running rteval
In-Reply-To: <20240725161514.1885152-1-ashelat@redhat.com>
Message-ID: <d9d07ba1-d184-03ab-e239-9fd6c64a8bcd@redhat.com>
References: <20240725161514.1885152-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Thu, 25 Jul 2024, Anubhav Shelat wrote:

> We would like to be able to set the idle states of CPUs while running
> rteval.
> 
> This patch adds the file cpupower.py and option '--idle-set' within
> rteval to use cpupower. The set idle state is applied to the cpulist
> given by '--measurement-cpulist'.
> 
> cpupower.py provides the infrastructure to interface and execute the cpupower
> command, and the options in rteval-cmd let the user specify the idle state
> to be set and the CPUs to set it on.
>

Ok, this time the patch applied cleanly, but there are a number of 
problems with it, please see below.


 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval-cmd                 | 22 ++++++++-
>  rteval/cpupower.py         | 94 ++++++++++++++++++++++++++++++++++++++
>  rteval/modules/__init__.py |  2 +-
>  3 files changed, 116 insertions(+), 2 deletions(-)
>  create mode 100644 rteval/cpupower.py
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index 19c82a0b64b3..9d87328302df 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -29,6 +29,7 @@ from rteval.Log import Log
>  from rteval import RtEval, rtevalConfig
>  from rteval.modules.loads import LoadModules
>  from rteval.modules.measurement import MeasurementModules
> +from rteval import cpupower
>  from rteval.version import RTEVAL_VERSION
>  from rteval.systopology import SysTopology, parse_cpulist_from_config
>  from rteval.modules.loads.kcompile import ModuleParameters
> @@ -149,7 +150,8 @@ def parse_options(cfg, parser, cmdargs):
>      parser.add_argument("--noload", dest="rteval___noload",
>                          action="store_true", default=False,
>                          help="only run the measurements (don't run loads)")
> -
> +    parser.add_argument('--idle-set', dest='rteval___idlestate', metavar='IDLESTATE',
> +                        default=None, help='Idle state to enable for this rteval run')
>  
>      if not cmdargs:
>          cmdargs = ["--help"]
> @@ -172,6 +174,12 @@ def parse_options(cfg, parser, cmdargs):
>          cmd_args = cmdargs[ind+1:]
>          cmdargs = cmdargs[:ind+1]
>  
> +    # if --cpulist is specified, make sure --idle-set is too
> +    if ((sys.argv.count('-c')+sys.argv.count('--cpulist')) > 0) and \
> +    (sys.argv.count('--idle-set') == 0):
> +        print('--cpulist must be used with --idle-set')
> +        cmdargs = ["--help"]
> +
>      cmd_opts = parser.parse_args(args=cmdargs)
>  
>      # if no kernel version was provided for --source-download, set version to default
> @@ -265,6 +273,9 @@ if __name__ == '__main__':
>                  | (rtevcfg.debugging and Log.DEBUG)
>          logger.SetLogVerbosity(loglev)
>  
> +        # check if cpupower is being used
> +        if sys.argv.count('--idle-set') > 0:
> +            rtevcfg.update({'usingCpupower': True})
>          # Load modules
>          loadmods = LoadModules(config, logger=logger)
>          measuremods = MeasurementModules(config, logger=logger)
> @@ -402,6 +413,11 @@ if __name__ == '__main__':
>          if not os.path.isdir(rtevcfg.workdir):
>              raise RuntimeError(f"work directory {rtevcfg.workdir} does not exist")
>  
> +        # if idle-set has been specified, enable idlestate in rtecfg.cpulist
> +        cpupower_controller = None
> +        if rtevcfg.idlestate:
> +            cpupower_controller = cpupower.Cpupower(msrcfg.cpulist, rtevcfg.idlestate)
> +            cpupower_controller.enable_idle_state()
>  
>          rteval = RtEval(config, loadmods, measuremods, logger)
>          rteval.Prepare(rtevcfg.onlyload)
> @@ -421,6 +437,10 @@ if __name__ == '__main__':
>              ec = rteval.Measure()
>              logger.log(Log.DEBUG, f"exiting with exit code: {ec}")
>  
> +        # reset idlestate
> +        if rtevcfg.idlestate:
> +            cpupower_controller.restore_cstate()
> +
>          sys.exit(ec)
>      except KeyboardInterrupt:
>          sys.exit(0)
> diff --git a/rteval/cpupower.py b/rteval/cpupower.py
> new file mode 100644
> index 000000000000..9437b2451b54
> --- /dev/null
> +++ b/rteval/cpupower.py
> @@ -0,0 +1,94 @@
> +#! /user/bin/python3

If I run
su -c "./rteval/cpupower"
I get
bash: line 1: ./rteval/cpupower: No such file or directory
and this is because you spelled "user", when it should be "usr"

If I work around that problem like this, then I get a new problem.
su -c "python  ./rteval/cpupower.py "
Password: 
Namespace(cpu_list=None, idle_set='', info=False)
Traceback (most recent call last):
  File "/home/jkacur/src/rteval/./rteval/cpupower.py", line 85, in 
<module>
    idlestate = args.cstate
                ^^^^^^^^^^^
AttributeError: 'Namespace' object has no attribute 'cstate'

I assume that you meant args.idle_set
which, I understand we are translating a subcommand from cpupower into an 
option, so
idle_set is fine, but you probably want a metavar of "state" so the help
output looks nicer.

Instead of time.sleep(10), if you use DEBUG log statements in the code
that print out the state, then there is no need to sleep
This is also probably what you want instead of raw print statements in the 
code.

Please consistently change references of cstate to idle_state, or 
idlestate.

You should probably check the output after Subprocess.run
(check=True) and handle subprocess.CalledProcessError

The code doesn't look too bad but we can use some existing structures
and some more pythonesque code. For example, you probably don't need
a cpu count, you can just loop through the cpu list

We can discuss offline if you wish.

Thanks

John



> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# Object to execute cpupower tool
> +# Copyright 2024    Anubhav Shelat <ashelat@redhat.com>
> +
> +import subprocess
> +import argparse
> +import os
> +import multiprocessing
> +import time
> +
> +
> +class Cpupower:
> +    def __init__(self, cpulist, idlestate):
> +        self.cpulist = cpulist
> +        self.idlestate = idlestate
> +        self.nstates = len(os.listdir('/sys/devices/system/cpu/cpu0/cpuidle/'))    # number of cstates
> +        self.cpu_count = multiprocessing.cpu_count()
> +        self.cstate_cfg = []
> +
> +
> +    def enable_idle_state(self):
> +        ''' Enable a specific cstate, while disabling all other cstates, and save the current cstate configuration '''
> +        self.cstate_cfg = self.get_cstate_cfg()
> +
> +        # ensure that cstate is in range of available cstates
> +        if int(self.idlestate) > self.nstates-1 or int(self.idlestate) < 0:
> +            print(f'Idle state {self.idlestate} is out of range, using POLL')
> +            self.idlestate = 0
> +
> +        # enable cstate and disable the rest
> +        if (self.cpulist):
> +            subprocess.run(['sudo', 'cpupower', '-c', self.cpulist,'idle-set', '-e', str(self.idlestate)], stdout=open(os.devnull, 'wb'))
> +            for cs in range(self.nstates):
> +                if str(cs) != self.idlestate:
> +                    subprocess.run(['sudo', 'cpupower', '-c', self.cpulist,'idle-set', '-d', str(cs)], stdout=open(os.devnull, 'wb'))
> +        else:
> +            subprocess.run(['sudo', 'cpupower', 'idle-set', '-e', str(self.idlestate)], stdout=open(os.devnull, 'wb'))
> +            for cs in range(self.nstates):
> +                if str(cs) != self.idlestate:
> +                    subprocess.run(['sudo', 'cpupower', 'idle-set', '-d', str(cs)], stdout=open(os.devnull, 'wb'))
> +
> +        if self.cpulist: print(f'Idlestate {self.idlestate} enabled on CPUs {self.cpulist}')
> +        else: print(f'Idlestate {self.idlestate} enabled on all CPUs')
> +
> +
> +    def get_cstate_cfg(self):
> +        ''' Store the current cstate config '''
> +        # cstate [m] configuration on cpu [n] can be found in '/sys/devices/system/cpu/cpu*/cpuidle/state*/disable'
> +        cfg = []
> +        for cpu in range(self.cpu_count):
> +            cfg.append([])
> +            for cs in range(self.nstates):
> +                f = open('/sys/devices/system/cpu/cpu'+str(cpu)+'/cpuidle/state'+str(cs)+'/disable', 'r')
> +                d = f.read(1)
> +                cfg[cpu].append(d)   # cstate_cfg[n][m] stores the m-th idle state on the n-th cpu
> +
> +        return cfg
> +
> +
> +    def restore_cstate(self):
> +        for cpu in range(self.cpu_count):
> +            for cs in range(self.nstates):
> +                f = open('/sys/devices/system/cpu/cpu'+str(cpu)+'/cpuidle/state'+str(cs)+'/disable', 'w')
> +                f.write(self.cstate_cfg[cpu][cs])
> +                f.close()
> +        print('Idle state configuration restored')
> +
> +    def get_idle_info():
> +        subprocess.call(['cpupower', 'idle-info'])
> +
> +
> +if __name__ == '__main__':
> +    parser = argparse.ArgumentParser()
> +    parser.add_argument('-c', '--cpu-list', required=False, default=None,
> +                        help='List of cpus to perform cpupower-idle-set operation on.')
> +    parser.add_argument('-s', '--idle-set', default='',
> +                        help='Specify idle state to enable/disable')
> +    parser.add_argument('--info', default=False, action='store_true', help='Get idle state information')
> +
> +    args = parser.parse_args()
> +    print(args)
> +    cpulist = args.cpu_list
> +    idlestate = args.cstate
> +    if (idlestate):
> +        cpupower = Cpupower(cpulist, idlestate)
> +        cpupower.enable_idle_state()
> +        time.sleep(10)
> +        cpupower.restore_cstate()
> +    elif (args.info):
> +        Cpupower.get_idle_info()
> +
> +
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index 2a4eafae71c7..10cbd50ddfd8 100644
> --- a/rteval/modules/__init__.py
> +++ b/rteval/modules/__init__.py
> @@ -282,7 +282,7 @@ reference from the first import"""
>          grparser.add_argument(f'--{self.__modtype}-cpulist',
>                              dest=f'{self.__modtype}___cpulist', action='store', default="",
>                              help=f'CPU list where {self.__modtype} modules will run',
> -                            metavar='LIST')
> +                            metavar='CPULIST')
>  
>          for (modname, mod) in list(self.__modsloaded.items()):
>              opts = mod.ModuleParameters()
> -- 
> 2.45.2
> 
> 
> 

