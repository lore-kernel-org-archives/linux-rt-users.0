Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7A54BCB
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Mar 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642134; cv=none; b=QLeZdG2y+8xg4PUkmLk5QcqqA0qyoO9XMUMhG34DGejMlHnEjyRivV2/ylRvKgjHhHrJCaNdxdozszIgH/f6qp5ovNjYqMhfaW69MqI8D/Eq9io9/Feu9HAgo3JgxudWjmcG9+WaT075mxClda2wL6ON1PTvoRd/1OZpGAlYXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642134; c=relaxed/simple;
	bh=Wy4PwjjaL/PZrlGPaxve+8P0aHxLJX/9yo+5OP6LlY8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YSWnvIRe2aAhIMhDg92GMKp/eo7HKJCM/cm6G1xowJs4NETU+1EzR/x6Ip/17b+PJmrzVkQbDn4Oo2owlxENnpzOSnzMoFmj1AOr/9v4zcDCPdoRWirTDyTld5Dx2q6wxNb7jRuLRIVY01goXhlkQMBNrEYTTcDjIrnFPeaAh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bn5t7jHt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn5t7jHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711642131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxJuKcAvWFwfO0dGsma1uPmZAA2UpOQAvmZCQj7/SEY=;
	b=bn5t7jHt6D6QQtV3PQhiWk8+aFFtzJVcVVvyXzdEE9KjB3V/Lez2SfSxGcNvfIy0zb9u9I
	sAnICU4n86FqeoICuib0huAt2P4FaJjy73Aw7nHfpFpSu72bYnbSeRJZha3WFuog9gHXks
	imUH7SdWkorju5OCsEa1LsTHQ5dpnew=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-zrUINwUnMhGGcMBdtC1mag-1; Thu, 28 Mar 2024 12:08:50 -0400
X-MC-Unique: zrUINwUnMhGGcMBdtC1mag-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-431361582d5so10901991cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Mar 2024 09:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711642126; x=1712246926;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxJuKcAvWFwfO0dGsma1uPmZAA2UpOQAvmZCQj7/SEY=;
        b=rrzRZBwQZcNB2NJkd90PK/9Hh0HVBtt1iVI+io9Evf5jDSMHIkRab/LR7O+mHI6XAp
         I+UXg5KWxaRkV6GBqRI1QCEakSdFR/IwtC8bn64HV0xoEswHF4EuYr+Iogbre4gNBHZ4
         SYANxhHuKs8Vq4pXgVHUOIZGn/4NEvFJtAC9crG81qmKf6yqzbAQVoZFeeKuMZQFQxoj
         QjlSBfbca00QDQ5w9BjaQ7D5DFV1mZlLJ0uoJt2KhLNdNBBsF83w1d8sZTovK26LpKnO
         FZV1DXl9d2Y8Dzue1NSC6BX7QKs1nYpAc8q+KXThcI8WHygULU8hHDZhdSIOm1PaFMwc
         K6bg==
X-Gm-Message-State: AOJu0YyqtSDHvu1wFI+0rWD5oMqushisZCM2xxoPn6WgSxX+7tvrxJoE
	C1yBVAkm+MdfwtOzRKheG8f1otf0DrQNUpBlj68we0XlopEMEiUt5rYDKnMMlVBF4Ey+IBFrc53
	oclVRrHm9phWgppf5gurHUBHwF0A7CJG58pCf0X4BtQ1kVagp68Ga8fGjwPAV5fBgjkRpRB2Q
X-Received: by 2002:ac8:7f52:0:b0:431:5b18:5c5c with SMTP id g18-20020ac87f52000000b004315b185c5cmr3401920qtk.38.1711642126358;
        Thu, 28 Mar 2024 09:08:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB27eExaG7Ed0fYa8c3kfLsMxcJOQS14g2piBJkqMoQRKgmoQc8ObczAWUbbhUOg31fUAUYA==
X-Received: by 2002:ac8:7f52:0:b0:431:5b18:5c5c with SMTP id g18-20020ac87f52000000b004315b185c5cmr3401900qtk.38.1711642126046;
        Thu, 28 Mar 2024 09:08:46 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-166.dsl.bell.ca. [184.147.142.166])
        by smtp.gmail.com with ESMTPSA id ex9-20020a05622a518900b00432b5c9b9ecsm599121qtb.14.2024.03.28.09.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:08:45 -0700 (PDT)
Date: Thu, 28 Mar 2024 12:08:38 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Add relative cpulists for loads
In-Reply-To: <20240306090722.147221-1-tglozar@redhat.com>
Message-ID: <716579de-2e8a-42c9-cda0-7d38c4ddf7c6@redhat.com>
References: <20240306090722.147221-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 6 Mar 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Relative cpulists were added for measurements in 64ce7848 ("rteval: Add
> relative cpulists for measurements").
> 
> Add support for relative cpulists also for loads. This works the same
> way as for measurements using parse_cpulist_from_config, only difference
> is there is no --loads-run-on-isolcpus option.

You need a better description here for people who don't know what this is 
about. For example, why would this be useful? There is no mention of 
--only-loads




> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval-cmd | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index a5e8746..8572022 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -340,28 +340,29 @@ if __name__ == '__main__':
>          ldcfg = config.GetSection('loads')
>          msrcfg = config.GetSection('measurement')
>          msrcfg_cpulist_present = msrcfg.cpulist != ""
> -        # Parse measurement cpulist using parse_cpulist_from_config to account for run-on-isolcpus
> +        ldcfg_cpulist_present = ldcfg.cpulist != ""

I'm not a fan of this syntactic sugar it makes things wordier and less 
readable IMO for programmers. I see I let you do that for msrcfg.cpulist, 
but I'd prefer you put that back too

> +        # Parse cpulists using parse_cpulist_from_config to account for run-on-isolcpus

I'm not religious about the 80 char term, but if you're already modifying 
a comment, that overflows to the next line, why not neaten this up?

>          # and relative cpusets
>          cpulist = parse_cpulist_from_config(msrcfg.cpulist, msrcfg.run_on_isolcpus)
>          if msrcfg_cpulist_present and not cpulist_utils.is_relative(msrcfg.cpulist) and msrcfg.run_on_isolcpus:
>              logger.log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
>          msrcfg.cpulist = collapse_cpulist(cpulist)
> -        if ldcfg.cpulist:
> -            ldcfg.cpulist = remove_offline(ldcfg.cpulist)
> +        cpulist = parse_cpulist_from_config(ldcfg.cpulist, run_on_isolcpus=False)

Since run_on_isolcpus are False by default you could also just do

cpulist = parse_cpulist_from_config(ldcfg.cpulist)

since we know that we are reusing the interface in which run_on_isolcpus 
are relevant, but in this case they are not, so explitly setting them to 
False is confusing

> +        ldcfg.cpulist = collapse_cpulist(cpulist)
>          # if we only specified one set of cpus (loads or measurement)
>          # default the other to the inverse of the specified list
> -        if not ldcfg.cpulist and msrcfg_cpulist_present:
> +        if not ldcfg_cpulist_present and msrcfg_cpulist_present:
>              tmplist = expand_cpulist(msrcfg.cpulist)
>              tmplist = SysTopology().invert_cpulist(tmplist)
>              tmplist = cpulist_utils.online_cpulist(tmplist)
>              ldcfg.cpulist = collapse_cpulist(tmplist)
> -        if not msrcfg_cpulist_present and ldcfg.cpulist:
> +        if not msrcfg_cpulist_present and ldcfg_cpulist_present:
>              tmplist = expand_cpulist(ldcfg.cpulist)
>              tmplist = SysTopology().invert_cpulist(tmplist)
>              tmplist = cpulist_utils.online_cpulist(tmplist)
>              msrcfg.cpulist = collapse_cpulist(tmplist)
>  
> -        if ldcfg.cpulist:
> +        if ldcfg_cpulist_present:
>              logger.log(Log.DEBUG, f"loads cpulist: {ldcfg.cpulist}")
>          # if --onlyload is specified msrcfg.cpulist is unused
>          if msrcfg_cpulist_present and not rtevcfg.onlyload:
> -- 
> 2.44.0


This works, but it needs to be more robust. For example
rteval-cmd --measurement-run-on-isolcpus --measurement-cpulist -2,4 -d5s
fails with
rteval-cmd: error: argument --measurement-cpulist: expected one argument
although this works
rteval-cmd --measurement-run-on-isolcpus --measurement-cpulist +0,-2,4 
-d5s

Also, ranges are not supported, it would be nice to do
-2-5 instead of -2,3,4,5

Thanks

John

