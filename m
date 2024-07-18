Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD35145A1C
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331765; cv=none; b=i+THFD5zi07i/NTeUoR3c+DvXC1Xz4feNVuVF3WjItCi99g6PiKc9QslwQcAqhlWnxEmh04QeVmiwJpTT4IVipx3a+82BlCdyxFGtjFxiDkLIi76S2SSbzqzPaG1EUGfpUU8fZ3s7xOOzqaVHWdqPvsDEzpEI7dKiX1tFKZ3zcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331765; c=relaxed/simple;
	bh=dYXA0gu2lhH4m/lpc+0/NhnEwys7zE9n7Y63D7C8Wyw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iRRSSlLyNDQTWllm6MSbteeVmvwzuWX4UI4FrSOeJdFAXeIr5XKlkFUWWj/uBcB7t+v2qss2R9rwVuHWQImWjesrmLE1AM98vUAzqpHCaole3eNMEz90BIylDkawr592F+Ey3evgELFIwr1KaX7l1TT65f4KVRRAK1OyaH6okrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpCT0MEy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpCT0MEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721331762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n1Pw7TMTc6gGiUtLWVIlMy2/6doFCPUQcxo6/y7nQg0=;
	b=fpCT0MEytW6QjYJCJJIySLDDFmAVOScNQBlEKSgHWUUlGifwqJ4z7jEVElIVZuuPWZPa3C
	gtJCAQRvIfhc+AcWDfI6VJDPsyTwdJ7mI6cNVPfYlPBMSn1vuPzrTKFy1+zqlQZzKlh7Vh
	YbQaUWv0o9AfMMSNLDCFipH2XA6ay7M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-xN37_SKsN_u-RUbBlif6-Q-1; Thu, 18 Jul 2024 15:42:40 -0400
X-MC-Unique: xN37_SKsN_u-RUbBlif6-Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-79ef9c44d85so87391585a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 12:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721331760; x=1721936560;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1Pw7TMTc6gGiUtLWVIlMy2/6doFCPUQcxo6/y7nQg0=;
        b=QbYNPBzLlsUmFdfZnURpDkcoBw7taxfq60ebY0KM8/sKNS/0rO9lDddWfvevTmLRng
         +9kNRkDKEHgZnpFFOiByOSrH69+EwFQvkq6+qwkYGhfMJ6dlqhMCb5lkMSKHHAjl9Nus
         ctw7UmUL5v3BX9nsFDklTIArGkSsLLUqHYDJIw6aX9clhK9JWWthvW3Bjk/KxBJTjOKn
         q/J1Y08AoMr3hKwd886vZ3sSFFQOpTwj6iEVFRYc8XtbZC2aFqKyOCnOLW9u4O9gdDFe
         2H23iAgryVpskYXEO551hgA/tImlBW0QPVR6xZek94Qelpyg/482Y8dgsEy9wBnFGcDZ
         1sng==
X-Forwarded-Encrypted: i=1; AJvYcCW4smhigJIQAJbzGNVa+aZM4YS6UCXGcqBKkaRn2Wew67NAZydxDScSvGhVJwtjotGN/oeT2f6+L37q1l9sgTzlcegs6LYidPVK3yrfiEI=
X-Gm-Message-State: AOJu0YwdvkGBmi5OsbFZ3jLYTyZizFAsQWKM+t3bwrNRyYXueZ9/fEwL
	0yUE4wdIazSEgs1fDveFJCbsZctf6xguA6SiZbBIlH2IgdqFWIhMQ+MhhUY802aIJ2dUJvf1CJv
	vZu8J0BkAJjQJY8JXnvN5Wd25cxykbJocuvpEuEZIQT7x/+LoSPjLkPB9kNeRKYGcmIHClTCH
X-Received: by 2002:a05:620a:404e:b0:7a1:632e:e576 with SMTP id af79cd13be357-7a1874d8b1cmr788550985a.54.1721331760234;
        Thu, 18 Jul 2024 12:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx3SA2GZ3mqi/UdCIjfgXrFZXVO5j3dQ7O9vbXUhsOZJWF7048B6GuT5qNWAHoTkOiECW+Xw==
X-Received: by 2002:a05:620a:404e:b0:7a1:632e:e576 with SMTP id af79cd13be357-7a1874d8b1cmr788549085a.54.1721331759780;
        Thu, 18 Jul 2024 12:42:39 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19396e7cdsm57508285a.111.2024.07.18.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:42:39 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:42:38 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/4] rteval: Enforce only one latency measurement module
 at a time
In-Reply-To: <20240621022417.2086751-5-crwood@redhat.com>
Message-ID: <2a78a468-320d-c3e1-0624-f8f665a4f27c@redhat.com>
References: <20240621022417.2086751-1-crwood@redhat.com> <20240621022417.2086751-5-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Jun 2024, Crystal Wood wrote:

> Latency modules will step on each other's toes if run at the same time
> (on the same CPU, though that's an enhancement for later), so only
> run one of them.  A priority mechanism allows selecting
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval/modules/__init__.py               | 11 +++++++++++
>  rteval/modules/measurement/cyclictest.py |  1 +
>  rteval/modules/measurement/timerlat.py   |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index de1ddc4628c1..2a4eafae71c7 100644
> --- a/rteval/modules/__init__.py
> +++ b/rteval/modules/__init__.py
> @@ -40,6 +40,7 @@ class rtevalModulePrototype(threading.Thread):
>                           "finished": threading.Event()}
>          self._donotrun = False
>          self._exclusive = False
> +        self._latency = False
>          self.__timestamps = {}
>          self.__sleeptime = 2.0
>  
> @@ -67,6 +68,11 @@ class rtevalModulePrototype(threading.Thread):
>          self._exclusive = True
>  
>  
> +    def set_latency(self):
> +        """ Sets the module as an exclusive latency measurer """
> +        self._latency = True
> +
> +
>      def set_donotrun(self):
>          """ set a module's donotrun field to True """
>          self._donotrun = True
> @@ -412,9 +418,14 @@ class RtEvalModules:
>  
>          self._logger.log(Log.INFO, f"Preparing {self._module_type} modules")
>          exclusive = 0
> +        latency = False
>          for (modname, mod) in self.__modules:
>              if mod.is_exclusive() and mod.WorkloadWillRun():
>                  exclusive += 1
> +            if mod._latency:
> +                if latency:
> +                    raise RuntimeError("More than one exclusive latency test")
> +                latency = True
>          for (modname, mod) in self.__modules:
>              if exclusive >= 1:
>                  if exclusive != 1:
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index 3a34c1b988d6..a9f5b0c4fba7 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -216,6 +216,7 @@ class Cyclictest(rtevalModulePrototype):
>          self.__started = False
>          self.__cyclicoutput = None
>          self.__breaktraceval = None
> +        self.set_latency()
>  
>  
>      @staticmethod
> diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
> index 19dd30732936..793b80cc0dac 100644
> --- a/rteval/modules/measurement/timerlat.py
> +++ b/rteval/modules/measurement/timerlat.py
> @@ -206,6 +206,7 @@ class Timerlat(rtevalModulePrototype):
>                                                    logfnc=self._log)
>          self.__timerlatdata['system'].description = (f"({self.__numcores} cores) ") + info['0']['model name']
>          self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
> +        self.set_latency()
>  
>  
>      def _WorkloadSetup(self):
> -- 
> 2.45.1
> 
> 
> 

We used to call them just measurement modules, so I see what you are 
trying to do, you are differentiating between measurement modules that 
measure latency such as cyclictest and rtla timerlat, as opposed to 
sysstat. However, the naming here is not good. self.set_latency() ?
how about maybe, set_latency_module() ? It's a bit unwieldy in length, but 
it's clear that you are setting which module to run and not some kind of a 
latency. I'm applying this patch, but would appreciate you following up 
with a renmaing patch.

Signed-off-by: John Kacur <jkacur@redhat.com>

