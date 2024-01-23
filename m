Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A782D7B
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041746; cv=none; b=YNqFhJHqbQS5HddDopwCbtmOlmBysB/Jz9vIlgcx4WAJLIeIZudFEwmpZ4srvW98snx68RH6a2imP/CkDNI79NhwdbiYjLCwoHR1rVevjo9yg2X9Ue0iKK5m+yeB3vBnFrC77hw4+1wP6ZNjMswebAvIYA+zR7kP1nlnGC7JSSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041746; c=relaxed/simple;
	bh=1YHN9QQTEOK7MYzsljUpNdhzMuKp7rpdgrLHyVCTwgM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XVsCNoSMAJ6RI0dbCYHC55IY7361VXVOBEGWcJA3LP5ZO9JoBETRPcY7vjnGj0HKC6BrHnslxNLNJPmZOPjm7UUu9dabewH3eYXkwe9V0VKze3jIFZOxYQuUD+ClqdcYMSrMqdQ85ANv7JFOT1kNSEsfGIPLv7SkwWDFQ6Psb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqLwcd4M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqLwcd4M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706041738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VRe0MS5o7PexXS7vcOb1YN5SogRe/7ljS9qS0LPwXwg=;
	b=OqLwcd4MrzP5N0GE+a3fde3yz+xv6h8/+xRgBkdf//hSiJNu8YG409OKRj3zeju/Dra+gg
	n16hnxz4ZNtnH7ZHYFFiy0cKQGa99NL15ZK1qpAbpgA2UlNAcqsEBYfqMrL/UNra2MjRzC
	g1FbMBKqSy8M/eQ6WWYM+4B1V4EkEm0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-yrtuPZGQNuOegtykHWLUMQ-1; Tue, 23 Jan 2024 15:28:56 -0500
X-MC-Unique: yrtuPZGQNuOegtykHWLUMQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-214430d7918so2632726fac.0
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 12:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706041736; x=1706646536;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRe0MS5o7PexXS7vcOb1YN5SogRe/7ljS9qS0LPwXwg=;
        b=el1XL9Ms6LLtHOFAPahjzhNduuQlhiFeR40djr0D9gzDj2WxANLlfXT2EUKFRYoxAW
         NSBUXAQxUPU/OV5+fVIYIt1F8ZVONZMHAX+/ou3kHDBMC1HgZmVwuuQ/7EIy0VvAfZbg
         8wGOwqHCEhXga809joLIsJpF25P7hLYoixxfcynKGPEyod/PKEDTM3maYemm7mwiOHC8
         NjvK8KX5tCChSiKLul955/rGTF3fZ47apPwf5O7DErhC8Og0Y2sjFawZSesi9g/2UwFc
         f9VTn553nS9Fgr7V0FyFnwWcBVQcSNiH0N8H8QfaRhpDHzGl9yMbkzShPZbgJarmAcqd
         8iPg==
X-Gm-Message-State: AOJu0Yy6cOhwx6tLuKgy4+Lo/+yXIbxTBbqsaTCdV+6AAh/9QAb+1qFl
	gKU/27Kptue2GFCNPlporvUDJyg+pnMSIwHTuCvbCJYTIrqQpHL4z/PlqV71VRIZY+YyGd9uFpj
	1qf6R/KhYAJH1eh3t0ZdJcVLutuFkfBaNS//DJj9TzjTv97ibI+InCTKk6qqA3dcO
X-Received: by 2002:a05:6871:60f:b0:210:b2d9:aa0f with SMTP id w15-20020a056871060f00b00210b2d9aa0fmr2333009oan.18.1706041736109;
        Tue, 23 Jan 2024 12:28:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk/qyjCMUG/YK80v2VB29e74kI9Kjia96r6Oafdf5WmVVQ0qFAL7Fgllluk1RKp66g+Uoj7w==
X-Received: by 2002:a05:6871:60f:b0:210:b2d9:aa0f with SMTP id w15-20020a056871060f00b00210b2d9aa0fmr2333004oan.18.1706041735794;
        Tue, 23 Jan 2024 12:28:55 -0800 (PST)
Received: from fionn ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id c14-20020a05622a058e00b00429f6fcfc6csm3750160qtb.57.2024.01.23.12.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:28:55 -0800 (PST)
Date: Tue, 23 Jan 2024 15:28:46 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/3] rt-tests: cyclics: Fix json segfault when not using
 histogram
In-Reply-To: <20240122221321.9545-1-crwood@redhat.com>
Message-ID: <96d947e3-21cd-67dc-638f-b3142d0d4f43@redhat.com>
References: <20240122221321.9545-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 22 Jan 2024, Crystal Wood wrote:

> If we're not generating a histogram, don't call the histogram code with
> a NULL pointer.  Also don't print the rest of the histogram json node.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  src/cyclictest/cyclictest.c         | 11 ++++++-----
>  src/sched_deadline/cyclicdeadline.c |  9 +++++----
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 6169170fc66d..33fac3b95f5d 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1778,12 +1778,13 @@ static void write_stats(FILE *f, void *data __attribute__ ((unused)))
>  	fprintf(f, "  \"resolution_in_ns\": %u,\n", use_nsecs);
>  	fprintf(f, "  \"thread\": {\n");
>  	for (i = 0; i < num_threads; i++) {
> -		fprintf(f, "    \"%u\": {\n", i);
> -
> -		fprintf(f, "      \"histogram\": {");
>  		s = par[i]->stats;
> -		hist_print_json(par[i]->stats->hist, f);
> -		fprintf(f, "      },\n");
> +		fprintf(f, "    \"%u\": {\n", i);
> +		if (s->hist) {
> +			fprintf(f, "      \"histogram\": {");
> +			hist_print_json(s->hist, f);
> +			fprintf(f, "      },\n");
> +		}
>  		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
>  		fprintf(f, "      \"min\": %ld,\n", s->min);
>  		fprintf(f, "      \"max\": %ld,\n", s->max);
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index e449be57870e..b3155547b9bb 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1141,10 +1141,11 @@ static void write_stats(FILE *f, void *data)
>  	for (i = 0; i < nr_threads; i++) {
>  		s = &sd[i].stat;
>  		fprintf(f, "    \"%u\": {\n", i);
> -
> -		fprintf(f, "      \"histogram\": {");
> -		hist_print_json(s->hist, f);
> -		fprintf(f, "      },\n");
> +		if (s->hist) {
> +			fprintf(f, "      \"histogram\": {");
> +			hist_print_json(s->hist, f);
> +			fprintf(f, "      },\n");
> +		}
>  		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
>  		fprintf(f, "      \"min\": %ld,\n", s->min);
>  		fprintf(f, "      \"max\": %ld,\n", s->max);
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

