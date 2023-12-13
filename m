Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1FvaFC6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E49EAC
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2023 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702483124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3KgIPCerlB8my+gs3n3QnQ8SsldsDoE8GMwOTyHwYjQ=;
	b=M1FvaFC63qDSueTbp48mD9/BbCxevsL1sTSx2VfHN4NFHKqca0q/Otltcwr3DyRZ7O1mKS
	QpUCODMksOUBoQpJfkW73DedX6s0OQBlir8njovlhfLJYM8MwotnLn9U3S8si1Y0niOMVJ
	GL6Pns9UV2CSvIID4l2BJi1qe5885ho=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-bHQ-ZabEN7m_8BNrdEkctA-1; Wed, 13 Dec 2023 10:58:40 -0500
X-MC-Unique: bHQ-ZabEN7m_8BNrdEkctA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77f38f2f6fbso1102355885a.0
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2023 07:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483120; x=1703087920;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KgIPCerlB8my+gs3n3QnQ8SsldsDoE8GMwOTyHwYjQ=;
        b=leDYghvsGfeIcEvRUZaItkhbXRyucecBHeVQfeyr1GRkxsDSKnN2jW0P0DE3ts/g2q
         4WqoFT5NAe+XEYdFOXbJjO2tx162vTifqgN8pXM9pNZ2bs5HCxt1X4tUqDXVng0WQHLB
         wc/AtDEG3IQCGjtmiAm4Y+7TCx/6EJ7SaVm9FBDlZVE/fqyoAuKH5KxlEKAxO1u5pAPv
         I/HyTvKBTZhPrw+hJgSFrCKXSciBK/U4VQG7VQ16lRcafdb0ndAflmIgmXnXHhi5jTIx
         RKbYgCmHNniX9DXPfohgAz2o59dcvF8E6mNhdaFNe0dtnHu3gVneHriHNcx4HZkjrdbx
         V52g==
X-Gm-Message-State: AOJu0YyiIZ7XeqFCOIsidcorrDjJpmOg+373XD7QzqiUjvRjnf5eCQh5
	1r9BaIY8BoqLVQcbEiUs4voAwoDiM+SmOMUSlf8yA51UU2Rx8jYE/4G3BZLGyPvQ0mBqD4RK/3D
	sHSHrpke7MC/cr3oxxAbjyHPqvscE65efjRE=
X-Received: by 2002:a05:620a:288b:b0:77d:72a3:aa82 with SMTP id j11-20020a05620a288b00b0077d72a3aa82mr14197145qkp.6.1702483119965;
        Wed, 13 Dec 2023 07:58:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWqmQuO9gWj98G/VpG861Vv0JjdFKic1H+YVvOqTFdy2vmgTC4hbFri2+Mdi+ZYoHOMuh3RA==
X-Received: by 2002:a05:620a:288b:b0:77d:72a3:aa82 with SMTP id j11-20020a05620a288b00b0077d72a3aa82mr14197132qkp.6.1702483119720;
        Wed, 13 Dec 2023 07:58:39 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a148400b0077f601d5162sm3597313qkj.101.2023.12.13.07.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:58:39 -0800 (PST)
Date: Wed, 13 Dec 2023 10:58:30 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/4] rt-tests: cyclictest: Remove histogram totals
In-Reply-To: <20231206205508.17148-3-crwood@redhat.com>
Message-ID: <7a911e4a-7990-bf89-7a7b-67a059a4dbf1@redhat.com>
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

-Tested with rteval
Signed-off-by: John Kacur <jkacur@redhat.com>

