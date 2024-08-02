Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481C1AE030
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Aug 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621654; cv=none; b=AtuUx90oDp/8jVZhnwp/NXbjrEsKUNj3P9GvmuHDrTA2geZkStDN3l7X8P9VPOBIr+0TYG44GukQ/BCXtC1xcT/S4oCXn2aJ7xitPo9DyirNoMPOU6ie8fFh9+O8fz2ZciTZ93RnKC/dlriHybCAxmgqsb+/RnAhzZQq40o1pe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621654; c=relaxed/simple;
	bh=hK34FvEbvUvmyY7kpDT2yHVZ6n3eU4ufQ2QHUtmvQeY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B/QZ8MCRewgv2g+MK1kp+AjPBqgB+CEehqPOshHusHFOszfCoWv4asZuAexrc9lZZbkDxobiveXP1Lnd6vPCzaVsbllitQK1iVyQrcUIoWjQOSEqFYXoAfBpqogZJSAjv0bmAdR8MedJo7DyjOv3MXRiut3d6kHQPyS8uS/49vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eL3tQVYl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eL3tQVYl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722621650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifJksKeKtJt09iCGC1Kv0qvJJx2X3W9nBDrEc6nVAzs=;
	b=eL3tQVYlSniFPwLb44sQJDAmgbH/G9Qj8sr1tD/FSunKaUM8SA3p7tivhNkhoAHtMcsKjJ
	xkwgJQN7m8sCurk1DONs+rEqP54okGlIkXqX2wql2PDyP99Gdri9myLHXieNnC6H5tQpYo
	x3aTTOIbyftbOVAKlokvOylp8dGDnZg=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-Y52JL8pmOSWRMxuQtGEDYg-1; Fri, 02 Aug 2024 14:00:49 -0400
X-MC-Unique: Y52JL8pmOSWRMxuQtGEDYg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-26118fb0f25so9168504fac.1
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Aug 2024 11:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722621648; x=1723226448;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifJksKeKtJt09iCGC1Kv0qvJJx2X3W9nBDrEc6nVAzs=;
        b=FEeSQP+Ib0KSiIvQbgMZsrUMS2qK9yxjSDAfGI4a7MoHFb/DsO7OnDXph6a/FyPWle
         zANmQA7TigW4NpsIoXhagatW7ewbPMAuxuyYYadRV8nrvhiMwYZ1lT53Io3he4G7cJ3R
         sN8Y98GhgyMUi5vDyCzbwHOXa21JGB8Jtm947cVZFf7P/ZGHOMDg+DtIG2e0MDFre5oE
         PsQcJ61tZOGtf+AjjdHfMorssyhFK0wqLEhGmXhXbuSwknbw8O9j2tsNN0Mea9QbGiLj
         RBkWu3Y7Qzc0TuYChWda+8VmMBOmAGReQb86NBHAkE3Bfcbq4gZ2z+bzyDtz3Jd/NHw/
         ZJEQ==
X-Gm-Message-State: AOJu0YydKLUAh2tU/zyZ1JjmzpcnYHJ7xiRYn7gpU8BryrefWu9vcPAr
	L7Zbm2Oa1SIuaNO0UKcWH5L8i6l6GSXKC4d0BWR7vJIerrYSrlFTuyJ6fLsE7V13mgrJ2eblqQL
	oGZcsNJRMFhSFhMDCtVAYZNpS10aNyZyXtH/ypon7Xtc7c8Lga/oCLtaMqP0UP45j0Lu+ssmS
X-Received: by 2002:a05:6871:3386:b0:261:6c0:8a25 with SMTP id 586e51a60fabf-26891a8201fmr5089810fac.1.1722621647892;
        Fri, 02 Aug 2024 11:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb/xPV7MLlRJIXGyR5ANlmjZRPAPefc8QMvdkr71uvG8Ky+qbkBV+ghTV6XBf5XkqfqUYGlA==
X-Received: by 2002:a05:6871:3386:b0:261:6c0:8a25 with SMTP id 586e51a60fabf-26891a8201fmr5089778fac.1.1722621647464;
        Fri, 02 Aug 2024 11:00:47 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f76f1d7sm107061985a.92.2024.08.02.11.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:00:46 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:00:44 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Anubhav Shelat <ashelat@redhat.com>
cc: linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH v6 1/2] rteval: Added functionality to allow user to set
 the cstate of specified cpus when running rteval
In-Reply-To: <20240802154636.1240064-1-ashelat@redhat.com>
Message-ID: <775dc802-f2f7-f0cd-d099-09faebdf0239@redhat.com>
References: <20240802154636.1240064-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 2 Aug 2024, Anubhav Shelat wrote:

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
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval-cmd                             |  11 ++-
>  rteval/cpupower.py                     | 125 +++++++++++++++++++++++++
>  rteval/modules/__init__.py             |   2 +-
>  rteval/modules/measurement/__init__.py |   2 +
>  4 files changed, 138 insertions(+), 2 deletions(-)
>  create mode 100644 rteval/cpupower.py
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index 19c82a0b64b3..6e7d8f5d99cb 100755
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
> @@ -149,7 +150,7 @@ def parse_options(cfg, parser, cmdargs):
>      parser.add_argument("--noload", dest="rteval___noload",
>                          action="store_true", default=False,
>                          help="only run the measurements (don't run loads)")
> -
> +
>  
>      if not cmdargs:
>          cmdargs = ["--help"]
> @@ -402,6 +403,10 @@ if __name__ == '__main__':
>          if not os.path.isdir(rtevcfg.workdir):
>              raise RuntimeError(f"work directory {rtevcfg.workdir} does not exist")
>  
> +        # if idle-set has been specified, enable the idle state via cpupower
> +        if msrcfg.idlestate:
> +            cpupower_controller = cpupower.Cpupower(msrcfg.cpulist, msrcfg.idlestate, logger=logger)
> +            cpupower_controller.enable_idle_state()
>  
>          rteval = RtEval(config, loadmods, measuremods, logger)
>          rteval.Prepare(rtevcfg.onlyload)
> @@ -421,6 +426,10 @@ if __name__ == '__main__':
>              ec = rteval.Measure()
>              logger.log(Log.DEBUG, f"exiting with exit code: {ec}")
>  
> +        # restore previous idle state settings
> +        if msrcfg.idlestate:
> +            cpupower_controller.restore_idle_states()
> +
>          sys.exit(ec)
>      except KeyboardInterrupt:
>          sys.exit(0)
> diff --git a/rteval/cpupower.py b/rteval/cpupower.py
> new file mode 100644
> index 000000000000..37c4d33f1df4
> --- /dev/null
> +++ b/rteval/cpupower.py
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# Copyright 2024    Anubhav Shelat <ashelat@redhat.com>
> +""" Object to execute cpupower tool """
> +
> +import subprocess
> +import os
> +import shutil
> +import sys
> +from rteval.Log import Log
> +from rteval.systopology import SysTopology as SysTop
> +from rteval import cpulist_utils
> +
> +PATH = '/sys/devices/system/cpu/'
> +
> +class Cpupower:
> +    """ class to store data for executing cpupower and restoring idle state configuration """
> +    def __init__(self, cpulist, idlestate, logger=None):
> +        if not self.cpupower_present():
> +            print('cpupower not found')
> +            sys.exit(1)
> +
> +        self.__idle_state = int(idlestate)
> +        self.__states = os.listdir(PATH + 'cpu0/cpuidle/')
> +        # self.__idle_states is a dict with cpus as keys,
> +        # and another dict as the value. The value dict
> +        # has idle states as keys and a boolean as the
> +        # value indicating if the state is disabled.
> +        self.__idle_states = {}
> +        self.__name = "cpupower"
> +        self.__online_cpus = SysTop().online_cpus()
> +        self.__cpulist = cpulist
> +        self.__logger = logger
> +
> +
> +    def _log(self, logtype, msg):
> +        """ Common log function for rteval modules """
> +        if self.__logger:
> +            self.__logger.log(logtype, f"[{self.__name}] {msg}")
> +
> +
> +    def enable_idle_state(self):
> +        """ Use cpupower to set the idle state """
> +        self.get_idle_states()
> +
> +        # ensure that idle state is in range of available idle states
> +        if self.__idle_state > len(self.__states) - 1 or self.__idle_state < 0:
> +            print(f'Idle state {self.__idle_state} is out of range')
> +            sys.exit(1)
> +
> +        # enable all idle states to a certain depth, and disable any deeper idle states
> +        with open(os.devnull, 'wb') as buffer:
> +            for state in self.__states:
> +                s = state.strip("state")
> +                if int(s) > self.__idle_state:
> +                    self.run_cpupower(['cpupower', '-c', self.__cpulist,'idle-set', '-d', s], buffer)
> +                else:
> +                    self.run_cpupower(['cpupower', '-c', self.__cpulist,'idle-set', '-e', s], buffer)
> +
> +        self._log(Log.DEBUG, f'Idle state depth {self.__idle_state} enabled on CPUs {self.__cpulist}')
> +
> +
> +    def run_cpupower(self, args, output_buffer=None):
> +        """ execute cpupower """
> +        try:
> +            subprocess.run(args, check=True, stdout=output_buffer)
> +        except subprocess.CalledProcessError:
> +            print('cpupower failed')
> +            sys.exit(1)
> +
> +
> +    def get_idle_states(self):
> +        """ Store the current idle state setting """
> +        for cpu in self.__online_cpus:
> +            self.__idle_states[cpu] = {}
> +            for state in self.__states:
> +                fp = os.path.join(PATH, 'cpu' + str(cpu) + '/cpuidle/' + state + '/disable')
> +                self.__idle_states[cpu][state] = self.read_idle_state(fp)
> +
> +
> +    def restore_idle_states(self):
> +        """ restore the idle state setting """
> +        for cpu, states in self.__idle_states.items():
> +            for state, disabled in states.items():
> +                fp = os.path.join(PATH, 'cpu' + str(cpu) + '/cpuidle/' + state + '/disable')
> +                self.write_idle_state(fp, disabled)
> +        self._log(Log.DEBUG, 'Idle state settings restored')
> +
> +
> +    def read_idle_state(self, file):
> +        """ read the disable value for an idle state """
> +        with open(file, 'r', encoding='utf-8') as f:
> +            return f.read(1)
> +
> +
> +    def write_idle_state(self, file, state):
> +        """ write the disable value for and idle state """
> +        with open(file, 'w', encoding='utf-8') as f:
> +            f.write(state)
> +
> +
> +    def get_idle_info(self):
> +        """ execute cpupower idle-info """
> +        self.run_cpupower(['cpupower', 'idle-info'])
> +
> +
> +    def cpupower_present(self):
> +        """ check if cpupower is downloaded """
> +        return shutil.which("cpupower") is not None
> +
> +
> +if __name__ == '__main__':
> +    l = Log()
> +    l.SetLogVerbosity(Log.DEBUG)
> +
> +    online_cpus = cpulist_utils.collapse_cpulist(SysTop().online_cpus())
> +    idlestate = '1'
> +    info = True
> +
> +    cpupower = Cpupower(online_cpus, idlestate, logger=l)
> +    if idlestate:
> +        cpupower.enable_idle_state()
> +        cpupower.restore_idle_states()
> +    print()
> +    cpupower.get_idle_info()
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index d7792108d5b8..acd6330788e2 100644
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
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index ecadd0885991..9314d1cb6bbc 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -38,6 +38,8 @@ class MeasurementModules(RtEvalModules):
>                                default=self._cfg.GetSection("measurement").setdefault("run-on-isolcpus", "false").lower()
>                                        == "true",
>                                help="Include isolated CPUs in default cpulist")
> +        grparser.add_argument('--idle-set', dest='measurement___idlestate', metavar='IDLESTATE',
> +                        default=None, help='Idle state depth to set on cpus running measurement modules')
>  
>  
>      def Setup(self, modparams):
> -- 
> 2.45.2
> 
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

