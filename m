Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16E76C61
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331170; cv=none; b=RCyN5fptC5ZHHzxaUUq98CW+RKymAcbyoOAZFO2yHvTcVsPIfHkMR/ouXTskMdlip/mqT+p/54UbFvO5c0TXbOPFBvwtpErJdjqEwo+G57mYzqG6By+kIUA38mPnvi4OyY7oRrXPntvCKJMpMR20fS8rGosioi81cYDy5ZWi9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331170; c=relaxed/simple;
	bh=ds1Ug1qyd+5qIANQOjzD6HsawRKuYHr9SnAwXh+zIRc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iEBwCTjqgYizJtV8vN+klwq99rlCMOsM1VvQvEgr1XPNHYDqqeqbkyDJjCUHNt+4tEvMdSXLVMib7RhdWuc0MLkH+863TuxDxiJY+7cyCb/bx3T8xDfGbp+pl6EfR5XApmWwiRmhIR0ulAGiKk7KZJ2R+LPGZVgtkjTa7I9E/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTjW5ehw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTjW5ehw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721331167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0Nc3ekc8rRWHiITi1paz5PDorluAg0+MpkhMTv70q8=;
	b=ZTjW5ehwkvmwVR+eV52BxqdEVXnzYyDk1sIyswnoxmLN2hdFzpGTha9WCQ3SAcq++qpDQW
	MzNFEF/bX2kvOwzaJRH5LiWTuTXeEMV6c29DMH+L/c35FW5lxHuiWPtNpMDbuCqih5KkBi
	nqKrNE1vNZ1rpD11OCDlqfy1zujAVYc=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-WjkkeF4UP06V5moqM2B4xQ-1; Thu, 18 Jul 2024 15:32:45 -0400
X-MC-Unique: WjkkeF4UP06V5moqM2B4xQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-664b7a67ad4so30146007b3.2
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 12:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721331165; x=1721935965;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0Nc3ekc8rRWHiITi1paz5PDorluAg0+MpkhMTv70q8=;
        b=F+XK8kTAkSPto3OGXBXLPIwxJ7uWBdKoA9cVmZgr38dzIhCocGvYKgwvve8f8jqPnX
         nKwGmJYIH/dDyVgnX/GkjrCAyYkc1E8NJierhAMC6iRkgdCczy24l0vb0sXCGwPThQcF
         JPRYceLChpmQbpxN6TEj+BIFE8WXnYs5a0tWQA0gLrnCTNtkdLrtWngvF40u1qXTLk9P
         chk2vTyTL7ocHsp27RADFvQmESFbJlcPVjAQ/fvezoW47lgnkgDN/QfWbCm/aF0QwePC
         XyhVZhews9f4Yo/V82uEMWvebmxX/bx9qTt4tnuH7D2Cd/rCx++6Sp/7Yz3XEa1QycP1
         fZIg==
X-Forwarded-Encrypted: i=1; AJvYcCWuyk/4V9p4XT2SLFTD1U2BYr+p5PcNRurEl8evS1sqLPZY6jNHoPQNjsgUNhwv1UzQH9bFffb+C62kPmQ/5f/BtcHEusG4z16MPjh/75w=
X-Gm-Message-State: AOJu0YzVZeFK4SDeH3mFaOuOIuqNQ2LwT7TVZmY8HEUMoP+lzlETCwXJ
	fWMp5RKMpciwqwmRNDxqze6OVR7u7MC5smONVIGpau+3RcAeq9fmd0ooTbDSYr/a4ERvscQMPFd
	uT3bZm1moe0u3HXyGJyVzAa3436QC2s1dWOqYxd4iT03IyFkBUO1/9BNkzZMv64KpY+Bfhx4C
X-Received: by 2002:a05:690c:dce:b0:64a:3e36:7fd1 with SMTP id 00721157ae682-66601ccbfb0mr55200317b3.10.1721331165058;
        Thu, 18 Jul 2024 12:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYQ7+BQF1L3EAconKqvzSfWvYe/ZcBMPBKx/shT7HgxnxiUSxf5w7DMvZdV2HVeKxwDJZ+/Q==
X-Received: by 2002:a05:690c:dce:b0:64a:3e36:7fd1 with SMTP id 00721157ae682-66601ccbfb0mr55199997b3.10.1721331164688;
        Thu, 18 Jul 2024 12:32:44 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f969aae98sm5699941cf.6.2024.07.18.12.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:32:44 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:32:43 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/4] rteval: measurement: Remove ModuleInfo()
In-Reply-To: <20240621022417.2086751-2-crwood@redhat.com>
Message-ID: <acf0b9ad-1e07-5392-bd93-f41933889d72@redhat.com>
References: <20240621022417.2086751-1-crwood@redhat.com> <20240621022417.2086751-2-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Jun 2024, Crystal Wood wrote:

> All of the measurement modules have identical settings, and the use cases
> for deviating seem questionable.  While we do have a desire to keep
> cyclictest and timerlat from running together, turning off run_parallel
> would prevent sysstat from running at the same time.  And if there's a
> desire to run without loads, that seems like it belongs in the realm of
> user configuration, rather than anything inherent to a given measurement
> module.
> 
> Any future module flags can be implemented similarly to what is done
> in load modules (e.g. set_exclusive).
> 
> Places that checked with_loads now check whether a LoadModules container
> is present at all, which can be wired up to a command line option in the
> future.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval/__init__.py                       | 39 ++++++-------
>  rteval/modules/__init__.py               | 13 +----
>  rteval/modules/measurement/__init__.py   | 73 ++----------------------
>  rteval/modules/measurement/cyclictest.py |  5 --
>  rteval/modules/measurement/sysstat.py    |  7 ---
>  rteval/modules/measurement/timerlat.py   |  5 --
>  6 files changed, 26 insertions(+), 116 deletions(-)
> 
> diff --git a/rteval/__init__.py b/rteval/__init__.py
> index 1a61148ef327..4a6883e28e5b 100644
> --- a/rteval/__init__.py
> +++ b/rteval/__init__.py
> @@ -111,20 +111,21 @@ class RtEval(rtevalReport):
>          except Exception as err:
>              raise RuntimeError(f"Cannot create report directory (NFS with rootsquash on?) [{err}]]")
>  
> -        self.__logger.log(Log.INFO, "Preparing load modules")
> -        params = {'workdir':self.__rtevcfg.workdir,
> -                  'reportdir':self.__reportdir and self.__reportdir or "",
> -                  'builddir':builddir,
> -                  'srcdir':self.__rtevcfg.srcdir,
> -                  'verbose': self.__rtevcfg.verbose,
> -                  'debugging': self.__rtevcfg.debugging,
> -                  'numcores':self._sysinfo.cpu_getCores(True),
> -                  'logging':self.__rtevcfg.logging,
> -                  'memsize':self._sysinfo.mem_get_size(),
> -                  'numanodes':self._sysinfo.mem_get_numa_nodes(),
> -                  'duration': float(self.__rtevcfg.duration),
> -                  }
> -        self._loadmods.Setup(params)
> +        if self._loadmods:
> +            self.__logger.log(Log.INFO, "Preparing load modules")
> +            params = {'workdir':self.__rtevcfg.workdir,
> +                      'reportdir':self.__reportdir and self.__reportdir or "",
> +                      'builddir':builddir,
> +                      'srcdir':self.__rtevcfg.srcdir,
> +                      'verbose': self.__rtevcfg.verbose,
> +                      'debugging': self.__rtevcfg.debugging,
> +                      'numcores':self._sysinfo.cpu_getCores(True),
> +                      'logging':self.__rtevcfg.logging,
> +                      'memsize':self._sysinfo.mem_get_size(),
> +                      'numanodes':self._sysinfo.mem_get_numa_nodes(),
> +                      'duration': float(self.__rtevcfg.duration),
> +                      }
> +            self._loadmods.Setup(params)
>  
>          self.__logger.log(Log.INFO, "Preparing measurement modules")
>          self._measuremods.Setup(params)
> @@ -136,13 +137,11 @@ class RtEval(rtevalReport):
>              raise Exception("measure_profile is not an MeasurementProfile object")
>  
>          measure_start = None
> -        (with_loads, run_parallel) = measure_profile.GetProfile()
> -        self.__logger.log(Log.INFO, f"Using measurement profile [loads: {with_loads}  parallel: {run_parallel}]")
>          try:
>              nthreads = 0
>  
>              # start the loads
> -            if with_loads:
> +            if self._loadmods:
>                  self._loadmods.Start()
>  
>              print(f"rteval run on {os.uname()[2]} started at {time.asctime()}")
> @@ -168,7 +167,7 @@ class RtEval(rtevalReport):
>  
>              # Unleash the loads and measurement threads
>              report_interval = int(self.__rtevcfg.report_interval)
> -            if with_loads:
> +            if self._loadmods:
>                  self._loadmods.Unleash()
>                  nthreads = threading.active_count()
>              else:
> @@ -192,7 +191,7 @@ class RtEval(rtevalReport):
>                      self.__logger.log(Log.WARN,
>                                        "Measurement threads did not use the full time slot. Doing a controlled stop.")
>  
> -                if with_loads:
> +                if nthreads:
>                      if threading.active_count() < nthreads:
>                          raise RuntimeError("load thread died!")
>  
> @@ -222,7 +221,7 @@ class RtEval(rtevalReport):
>              measure_profile.Stop()
>  
>              # stop the loads
> -            if with_loads:
> +            if self._loadmods:
>                  self._loadmods.Stop()
>  
>          print(f"stopping run at {time.asctime()}")
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index 4330a839db6f..0c0ce7202f77 100644
> --- a/rteval/modules/__init__.py
> +++ b/rteval/modules/__init__.py
> @@ -269,14 +269,6 @@ reference from the first import"""
>              return mod
>  
>  
> -    def ModuleInfo(self, modname, modroot=None):
> -        """Imports a module and calls the modules' ModuleInfo() function and returns
> -the information provided by the module"""
> -
> -        mod = self.LoadModule(modname, modroot)
> -        return mod.ModuleInfo()
> -
> -
>      def SetupModuleOptions(self, parser, config):
>          """Sets up a separate argparse ArgumentGroup per module with its supported parameters"""
>  
> @@ -495,9 +487,8 @@ class RtEvalModules:
>  
>  
>      def Unleash(self):
> -        """Unleashes all the loaded modules workloads"""
> +        """Unleashes all the loaded modules"""
>  
> -        # turn loose the loads
>          nthreads = 0
>          self._logger.log(Log.INFO, f"Sending start event to all {self._module_type} modules")
>          for (modname, mod) in self.__modules:
> @@ -508,7 +499,7 @@ class RtEvalModules:
>          return nthreads
>  
>  
> -    def _isAlive(self):
> +    def isAlive(self):
>          """Returns True if all modules are running"""
>  
>          for (modname, mod) in self.__modules:
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index 43c0fda30ce1..7b1d84ef554d 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -11,24 +11,13 @@ import rteval.cpulist_utils as cpulist_utils
>  class MeasurementProfile(RtEvalModules):
>      """Keeps and controls all the measurement modules with the same measurement profile"""
>  
> -    def __init__(self, config, with_load, run_parallel, modules_root, logger):
> -        self.__with_load = with_load
> -        self.__run_parallel = run_parallel
> -
> -        # Only used when running modules serialised
> -        self.__run_serialised_mods = None
> -
> +    def __init__(self, config, modules_root, logger):
>          self._module_type = "measurement"
>          self._module_config = "measurement"
>          self._report_tag = "Profile"
>          RtEvalModules.__init__(self, config, modules_root, logger)
>  
>  
> -    def GetProfile(self):
> -        "Returns the profile characteristic as (with_load, run_parallel)"
> -        return (self.__with_load, self.__run_parallel)
> -
> -
>      def ImportModule(self, module):
>          "Imports an exported module from a ModuleContainer() class"
>          return self._ImportModule(module)
> @@ -41,54 +30,6 @@ class MeasurementProfile(RtEvalModules):
>          self._RegisterModuleObject(modname, modobj)
>  
>  
> -    def Unleash(self):
> -        """Unleashes all the measurement modules"""
> -
> -        if self.__run_parallel:
> -            # Use the inherrited method if running
> -            # measurements in parallel
> -            return RtEvalModules.Unleash(self)
> -
> -        # Get a list of all registered modules,
> -        # and start the first one
> -        self.__serialised_mods = self.GetModulesList()
> -        mod = self.GetNamedModuleObject(self.__serialised_mods[0])
> -        mod.setStart()
> -        return 1
> -
> -
> -    def MakeReport(self):
> -        "Generates an XML report for all run measurement modules in this profile"
> -        rep_n = RtEvalModules.MakeReport(self)
> -        rep_n.newProp("loads", self.__with_load and "1" or "0")
> -        rep_n.newProp("parallel", self.__run_parallel and "1" or "0")
> -        return rep_n
> -
> -
> -    def isAlive(self):
> -        """Returns True if all modules which are supposed to run runs"""
> -
> -        if self.__run_parallel:
> -            return self._isAlive()
> -
> -        if self.__serialised_mods:
> -            # If running serialised, first check if measurement is still running,
> -            # if so - return True.
> -            mod = self.GetNamedModuleObject(self.__serialised_mods[0])
> -            if mod.WorkloadAlive():
> -                return True
> -
> -            # If not, go to next on the list and kick it off
> -            self.__serialised_mods.remove(self.__serialised_mods[0])
> -            if self.__serialised_mods:
> -                mod = self.GetNamedModuleObject(self.__serialised_mods[0])
> -                mod.setStart()
> -                return True
> -
> -        # If we've been through everything, nothing is running
> -        return False
> -
> -
>  class MeasurementModules:
>      """Class which takes care of all measurement modules and groups them into
>  measurement profiles, based on their characteristics"""
> @@ -116,13 +57,11 @@ measurement profiles, based on their characteristics"""
>                  self.__container.LoadModule(m[0])
>  
>  
> -    def GetProfile(self, with_load, run_parallel):
> +    def GetProfile(self):
>          "Returns the appropriate MeasurementProfile object, based on the profile type"
>  
>          for p in self.__measureprofiles:
> -            mp = p.GetProfile()
> -            if mp == (with_load, run_parallel):
> -                return p
> +            return p
>          return None
>  
>  
> @@ -154,15 +93,13 @@ measurement profiles, based on their characteristics"""
>  
>          for (modname, modtype) in modcfg:
>              if isinstance(modtype, str) and modtype.lower() == 'module':  # Only 'module' will be supported (ds)
> -                # Extract the measurement modules info
> -                modinfo = self.__container.ModuleInfo(modname)
> +                self.__container.LoadModule(modname)
>  
>                  # Get the correct measurement profile container for this module
> -                mp = self.GetProfile(modinfo["loads"], modinfo["parallel"])
> +                mp = self.GetProfile()
>                  if mp is None:
>                      # If not found, create a new measurement profile
>                      mp = MeasurementProfile(self.__cfg,
> -                                            modinfo["loads"], modinfo["parallel"],
>                                              self.__modules_root, self.__logger)
>                      self.__measureprofiles.append(mp)
>  
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index 3301e1b45e11..3a34c1b988d6 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -394,11 +394,6 @@ class Cyclictest(rtevalModulePrototype):
>          return rep_n
>  
>  
> -def ModuleInfo():
> -    return {"parallel": True,
> -            "loads": True}
> -
> -
>  def ModuleParameters():
>      """ default parameters """
>      return {"interval": {"descr": "Base interval of the threads in microseconds",
> diff --git a/rteval/modules/measurement/sysstat.py b/rteval/modules/measurement/sysstat.py
> index d4646c1646f4..a0efd8953659 100644
> --- a/rteval/modules/measurement/sysstat.py
> +++ b/rteval/modules/measurement/sysstat.py
> @@ -93,13 +93,6 @@ class sysstat(rtevalModulePrototype):
>  
>  
>  
> -def ModuleInfo():
> -    # sysstat features - run in parallel with outher measurement modules with loads
> -    return {"parallel": True,
> -            "loads": True}
> -
> -
> -
>  def ModuleParameters():
>      return {}  # No arguments available
>  
> diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
> index e8345fab1ad7..19dd30732936 100644
> --- a/rteval/modules/measurement/timerlat.py
> +++ b/rteval/modules/measurement/timerlat.py
> @@ -329,11 +329,6 @@ class Timerlat(rtevalModulePrototype):
>          return rep_n
>  
>  
> -def ModuleInfo():
> -    """ Required measurement module information """
> -    return {"parallel": True,
> -            "loads": True}
> -
>  def ModuleParameters():
>      """ default parameters """
>      return {"priority": {"descr": "Run rtla timerlat with this priority",
> -- 
> 2.45.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

