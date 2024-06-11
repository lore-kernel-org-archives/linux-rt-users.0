Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477A63C
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Jun 2024 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718079062; cv=none; b=i0CiebTUFWihPWN8wkOCzIfZOj76Toye1a14iTN1uWECq6E79Yvl4O07BUIIsAs6F9eqAw98cmZXK+QhZ1uOgLwoXxghpVehPDSOGaXwxRp//9BzJwPXiYKu3uzD38XBy8p8Mms3lPGauEstQshRSGtpWrRWRApMNCQZsCq0ZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718079062; c=relaxed/simple;
	bh=Dhw0bzFDxU0OyvVFhhxa0kELc11kL0Jg8cqevwVFMxE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mn506lwqzVP5Cf/q5jQXSOCpLPUEu/wfArHvzANPafGhY+LSPsdJiEqLGvkcbeVlW/4zOA5zT1o59DWgcEQT3j+057MNfoYlqzGd3NuQi002fhMUfJAmicP8CUpbh1WVm+rqVFGGrmxu2OLB94Cc3ZrVTke+PD+byLSb44k9gMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENaaREBr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENaaREBr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718079059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JGgCc0RiE/hpALkzGJCudBJkmknQ+fklAG6vwW7WN0M=;
	b=ENaaREBrBh9IspIVYXVV3e7JqRvbjeMIvkfZRzoBbBQDHp2VyB+28A+nEPMj1ZJ08q0Rn5
	3MSPFzpcTte9cIwytpy0DZShChAa2tG8BXCf9bj2cz2LBUc0PdDikBoC/K+uWRNFIKuZMK
	P7/Xhu1BFVPOMLUN4JGi8ZySbDKKlQ8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-yP6kngEuPI-yLlqjMaqTvg-1; Tue, 11 Jun 2024 00:10:54 -0400
X-MC-Unique: yP6kngEuPI-yLlqjMaqTvg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43fd36ca920so53631021cf.1
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jun 2024 21:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718079054; x=1718683854;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGgCc0RiE/hpALkzGJCudBJkmknQ+fklAG6vwW7WN0M=;
        b=QZGRaBzZypMOa8/O/pI7qVRmz8peY0UQHuG5G1wEhkY7SiiRqSaoEXjTY9DbEolf0z
         4cLMzX5hCUX2W2p6jp43sX6nHEu0QCcMJFNOFPTB2Fc0sb29oj+kAA8xAEwy8UU8W8fg
         AevVMH3Sq00igzr6V/FNUOOqT0VBfRMXop+Ggdk9s0OP+h+0Vnr6+KX0BBo9pNZoqyEj
         L0pMnlCf0ICQLxS15KjNbJyfpqbyf7UgVflQDgOETjCwFRsx7VGdBbI9DBUm7d8uwQt5
         C0dZrVZv/3vR02ft2NP2Mi0/9IySF5fGCTQ0z9Zjsoa98WLXWy9BtFJHgCsOL6jY0QgP
         IM3w==
X-Gm-Message-State: AOJu0YztY/5QD0OQW2mEWlrg9eosYEhmK8k8PrcahS23TgbDSj0LFzXZ
	GRbvArWfKi2vjHA4U8jdObTHAZiXcJEt6Af9iAu9VFdR9DO03GsBoAn9qjUADIpQR3//FNAU8py
	vi59TJt0r6MDhNAg4WbTuf0HnvEH3OTpX9QzsPXCJibOxlmO4MYeytI9YfppobtWO/1xHVHZy
X-Received: by 2002:ac8:4754:0:b0:440:4eb7:293f with SMTP id d75a77b69052e-4404eb72cf8mr95313511cf.12.1718079053654;
        Mon, 10 Jun 2024 21:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmYLUAKUUFdrXylCo1eS7xvkC749/ftDMqeQ3qPuhUtc/2YfwqDE3zD2XIaRMqdH0lPWd7MA==
X-Received: by 2002:ac8:4754:0:b0:440:4eb7:293f with SMTP id d75a77b69052e-4404eb72cf8mr95313361cf.12.1718079053180;
        Mon, 10 Jun 2024 21:10:53 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038ac4bd1sm42288061cf.57.2024.06.10.21.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 21:10:51 -0700 (PDT)
Date: Tue, 11 Jun 2024 00:10:40 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Avoid passing None cpulist to measurement
In-Reply-To: <20240606104054.111997-1-tglozar@redhat.com>
Message-ID: <4010779d-ef70-d2df-9f17-3d5a35ba87b3@redhat.com>
References: <20240606104054.111997-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 6 Jun 2024, tglozar@redhat.com wrote:

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
> The issue was introduced in 64ce7848dfab ("rteval: Add relative cpulists
> for measurements"), where the check for None was removed from
> the cyclictest module, assuming the value was processed by
> parse_cpulist_from_config.
> 
> Avoid this by calling parse_cpulist_from_config with an empty string to
> get the default cpulist to pass to cyclictest module if cpulist is empty
> in the measurement config.

In this context "avoid" is a weasel word. I "avoid" a sunburn by staying 
out of the sun.

> 
> Note: this is a workaround, in the future, parse_cpulist_from_config
> will be called properly in one place only instead of being scattered
> throughout the code of rteval. That will also enable relative cpulists
> to be used when calling rteval as a module.

I don't know if it is a workaround, this is what the code did before it 
was changed in 64ce7848dfab, leave out any predictions of how we'll handle 
this in the futre.

> 
> Fixes: 64ce7848dfab ("rteval: Add relative cpulists for measurements")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/modules/measurement/__init__.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index 11bd7b0..fda618d 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -148,6 +148,13 @@ measurement profiles, based on their characteristics"""
>          modcfg = self.__cfg.GetSection("measurement")
>          cpulist = modcfg.cpulist
>          run_on_isolcpus = modcfg.run_on_isolcpus
> +        if cpulist is None:
> +            # Avoid passing None cpulist down to measurement module which might
> +            # not expect it
> +            # Note: None can appear only when using rteval as module, not when
> +            # being called from command line; in the latter, cpulists are all
> +            # processed by parse_cpulist_from_config already by this point

Five lines of comment for one line of code? How about
# Initialize the cpulist if it wasn't already set from the command line
> +            cpulist = cpulist_utils.collapse_cpulist(parse_cpulist_from_config("", run_on_isolcpus))
>  
>          for (modname, modtype) in modcfg:
>              if isinstance(modtype, str) and modtype.lower() == 'module':  # Only 'module' will be supported (ds)
> -- 
> 2.45.0

John

