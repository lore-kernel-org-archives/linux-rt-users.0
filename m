Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgX6tqh2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4FCDD
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2023 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702484504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOidaB6H7tXlduCMGNwmB+CChDYK+kkjPbDMV+UnQdA=;
	b=JgX6tqh2ggiBHS/dKwJhiutr+EzaZMk1QcbTymaHNZ3CeQsZRQo+BB5fp8LUHDonwihsr/
	x8qVqmUaSZi1BtuklCTATnoIpyPTeQD8dYrHU4vxvSoiXhaERMpyk4V53Ge8riKYQHL8qi
	ozzmGD/eo3Bk2w8RLDDBX0CivxQIZl4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-THqYs3DCMLCtKxQZA_Bx6A-1; Wed, 13 Dec 2023 11:21:42 -0500
X-MC-Unique: THqYs3DCMLCtKxQZA_Bx6A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77f2b61bf30so498220185a.0
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2023 08:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484502; x=1703089302;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOidaB6H7tXlduCMGNwmB+CChDYK+kkjPbDMV+UnQdA=;
        b=n+06FHJazwhcRPnYGv39smXaQQAoMhx3D6cgfNyz+ZJoUHSy5V3cgX7DpjGMNtYNsM
         CN+PI7IrzB1YRo65lgNgwv5nAPi7jVVJWFCnqYb5Zu6fx0hC6/vepzfTjce45UxrnvgC
         GPgVk05rGcyQT10DZ9u0TYNZ+FO9K2BN7qR/lAEKvc80noLpoZLdVtSmSYyuwNO8b2uA
         FcArXioGSHEekqAvLd9eau6CLT2wkP3/0FzhK5Hs8IUoNmPRfoljv3xwjPlkodgffJZS
         k8p05G1bY/nE/Q92An+yQaRkpWCybNcvs/aiX/sJdPaqPZMkBcLIh/qNa8yFYHztNxIQ
         bUsQ==
X-Gm-Message-State: AOJu0YyXIXmw5ea9ZhFHdQZxTQHY7HDlk7co7HwsSEk7r5JURrzwUZot
	OuxJ6vwfSIQrNjsVKEAGhmj7aa9ueTwhcGfMlIwBMiaY2xTTJ47pBVVklHP8srblSwbWHr2VkWY
	5yb/DW3aO8eKJ57d3VLIJSq1HY3g=
X-Received: by 2002:ae9:f10c:0:b0:77e:fba3:a7b0 with SMTP id k12-20020ae9f10c000000b0077efba3a7b0mr6067048qkg.142.1702484502206;
        Wed, 13 Dec 2023 08:21:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExpSDcR1meSdakAZpwB6WV6Oj/95WMwQ1MwGfonCZIvWWL+7e7Ar1Zvm/A6mn2GbuZrjbdYw==
X-Received: by 2002:ae9:f10c:0:b0:77e:fba3:a7b0 with SMTP id k12-20020ae9f10c000000b0077efba3a7b0mr6067041qkg.142.1702484501915;
        Wed, 13 Dec 2023 08:21:41 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a13e400b0077dd463da60sm4611768qkl.126.2023.12.13.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:21:41 -0800 (PST)
Date: Wed, 13 Dec 2023 11:21:32 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/4] rt-tests: cyclictest: Remove histogram totals
In-Reply-To: <20231206205508.17148-3-crwood@redhat.com>
Message-ID: <a8cec248-2866-2319-7f0a-f71d068c4ae2@redhat.com>
References: <20231206205508.17148-1-crwood@redhat.com> <20231206205508.17148-3-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 6 Dec 2023, Crystal Wood wrote:

> The Total: line does not seem to contribute much value, as it should just
> be the number of buckets minus the number of overflows.  Unless someone
> complains, remove it to simplify moving to common histogram code.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index a8039b49feb6..93ce201e9fca 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1407,12 +1407,9 @@ static void print_tids(struct thread_param *par[], int nthreads)
>  static void print_hist(struct thread_param *par[], int nthreads)
>  {
>  	int i, j;
> -	unsigned long long int log_entries[nthreads+1];
>  	unsigned long maxmax, alloverflows;
>  	FILE *fd;
>  
> -	bzero(log_entries, sizeof(log_entries));
> -
>  	if (use_histfile) {
>  		fd = fopen(histfile, "w");
>  		if (!fd) {
> @@ -1434,21 +1431,12 @@ static void print_hist(struct thread_param *par[], int nthreads)
>  			fprintf(fd, "%06lu", curr_latency);
>  			if (j < nthreads - 1)
>  				fprintf(fd, "\t");
> -			log_entries[j] += curr_latency;
>  			allthreads += curr_latency;
>  		}
> -		if (histofall && nthreads > 1) {
> +		if (histofall && nthreads > 1)
>  			fprintf(fd, "\t%06llu", allthreads);
> -			log_entries[nthreads] += allthreads;
> -		}
>  		fprintf(fd, "\n");
>  	}
> -	fprintf(fd, "# Total:");
> -	for (j = 0; j < nthreads; j++)
> -		fprintf(fd, " %09llu", log_entries[j]);
> -	if (histofall && nthreads > 1)
> -		fprintf(fd, " %09llu", log_entries[nthreads]);
> -	fprintf(fd, "\n");
>  	fprintf(fd, "# Min Latencies:");
>  	for (j = 0; j < nthreads; j++)
>  		fprintf(fd, " %05lu", par[j]->stats->min);
> -- 
> 2.43.0
> 
> 
> 
- Tested in rteval
- Edited commit message to say "cycles" instead of buckets
Signed-off-by: John Kacur <jkacur@redhat.com>

