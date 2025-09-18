Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA096213237
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218785; cv=none; b=fpdA4wyemQP3pnuH3JorxAr+8sZf0hQ+3EVa1hI163YoeB1nGbLqU54+Nxd640+kfZPpfuncBl5xL8h0/8VJ2KPJK5D3/Ej6vQvUzkwIImDYnQIuB6W55iROmaVx4Q2F65WxzsWR+GPsFm4751/R02dld3DNG+RQyTf+KOkhWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218785; c=relaxed/simple;
	bh=YtI0uMSK9JTGVNLrzvnnXN5zPOrU8iQ0D65qkUijErs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uNselteTUVKVSzC+q3DpF2R0YxkYWO4BTBlChajIiUrl0nXiDxlctBjoOb3cfpuN9tlSh8tc95bTCP3uSAXJQiifRSfhYkdksmaMbGmzFJWEnHzXwICxJPB6PxuNjolsfZnkA408sArq96PbE8juHL64sk40qTV02hkZ0iJZRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHMF6riZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHMF6riZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758218782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LO7Iw/MFp6PLLZ8vuSs+XWoaKQLmpk925vsKAlIlttU=;
	b=UHMF6riZ4ktQJlGObmGZo8j/+g00YTNMC2mXyQ+azb/qfggyTVh5Yyg2wsh4y/bXdpQfCJ
	7G5sP4gSuVCquzp4hJlFm/snJWEvEcQCBQ+dOoxwwyZqnn5Rvd9ttwNThDnuxFBlKfY1+5
	s4DkunkmWx3CpTSGrBlLyTKxsxoH66o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-DXR8i3djMre5uVuiLFfOjg-1; Thu, 18 Sep 2025 14:06:21 -0400
X-MC-Unique: DXR8i3djMre5uVuiLFfOjg-1
X-Mimecast-MFC-AGG-ID: DXR8i3djMre5uVuiLFfOjg_1758218781
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8063443ef8cso359994685a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 11:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218781; x=1758823581;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LO7Iw/MFp6PLLZ8vuSs+XWoaKQLmpk925vsKAlIlttU=;
        b=QQeRyBoTbwNkRZZVaPR++6fZ8FtNYHVAB70Vh3ThNCnnB3KTRPIaWDuI2ZM6ny0ezf
         P6GWsCe1iU+cZM/G798lu90RCl7ms9oqDWunannolot64S4z3cOHwgPLO0NoVRRrBDBA
         RmbQk3QG7C68Z4NkUGBjjmbVw+X4FymMFMwhFRYBNhGB1dJOoCxihcexBpHqTltZWOo6
         M0J6n9uHvF+uN/0Go+akjUM63iXm2bwQ8moA0K3JD/d1/c237Zyw+rYTkBog1AaeidfL
         dS433xqUL8ujHlkWtWu3qJwXhHpqZxft57f6zvjz9nWY9xDpEelwe7qa28q/6GxIOFe+
         xMfA==
X-Forwarded-Encrypted: i=1; AJvYcCVcTI5ggMnuiYTSj9mcvHJ142l+jNdJs8CeJpPvRYDgzpNhpMOGBz3nN+OsCU+QnX2d5SSfZqgPK21c+ZmJfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBd2iwWQ4kWwSljp4WW2mglREFNLDBOqryIfKDKNQccHZkUVwx
	sRlyWPJOpROi5tndlzEtlImRvGrS9dY/T4zmi9w/d0PcMvNj1OPRyceGFKjLrICcbDxpFJfwQ0z
	BykHS7kflnl/sGVQR/igfSxBwU9/jW0rIiiQoEpDK3kC/Ujygp9clcGuoVf0Udg+dlvJR
X-Gm-Gg: ASbGncsxlv5bsJFVnsrCBILrprSHOoG48fMEAYRTpdk8zAcLYQJ3uyCkQdxDX3PaBkR
	lcfhvF9Ob74b58557dF4HtaRlWnTNA5buhavnvrHv/ZhQjuA0s0zxPRSdK8tPPTd912ducKfNpf
	mmKTIBk8rjKwNW2fDDssFsQw12DpyjFCPPdSQDJ62agQQveD//JC+y04kjNZEpx8F+p4+kl7tVC
	jtcv5QctXhjZUW8lvTCqUwtFeeFkJg8BAWZ0nkCLtnOdS9sBT3aRRMl9VPB2mqLptOTURubOIo1
	WeDDYqtS2FICVW4bbrNZgzURlw==
X-Received: by 2002:a05:620a:17a3:b0:82b:54f:5b8a with SMTP id af79cd13be357-83bac4afa51mr71215285a.75.1758218778946;
        Thu, 18 Sep 2025 11:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmL6w8mZIEvo4yqDTwwyMt4ck5g5aAN1nn9eYS5DnOG8qQzyBQp2QVrPBuluwnsdnmqDF1cA==
X-Received: by 2002:a05:620a:17a3:b0:82b:54f:5b8a with SMTP id af79cd13be357-83bac4afa51mr71210885a.75.1758218778542;
        Thu, 18 Sep 2025 11:06:18 -0700 (PDT)
Received: from fionn ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda86b3a15sm16716421cf.24.2025.09.18.11.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:06:17 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:06:06 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] tuna: Add common virtual envs gitignores
In-Reply-To: <20250813200839.82200-1-jwyatt@redhat.com>
Message-ID: <3c66730b-a473-f103-bf13-cc19d312880d@redhat.com>
References: <20250813200839.82200-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 13 Aug 2025, John B. Wyatt IV wrote:

> Virtual environments are a common method to develop in the Python world.
> The virtual environment directories are ignored.
> 
> Copied partially from https://github.com/github/gitignore/blob/main/Python.gitignore
> 
> License of copied text: CC0-1.0 (Public Domain declaration)
> https://github.com/github/gitignore/blob/main/LICENSE
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>  .gitignore | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 29b00a0..1fa5bbd 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -2,3 +2,13 @@
>  *~
>  *.swp
>  tags
> +
> +# Environments
> +.env
> +.envrc
> +.venv
> +env/
> +venv/
> +ENV/
> +env.bak/
> +venv.bak/
> -- 
> 2.50.1
> 
> 
> 

I ran in a python virtual environment and only got an env directory which 
I deleted at the end. Are you actually using this, or is this just 
theorectically something we might want to add?

Granted, I didn't do anything complicated with this

I also understand you are trying to do your due dilligence by referencing
where you copied this from, but then pulling in another license to do so.
This is going to cause me headaches for something kind of trivial.

I'd rather not have a lot of patches creating churn in something like 
.gitignore, if we start using this a lot and it becomes more convenient to 
add somethings here, then fine, but then figure it out yourself, and don't 
copy from somewhere else. I think we'll just ignore this for now please.

John

