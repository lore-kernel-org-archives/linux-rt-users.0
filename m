Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763676C61
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331386; cv=none; b=a9WSaRmvCgA8gSrfHkFIwjJozkq471rQoB35ccb+nUSc6mWdX979mRnvy3gKp+owgcTBX++D9dV2++9F756ss3+8z90G+s0YGCv4En3GybjpcGBGo/CfPLIh5pjMGrAJ1a2HsIG7Np3jDCzTrhnzktRQBfaTPxoGKri4F+dYTIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331386; c=relaxed/simple;
	bh=EATp4bNZCMhdVjXGhy3A2cil0803xuU4e5Ny9ZUL+OE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MdRYhArse70oN/Wzepewse87WRgX/H4q8Rw+dgTZ7n0FgKru6/DylQ2iyNaBMPiHo3ZthkNAa8LGuoJbRQNW22wS8oTnp8IO1tUYpu3aFVR/5GWxtyi7XkJJE4/QhSkm0vgTJb3o/1hruasR7qwaHVyFVLovC5uqtA15gv51ULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONmAvaTP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONmAvaTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721331382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSrWKpT7PW9XMgq8m0D2QIPnDzwHJYCBS7jJu3C6RNQ=;
	b=ONmAvaTPgfPyhyYSJyvL8oW6tVZhh+r78B98XX+Q4nt6HMyEMiGsWESSUMFwBI7/Y2IYYQ
	dXrCKPbv4/N8b2eSRLb5dSMf1xNclrH+bIdrXKOdqOV1BvNgCPPeGbSaafbekHTR+rfCQ+
	JsFIe3Nw3JhHBBzv5gJBueBbXgEJNPk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-lhAmbYxMMPKAi27wXulVfQ-1; Thu, 18 Jul 2024 15:36:20 -0400
X-MC-Unique: lhAmbYxMMPKAi27wXulVfQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b75e880a12so20595816d6.3
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 12:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721331379; x=1721936179;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSrWKpT7PW9XMgq8m0D2QIPnDzwHJYCBS7jJu3C6RNQ=;
        b=KUJ88ryh6petrc8rFkpXpFOMfOlhjy5vJN90hTu2b2CwUSrUBCw/KEBE04GTZFyheg
         3dtz/kEG0wcD1UFdEipBXf79fUxmt1liAG+sJg7Uocp7f5U0dmfokm995lmkD8K5WiK1
         FBai/+gMeMx8eYnuyKWVPQBotEv8VEJiFjxtyOrlAJfkUnK0l65DZzuvtC7YxLsSAg75
         ZVwJ3zc9FhbQkUtDnJRvCVxrg/mol5sx5bVnpd0rN8ZTnarGLKIvaiIWBDaEccsJkFD3
         uycb1LeVO0g/C63r8Aw2DKwl64w4g6ZpSBfaz2r9BoTQEUv5KMnJ3UfcrTE5pQSm2Apy
         JNcw==
X-Forwarded-Encrypted: i=1; AJvYcCUQsvlS3ihwih53miFjWXMNXr+awW1GsLPtuwEY5t+sM6Gw0etswXyl6okJ9O7jL6NJ+lP/B2IvdeMSp0O7Qt4N01H5g6ShwwKJpPY4zDo=
X-Gm-Message-State: AOJu0YzcJQmRjJlk8EtgUSRSXUD7/+hN/objit/Ve3s7lfihFt8tXMNx
	g+hFuATXT7KmoJ4q/p2dcONymFeZxhsF/vbiD99XBwXDyLANDswD4F4TPPyCtma7E2rgzOImEw2
	fWALSpAAP3Pc1zl3xCgN4Hq8l8mtzhf9Uq4p6QlS/iQkc99AbLYz87k0LaAL/xk2esHzR1PCk
X-Received: by 2002:a05:6214:130a:b0:6b2:b11b:c326 with SMTP id 6a1803df08f44-6b78e2ca384mr56040526d6.48.1721331378852;
        Thu, 18 Jul 2024 12:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGfK2u4bLItS8JNqZDUhYlZgfhP49rJcXvambsU60yD4ByzMLWWIVEx99xwlEE/Eh0B+pQXQ==
X-Received: by 2002:a05:6214:130a:b0:6b2:b11b:c326 with SMTP id 6a1803df08f44-6b78e2ca384mr56040316d6.48.1721331378393;
        Thu, 18 Jul 2024 12:36:18 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7a89ee277sm2204926d6.122.2024.07.18.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:36:18 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:36:16 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/4] rteval: Remove MeasurementProfile
In-Reply-To: <20240621022417.2086751-3-crwood@redhat.com>
Message-ID: <f1fa7e0a-2e06-a7a0-f0de-7a2a3a5a96ba@redhat.com>
References: <20240621022417.2086751-1-crwood@redhat.com> <20240621022417.2086751-3-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Jun 2024, Crystal Wood wrote:

> Now that the ModuleInfo() flags are gone, remove the remaining infrastructure
> around measurement profiles.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval/__init__.py                     |  25 ++----
>  rteval/modules/measurement/__init__.py | 117 ++++---------------------
>  rteval/rteval_histogram_raw.xsl        |  24 ++---
>  rteval/rteval_text.xsl                 |  41 +++------
>  4 files changed, 54 insertions(+), 153 deletions(-)
> 
> diff --git a/rteval/__init__.py b/rteval/__init__.py
> index 4a6883e28e5b..226d14f80f48 100644
> --- a/rteval/__init__.py
> +++ b/rteval/__init__.py
> @@ -20,7 +20,7 @@ import time
>  from datetime import datetime
>  import sysconfig
>  from rteval.modules.loads import LoadModules
> -from rteval.modules.measurement import MeasurementModules, MeasurementProfile
> +from rteval.modules.measurement import MeasurementModules
>  from rteval.rtevalReport import rtevalReport
>  from rteval.Log import Log
>  from rteval import rtevalConfig
> @@ -131,10 +131,8 @@ class RtEval(rtevalReport):
>          self._measuremods.Setup(params)
>  
>  
> -    def __RunMeasurementProfile(self, measure_profile):
> +    def __RunMeasurement(self):
>          global earlystop
> -        if not isinstance(measure_profile, MeasurementProfile):
> -            raise Exception("measure_profile is not an MeasurementProfile object")
>  
>          measure_start = None
>          try:
> @@ -155,15 +153,14 @@ class RtEval(rtevalReport):
>                  print(f" with {self._sysinfo.mem_get_numa_nodes()} numa nodes")
>              else:
>                  print("")
> -            cpulist = self._measuremods._MeasurementModules__cfg.GetSection("measurement").cpulist
> +            cpulist = self._measuremods._cfg.GetSection("measurement").cpulist
>              if cpulist:
>                  print(f"started measurement threads on cores {cpulist}")
>              else:
>                  print(f"started measurement threads on {onlinecpus} cores")
>              print(f"Run duration: {str(self.__rtevcfg.duration)} seconds")
>  
> -            # start the cyclictest thread
> -            measure_profile.Start()
> +            self._measuremods.Start()
>  
>              # Unleash the loads and measurement threads
>              report_interval = int(self.__rtevcfg.report_interval)
> @@ -172,7 +169,7 @@ class RtEval(rtevalReport):
>                  nthreads = threading.active_count()
>              else:
>                  nthreads = None
> -            measure_profile.Unleash()
> +            self._measuremods.Unleash()
>              measure_start = datetime.now()
>  
>              # wait for time to expire or thread to die
> @@ -185,7 +182,7 @@ class RtEval(rtevalReport):
>              load_avg_checked = 5
>              while (currtime <= stoptime) and not stopsig.is_set():
>                  stopsig.wait(min(stoptime - currtime, 60.0))
> -                if not measure_profile.isAlive():
> +                if not self._measuremods.isAlive():
>                      stoptime = currtime
>                      earlystop = True
>                      self.__logger.log(Log.WARN,
> @@ -218,7 +215,7 @@ class RtEval(rtevalReport):
>  
>          finally:
>              # stop measurement threads
> -            measure_profile.Stop()
> +            self._measuremods.Stop()
>  
>              # stop the loads
>              if self._loadmods:
> @@ -227,7 +224,7 @@ class RtEval(rtevalReport):
>          print(f"stopping run at {time.asctime()}")
>  
>          # wait for measurement modules to finish calculating stats
> -        measure_profile.WaitForCompletion()
> +        self._measuremods.WaitForCompletion()
>  
>          return measure_start
>  
> @@ -236,11 +233,7 @@ class RtEval(rtevalReport):
>          """ Run the full measurement suite with reports """
>          global earlystop
>          rtevalres = 0
> -        measure_start = None
> -        for meas_prf in self._measuremods:
> -            mstart = self.__RunMeasurementProfile(meas_prf)
> -            if measure_start is None:
> -                measure_start = mstart
> +        measure_start = self.__RunMeasurement()
>  
>          self._report(measure_start, self.__rtevcfg.xslt_report)
>          if self.__rtevcfg.sysreport:
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index 7b1d84ef554d..ecadd0885991 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -8,43 +8,14 @@ from rteval.modules import RtEvalModules, ModuleContainer
>  from rteval.systopology import parse_cpulist_from_config
>  import rteval.cpulist_utils as cpulist_utils
>  
> -class MeasurementProfile(RtEvalModules):
> -    """Keeps and controls all the measurement modules with the same measurement profile"""
> -
> -    def __init__(self, config, modules_root, logger):
> -        self._module_type = "measurement"
> -        self._module_config = "measurement"
> -        self._report_tag = "Profile"
> -        RtEvalModules.__init__(self, config, modules_root, logger)
> -
> -
> -    def ImportModule(self, module):
> -        "Imports an exported module from a ModuleContainer() class"
> -        return self._ImportModule(module)
> -
> -
> -    def Setup(self, modname):
> -        "Instantiates and prepares a measurement module"
> -
> -        modobj = self._InstantiateModule(modname, self._cfg.GetSection(modname))
> -        self._RegisterModuleObject(modname, modobj)
> -
> -
> -class MeasurementModules:
> -    """Class which takes care of all measurement modules and groups them into
> -measurement profiles, based on their characteristics"""
> +class MeasurementModules(RtEvalModules):
> +    """Module container for measurement modules"""
>  
>      def __init__(self, config, logger):
> -        self.__cfg = config
> -        self.__logger = logger
> -        self.__measureprofiles = []
> -        self.__modules_root = "modules.measurement"
> -        self.__iter_item = None
> -
> -        # Temporary module container, which is used to evalute measurement modules.
> -        # This will container will be destroyed after Setup() has been called
> -        self.__container = ModuleContainer(self.__modules_root, self.__logger)
> -        self.__LoadModules(self.__cfg.GetSection("measurement"))
> +        self._module_type = "measurement"
> +        self._report_tag = "Measurements"
> +        RtEvalModules.__init__(self, config, "modules.measurement", logger)
> +        self.__LoadModules(self._cfg.GetSection("measurement"))
>  
>  
>      def __LoadModules(self, modcfg):
> @@ -54,37 +25,28 @@ measurement profiles, based on their characteristics"""
>              # hope to eventually have different kinds but module is only on
>              # for now (jcw)
>              if m[1].lower() == 'module':
> -                self.__container.LoadModule(m[0])
> -
> -
> -    def GetProfile(self):
> -        "Returns the appropriate MeasurementProfile object, based on the profile type"
> -
> -        for p in self.__measureprofiles:
> -            return p
> -        return None
> -
> +                self._LoadModule(m[0])
>  
>      def SetupModuleOptions(self, parser):
>          "Sets up all the measurement modules' parameters for the option parser"
> -        grparser = self.__container.SetupModuleOptions(parser, self.__cfg)
> +        grparser = super().SetupModuleOptions(parser)
>  
>          # Set up options specific for measurement module group
>          grparser.add_argument("--measurement-run-on-isolcpus",
>                                dest="measurement___run_on_isolcpus",
>                                action="store_true",
> -                              default=self.__cfg.GetSection("measurement").setdefault("run-on-isolcpus", "false").lower()
> +                              default=self._cfg.GetSection("measurement").setdefault("run-on-isolcpus", "false").lower()
>                                        == "true",
>                                help="Include isolated CPUs in default cpulist")
>  
>  
>      def Setup(self, modparams):
> -        "Loads all measurement modules and group them into different measurement profiles"
> +        "Loads all measurement modules"
>  
>          if not isinstance(modparams, dict):
>              raise TypeError("modparams attribute is not of a dictionary type")
>  
> -        modcfg = self.__cfg.GetSection("measurement")
> +        modcfg = self._cfg.GetSection("measurement")
>          cpulist = modcfg.cpulist
>          run_on_isolcpus = modcfg.run_on_isolcpus
>          if cpulist is None:
> @@ -93,61 +55,20 @@ measurement profiles, based on their characteristics"""
>  
>          for (modname, modtype) in modcfg:
>              if isinstance(modtype, str) and modtype.lower() == 'module':  # Only 'module' will be supported (ds)
> -                self.__container.LoadModule(modname)
> -
> -                # Get the correct measurement profile container for this module
> -                mp = self.GetProfile()
> -                if mp is None:
> -                    # If not found, create a new measurement profile
> -                    mp = MeasurementProfile(self.__cfg,
> -                                            self.__modules_root, self.__logger)
> -                    self.__measureprofiles.append(mp)
> -
> -                    # Export the module imported here and transfer it to the
> -                    # measurement profile
> -                    mp.ImportModule(self.__container.ExportModule(modname))
> +                self._cfg.AppendConfig(modname, modparams)
> +                self._cfg.AppendConfig(modname, {'cpulist':cpulist})
> +                self._cfg.AppendConfig(modname, {'run-on-isolcpus':run_on_isolcpus})
>  
> -                # Setup this imported module inside the appropriate measurement profile
> -                self.__cfg.AppendConfig(modname, modparams)
> -                self.__cfg.AppendConfig(modname, {'cpulist':cpulist})
> -                self.__cfg.AppendConfig(modname, {'run-on-isolcpus':run_on_isolcpus})
> -                mp.Setup(modname)
> -
> -        del self.__container
> +                modobj = self._InstantiateModule(modname, self._cfg.GetSection(modname))
> +                self._RegisterModuleObject(modname, modobj)
>  
>  
>      def MakeReport(self):
> -        "Generates an XML report for all measurement profiles"
> +        rep_n = super().MakeReport()
>  
> -        # Get the reports from all meaurement modules in all measurement profiles
> -        rep_n = libxml2.newNode("Measurements")
> -        cpulist = self.__cfg.GetSection("measurement").cpulist
> -        run_on_isolcpus = self.__cfg.GetSection("measurement").run_on_isolcpus
> +        cpulist = self._cfg.GetSection("measurement").cpulist
> +        run_on_isolcpus = self._cfg.GetSection("measurement").run_on_isolcpus
>          cpulist = parse_cpulist_from_config(cpulist, run_on_isolcpus)
>          rep_n.newProp("measurecpus", cpulist_utils.collapse_cpulist(cpulist))
>  
> -        for mp in self.__measureprofiles:
> -            mprep_n = mp.MakeReport()
> -            if mprep_n:
> -                rep_n.addChild(mprep_n)
> -
>          return rep_n
> -
> -
> -    def __iter__(self):
> -        "Initiates an iteration loop for MeasurementProfile objects"
> -
> -        self.__iter_item = len(self.__measureprofiles)
> -        return self
> -
> -
> -    def __next__(self):
> -        """Internal Python iterating method, returns the next
> -MeasurementProfile object to be processed"""
> -
> -        if self.__iter_item == 0:
> -            self.__iter_item = None
> -            raise StopIteration
> -
> -        self.__iter_item -= 1
> -        return self.__measureprofiles[self.__iter_item]
> diff --git a/rteval/rteval_histogram_raw.xsl b/rteval/rteval_histogram_raw.xsl
> index 00b2be34f305..35d8e8461f74 100644
> --- a/rteval/rteval_histogram_raw.xsl
> +++ b/rteval/rteval_histogram_raw.xsl
> @@ -11,25 +11,25 @@
>      <xsl:text>core&#09;index&#09;value&#10;</xsl:text>
>  
>      <!-- Extract overall system histogram data -->
> -    <xsl:apply-templates select="Measurements/Profile/cyclictest/system/histogram/bucket">
> +    <xsl:apply-templates select="Measurements/cyclictest/system/histogram/bucket">
>        <xsl:with-param name="label" select="'system'"/>
> -      <xsl:sort select="Measurements/Profile/cyclictest/core/histogram/bucket/@index" data-type="number"/>
> +      <xsl:sort select="Measurements/cyclictest/core/histogram/bucket/@index" data-type="number"/>
>      </xsl:apply-templates>
>  
> -    <xsl:apply-templates select="Measurements/Profile/timerlat/system/histogram/bucket">
> +    <xsl:apply-templates select="Measurements/timerlat/system/histogram/bucket">
>        <xsl:with-param name="label" select="'system'"/>
> -      <xsl:sort select="Measurements/Profile/timerlat/core/histogram/bucket/@index" data-type="number"/>
> +      <xsl:sort select="Measurements/timerlat/core/histogram/bucket/@index" data-type="number"/>
>      </xsl:apply-templates>
>  
>      <!-- Extract per cpu core histogram data -->
> -    <xsl:apply-templates select="Measurements/Profile/cyclictest/core/histogram/bucket">
> -      <xsl:sort select="Measurements/Profile/cyclictest/core/@id" data-type="number"/>
> -      <xsl:sort select="Measurements/Profile/cyclictest/core/histogram/bucket/@index" data-type="number"/>
> +    <xsl:apply-templates select="Measurements/cyclictest/core/histogram/bucket">
> +      <xsl:sort select="Measurements/cyclictest/core/@id" data-type="number"/>
> +      <xsl:sort select="Measurements/cyclictest/core/histogram/bucket/@index" data-type="number"/>
>      </xsl:apply-templates>
>  
> -    <xsl:apply-templates select="Measurements/Profile/timerlat/core/histogram/bucket">
> -      <xsl:sort select="Measurements/Profile/timerlat/core/@id" data-type="number"/>
> -      <xsl:sort select="Measurements/Profile/timerlat/core/histogram/bucket/@index" data-type="number"/>
> +    <xsl:apply-templates select="Measurements/timerlat/core/histogram/bucket">
> +      <xsl:sort select="Measurements/timerlat/core/@id" data-type="number"/>
> +      <xsl:sort select="Measurements/timerlat/core/histogram/bucket/@index" data-type="number"/>
>      </xsl:apply-templates>
>  
>    </xsl:template>
> @@ -38,7 +38,7 @@
>    <!--                              -->
>  
>    <!-- Record formatting -->
> -  <xsl:template match="/rteval/Measurements/Profile/cyclictest/*/histogram/bucket">
> +  <xsl:template match="/rteval/Measurements/cyclictest/*/histogram/bucket">
>      <xsl:param name="label"/>
>      <xsl:choose>
>        <!-- If we don't have a id tag in what should be a 'core' tag, use the given label -->
> @@ -54,7 +54,7 @@
>      <xsl:text>&#10;</xsl:text>
>    </xsl:template>
>  
> -  <xsl:template match="/rteval/Measurements/Profile/timerlat/*/histogram/bucket">
> +  <xsl:template match="/rteval/Measurements/timerlat/*/histogram/bucket">
>      <xsl:param name="label"/>
>      <xsl:choose>
>        <!-- If we don't have a id tag in what should be a 'core' tag, use the given label -->
> diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
> index 2f03bda0bb55..1297b12f77e6 100644
> --- a/rteval/rteval_text.xsl
> +++ b/rteval/rteval_text.xsl
> @@ -154,8 +154,8 @@
>      <xsl:value-of select="SystemInfo/cmdlineInfo/cmdline"/>
>      <xsl:text>&#10;</xsl:text>
>  
> -    <!-- Generate a summary report for all measurement profiles -->
> -    <xsl:apply-templates select="Measurements/Profile"/>
> +    <!-- Generate a summary report for all measurement modules -->
> +    <xsl:apply-templates select="Measurements"/>
>     <xsl:text>  ===================================================================&#10;</xsl:text>
>  </xsl:template>
>    <!--                              -->
> @@ -178,21 +178,8 @@
>    </xsl:template>
>  
>  
> -  <xsl:template match="/rteval/Measurements/Profile">
> -    <xsl:text>   Measurement profile </xsl:text>
> -    <xsl:value-of select="position()"/><xsl:text>: </xsl:text>
> -    <xsl:choose>
> -      <xsl:when test="@loads = '1'"><xsl:text>With loads, </xsl:text></xsl:when>
> -      <xsl:otherwise><xsl:text>Without loads, </xsl:text></xsl:otherwise>
> -    </xsl:choose>
> -    <xsl:choose>
> -      <xsl:when test="@parallel = '1'">
> -        <xsl:text>measurements in parallel</xsl:text>
> -      </xsl:when>
> -      <xsl:otherwise>
> -        <xsl:text>measurements serialised</xsl:text>
> -      </xsl:otherwise>
> -    </xsl:choose>
> +  <xsl:template match="/rteval/Measurements">
> +    <xsl:text>   Measurements: </xsl:text>
>      <xsl:text>&#10;</xsl:text>
>  
>      <!-- Format other sections of the report, if they are found                 -->
> @@ -206,7 +193,7 @@
>    </xsl:template>
>  
>    <!-- Format the cyclictest section of the report -->
> -  <xsl:template match="/rteval/Measurements/Profile/cyclictest">
> +  <xsl:template match="/rteval/Measurements/cyclictest">
>      <xsl:text>       Latency test&#10;</xsl:text>
>  
>      <xsl:text>          Started: </xsl:text>
> @@ -238,7 +225,7 @@
>  
>  
>    <!--  Format the CPU core section in the cyclictest part -->
> -  <xsl:template match="/rteval/Measurements/Profile/cyclictest/core">
> +  <xsl:template match="/rteval/Measurements/cyclictest/core">
>      <xsl:text>          CPU core </xsl:text>
>      <xsl:value-of select="@id"/>
>      <xsl:text>       Priority: </xsl:text>
> @@ -251,7 +238,7 @@
>  
>  
>    <!-- Generic formatting of statistics information -->
> -  <xsl:template match="/rteval/Measurements/Profile/cyclictest/*/statistics">
> +  <xsl:template match="/rteval/Measurements/cyclictest/*/statistics">
>      <xsl:text>            Samples:           </xsl:text>
>      <xsl:value-of select="samples"/>
>      <xsl:text>&#10;</xsl:text>
> @@ -301,7 +288,7 @@
>    </xsl:template>
>  
>    <!-- Format the timerlat section of the report -->
> -  <xsl:template match="/rteval/Measurements/Profile/timerlat">
> +  <xsl:template match="/rteval/Measurements/timerlat">
>      <xsl:text>       Latency test&#10;</xsl:text>
>  
>      <xsl:text>          Started: </xsl:text>
> @@ -333,7 +320,7 @@
>  
>  
>    <!--  Format the CPU core section in the timerlat part -->
> -  <xsl:template match="/rteval/Measurements/Profile/timerlat/core">
> +  <xsl:template match="/rteval/Measurements/timerlat/core">
>      <xsl:text>          CPU core </xsl:text>
>      <xsl:value-of select="@id"/>
>      <xsl:text>       Priority: </xsl:text>
> @@ -346,7 +333,7 @@
>  
>  
>    <!-- Generic formatting of statistics information -->
> -  <xsl:template match="/rteval/Measurements/Profile/timerlat/*/statistics">
> +  <xsl:template match="/rteval/Measurements/timerlat/*/statistics">
>      <xsl:text>            Samples:           </xsl:text>
>      <xsl:value-of select="samples"/>
>      <xsl:text>&#10;</xsl:text>
> @@ -397,7 +384,7 @@
>  
>  
>    <!-- Format the hwlatdetect test section of the report -->
> -  <xsl:template match="/rteval/Measurements/Profile/hwlatdetect[@format='1.0' and not(@aborted)]">
> +  <xsl:template match="/rteval/Measurements/hwlatdetect[@format='1.0' and not(@aborted)]">
>      <xsl:text>     Hardware latency detector&#10;</xsl:text>
>  
>      <xsl:text>       Run duration: </xsl:text>
> @@ -422,12 +409,12 @@
>      <xsl:apply-templates select="samples/sample"/>
>    </xsl:template>
>  
> -  <xsl:template match="/rteval/Measurements/Profile/hwlatdetect[@format='1.0' and @aborted > 0]">
> +  <xsl:template match="/rteval/Measurements/hwlatdetect[@format='1.0' and @aborted > 0]">
>      <xsl:text>     Hardware latency detector&#10;</xsl:text>
>      <xsl:text>        ** WARNING ** hwlatedect failed to run&#10;</xsl:text>
>    </xsl:template>
>  
> -  <xsl:template match="/rteval/Measurements/Profile/hwlatdetect[@format='1.0']/samples/sample">
> +  <xsl:template match="/rteval/Measurements/hwlatdetect[@format='1.0']/samples/sample">
>      <xsl:text>         - @</xsl:text>
>      <xsl:value-of select="@timestamp"/>
>      <xsl:text>  </xsl:text>
> @@ -436,7 +423,7 @@
>    </xsl:template>
>  
>    <!-- Format the cyclictest section of the report -->
> -  <xsl:template match="/rteval/Measurements/Profile/sysstat">
> +  <xsl:template match="/rteval/Measurements/sysstat">
>      <xsl:text>       sysstat measurements&#10;</xsl:text>
>  
>      <xsl:text>          Started: </xsl:text>
> -- 
> 2.45.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

