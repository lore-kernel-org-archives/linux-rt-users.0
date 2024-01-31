Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063112CDBE
	for <linux-rt-users@vger.kernel.org>; Wed, 31 Jan 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720797; cv=none; b=NQjmhtFNnhSph5rjsF5niHACMz+gzs63Bnrcq2N128TRcXGoxTNnhXIpDP2LZ7VkUhKeldJayrGI/090w3YHKl/s4nCB6eoZXg1oea2KOPv4i/Mf5oOBUl3f0Fzxc/PuDo6oCGsQj80GXsHZx3NzXQPQxz69D6K4OULbJQ36yRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720797; c=relaxed/simple;
	bh=GOSiEGuKouwVpnNkIrtzh8lhbaY82Ct8SL35xYIE1KM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S0EuqsuTZLg8fEZ9tQOIcpLU74vMdHbw9yguWXz+QlUz20xRGWqTkGkFWW+zCjkEgk99mfG41ET89XeAaDzI4ckm4yi42Nk4qyzYL0oNgJnO8JAf5dVzgn8nYKy1UuWC4/bsG8yODoC10zDjhsUG4Bl3D0VX248IJYt4/PbeFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJLI1QyF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJLI1QyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706720794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YIE8X6r8aEJr9UJ2oK1zk59s4TJNJ9MeseID2vsWBHs=;
	b=GJLI1QyFz4wm058if4MjupR/g7i2rR1N1D1RAdGG3Xg6cfevXkLOMuzC2yPVdn8aY5iAbL
	EgvffazYQuKLkyScbynFA58sfaOvYis7YeVL6nvrwxqkWVh8jQ9jPk58Mnevn79FKJ6HrL
	Br9Ij5l1HH5HWqQ3BS62yIri9IH/Qu0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-eLEzpQRgP_ua3FRiAgVVAA-1; Wed, 31 Jan 2024 12:06:25 -0500
X-MC-Unique: eLEzpQRgP_ua3FRiAgVVAA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78319f64126so3957985a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Jan 2024 09:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706720779; x=1707325579;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIE8X6r8aEJr9UJ2oK1zk59s4TJNJ9MeseID2vsWBHs=;
        b=qGWuqe1twBAqm7CnxX1cw1McgjykecDLYEVNJ6gGhexcKNjMnb9hRAu34WEhhAInPu
         WcJBpqPiZMymLXFbOPOL6Te5Ie6eI6UTG1MRwdW+dTJR/FW+zmCzCA/0iakVvguQmNZ3
         Yxy1G2+N12N3KkDrNzqTrFxoCZBVZxbG92PjodJ7QdgzeMReKPJfouZdVAwQqknSGaTr
         b09gtyxD/6reHKlg1GX4vJsDFd5ovdCXtLAVAWq/vqBN0ZujVT2J8kHPsH4BXuwoTiHD
         hmy44n+LLwxVtzVyGJyktP0qCqoPOn99/JkZK3rjMoqLZFp7lrAAVG4Wsq76KZfa2hjI
         4nIA==
X-Gm-Message-State: AOJu0YwwMp264+iv0qHodeowpfkpcNLMOWag3JT5/7SUreMyI2hLhKXe
	uXNWbUorKgWdNHGqQoCWsnLVsdlVB/yFimntegYJ2ay6eTkslUhywSC7xkQh082GgFPo5IeRrJW
	ZbEAZQm+uHBoj9Zobq61PLj27KMneznibg0RnN/Cc5l6YjiZ8yMhdD+zPwUWDxovp
X-Received: by 2002:a05:620a:2908:b0:783:cdd0:2186 with SMTP id m8-20020a05620a290800b00783cdd02186mr6322qkp.23.1706720778855;
        Wed, 31 Jan 2024 09:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzupdqk6Cfd4V3G94fiXdFQjdgxrqkRwFGSEyh3yFtlZhFxvTB/kG12M+k6wrisw04uJao8Q==
X-Received: by 2002:a05:620a:2908:b0:783:cdd0:2186 with SMTP id m8-20020a05620a290800b00783cdd02186mr6287qkp.23.1706720778486;
        Wed, 31 Jan 2024 09:06:18 -0800 (PST)
Received: from fionn ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id ou8-20020a05620a620800b00783fc26a5c8sm2897293qkn.2.2024.01.31.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:06:18 -0800 (PST)
Date: Wed, 31 Jan 2024 12:06:09 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rteval: Add relative cpulists for measurements
In-Reply-To: <20240118091810.127396-3-tglozar@redhat.com>
Message-ID: <6decaa1f-2c6e-e854-4867-9c43b0da1046@redhat.com>
References: <20240118091810.127396-1-tglozar@redhat.com> <20240118091810.127396-3-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 18 Jan 2024, tglozar@redhat.com wrote:

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
> index d224728..a5e8746 100755
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
> @@ -339,26 +339,32 @@ if __name__ == '__main__':
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
> +        msrcfg.cpulist = collapse_cpulist(cpulist)
> +        if ldcfg.cpulist:
>              ldcfg.cpulist = remove_offline(ldcfg.cpulist)
> -            msrcfg.cpulist = remove_offline(msrcfg.cpulist)
>          # if we only specified one set of cpus (loads or measurement)
>          # default the other to the inverse of the specified list
> -        if not ldcfg.cpulist and msrcfg.cpulist:
> +        if not ldcfg.cpulist and msrcfg_cpulist_present:
>              tmplist = expand_cpulist(msrcfg.cpulist)
>              tmplist = SysTopology().invert_cpulist(tmplist)
> -            ldcfg.cpulist = compress_cpulist(tmplist)
> -            msrcfg.cpulist = remove_offline(msrcfg.cpulist)
> -        if not msrcfg.cpulist and ldcfg.cpulist:
> +            tmplist = cpulist_utils.online_cpulist(tmplist)
> +            ldcfg.cpulist = collapse_cpulist(tmplist)
> +        if not msrcfg_cpulist_present and ldcfg.cpulist:
>              tmplist = expand_cpulist(ldcfg.cpulist)
>              tmplist = SysTopology().invert_cpulist(tmplist)
> -            msrcfg.cpulist = compress_cpulist(tmplist)
> -            ldcfg.cpulist = remove_offline(ldcfg.cpulist)
> +            tmplist = cpulist_utils.online_cpulist(tmplist)
> +            msrcfg.cpulist = collapse_cpulist(tmplist)
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
> index fdca257..7224225 100644
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
>  expand_cpulist = cpulist_utils.expand_cpulist
> @@ -193,39 +192,9 @@ class Cyclictest(rtevalModulePrototype):
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
> -            self.__cpus = expand_cpulist(self.__cpulist)
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
> +        self.__cpus = [str(c) for c in expand_cpulist(self.__cpulist)]
>          self.__numcores = len(self.__cpus)
>  
>          info = cpuinfo()
> @@ -242,10 +211,7 @@ class Cyclictest(rtevalModulePrototype):
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
> @@ -280,12 +246,8 @@ class Cyclictest(rtevalModulePrototype):
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
> index 9e45762..6bcfc77 100644
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

Signed-off-by: John Kacur <jkacur@redhat.com>

