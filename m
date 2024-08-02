Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE21AE052
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Aug 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621678; cv=none; b=uI5pj+V5Lxz/b5pLFdD2+q2pYDS6Jn5B1DJescxF8xf3daNCtrKJne4QA1yVu4ShR/ipz0oglIOhj4Ix3iIBckSv6/iIWMNb3YBLQUvWuwdlpPTHnivpA6iku6kxOXuojBqkVc2eb0u39qeX+S/j3OJWHX1geIQDYmp7BX/Jb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621678; c=relaxed/simple;
	bh=49DHT/nLZYb/VlXj5Sm9NNjmfSaHb8dthK22ye1IIC8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pAw8RuM9hjzhqu5ICzoQNarR9hFw9fmx1xu9TuWdliOB89xT78SsonRt0ine7+32tYzOT6Hvkubhz1bARdQmc64f0xzEwys3hGb15gTGzJm1wwer8n+v1q4znBMwrHn4gPjW8xeyDy1DsAj7fG216txvxPF+JeQ2DKSrANaLJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AK1U80Yj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AK1U80Yj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722621676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sGRK9AxkPNPh5eGXgR/t0AiMhySYlgVSnWi5VhYX6h4=;
	b=AK1U80Yj0y3HnpS2mo56R7IAHoGj/C1zld1JXizeV4/2zAU1bFH32wXIJWmHIkl0yUlQgL
	LbjzjSNuizcJywnxUJgfwV87LNp9vnCd//5KsaFc+Sz73SvVr6oXIFwUGIXw9FIQHJyFuf
	UwW5aNPZRsYjnRN2RfAIHoRN9m91D2c=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-nnYHYs-EOV-ljKn69P-8UQ-1; Fri, 02 Aug 2024 14:01:13 -0400
X-MC-Unique: nnYHYs-EOV-ljKn69P-8UQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-70934735336so6788564a34.1
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Aug 2024 11:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722621673; x=1723226473;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGRK9AxkPNPh5eGXgR/t0AiMhySYlgVSnWi5VhYX6h4=;
        b=YV9U7A8Y8j3B4P9pxWn+PeK/aY4f86Dqa8lvTha66piQmxb7JFqmBEhMAJkDAUNnBj
         bQ1l6fEZx5izfxu0JJTKUABr/MAOWSVoi2Z69wrnrqlVsLgsoLXpp71ZtihVnfr3xvYJ
         JV/VRK99gyjXyr8BB6Cfs1kqZM5PRvpHUKbpKciHhjwf1VmTEqt4bhsB9tbEGx89KdN7
         bTnX/8fovWRNBu1eOGqTxcjSmMkSiW7K8U1Gy3NtGwfXZ02HUlByFWIZdbPTXg7R08+d
         kqC75OTK2JxGSND0+7COzBccT4RKPex6BP5vRqwlkffBWtpNrJu2vGmaFXydOhbqZevX
         ETfQ==
X-Gm-Message-State: AOJu0YzMWq/3/6JD1M2qRHg5Fg0XyJyTunJSUWwDEGnLO+PfyU2tVW0o
	ncdSucMxEh7trYMH3axorznOS7U/LBaQyo4eWTBtyKM6XxG5M8tGczMOjsNjsiOyCJbaJWL2J8X
	rkIi0zvZjgl1SbUFfxOGCgKMA8mZhusajOSUycl2BO69QdmcuFXpf6CGhafxyjYBu
X-Received: by 2002:a05:6830:631a:b0:709:4d7a:3438 with SMTP id 46e09a7af769-709b32081c5mr5757339a34.11.1722621672801;
        Fri, 02 Aug 2024 11:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHac6RcMIfMT/Kyg0SJCWZsZYiI61w0NN9yB8Bwa9m0qDBrHXByJUVGTm3BOEVW5iBpaqgbw==
X-Received: by 2002:a05:6830:631a:b0:709:4d7a:3438 with SMTP id 46e09a7af769-709b32081c5mr5757315a34.11.1722621672453;
        Fri, 02 Aug 2024 11:01:12 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c79b875sm9142376d6.49.2024.08.02.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:01:12 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:01:11 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Anubhav Shelat <ashelat@redhat.com>
cc: linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH v6 2/2] rteval: run cyclictest using '--default-system'
 when setting idle states
In-Reply-To: <20240802154636.1240064-2-ashelat@redhat.com>
Message-ID: <23ececbc-f5e6-a7d5-e9e0-f035bff4390e@redhat.com>
References: <20240802154636.1240064-1-ashelat@redhat.com> <20240802154636.1240064-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 2 Aug 2024, Anubhav Shelat wrote:

> When running cyclictest in rteval, cyclictest automatically disables
> idle states. This means whenever the user sets the idle state of a cpu
> list using '--idle-set' it is overridden by cyclictest.
> 
> To fix this, the variable 'usingCpupower' is appended to the parameter
> dictionary that's passed to the Cyclictest measurement object which executes
> cyclictest in rteval.
> 
> If '--idle-set' is specified when running rteval,
> 'usingCpupower' is set to true and the '--default-system' option is
> appended to the cyclictest command, which will prevent cyclictest from
> disabling cstates.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval-cmd                               | 4 ++++
>  rteval/__init__.py                       | 1 +
>  rteval/modules/measurement/cyclictest.py | 3 +++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index 6e7d8f5d99cb..542d08fc67f0 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -266,6 +266,10 @@ if __name__ == '__main__':
>                  | (rtevcfg.debugging and Log.DEBUG)
>          logger.SetLogVerbosity(loglev)
>  
> +        # check if cpupower is being used
> +        if sys.argv.count('--idle-set') > 0:
> +            rtevcfg.update({'usingCpupower': True})
> +
>          # Load modules
>          loadmods = LoadModules(config, logger=logger)
>          measuremods = MeasurementModules(config, logger=logger)
> diff --git a/rteval/__init__.py b/rteval/__init__.py
> index 4d3e0c23e5ab..8ded374d287e 100644
> --- a/rteval/__init__.py
> +++ b/rteval/__init__.py
> @@ -119,6 +119,7 @@ class RtEval(rtevalReport):
>                    'memsize':self._sysinfo.mem_get_size(),
>                    'numanodes':self._sysinfo.mem_get_numa_nodes(),
>                    'duration': float(self.__rtevcfg.duration),
> +                  'usingCpupower': self.__rtevcfg.usingCpupower
>                    }
>  
>          if self._loadmods:
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index d919058e927f..2e8f6f1870ed 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -251,6 +251,9 @@ class Cyclictest(rtevalModulePrototype):
>          self.__cmd.append(f'-t{self.__numcores}')
>          self.__cmd.append(f'-a{self.__cpulist}')
>  
> +        if (self.__cfg.usingCpupower):
> +            self.__cmd.append('--default-system')
> +
>          if 'threads' in self.__cfg and self.__cfg.threads:
>              self.__cmd.append(f"-t{int(self.__cfg.threads)}")
>  
> -- 
> 2.45.2
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

