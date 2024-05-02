Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3A17B518
	for <linux-rt-users@vger.kernel.org>; Thu,  2 May 2024 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677241; cv=none; b=V6IZ3d1/0aQNUm5/hVgNw4uXIpwnAqwNV9ATIfNWTdirq6suXsflVCLaR+8niCdEiZXmJ8F4BvalWtFXHPMQwz2lrz8uIxZtEiN65KBfrNyoeFWBBX7CKAUMuUuaebFpRe+TF+j8BHLSNMwjvZYJ3rxdXaf/MvYcDPtYZ/s85kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677241; c=relaxed/simple;
	bh=LXN1VmNqKv+uIgrCyRE35bOPiVlpoPw4owHABzab9Hw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PKjK9HREdfM7X/FGXdB68YbENIydNQvg/mXmhGq9QbZnL5Rcn3hJcXrL+aDe+en8I3FHzPfftVRqbM1nQ7qMD7Jev2jqiE9yqCiclJLKuF4aBquQYiqxhxUROq1jDO/YOQpRtVGanDVLWu9Uit09D+tRPOVPYVYeIPqQ6hU+oXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnH0peTL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnH0peTL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714677238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/5WngJOxe4Q2+fLwd7en0PphUvpZvRY31iujNOuB6o=;
	b=WnH0peTLqsD6TYGR5BvuyZWTcwBYsUTNmU26tEFqQtKpxpYb96MmdWPx5wkX0f9b5Tl9m0
	6yhhrf8cp14Ws1NezmEy39ra4KSYmpKxSWUD/Ru131osd5uUz5DRDD3dtkIxePVtVnbT+9
	bVJ76EdHAyXbOnfMclGb7KgFdRhjDiM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-dIjoChZDPuufmcm8zCcgfw-1; Thu, 02 May 2024 15:13:56 -0400
X-MC-Unique: dIjoChZDPuufmcm8zCcgfw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a0bad9e756so53055706d6.3
        for <linux-rt-users@vger.kernel.org>; Thu, 02 May 2024 12:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714677235; x=1715282035;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/5WngJOxe4Q2+fLwd7en0PphUvpZvRY31iujNOuB6o=;
        b=GyFQrHqnlRQTtIjNeWEATEP+ZJzPDtJlSC+SvmlIO5ecGxesrGJozqK0fGTn+qWhtc
         m28HmI/8NNF3Vh6ArQZEr3X8pivKH67KCy0/olEQ8OJO541DQuwQIVo4yar5cQAVWpIq
         tCGFiYHG3fG8SFrxUY4rNUowXCMQZdPeKeOQTrAmHvCPapZpxDYL6quOaOR+3MuYYA6T
         1TH/FM8tUVQGbsCzO/0ob6aM0RHjo7ELQLqng0UG20I6T/c4uMPY9nmHubD3QUIsoXME
         UtusZliH0IoQ7HZsFoI0S+EIKIXytb1uCKfJ/+sLFPjZGrNhjaNbqmZiIu3vGAQdoahR
         CWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9lDM+3RhtPvliyF7t8zfaiGjdjr7g2nLUqtAd0Z0blNGc5pk/KX2f9JFgjtpUfvN/i7Ov4koRj2SKBYWMqDk/625xEfxraj0q3VBzaYQ=
X-Gm-Message-State: AOJu0Yw4dEumsfA8bgRiXsJLt7uvclE3D2ANuWDLXOr+d4YPACjYfo0e
	7YWSrCfHbuEYh0kXdpma//MUQ/HPXKiTFqXwW7V4FPY5kMe5OJ/E0RHWM8zQIQT+prO9oSS8HkL
	or+QmOS2tSIxHLvTTXPJ1MWjzFk+c/r533088/+mnXNJMR188+zCA5IN+6aI7dTyBEq8jMHsH
X-Received: by 2002:a05:6214:b6c:b0:6a0:6649:c7f3 with SMTP id ey12-20020a0562140b6c00b006a06649c7f3mr622772qvb.41.1714677235613;
        Thu, 02 May 2024 12:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7DHwnjbBXwyWao236/I0iynZPl5zDLzPyWB0hZupJcy7fVpVwpVzP320cColO/Y298eG84Q==
X-Received: by 2002:a05:6214:b6c:b0:6a0:6649:c7f3 with SMTP id ey12-20020a0562140b6c00b006a06649c7f3mr622749qvb.41.1714677235156;
        Thu, 02 May 2024 12:13:55 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id q18-20020a0ce9d2000000b006a07e3701a2sm560855qvo.143.2024.05.02.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:13:54 -0700 (PDT)
Date: Thu, 2 May 2024 15:13:45 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: cyclics: Omit empty histogram buckets
In-Reply-To: <20240501204944.228386-1-crwood@redhat.com>
Message-ID: <974cd5d9-f027-5e51-e6ba-fd50e4759d4b@redhat.com>
References: <20240501204944.228386-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 1 May 2024, Crystal Wood wrote:

> This makes the output more palatable for human readers, at the expense
> of requiring other consumers of the data to be able to handle the missing
> lines.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> Don't apply until the below patch has been merged in rteval:
> https://lore.kernel.org/linux-rt-users/20240501200922.226347-1-crwood@redhat.com/
> ---
>  src/cyclictest/cyclictest.c         |  6 +++---
>  src/include/histogram.h             |  4 ++--
>  src/lib/histogram.c                 | 15 ++++++++++++---
>  src/sched_deadline/cyclicdeadline.c |  7 +++----
>  4 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 8a963392e639..c5c33898c63c 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1340,13 +1340,13 @@ static void print_hist(struct thread_param *par[], int nthreads)
>  	fprintf(fd, "# Histogram\n");
>  	for (i = 0; i < histogram; i++) {
>  		unsigned long flags = 0;
> +		char buf[64];
>  
> -		fprintf(fd, "%06d ", i);
> +		snprintf(buf, sizeof(buf), "%06d ", i);
>  
>  		if (histofall)
>  			flags |= HSET_PRINT_SUM;
> -		hset_print_bucket(&hset, fd, i, flags);
> -		fprintf(fd, "\n");
> +		hset_print_bucket(&hset, fd, buf, i, flags);
>  	}
>  	fprintf(fd, "# Min Latencies:");
>  	for (j = 0; j < nthreads; j++)
> diff --git a/src/include/histogram.h b/src/include/histogram.h
> index c7aba68ffb99..31fe2a08eda0 100644
> --- a/src/include/histogram.h
> +++ b/src/include/histogram.h
> @@ -36,7 +36,7 @@ int hist_sample(struct histogram *h, uint64_t sample);
>  int hset_init(struct histoset *hs, unsigned long histos, unsigned long bucket_width,
>  	      unsigned long num_buckets, unsigned long overflow);
>  void hset_destroy(struct histoset *hs);
> -void hset_print_bucket(struct histoset *hs, FILE *f, unsigned long bucket,
> -		       unsigned long flags);
> +void hset_print_bucket(struct histoset *hs, FILE *f, const char *pre,
> +		       unsigned long bucket, unsigned long flags);
>  void hist_print_json(struct histogram *h, FILE *f);
>  void hist_print_oflows(struct histogram *h, FILE *f);
> diff --git a/src/lib/histogram.c b/src/lib/histogram.c
> index 35a9d604da86..c21fc49c0a6c 100644
> --- a/src/lib/histogram.c
> +++ b/src/lib/histogram.c
> @@ -114,8 +114,8 @@ void hset_destroy(struct histoset *hs)
>  	hs->histos = NULL;
>  }
>  
> -void hset_print_bucket(struct histoset *hs, FILE *f, unsigned long bucket,
> -		       unsigned long flags)
> +void hset_print_bucket(struct histoset *hs, FILE *f, const char *pre,
> +		       unsigned long bucket, unsigned long flags)
>  {
>  	unsigned long long sum = 0;
>  	unsigned long i;
> @@ -123,10 +123,17 @@ void hset_print_bucket(struct histoset *hs, FILE *f, unsigned long bucket,
>  	if (bucket >= hs->num_buckets)
>  		return;
>  
> +	for (i = 0; i < hs->num_histos; i++)
> +		sum += hs->histos[i].buckets[bucket];
> +
> +	if (sum == 0)
> +		return;
> +	if (pre)
> +		fprintf(f, "%s", pre);
> +
>  	for (i = 0; i < hs->num_histos; i++) {
>  		unsigned long val = hs->histos[i].buckets[bucket];
>  
> -		sum += val;
>  		if (i != 0)
>  			fprintf(f, "\t");
>  		fprintf(f, "%06lu", val);
> @@ -134,6 +141,8 @@ void hset_print_bucket(struct histoset *hs, FILE *f, unsigned long bucket,
>  
>  	if (flags & HSET_PRINT_SUM)
>  		fprintf(f, "\t%06llu", sum);
> +
> +	fprintf(f, "\n");
>  }
>  
>  void hist_print_json(struct histogram *h, FILE *f)
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 7525ad136d2c..631d57ee885e 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -731,11 +731,10 @@ static void print_hist(FILE *fp, struct sched_data *sd, int nthreads)
>  	fprintf(fp, "# Histogram\n");
>  	for (i = 0; i < histogram; i++) {
>  		unsigned long flags = 0;
> +		char buf[64];
>  
> -		fprintf(fp, "%06d ", i);
> -
> -		hset_print_bucket(&hset, fp, i, flags);
> -		fprintf(fp, "\n");
> +		snprintf(buf, sizeof(buf), "%06d ", i);
> +		hset_print_bucket(&hset, fp, buf, i, flags);
>  	}
>  	fprintf(fp, "# Min Latencies:");
>  	for (i = 0; i < nthreads; i++)
> -- 
Fixed title to say: rt-tests: cyclictest: Omit empty histogram buckets
Signed-off-by: John Kacur <jkacur@redhat.com>

