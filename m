Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6120101F
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Nov 2024 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921157; cv=none; b=fZcRQqFMVxFvbuXY4t5uqYtIc5ist4oCmPmJLdPU5z6QY1nfMR5nmqG5UyuTeSrBF+OMYcE3BysqBwuv1Hb602SJ8t/bJ50fNYURaXMNHDQvODWJlc/kZ/4ZQiEvXnA+ho7RdjMDPwsM4Fx0VDcwAiJCIcmjw1gpZVSHPDi0lTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921157; c=relaxed/simple;
	bh=cbrNniNhhHoPQfCcavLDV1jN0l9vHn2hp5rNlnR3tq8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TW/VDYfDyUiMHYKv58uMtEVcjYdarhZ3GuNx8747Zb8hfmoKD2fOhS+e9pYWejqU1qMDmaVoVum5IZCdxnXHfFaSnZ1ycSLW331z+qGM+I11hdeoncKbsAoL91z2VIb4ArumNrdQ2t0ei9Q8vlhFFmKSMzXLCoWOnOxkozaE9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XscXjOoG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XscXjOoG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730921153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DntzB+NlD667kv30iO+I0puBBeNE264zT4+97g3GoZ8=;
	b=XscXjOoGw+omcAUutlqQ3kbGAJsKp6h7gOfKAk+RkPaEpTgVBw5iqBI9dQVtLToUbU3WvF
	AUBlTdICgSr2UduWemmCtqjdiHV8/YPb3VfBT9EOOaMYTBqvSnfIOEOEFHzvduTUSvhNI8
	IQ1P3smXc5P+9UMTzc7vdexudJGuiHo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-Bo0DU6f3MImE82vqBV2-vQ-1; Wed, 06 Nov 2024 14:25:51 -0500
X-MC-Unique: Bo0DU6f3MImE82vqBV2-vQ-1
X-Mimecast-MFC-AGG-ID: Bo0DU6f3MImE82vqBV2-vQ
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbead8eb2bso1991616d6.3
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Nov 2024 11:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730921150; x=1731525950;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DntzB+NlD667kv30iO+I0puBBeNE264zT4+97g3GoZ8=;
        b=C38V/UMwShUSpHqWr0jK/GcrR3DOpXMqn7FO2SC+dl4ylob1k5OD9Wo2QhUdf+xc2u
         veJw2W1oVVXzMNcDSyLUr6Ewu+sdmALDBRCrXGK5PIHsYrJ4f8TVU47mOtrpeplI2ZBs
         hg/X16h6YmdDS3bIDOgnHGp2PXMkZSyw/w5W/BLidbmfVbhusBGTTufA4XXXMBM2KfYn
         aT+zR1SVTTF5VT37yESu7eBZ0n8o2fcauMmsBNvbNlwscma+0SWuf+mCjkCIr4iq+KMf
         OKFngUWP2Zzq82n9mgqjaunaNDkqTPaFv/GL0f5Sb0o4ldjSjUqz9t70VkP/td7u/efh
         DwBw==
X-Gm-Message-State: AOJu0YzRXu7M2IvbOqhNfsyidBilsynrWhoMqy8B5b5IcYyGWE6Aui/J
	mRQ/PQN4qfPQJbwzrE6kWTEbZpktbHO68p1e/dTK3yMB8VaqENXdGVj0RBkf0zuHYDzbJk8iZOE
	QJdQJIwTmDgPxrl1qP31CDYi6FPDm5uABtbwvfDKmkENKi+v4iAOlVJMvYcWFPcT0
X-Received: by 2002:a05:6214:459f:b0:6cb:460c:61dc with SMTP id 6a1803df08f44-6d351a935f3mr398448396d6.11.1730921150472;
        Wed, 06 Nov 2024 11:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY50r6TVL/aDbS4jqhqaixaAakrNM/jVfv1nQ0TTkyLFUiQOv9Nw66scsbLA/iIC9JZfTefg==
X-Received: by 2002:a05:6214:459f:b0:6cb:460c:61dc with SMTP id 6a1803df08f44-6d351a935f3mr398448146d6.11.1730921150113;
        Wed, 06 Nov 2024 11:25:50 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fe6fcasm76006026d6.59.2024.11.06.11.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 11:25:49 -0800 (PST)
Date: Wed, 6 Nov 2024 14:25:48 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rteval: Print useful exception info and exit on missing
 measurement tool
In-Reply-To: <20241101205446.41310-1-crwood@redhat.com>
Message-ID: <030b3e45-8582-5276-5f8d-479b1bd075cb@redhat.com>
References: <20241101205446.41310-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 1 Nov 2024, Crystal Wood wrote:

> Currently, if cyclictest or rtla (whichever rteval is configured to use)
> is missing, the error output only says "measurement threads did not use
> the full time slot" and then rteval hangs.
> 
> Avoid catching these exceptions so that they will be printed out,
> pointing to the actual problem.  Also set up a thread exception hook to
> do a prompt and (relatively) graceful exit if a thread has any uncaught
> exception (this requires python >= 3.8).

This can happen when developers run from source. When people install from 
packages these dependencies are taken care of. The hang is especially bad, 
so I like that your patch exits gracefully. However, we are really 
throwing an exception because of one reason, either cyclictest or rtla 
timerlat are not available on the machine, or at least not in a location 
that rteval knows about. In this case we should report that this is the 
case instead of printing an exception / traceback which looks like a 
problem with the software to the enduser. I would only print a traceback 
if the exception is one that we're not aware of.
A few comments on the code follows.

> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  README                                   |  2 +-
>  rteval/__init__.py                       | 12 ++++++++++++
>  rteval/modules/__init__.py               | 14 +++++++++++---
>  rteval/modules/measurement/cyclictest.py | 14 +++++---------
>  rteval/modules/measurement/timerlat.py   | 13 +++++--------
>  5 files changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/README b/README
> index b352d7f..19704b4 100644
> --- a/README
> +++ b/README
> @@ -16,7 +16,7 @@ The rteval source may be pulled from it's git tree on kernel.org:
>  
>  Rteval requires the following packages to run:
>  
> -Python >= 3.0
> +Python >= 3.8
>      http://www.python.org/download/
>  
>  python-lxml
> diff --git a/rteval/__init__.py b/rteval/__init__.py
> index 7c13e84..6097ddf 100644
> --- a/rteval/__init__.py
> +++ b/rteval/__init__.py
> @@ -19,6 +19,7 @@ import threading
>  import time
>  from datetime import datetime
>  import sysconfig
> +from traceback import format_exception
>  from rteval.modules.loads import LoadModules
>  from rteval.modules.measurement import MeasurementModules
>  from rteval.rtevalReport import rtevalReport
> @@ -29,6 +30,7 @@ from rteval import version
>  RTEVAL_VERSION = version.RTEVAL_VERSION
>  
>  EARLYSTOP = False
> +threaderr = False

If this is a global we should follow the convention and 
capitalize it. Yes there is legacy code in rteval that doesn't follow the 
convention.

Even better, does this have to be a global? Would perhaps a class variable 
work here instead?

>  
>  stopsig = threading.Event()
>  def sig_handler(signum, frame):
> @@ -39,9 +41,17 @@ def sig_handler(signum, frame):
>      else:
>          raise RuntimeError(f"SIGNAL received! ({signum})")
>  
> +def except_hook(args):
> +    global threaderr
> +
> +    threading.__excepthook__(args)
> +    threaderr = True
> +    stopsig.set()
> +
>  class RtEval(rtevalReport):
>      def __init__(self, config, loadmods, measuremods, logger):
>          self.__version = RTEVAL_VERSION
> +        threading.excepthook = except_hook
>  
>          if not isinstance(config, rtevalConfig.rtevalConfig):
>              raise TypeError("config variable is not an rtevalConfig object")
> @@ -237,6 +247,8 @@ class RtEval(rtevalReport):
>          global EARLYSTOP
>          rtevalres = 0
>          measure_start = self.__RunMeasurement()
> +        if threaderr:
> +            return 1
>  
>          self._report(measure_start, self.__rtevcfg.xslt_report)
>          if self.__rtevcfg.sysreport:
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index eb29db8..9827651 100644
> --- a/rteval/modules/__init__.py
> +++ b/rteval/modules/__init__.py
> @@ -124,8 +124,8 @@ class rtevalModulePrototype(threading.Thread):
>  
>      def WaitForCompletion(self, wtime=None):
>          """ Blocks until the module has completed its workload """
> -        if not self.shouldStart():
> -            # If it hasn't been started yet, nothing to wait for
> +        if self.hadRuntimeError() or not self.shouldStart():
> +            # If it failed or hasn't been started yet, nothing to wait for
>              return None
>          return self.__events["finished"].wait(wtime)
>  
> @@ -175,7 +175,7 @@ class rtevalModulePrototype(threading.Thread):
>          return self._donotrun is False
>  
>  
> -    def run(self):
> +    def __run(self):
>          "Workload thread runner - takes care of keeping the workload running as long as needed"
>          if self.shouldStop():
>              return
> @@ -215,6 +215,12 @@ class rtevalModulePrototype(threading.Thread):
>  
>          self._WorkloadCleanup()
>  
> +    def run(self):
> +        try:
> +            self.__run()
> +        except Exception as e:
> +            self._setRuntimeError()
> +            raise e
>  
>      def MakeReport(self):
>          """ required module method, needs to return an libxml2.xmlNode object
> @@ -532,6 +538,8 @@ class RtEvalModules:
>          rep_n = libxml2.newNode(self._report_tag)
>  
>          for (modname, mod) in self.__modules:
> +            if mod.hadRuntimeError():
> +                continue
>              self._logger.log(Log.DEBUG, f"Getting report from {modname}")
>              modrep_n = mod.MakeReport()
>              if modrep_n is not None:
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index 2e8f6f1..3d25c20 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -285,15 +285,11 @@ class Cyclictest(rtevalModulePrototype):
>                  fp.flush()
>  
>          self.__cyclicoutput.seek(0)
> -        try:
> -            self.__cyclicprocess = subprocess.Popen(self.__cmd,
> -                                                    stdout=self.__cyclicoutput,
> -                                                    stderr=self.__nullfp,
> -                                                    stdin=self.__nullfp)
> -            self.__started = True
> -        except OSError:
> -            self.__started = False
> -
> +        self.__cyclicprocess = subprocess.Popen(self.__cmd,
> +                                                stdout=self.__cyclicoutput,
> +                                                stderr=self.__nullfp,
> +                                                stdin=self.__nullfp)
> +        self.__started = True
>  
>      def WorkloadAlive(self):
>          if self.__started:
> diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
> index 92bc070..df42777 100644
> --- a/rteval/modules/measurement/timerlat.py
> +++ b/rteval/modules/measurement/timerlat.py
> @@ -252,14 +252,11 @@ class Timerlat(rtevalModulePrototype):
>  
>          self.__timerlat_out.seek(0)
>          self.__timerlat_err.seek(0)
> -        try:
> -            self.__timerlat_process = subprocess.Popen(self.__cmd,
> -                                                       stdout=self.__timerlat_out,
> -                                                       stderr=self.__timerlat_err,
> -                                                       stdin=None)
> -            self.__started = True
> -        except OSError:
> -            self.__started = False
> +        self.__timerlat_process = subprocess.Popen(self.__cmd,
> +                                                   stdout=self.__timerlat_out,
> +                                                   stderr=self.__timerlat_err,
> +                                                   stdin=None)
> +        self.__started = True
>  
>      def WorkloadAlive(self):
>          if self.__started:
> -- 
> 2.47.0
> 
> 
> 

