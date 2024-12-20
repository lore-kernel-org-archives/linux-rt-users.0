Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BCE21B918
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Dec 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734718071; cv=none; b=bqKIV7eZvN1aOkV3h1EPTENB8C3M5RNxByuVwS/lWax4seFi5mBSDKjg6YeKu/GxS7sP4sNFi5+1HqgP+CG8VsgwF/C1FyfErkIhMfGBLA8KzBYD7yIW9F1lnZrpTvkaKMrv/8escL9TGGLjCsR+eSvyYRu8DryFBZQHgCHXOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734718071; c=relaxed/simple;
	bh=GknkQ8NcZymPr9CAcxLmqiWO315YyuaqSFYM8cNc/Ys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bHacymFkhNV3FHWRNOWeNSu4K3/4Uwb6GThQhVg+KxbJCTKlD5GNopCUtH5o2tbVYnaMzfuksakHWyB0Bgj1lve1NsQzeDDyvj42072AhbiURbXKcFa42sxRLbSpn98k/crwzLIwLOPgNcx3zDIL9ltxguNwrMlYs7OefyWXaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/Gqd7IB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/Gqd7IB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734718068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFpnuvgIh64oaItfUhdpqETz5xe9wJEEG0AusGW24Y8=;
	b=G/Gqd7IBo+RFra8oaRKJwcNI52AyVr/uVsRW1t1c1yPzXSx2Gj9LiYdbYioHUXttkx6a5j
	Xrg/Sa2iuPqMfMr+VVVrs/vLk9vm/Cjzzl8rjXfZEi5BmoUAqiimwQbvX8l4iKRUuVbjTT
	jI2Q4zA8IfZlYyNPNk/JDIo71YccXOA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543--Uexest7P_2BTBALi1DKrw-1; Fri, 20 Dec 2024 13:07:47 -0500
X-MC-Unique: -Uexest7P_2BTBALi1DKrw-1
X-Mimecast-MFC-AGG-ID: -Uexest7P_2BTBALi1DKrw
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4675c482d6cso34748471cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Dec 2024 10:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734718066; x=1735322866;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFpnuvgIh64oaItfUhdpqETz5xe9wJEEG0AusGW24Y8=;
        b=aZwkijFLyfsiNJ5h+KWbCLK7cxl11pkzgAZfoHvYk+92pLNXeG02455dcbO+PG0WRE
         CNaKAQ69qN2Y3pPKcyKHtXqM/utNZ+1wKFSpiqWDOpZwccTXNZOnvmztUvttuo/qjMCz
         gfAuRfPu3yROeZfeSta11x/oN5TNGoy1AWTKCCzF4Zwr73zImNoKjpK9scgXKlPIrZER
         3l5LP1xZBBiZLyvCgJn3O+JjsVkuYqoh/Icgg6jNrUmBH6mIJE+YW5vZWlSdQEyL+zee
         ZBNnqMqgGbpBRt01vE+D7ChpU2r86ZYvHDmC8RDxVS0rwBrhXZ5b7E6QKojEsX6hs9jj
         +D5w==
X-Gm-Message-State: AOJu0Yyi/aJL2+C9GQbUOFkL1Wa6+RKQCWHm/YplC3LUSydhKjI4y+6U
	EGgdrd4GQpzih7DiLNakxUBbAWGNj0m3r88oW4t3uldU15pgVa3xl3SbbsZBFwEFOu7jCweguHH
	ayI1CcWTCwV+DVLQecp318uvS4IK3fFi5wqO79J7QkErvrPO171Ro8Ea2jRzGS4fX
X-Gm-Gg: ASbGnct8k83i46vRmMC8LpEANhdvgJwU0SHPdF61duc3mW5K215PI7Y1aOYBcAXGxYH
	1CymSNv+V4M/MOU8xxu7zyK167i+s8lZtKQL6DsYiuraXdVqI3AqPiDIcP8HtajIzsu84PottaF
	V0EjchwvlCOQUjncvQnSHgSm2pQ7sKWcwJTxWWKAdIJvCQaVdkyP/sTCoQWTYQlOlcM4N7ShEtc
	5mYQpG/f6bO4Eo2xx/RUK9ZiBaFI4unageE1lyX0zmmVaM=
X-Received: by 2002:a05:622a:648:b0:467:867b:ff57 with SMTP id d75a77b69052e-46a4a978b18mr73580961cf.44.1734718066550;
        Fri, 20 Dec 2024 10:07:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgfp+82Yr+iIw/WNUw2no1bxgw8eRPNpwHJi689nG4y/c8zjf9pgmHzdVyz5QZ9mh+n9f49A==
X-Received: by 2002:a05:622a:648:b0:467:867b:ff57 with SMTP id d75a77b69052e-46a4a978b18mr73580591cf.44.1734718066313;
        Fri, 20 Dec 2024 10:07:46 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb1760fsm19014771cf.71.2024.12.20.10.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 10:07:45 -0800 (PST)
Date: Fri, 20 Dec 2024 13:07:44 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tan En De <ende.tan@starfivetech.com>
cc: linux-rt-users@vger.kernel.org, mtosatti@redhat.com, williams@redhat.com, 
    leyfoon.tan@starfivetech.com, endeneer@gmail.com
Subject: Re: [1/1] rt-tests: cyclictest: Suppress unused parameter warnings
In-Reply-To: <20241212162453.2618945-1-ende.tan@starfivetech.com>
Message-ID: <2536ec36-44e3-e88c-1333-678dc41c649c@redhat.com>
References: <20241212162453.2618945-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 13 Dec 2024, ende.tan@starfivetech.com wrote:

> From: Tan En De <ende.tan@starfivetech.com>
> 
> Mark unused parameters with `__attribute__((unused))`.

You were probably trying to be consistent with the rest of the programs in 
rt-tests, however, according to checkpatch, 

WARNING: __always_unused or __maybe_unused is preferred over 
__attribute__((__unused__))

__always_unused is slightly shorter, shall we try that instead?

John

> 
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> ---
>  src/cyclictest/cyclictest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index b1f8420..f2db5e4 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -603,12 +603,12 @@ static int has_smi_counter(void)
>  	return 1;
>  }
>  #else
> -static int open_msr_file(int cpu)
> +static int open_msr_file(int cpu __attribute__((unused)))
>  {
>  	return -1;
>  }
>  
> -static int get_smi_counter(int fd, unsigned long *counter)
> +static int get_smi_counter(int fd __attribute__((unused)), unsigned long *counter __attribute__((unused)))
>  {
>  	return 1;
>  }
> -- 
> 2.34.1
> 
> 
> 

