Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866441F2371
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466839; cv=none; b=ST66lyNfVQnV3BUoyDJ/v6MDR5NavhhJmJl7GKSHoT8QB38iU7lFWtE/F5WmMBPDvY3QdGwcaPthOkK5mVvw8NOwPmPAReNshlqFuEC2rs/SbuZ2nwtSksTMNXXmothVt1AOHzYMOLt7h3m8Z/x+ga5exBXkywM95PWwjZQTUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466839; c=relaxed/simple;
	bh=oI3k11Q5uUm6W/TrgeYOk1C9hGdjsGEqqBLDpcqnSws=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X0ULg8ku9zTdXYR8KHFCMKLXuXePpPsOjFO2BkDLKI3JZEuVITcxJW8iihOH9fresNLptl8hSjfiBq52rNdGLxg5rY92tOfiiDQsby0DE0cNiu8jmpBWYMJbnliOT7h0pHAcjXOHEy98ZyZ3AsyIQt76AhiLJdYWN075Buzlm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3/LWdUT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3/LWdUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753466836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1JhKKcgiCDN7zj7qeDDSqTJqAIbFt1Yc77uvyVEA/4s=;
	b=H3/LWdUTzVuazFvmpqYzUb/M3LNKw/535s2gW2Rc9nSgs45IemGZrDOvQ7sqhRaDpG12QD
	7n92kbJzXX5Z7XZQofgRFqvc2O8mBzC+HOIF0rx6s3aF2S0uhvXyCbAdexmLi6X1QnOrXd
	gB5Bwe7AgAHc51m7FB4heI3k7AAu01U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-TmmyBiVSOm6qUWPXu6SDVg-1; Fri, 25 Jul 2025 14:07:14 -0400
X-MC-Unique: TmmyBiVSOm6qUWPXu6SDVg-1
X-Mimecast-MFC-AGG-ID: TmmyBiVSOm6qUWPXu6SDVg_1753466833
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c955be751aso357534785a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 11:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466833; x=1754071633;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JhKKcgiCDN7zj7qeDDSqTJqAIbFt1Yc77uvyVEA/4s=;
        b=NI++dBi1J34p9T6Ff6PWXfh0x4pmSe2Z3YiBMbLnk1ZhIernNb7C5QirlKgxjK+3N+
         tlgl4hpB5uTfODfDCl6DwOAfp14belc4AjXbbkVkR+hfMuLEQxgyfyu+gkjq3x4PFuQu
         1v6fM9i2+rqKos5+LxHOE9I5F52K1Goa+EuXfpHZZ70Hq6nW7qh3ohC8CnkAl026Nax7
         mYeicvdFzv6+BbfRsoOkcvGzE0tqhIusuOg1cdncA2fLdkxpcQOXtDnBlHjOhAlajHI6
         i7i1dVgWLW7PzCgQQ5iXr8mN7KFZFv/pP4/ImMq9INsGqGB8xGx5+Me8SnPLOaeTn9E4
         Lrkw==
X-Forwarded-Encrypted: i=1; AJvYcCUecd5At4kpthvzC2a5FtoVyRe9uuWSMrZ2yP5HJVQCKsT9dEVCLSuLw8xTRSIbOVpfys8sJzGnDAlEr5I9Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/A4QSGCmEXeGEYoDdS20tfumzjnZVCglmev0US4o9kUvhPoZ2
	wKHYq5ZIbaW2govwnQ1a9ItjHLfn/4iQeMW+GvRgmyB4OmBzXZRg0H9E8idhtwmcSeo1jWQv7mA
	hOvY9o31WhWqGOc+4brjBp6bvfpkIj9Y7XRTXf9msW+EZ6NExoreA/jS3Aan+5wDI/z8k
X-Gm-Gg: ASbGncv+OSiAxFlbSwlsQQZFhhA1zwctUwncCxzJwVCv9PQHh4HKrguENehGgFlGBQE
	MMPKDMCuQvBrcMpsn3fwQ4eskWkZBrTjpniy6nfmtXo+NcrjkTqJx9TyKlcigV9d0Td82jnc48+
	gDNRadXYHHY3a3E6y7n3pIanJGhkAVCD3z2KjCMdeEpoL5V4iXPkotVhSLeyOu4MBM/g0wyWg35
	nCXjrApx9NUeARlkenGAnkFzVYfqxMUa+RfhSDeIier13aO3HN7ZKkfJYDP9rvSdvj2W1ov6zoO
	ht573U1vCRkqQn+GDo/y0FiLPjE+2Q==
X-Received: by 2002:a05:620a:237:b0:7e6:25af:bbe2 with SMTP id af79cd13be357-7e63bfb9102mr293313385a.42.1753466833431;
        Fri, 25 Jul 2025 11:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaOAPjCuI9xSyJ/ZaFoQi7MXYFoJVGYH6aFjnWBYwyCw3qOzZXj2LUeiBj0JNgKvQwSqfBig==
X-Received: by 2002:a05:620a:237:b0:7e6:25af:bbe2 with SMTP id af79cd13be357-7e63bfb9102mr293308285a.42.1753466832892;
        Fri, 25 Jul 2025 11:07:12 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729ab2d50sm3001376d6.43.2025.07.25.11.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:07:12 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:07:11 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 2/8] pmqtest.c: Suppress warning
In-Reply-To: <20250712134213.58582-3-yphbchou0911@gmail.com>
Message-ID: <35888167-ac6b-e8a9-c884-17ffc7ae109b@redhat.com>
References: <20250712134213.58582-1-yphbchou0911@gmail.com> <20250712134213.58582-3-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 12 Jul 2025, Cheng-Yang Chou wrote:

> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  src/pmqtest/pmqtest.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index 04e36a1..eb20baa 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -75,6 +75,7 @@ void *pmqthread(void *param)
>  	int policy = SCHED_FIFO;
>  	struct sched_param schedp;
>  	struct timespec ts;
> +	int ret;
>  
>  	memset(&schedp, 0, sizeof(schedp));
>  	schedp.sched_priority = par->priority;
> @@ -189,7 +190,10 @@ void *pmqthread(void *param)
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
>  				if (tracing_enabled >= 0) {
> -					write(tracing_enabled, "0", 1);
> +					ret = write(tracing_enabled, "0", 1);
> +					if (ret < 0)
> +						fatal("Could not write to %s: %s\n",
> +						      tracing_enabled_file, strerror(errno));
>  					close(tracing_enabled);
>  				} else
>  					fatal("Could not access %s\n", tracing_enabled_file);
> -- 
> 2.48.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

