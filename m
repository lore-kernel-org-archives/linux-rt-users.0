Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A113CA93
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513176; cv=none; b=l+my6A6ozHmxh5ieG9AGiU6fKFCsNGOqaFaU57pcTTjVZsQbeB3s8JJOoCnXjk1/7+bIXo898cqMZShiQUw3TJyj+gP6qRmZPVb79GW+vdf5f1B8tF5zbKmbJ8ZTU5pByDJXhN3C/1DW2E11vYZj6P29uIcjQM4AZJ9pofpGgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513176; c=relaxed/simple;
	bh=TAZEwrUBwT8N//DXTUwmeBHE7OJ6FoWXDGxZjWsOaEQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jN8cfrNzlia5iR8QVO+PzX2dB8MPSq4WD/CZJY69+7cqXfwR9emQN2ArgvffRh3OEHl2yz58aZdFYacDrAOix2yApc+JzsvglAr8kltGbVilzxfkdpEds3CHrC5LkA334zR+Ae5NHyupaKepgl63ZVc25MtlwQ8W5mN2G0RD2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkkfSF72; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkkfSF72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731513173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k9l2s3e8hoeTrqx24h07UDec+c17ZtP045TUtcxUN0M=;
	b=HkkfSF7253h21sWpa77+5RltiEDmkCXuvcyIirC5SX1U3CNl97cvWG80ZFS+5Xq8YSQgYj
	gXmuzkXV0LxhWvWACIIPfDhajs5dKZSB4Y6ofqsr2/n/WdCHOt49Vaim6CV271PimA97MG
	ZjPBcGHu7ERGxfE9Og55G5MxZeoMKFw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-7OHYhVJrMLy2u1WJYR3E1Q-1; Wed, 13 Nov 2024 10:52:51 -0500
X-MC-Unique: 7OHYhVJrMLy2u1WJYR3E1Q-1
X-Mimecast-MFC-AGG-ID: 7OHYhVJrMLy2u1WJYR3E1Q
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e606c05b87so6372791b6e.2
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 07:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513171; x=1732117971;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9l2s3e8hoeTrqx24h07UDec+c17ZtP045TUtcxUN0M=;
        b=FAzPn2XX7wMMy6fVKVaxS7TAQER8DWWPucb9kyp7fYGAS7x6X3GMt7ZIDgBwiOqLVi
         ehWdiE/vTjQZFx67qQDpKi3PR1ctK/vbGRmNvWUkt9S7KLVLHUMP0tEU7JxBuqfb2EBA
         BcryW4VXD4D+DJ0Bv6nuhVGoV9XkdljwO/XwJ4UoeDJ+YieWDH5cXW9ZKpJ9wZUiMiwJ
         /KnRoh+HBqvCgBHZk/uLQD9R4Dub2JFX7gV3F/8Cb8h1nrrWL0MugdtP1IxzV5j5/tqR
         fou/VvVI0AzeJL0y3zCuVmasKIkamRnqDJyaGfyJa6dbeDYAbyPpwTIk9x+vMkBJ62sP
         26mg==
X-Gm-Message-State: AOJu0Yzj4lVle/B49mZgRwA86hMXFtDJDkixn4V3y5iaRaWoDLN9AfxR
	6QKBTUvxrjHxJxg1gsek9u+vyGY6E5DJ1I4ViJ8wDQbHoM1QxsbDp76WLEjBtITA/utbGBiBW8f
	gEEsJfiGIqVN26rYv+uGL7Rb017TpES+UMt1CWt+sl9cB9OVDjz9u0pi9vT0XCA/B
X-Received: by 2002:a05:6808:2117:b0:3e6:2471:4d10 with SMTP id 5614622812f47-3e7b0a7df68mr3150820b6e.11.1731513171201;
        Wed, 13 Nov 2024 07:52:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrCdlTH5Sd5Tu25OAg+S29PgAdRVEOa+RLezKjNPZcb6RjjBOcyorn0VQ6qo2KMgcZCkHmUw==
X-Received: by 2002:a05:6808:2117:b0:3e6:2471:4d10 with SMTP id 5614622812f47-3e7b0a7df68mr3150793b6e.11.1731513170858;
        Wed, 13 Nov 2024 07:52:50 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ef48csm85742996d6.35.2024.11.13.07.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:52:50 -0800 (PST)
Date: Wed, 13 Nov 2024 10:52:49 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rteval: Print useful exception info and exit on missing
 measurement tool
In-Reply-To: <20241101205446.41310-1-crwood@redhat.com>
Message-ID: <8f7edeee-55b6-649b-4077-63ecb6a8c503@redhat.com>
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
Signed-off-by: John Kacur <jkacur@redhat.com>

Thank you

