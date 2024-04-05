Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA4171E41
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351787; cv=none; b=UJw7iwcKBOMpJb33oS44kX0yWw4wx+or0BkA5urTdAaQJfVsIcX7XJoDHmif7IE5Ue1GfvDf/SJh7SZbY80cOt321qOr4nT22qkHTmhwdBALCs2+R8ivvVF1vGnWaagnWOCKevl9xZaomrQDiPB921gXhRfxKKRUFNnUHKBYdRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351787; c=relaxed/simple;
	bh=GSsAUan1a8gEUXvKq/rDPvysLfsRTNNtGeTMTjGuC5Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hBTpMb2Jw55bWvAr+G07fBM2R865ulcLKtGan7FrponaKRoe2IwXtWhok8JVLE/G6TWWioRIdcKXcyZ4W0k7CdmeYu9sDM4cNK8+7dmIrmCVvsqwA23QheP3W1n3D+be9dqlssZcvFQEl2QULblxplMyfV6h6kPm0oCJqgKUSDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEwDxvvO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEwDxvvO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712351784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqFbFjtcQbnUVBFjrIukJgmt1fiJzImZU6jd9vKcT0U=;
	b=hEwDxvvOpj39P6k5OJrUleA3WZ2/uUvDiBjW5Sf2+kgS1xqqxLEuC6XAuF5zVUBvGp6jKY
	lglGNiB44T0RwlfZ+ow49QlkRF+LuRYnMl3e+HKemo40Ywi1cTqXsIPRmGPVYSRFcezgRD
	rCQp6ZovEF9AdqJcQpVlMaVK+vVTHBA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-AZnsGLc0P0ubqFp4av8QDg-1; Fri, 05 Apr 2024 17:16:22 -0400
X-MC-Unique: AZnsGLc0P0ubqFp4av8QDg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-430a74cc3d5so23443741cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2024 14:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351782; x=1712956582;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqFbFjtcQbnUVBFjrIukJgmt1fiJzImZU6jd9vKcT0U=;
        b=PL2Y/npkfQIdgTjbLoOtU/GYmE7oV5egLqoMa2xC1mhwtsLxcmQdMECoo02fepPR3A
         lhW1XvsFzSLSC0qyouUuJ3YwdbbSb3Pm15bnukKHGj2iabjXOia835lJgERlf3utOSjO
         Y4elix/qBQyKIdOuH0kf/M1/GhLcAe6MYs8py6buuld69OV8HXh9k1nNlhE8zkmOYXBl
         laJr2qH8jyAcKAuPS3NiBXzu9njSYi2M2AN4aF1DYXD9iiH+z0TWgGGjHhjPif9gfNLa
         EgsJi67pNdn7G4g6m6X+u5fp9ku+pB6j6B/ZnOynKEfjFdKUAP8OKArV/4UPFMdz94ob
         Pb1g==
X-Gm-Message-State: AOJu0YyiAcPSCcqg/Z7K43EfDCrBVvKsZRGY2GgBznR6ebYn/tVj7HP7
	z8VFWT4yposXbOTKTh7NKh7ooyZZ6VvobgpIK74UQxXOlZUQWbrphS7iMG0mO+aueepeIVVCB4F
	rF2kWA1qIeLzE3oWAxOWTtV6udz5UNCW18EDyCFfVyNw3jMB4IqGkJpAYlo51W3BMkiptGNcT
X-Received: by 2002:a05:622a:1210:b0:434:3333:77e3 with SMTP id y16-20020a05622a121000b00434333377e3mr3252318qtx.29.1712351782130;
        Fri, 05 Apr 2024 14:16:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESvhreqjtm/ssP4t7VG+ttXk6fmCVn6anIgDR4FoOM4YYiqqBYoQchK5hW3OisMkPS1FXprQ==
X-Received: by 2002:a05:622a:1210:b0:434:3333:77e3 with SMTP id y16-20020a05622a121000b00434333377e3mr3252303qtx.29.1712351781845;
        Fri, 05 Apr 2024 14:16:21 -0700 (PDT)
Received: from fionn ([184.147.142.166])
        by smtp.gmail.com with ESMTPSA id h14-20020ac8744e000000b004314e13afa2sm1101557qtr.29.2024.04.05.14.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:16:21 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:16:12 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rteval: Add relative cpulists for loads
In-Reply-To: <20240404081438.252394-1-tglozar@redhat.com>
Message-ID: <6a46a773-1436-ae0c-be25-bbec72020966@redhat.com>
References: <20240404081438.252394-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 4 Apr 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Relative cpulists were added for measurements in 64ce7848 ("rteval: Add
> relative cpulists for measurements"). It was observed since that this
> feature would also be useful for load cpulists, for example when the
> measurements are performed externally and rteval is only used to run
> loads.
> 
> Add support for relative cpulists also for loads. This works the same
> way as for measurements using parse_cpulist_from_config, only difference
> is there is no --loads-run-on-isolcpus option. That is, --loads-cpulist
> now also takes lists with addition (+) and removal (-) of CPUs against
> the default list, e.g. +0,1,-7,8.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval-cmd | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index a5e8746..2ef6cf4 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -339,29 +339,32 @@ if __name__ == '__main__':
>  
>          ldcfg = config.GetSection('loads')
>          msrcfg = config.GetSection('measurement')
> +        # Remember if cpulists were explicitly set by the user before running
> +        # parse_cpulist_from_config, which generates default value for them
>          msrcfg_cpulist_present = msrcfg.cpulist != ""
> -        # Parse measurement cpulist using parse_cpulist_from_config to account for run-on-isolcpus
> -        # and relative cpusets
> +        ldcfg_cpulist_present = ldcfg.cpulist != ""
> +        # Parse cpulists using parse_cpulist_from_config to account for
> +        # run-on-isolcpus and relative cpusets
>          cpulist = parse_cpulist_from_config(msrcfg.cpulist, msrcfg.run_on_isolcpus)
>          if msrcfg_cpulist_present and not cpulist_utils.is_relative(msrcfg.cpulist) and msrcfg.run_on_isolcpus:
>              logger.log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
>          msrcfg.cpulist = collapse_cpulist(cpulist)
> -        if ldcfg.cpulist:
> -            ldcfg.cpulist = remove_offline(ldcfg.cpulist)
> +        cpulist = parse_cpulist_from_config(ldcfg.cpulist)
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

Signed-off-by: John Kacur <jkacur@redhat.com>

