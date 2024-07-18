Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3E140E29
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331509; cv=none; b=KW95hjFN1jxLlFFLDRxubAMjrUi0EFjyou/hCEOOj+XIsqJabhBKiKEYj0zJI3EZRWltGabSAQS99mjsG2Ucb8JdUXoWJDiExN6eRIWaJpI2XbtUwCBkOagkxIKbLdviAGE0FKiUnUXrM9aygFyMekS9G7o3oxo9RabGhtFniSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331509; c=relaxed/simple;
	bh=X94VDjNj2TH1eCQ2mPr5Dn1WrvHlzrZ7SWor883O2Lg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h5Wpo2rhNR4aq4K5T4XEHwc1gTN9OB6XmQa+SuWyfMuHKKj2R/Lnq/1RGABIQH81JORztzdvRKnatf6oFVF3HDqaFgtPe4anh6jL9Xl4UPASXx9JJvN7QGpeMoaFs76fD/NYyKrAe2bn3TFur6XnGnxjgtN4RWgGIq/JKcAZuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AhRzGKmR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhRzGKmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721331506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rE8+zH2eWlgL0ZkhgSCWMfvggqdhl4cbkYI3oK7BsQ4=;
	b=AhRzGKmRqZwpPLDSHQAU5GzuPBWCBceW4NOCIZEREt93Aeil27Kl7+vKfGhbOaI+8wOLdv
	GvBRCcox+uijDve/bEzZR2hw50k2R8sIGxeCQ8ujok37Iy1lXRH7dTrsIclsqjuS9XU85V
	+n+OTY55bGTB+GJlfEpWXE70Meezq8g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-h_8elY2QN3yfgUDyCfEzhA-1; Thu, 18 Jul 2024 15:38:25 -0400
X-MC-Unique: h_8elY2QN3yfgUDyCfEzhA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b78eca5502so25853726d6.1
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 12:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721331505; x=1721936305;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rE8+zH2eWlgL0ZkhgSCWMfvggqdhl4cbkYI3oK7BsQ4=;
        b=POAYqAqp4IBdWCa/Hatv9Sjh2EYEvNVwlhhyBYy2C4jNtmqKuTXiGSpHPIZbGlvcck
         dXT3fxWqtbZoVM+epvFAncBXi1yL5Lx8nZrc4XXqf0EL2MEGn0pPS2zhoUDBUB7/HTzN
         umTpJwrCMibfZkhbkrnl4MilHXXbEUVo9fAxWR3g6qzra7v3orMMdiHfNxJTsYOvQS/T
         7KHd3bjbxjVe7U0Hckx9iBhmg0z3gMLy5/D8BZEVMHsFMCfQNCfEPvycM05t+qza+JHy
         IWEBWU2viNLG0vAw0v8abGYNapjPveQkKJxOHncjO+2gxWAySuD9IHwrAUXldrN531i2
         WOKg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3KjbwJl/j/jJXaTpEgipAtV9fN6WNS0wnafBtfAoMjNOfuwkC+NFIMs7t/6g/kNufYWU8R7CutHonE0uWcL0SJKIufjlgt3Ea2fUU3E=
X-Gm-Message-State: AOJu0YxhZB9vl5ia30ADIRlFvS1aTsapEYq/8NsV6AESBLvrlm+s2uev
	owErD8qaRffFNPQ13l8wJJgKdUjSacGs0MSKdj52KL6WgPOQRKwUy4w9BrJELiULO7fmhGE0dif
	KGyaGZxHo0JnIbossht3xUHSNPKA2txIKCyDOdkWNR0fzsdqBjyur0CTHNSup9j0G8hO3XT3c
X-Received: by 2002:a05:6214:2b0c:b0:6b5:8913:d63a with SMTP id 6a1803df08f44-6b79d03df1cmr66475556d6.12.1721331504970;
        Thu, 18 Jul 2024 12:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhHb/xiDbzMpQhLQtrQrMnbCGyFvG8qZVEmMWhd92cTBSJd9pUFu+nwQXBGK77sKi+hXcP8Q==
X-Received: by 2002:a05:6214:2b0c:b0:6b5:8913:d63a with SMTP id 6a1803df08f44-6b79d03df1cmr66475246d6.12.1721331504609;
        Thu, 18 Jul 2024 12:38:24 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c675536sm11170256d6.138.2024.07.18.12.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:38:24 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:38:23 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/4] rteval: RtEvalModules: Remove unused methods
In-Reply-To: <20240621022417.2086751-4-crwood@redhat.com>
Message-ID: <6b3bd449-b5ff-8410-953e-ba695baff961@redhat.com>
References: <20240621022417.2086751-1-crwood@redhat.com> <20240621022417.2086751-4-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Jun 2024, Crystal Wood wrote:

> With measurement profiles gone, remove methods that no longer have any
> users.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval/modules/__init__.py | 37 -------------------------------------
>  1 file changed, 37 deletions(-)
> 
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index 0c0ce7202f77..de1ddc4628c1 100644
> --- a/rteval/modules/__init__.py
> +++ b/rteval/modules/__init__.py
> @@ -333,36 +333,11 @@ returned when a ModuleContainer object is iterated over"""
>          self.__modobjects[modname] = modobj
>  
>  
> -    def ExportModule(self, modname, modroot=None):
> -        "Export module info, used to transfer an imported module to another ModuleContainer"
> -        if modroot is None:
> -            modroot = self.__modules_root
> -
> -        mod = f"{modroot}.{modname}"
> -        return (mod, self.__modsloaded[mod])
> -
> -
> -    def ImportModule(self, module):
> -        "Imports an exported module from another ModuleContainer"
> -        (modname, moduleimp) = module
> -        self.__modsloaded[modname] = moduleimp
> -
> -
>      def ModulesLoaded(self):
>          "Returns number of registered module objects"
>          return len(self.__modobjects)
>  
>  
> -    def GetModulesList(self):
> -        "Returns a list of module names"
> -        return list(self.__modobjects.keys())
> -
> -
> -    def GetNamedModuleObject(self, modname):
> -        "Looks up a named module and returns its registered module object"
> -        return self.__modobjects[modname]
> -
> -
>      def __iter__(self):
>          "Initiates the iterating process"
>  
> @@ -406,10 +381,6 @@ class RtEvalModules:
>      # Export some of the internal module container methods
>      # Primarily to have better control of the module containers
>      # iteration API
> -    def _ImportModule(self, module):
> -        "Imports a module exported by ModuleContainer::ExportModule()"
> -        return self.__modules.ImportModule(module)
> -
>      def _InstantiateModule(self, modname, modcfg, modroot=None):
>          "Imports a module and returns an instantiated object from the module"
>          return self.__modules.InstantiateModule(modname, modcfg, modroot)
> @@ -426,17 +397,9 @@ class RtEvalModules:
>          "Returns number of imported modules"
>          return self.__modules.ModulesLoaded()
>  
> -    def GetModulesList(self):
> -        "Returns a list of module names"
> -        return self.__modules.GetModulesList()
> -
>      def SetupModuleOptions(self, parser):
>          "Sets up argparse based argument groups for the loaded modules"
>          return self.__modules.SetupModuleOptions(parser, self._cfg)
> -
> -    def GetNamedModuleObject(self, modname):
> -        "Returns a list of module names"
> -        return self.__modules.GetNamedModuleObject(modname)
>      # End of exports
>  
>  
> -- 
> 2.45.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

