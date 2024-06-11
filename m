Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAA383A3
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Jun 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123193; cv=none; b=JOZsCQrq3watk5LrTNsqWSImmkjUU/36ZDwycUjqZbInzDYDAWOKzB70qOYFMI0F4ROoUEBGz8zFT4FgnKofyzKLfuxroLYeNOU6OJzoICXJ5AlKvbjhSsS7R6J8HiOJMMTZBkYikz49xc9UjT1jedDvRwRQ19aF5GFIIGM+Zvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123193; c=relaxed/simple;
	bh=MHskX06eM4m6r7S+hmLHytmN4M+I+D2H1GrU9UYRuMo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XUUmyHDbWobK4aOA4EIIuufIFLt08+QbgKK0o3L9GPpdKQJPxdVTLAr+mcv86239Ujx6X6Q/VfBn+uAdJq8KmWl5VLJ+iGZIkrtKXw8pDtABRyohj0xTT8b1lbP2qFUQoZR7XYkqQkzJVdVfaDLar1p6oo3xWit1eAGlMEoxL1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USr19kQi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USr19kQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718123189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWAioaegc4UUuFf0eG9Qxt1Yoic4uZzice+5lhZneuk=;
	b=USr19kQiy73fExB79MxmAgunv9/J0/alvPTnpOtZt0Bw/duHtr0pSZCKASmk8L/+xVcC5w
	x8QPJqkgwStfpJFnfSMSRiVHDqFc+gqx84DiFdmePubaHBfPxTjE3CpR+7Db8gsYB1vbvb
	yv7F5OQbg4YjVy75HPrQdY/wohqALh8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-4INUaYGKP_G8a8b4FxBv7A-1; Tue, 11 Jun 2024 12:26:28 -0400
X-MC-Unique: 4INUaYGKP_G8a8b4FxBv7A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4404d088c36so13490381cf.0
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Jun 2024 09:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718123187; x=1718727987;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWAioaegc4UUuFf0eG9Qxt1Yoic4uZzice+5lhZneuk=;
        b=ufo3jvp+mLOhEgD3TC0MKqiJOYTUM13QDWS8mNxWT8TgHZY1bihjK87OdRi+yB5q6X
         tgRZVKzuw4DKNHDWJcoNtCQjB0uq8wgrNA5kulzXeMk+s7hFDVL2p/TmdggFTuOjAVka
         cynbCADNdvNFtdMxPTL5PhuaRY+UXNGSHo+fdQX3RXeDWwZ0SsQJTgJeMp2nOq4xtXAB
         tPYR5qC/3malUMvy3HwhHrRUfZ0t4CQjJTscE0/HgZcpS2w3TKyjoXpn13+raQRDi0Xg
         wZFoxWYC5G4KOd9z6ALVm1a7uCicAGlPP3SXYheYMPHvY7qOwiAJ4YJ8TT5kKC9h5iUF
         m3Ig==
X-Gm-Message-State: AOJu0Yy7pz8YlLgZpw/Qkv4qo+i+lg0B5pGdFVi/O/loUk8198hn/4eZ
	26kzJ1cslAFbfh3UFUwoEhDvf+HeM4g+22Ife6D8PKhCfcD1jjb3CCopqjH3vWpxP7LFKqLGY/k
	lo09NdozrIL0IWZIwd3GRVQ/B+Uh5G7DtREl4qoJR53+H9kXtvfJ02DxW1nVbAMsQtdlaL2Jv
X-Received: by 2002:a05:622a:248:b0:441:5651:2008 with SMTP id d75a77b69052e-441565121a3mr13512051cf.16.1718123187063;
        Tue, 11 Jun 2024 09:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeInGSKfuFJsH1OosGL++JSSpvg57W8w7RlzXbWAClZEUsykDR9i+m0BLZLTtkzwEMsWXyZw==
X-Received: by 2002:a05:622a:248:b0:441:5651:2008 with SMTP id d75a77b69052e-441565121a3mr13511831cf.16.1718123186642;
        Tue, 11 Jun 2024 09:26:26 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44053a75bcfsm35647181cf.59.2024.06.11.09.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:26:26 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:26:15 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rteval: Fix -aNone being passed to cyclictest
In-Reply-To: <20240611144553.185624-1-tglozar@redhat.com>
Message-ID: <1d63f6b6-b969-c043-a9af-95d96e34a605@redhat.com>
References: <20240611144553.185624-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 11 Jun 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> When rteval is called via the command line, cpulists for both
> measurements and loads default to an empty string and are further
> processed by parse_cpulist_from_config. However, this is not true when
> rteval is used as a module: in that case, neither the default
> command-line value is used nor parse_cpulist_from_config is run, leading
> to None being set to the config property of measurements which is
> explicitely passed down to the corresponding cyclictest config property.
> 
> After 64ce7848dfab ("rteval: Add relative cpulists for measurements"),
> where the check for None was removed from the cyclictest module, rteval
> passes "-aNone" to cyclictest when being used as a module.
> 
> Call parse_cpulist_from_config with an empty string to get the default
> cpulist to pass to cyclictest module if cpulist is empty in
> the measurement config.
> 
> Fixes: 64ce7848dfab ("rteval: Add relative cpulists for measurements")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/modules/measurement/__init__.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index 11bd7b0..43c0fda 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -148,6 +148,9 @@ measurement profiles, based on their characteristics"""
>          modcfg = self.__cfg.GetSection("measurement")
>          cpulist = modcfg.cpulist
>          run_on_isolcpus = modcfg.run_on_isolcpus
> +        if cpulist is None:
> +            # Get default cpulist value
> +            cpulist = cpulist_utils.collapse_cpulist(parse_cpulist_from_config("", run_on_isolcpus))
>  
>          for (modname, modtype) in modcfg:
>              if isinstance(modtype, str) and modtype.lower() == 'module':  # Only 'module' will be supported (ds)
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

