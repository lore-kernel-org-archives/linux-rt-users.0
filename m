Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnQzqiCS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A06FAB
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 13:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702417698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEqhoJdE3Ej7O4owVMoCuFeaa8nWLK+9cmmHb7zGFsQ=;
	b=SnQzqiCSOKiWRta79zJIq7NEbIJT+SKxUI0bBqvbE93G7iD50qd+TIBTutzs728pb8XATU
	DYKVjoK4foRShyHGtix+WYZz8/7eI1kZQKA/uHtu2q7n1wYd0rEMocumzPPKCHvK12dth+
	xrLqwq1Hbs/VR8I8j321X1kKN3Y+6BM=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-QvwTVdGNN9K07rveGI0VPw-1; Tue, 12 Dec 2023 16:48:15 -0500
X-MC-Unique: QvwTVdGNN9K07rveGI0VPw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-203014900a9so1449778fac.3
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 13:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417694; x=1703022494;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEqhoJdE3Ej7O4owVMoCuFeaa8nWLK+9cmmHb7zGFsQ=;
        b=l34dqTnY0oyidOA7DkDU3aQIiJS3PK8nyb4WlbxlCEh0IxCyG/OuilfPCUvk625W4H
         jgKNVH6hb4hZxlyJoGs3T6/1OD6dIWwW3sDuXT2eOaVswmrQ81+UCM+JfDCyUUhLdHu6
         3QYyzyWl7GkiCmOJYM4UqwWV710+9WyIzqNvtkQ+mcLjMz/1bYdCZNapQ9h/L4gP1le7
         5YqyssJhoQH/Q7bxR591t7JZws0pGwdpoZH7+XXWc+lnwA8GuR2nZ1h0KhDBJexcKLuY
         ChHx8Kk3p/2gY9v5g85k4vo13UiHGDjJJiSCVp/f/FswGSYmFRVj2fQLdfa+8fENqeHk
         Grqg==
X-Gm-Message-State: AOJu0YzQ4RI6aEX5yFAlKFrPTgvuQDYEHcyfu4TBFv6V24y4bpYzyksi
	IVXFOSI61Y+rQxR7+rzBzS2UMG0A9nu/li9s4ZZnjzHe3ARsPSSl5b5utDxuzbON3wr6fttGwHi
	lxHGTrCOIHl7EkoI0ws+QffXDjnQ=
X-Received: by 2002:a05:6871:5a05:b0:1fb:75a:77bb with SMTP id on5-20020a0568715a0500b001fb075a77bbmr6856514oac.108.1702417694130;
        Tue, 12 Dec 2023 13:48:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYeJUk//3TuGwFGPL1ZRRToUBIzBWhvcdxalqKsUjHNXAfsHTmb5v//lGlMirRJysG/3qwBQ==
X-Received: by 2002:a05:6871:5a05:b0:1fb:75a:77bb with SMTP id on5-20020a0568715a0500b001fb075a77bbmr6856504oac.108.1702417693802;
        Tue, 12 Dec 2023 13:48:13 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id qf4-20020a05620a660400b0077d66e5b2e6sm4060526qkn.3.2023.12.12.13.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:48:13 -0800 (PST)
Date: Tue, 12 Dec 2023 16:48:04 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/4] rteval: Add relative cpulists for measurements
In-Reply-To: <20231129093457.17984-5-tglozar@redhat.com>
Message-ID: <0f97a64b-8f87-5337-bf52-a9a9d3d36cc2@redhat.com>
References: <20231129093457.17984-1-tglozar@redhat.com> <20231129093457.17984-5-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 29 Nov 2023, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Instead of specifying an absolute list of CPUs to run measurements on
> in --measurement-cpulist, implement an option to specify a relative list
> with respect to the current cpuset of rteval.
> 
> The relative cpulist can include CPUs both for addition and for removal,
> e.g. +0,1,-7,8.
> 
> Also move the logic for processing cpulists specified by the user as
> a string into cpulists usable by rteval to a single function.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval-cmd                               | 26 +++++++-----
>  rteval/cpulist_utils.py                  | 33 ++++++++++++++++
>  rteval/modules/measurement/__init__.py   |  9 +----
>  rteval/modules/measurement/cyclictest.py | 50 +++---------------------
>  rteval/systopology.py                    | 33 ++++++++++++++++
>  5 files changed, 90 insertions(+), 61 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index 56b2c95..dd7d645 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -30,7 +30,7 @@ from rteval import RtEval, rtevalConfig
>  from rteval.modules.loads import LoadModules
>  from rteval.modules.measurement import MeasurementModules
>  from rteval.version import RTEVAL_VERSION
> -from rteval.systopology import SysTopology
> +from rteval.systopology import SysTopology, parse_cpulist_from_config
>  from rteval.modules.loads.kcompile import ModuleParameters
>  import rteval.cpulist_utils as cpulist_utils
>  
> @@ -336,26 +336,32 @@ if __name__ == '__main__':
>  
>          ldcfg = config.GetSection('loads')
>          msrcfg = config.GetSection('measurement')
> -        if ldcfg.cpulist and msrcfg.cpulist:
> +        msrcfg_cpulist_present = msrcfg.cpulist != ""
> +        # Parse measurement cpulist using parse_cpulist_from_config to account for run-on-isolcpus
> +        # and relative cpusets
> +        cpulist = parse_cpulist_from_config(msrcfg.cpulist, msrcfg.run_on_isolcpus)
> +        if msrcfg_cpulist_present and not cpulist_utils.is_relative(msrcfg.cpulist) and msrcfg.run_on_isolcpus:
> +            logger.log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
> +        msrcfg.cpulist = cpulist_utils.collapse_cpulist(cpulist)
> +        if ldcfg.cpulist:
>              ldcfg.cpulist = remove_offline(ldcfg.cpulist)
> -            msrcfg.cpulist = remove_offline(msrcfg.cpulist)
>          # if we only specified one set of cpus (loads or measurement)
>          # default the other to the inverse of the specified list
> -        if not ldcfg.cpulist and msrcfg.cpulist:
> +        if not ldcfg.cpulist and msrcfg_cpulist_present:
>              tmplist = cpulist_utils.expand_cpulist(msrcfg.cpulist)
>              tmplist = SysTopology().invert_cpulist(tmplist)
> -            ldcfg.cpulist = cpulist_utils.compress_cpulist(tmplist)
> -            msrcfg.cpulist = remove_offline(msrcfg.cpulist)
> -        if not msrcfg.cpulist and ldcfg.cpulist:
> +            tmplist = cpulist_utils.online_cpulist(tmplist)
> +            ldcfg.cpulist = cpulist_utils.collapse_cpulist(tmplist)
> +        if not msrcfg_cpulist_present and ldcfg.cpulist:
>              tmplist = cpulist_utils.expand_cpulist(ldcfg.cpulist)
>              tmplist = SysTopology().invert_cpulist(tmplist)
> -            msrcfg.cpulist = cpulist_utils.compress_cpulist(tmplist)
> -            ldcfg.cpulist = remove_offline(ldcfg.cpulist)
> +            tmplist = cpulist_utils.online_cpulist(tmplist)
> +            msrcfg.cpulist = cpulist_utils.collapse_cpulist(tmplist)
>  
>          if ldcfg.cpulist:
>              logger.log(Log.DEBUG, f"loads cpulist: {ldcfg.cpulist}")
>          # if --onlyload is specified msrcfg.cpulist is unused
> -        if msrcfg.cpulist and not rtevcfg.onlyload:
> +        if msrcfg_cpulist_present and not rtevcfg.onlyload:
>              logger.log(Log.DEBUG, f"measurement cpulist: {msrcfg.cpulist}")
>          logger.log(Log.DEBUG, f"workdir: {rtevcfg.workdir}")
>  
> diff --git a/rteval/cpulist_utils.py b/rteval/cpulist_utils.py
> index 402d579..7abc45a 100644
> --- a/rteval/cpulist_utils.py
> +++ b/rteval/cpulist_utils.py
> @@ -126,3 +126,36 @@ def nonisolated_cpulist(cpulist):
>      isolated_cpulist = sysread(cpupath, "isolated")
>      isolated_cpulist = expand_cpulist(isolated_cpulist)
>      return list(set(cpulist).difference(set(isolated_cpulist)))
> +
> +
> +def is_relative(cpulist):

a docstring here would be nice

> +    return cpulist.startswith("+") or cpulist.startswith("-")
> +
> +
> +def expand_relative_cpulist(cpulist):
> +    """
> +    Expand a relative cpulist into a tuple of lists.
> +    :param cpulist: Relative cpulist of form +1,2,3,-4,5,6
> +    :return: Tuple of two lists, one for added CPUs, one for removed CPUs
> +    """
> +    added_cpus = []
> +    removed_cpus = []
> +
> +    if not cpulist:
> +        return added_cpus, removed_cpus
> +
> +    cpus = None
> +
> +    for part in cpulist.split(','):
> +        if part.startswith('+') or part.startswith('-'):
> +            cpus = added_cpus if part[0] == '+' else removed_cpus
> +            part = part[1:]
> +        if '-' in part:
> +            a, b = part.split('-')
> +            a, b = int(a), int(b)
> +            cpus.extend(list(range(a, b + 1)))
> +        else:
> +            a = int(part)
> +            cpus.append(a)
> +
> +    return list(set(added_cpus)), list(set(removed_cpus))
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index 66dc9c5..11bd7b0 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -5,7 +5,7 @@
>  
>  import libxml2
>  from rteval.modules import RtEvalModules, ModuleContainer
> -from rteval.systopology import SysTopology as SysTop
> +from rteval.systopology import parse_cpulist_from_config
>  import rteval.cpulist_utils as cpulist_utils
>  
>  class MeasurementProfile(RtEvalModules):
> @@ -183,12 +183,7 @@ measurement profiles, based on their characteristics"""
>          rep_n = libxml2.newNode("Measurements")
>          cpulist = self.__cfg.GetSection("measurement").cpulist
>          run_on_isolcpus = self.__cfg.GetSection("measurement").run_on_isolcpus
> -        if cpulist:
> -            # Convert str to list and remove offline cpus
> -            cpulist = cpulist_utils.expand_cpulist(cpulist)
> -            cpulist = cpulist_utils.online_cpulist(cpulist)
> -        else:
> -            cpulist = SysTop().online_cpus() if run_on_isolcpus else SysTop().default_cpus()
> +        cpulist = parse_cpulist_from_config(cpulist, run_on_isolcpus)
>          rep_n.newProp("measurecpus", cpulist_utils.collapse_cpulist(cpulist))
>  
>          for mp in self.__measureprofiles:
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index dcfca0b..87fa9d8 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -16,8 +16,7 @@ import math
>  import libxml2
>  from rteval.Log import Log
>  from rteval.modules import rtevalModulePrototype
> -from rteval.systopology import cpuinfo
> -from rteval.systopology import SysTopology
> +from rteval.systopology import cpuinfo, parse_cpulist_from_config
>  import rteval.cpulist_utils as cpulist_utils
>  
>  
> @@ -192,39 +191,9 @@ class Cyclictest(rtevalModulePrototype):
>          self.__priority = int(self.__cfg.setdefault('priority', 95))
>          self.__buckets = int(self.__cfg.setdefault('buckets', 2000))
>          self.__numcores = 0
> -        self.__cpus = []
>          self.__cyclicdata = {}
> -        self.__sparse = False
> -        self.__run_on_isolcpus = bool(self.__cfg.setdefault('run-on-isolcpus', False))
> -
> -        if self.__cfg.cpulist:
> -            self.__cpulist = self.__cfg.cpulist
> -            self.__cpus = cpulist_utils.expand_cpulist(self.__cpulist)
> -            # Only include online cpus
> -            self.__cpus = cpulist_utils.online_cpulist(self.__cpus)
> -            # Reset cpulist from the newly calculated self.__cpus
> -            self.__cpulist = cpulist_utils.collapse_cpulist(self.__cpus)
> -            self.__cpus = [str(c) for c in self.__cpus]
> -            self.__sparse = True
> -            if self.__run_on_isolcpus:
> -                self._log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
> -        else:
> -            self.__cpus = SysTopology().online_cpus_str()
> -            # Get the cpuset from the environment
> -            cpuset = os.sched_getaffinity(0)
> -            # Convert the elements to strings
> -            cpuset = [str(c) for c in cpuset]
> -            # Get isolated CPU list
> -            isolcpus = [str(c) for c in SysTopology().isolated_cpus()]
> -            # Only include cpus that are in the cpuset and isolated CPUs if run_on_isolcpus is enabled
> -            self.__cpus = [c for c in self.__cpus if c in cpuset or self.__run_on_isolcpus and c in isolcpus]
> -            if self.__run_on_isolcpus:
> -                self.__sparse = True
> -                self.__cpulist = cpulist_utils.collapse_cpulist([int(c) for c in self.__cpus])
> -
> -        # Sort the list of cpus to align with the order reported by cyclictest
> -        self.__cpus.sort(key=int)
> -
> +        self.__cpulist = self.__cfg.cpulist
> +        self.__cpus = [str(c) for c in cpulist_utils.expand_cpulist(self.__cpulist)]
>          self.__numcores = len(self.__cpus)
>  
>          info = cpuinfo()
> @@ -241,10 +210,7 @@ class Cyclictest(rtevalModulePrototype):
>                                                logfnc=self._log)
>          self.__cyclicdata['system'].description = (f"({self.__numcores} cores) ") + info['0']['model name']
>  
> -        if self.__sparse:
> -            self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
> -        else:
> -            self._log(Log.DEBUG, f"system has {self.__numcores} cpu cores")
> +        self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
>          self.__started = False
>          self.__cyclicoutput = None
>          self.__breaktraceval = None
> @@ -279,12 +245,8 @@ class Cyclictest(rtevalModulePrototype):
>                        f'-h {self.__buckets}',
>                        f"-p{int(self.__priority)}",
>                        ]
> -        if self.__sparse:
> -            self.__cmd.append(f'-t{self.__numcores}')
> -            self.__cmd.append(f'-a{self.__cpulist}')
> -        else:
> -            self.__cmd.append('-t')
> -            self.__cmd.append('-a')
> +        self.__cmd.append(f'-t{self.__numcores}')
> +        self.__cmd.append(f'-a{self.__cpulist}')
>  
>          if 'threads' in self.__cfg and self.__cfg.threads:
>              self.__cmd.append(f"-t{int(self.__cfg.threads)}")
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index 9db1a80..40ac5ab 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -241,6 +241,39 @@ class SysTopology:
>          """ return a list of online cpus in cpulist """
>          return [c for c in self.online_cpus() if c in cpulist]
>  
> +
> +def parse_cpulist_from_config(cpulist, run_on_isolcpus=False):
> +    """
> +    Generates a cpulist based on --*-cpulist argument given by user
> +    :param cpulist: Value of --*-cpulist argument
> +    :param run_on_isolcpus: Value of --*-run-on-isolcpus argument
> +    :return: Sorted list of CPUs as integers
> +    """
> +    if cpulist and not cpulist_utils.is_relative(cpulist):
> +        result = cpulist_utils.expand_cpulist(cpulist)
> +        # Only include online cpus
> +        result = cpulist_utils.online_cpulist(result)
> +    else:
> +        result = SysTopology().online_cpus()
> +        # Get the cpuset from the environment
> +        cpuset = os.sched_getaffinity(0)
> +        # Get isolated CPU list
> +        isolcpus = SysTopology().isolated_cpus()
> +        if cpulist and cpulist_utils.is_relative(cpulist):
> +            # Include cpus that are not removed in relative cpuset and are either in cpuset from affinity,
> +            # isolcpus (with run_on_isolcpus enabled, or added by relative cpuset
> +            added_cpus, removed_cpus = cpulist_utils.expand_relative_cpulist(cpulist)
> +            result = [c for c in result
> +                      if (c in cpuset or
> +                          c in added_cpus or
> +                          run_on_isolcpus and c in isolcpus) and
> +                      c not in removed_cpus]
> +        else:
> +            # Only include cpus that are in the cpuset and isolated CPUs if run_on_isolcpus is enabled
> +            result = [c for c in result if c in cpuset or run_on_isolcpus and c in isolcpus]
> +    return result
> +
> +
>  if __name__ == "__main__":
>  
>      def unit_test():
> -- 
> 2.39.3
> 
> 
> 

This is the big pay off! I like this, just if you make changes to patch 3 
you might need to modify a few things here, about ready to sign-off on it.

John

