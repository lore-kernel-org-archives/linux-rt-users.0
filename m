Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC066123
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041804; cv=none; b=h4nz0ywlRVlBKWT2a1bf3SJF6foUPoMlWkpb+mAW5zUwfdcHnFzgxqVHnodtp1+AliTqzxUt2oqYmfzje5QUG5zqihp0Shk8f2jlkC0RQVBEzUJs7cppLua8Z7dhaID4I36TXAoCPfLVuMxjO4KaOXSQCVbAFl9cN/1/mMkX5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041804; c=relaxed/simple;
	bh=InPpckzMDZ/bg5U9fPLQbxEUNlhqY96oKTqNbQAtgGk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XZw56K9QCIrc+1ed4esLH0szT1vrGcjlktRFrJhu3eXb5TWf9OkvxFFPrBShY575G8NZ48x19lHrv2km+49KeP//MIuS0jqc8D7kjQqRlfCTrJUY2VqWagxvXT6sZCzfd4U1Gj6qFVLaNqr9Pwygeb92BrujBD4LN+UHw07w4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cc9T84KX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cc9T84KX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706041801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YRfqYju8NJKCgVhhF9hbrs9HbFSst66b4K71Ny3l/nc=;
	b=cc9T84KXRbeGv4U18i6ANru6q0T/51ucfb4fi1YVpFhGqMVQF34JPwDaLZhQ1K/lsooPNE
	J7Q5Sqge6rX1ZVJ7ngDaggWXOsmS/E/brpl8oTpZ+rq74X+OQb7x+Vs5zjLwQ9/ONjIUef
	WoRkLWQ3AvvGu1ip4r94VvDdJruMU6g=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-Er2-aI21MLK78ttZfBJYUg-1; Tue, 23 Jan 2024 15:30:00 -0500
X-MC-Unique: Er2-aI21MLK78ttZfBJYUg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5ffee6fcdc1so38233867b3.2
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 12:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706041799; x=1706646599;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRfqYju8NJKCgVhhF9hbrs9HbFSst66b4K71Ny3l/nc=;
        b=HPZdPKpefAunMi7iEUnIoMTShND4t7TxNQKput9WkRtqQIrhV75VoZ4nRdrHJq/0AO
         7koocdu7yq9F86K0JP7yrM4/Q0JnibDygdRxyK4ey39tuy1AxAxzDQrxeu4ulWD3GBqJ
         us49tMcCi+fP2WRo0z3jnpBFVrJg7T1HAcsC4eTm62FchEHOwT8bM3nIaq2hj9gXHln1
         WNGIC8E8llkkip3xE3J9zl74LNk2jmKYsW++8KIAQSZsigMduCjdtuxbJdIWGLk0Uj22
         +wmBxvSCGFnr/E/+jNt+t9gvnSLJp45tRMB1dwJMAQVVklXZZFPtAG70kGbcuOl1gto+
         rjXA==
X-Gm-Message-State: AOJu0YzuNlrXYD9YmHts0PKYdntZQLf/2JroVuiP58CIuBWYH4ngcEN7
	hV94UL/jRNLNMEw2X/8x1GiYke1DkOz4uGufLD9hqVgidIKPQ1SMR607O7haGalMznSnpwKQFV1
	AXKB4x172KWxN4/m54QRMcnM2xAtNqilgLSn2fA3VIg0pl9OAWHFlgWuwtMOJmJVn
X-Received: by 2002:a0d:e892:0:b0:600:2da3:1cde with SMTP id r140-20020a0de892000000b006002da31cdemr2299916ywe.42.1706041799717;
        Tue, 23 Jan 2024 12:29:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4HPVsxZejtnFza/lrWsNNmBjEnlLeHh6rxoqdlZ8s9Dh5CymNfkfHXPebkW3R50EalHXUXw==
X-Received: by 2002:a0d:e892:0:b0:600:2da3:1cde with SMTP id r140-20020a0de892000000b006002da31cdemr2299905ywe.42.1706041799454;
        Tue, 23 Jan 2024 12:29:59 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-15-174-88-88-13.dsl.bell.ca. [174.88.88.13])
        by smtp.gmail.com with ESMTPSA id z188-20020a0df0c5000000b005f900790763sm10478221ywe.49.2024.01.23.12.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:29:59 -0800 (PST)
Date: Tue, 23 Jan 2024 15:29:58 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/3] rt-tests: cyclicdeadline: Remove dead "verbose" code
 in print_stat()
In-Reply-To: <20240122221321.9545-3-crwood@redhat.com>
Message-ID: <a903d0c3-1483-3d8c-0e29-aa107fb20ec7@redhat.com>
References: <20240122221321.9545-1-crwood@redhat.com> <20240122221321.9545-3-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 22 Jan 2024, Crystal Wood wrote:

> print_stat() isn't and has never been called with verbose set, and
> that codepath doesn't even print anything.  Remove it.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  src/sched_deadline/cyclicdeadline.c | 46 ++++++++++-------------------
>  1 file changed, 15 insertions(+), 31 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 3cb8f714b788..7525ad136d2c 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -53,7 +53,6 @@ typedef int s32;
>  /* Struct for statistics */
>  struct thread_stat {
>  	unsigned long cycles;
> -	unsigned long cyclesread;
>  	long min;
>  	long max;
>  	long act;
> @@ -64,8 +63,6 @@ struct thread_stat {
>  	int threadstarted;
>  	int tid;
>  	long reduce;
> -	long redmax;
> -	long cycleofmax;
>  };
>  
>  struct sched_data {
> @@ -775,36 +772,23 @@ static void print_hist(FILE *fp, struct sched_data *sd, int nthreads)
>  	fprintf(fp, "\n");
>  }
>  
> -static void print_stat(FILE *fp, struct sched_data *sd, int index, int verbose, int quiet)
> +static void print_stat(FILE *fp, struct sched_data *sd, int index, int quiet)
>  {
>  	struct thread_stat *stat = &sd->stat;
> +	char *fmt;
>  
> -	if (!verbose) {
> -		if (quiet != 1) {
> -			char *fmt;
> -			if (use_nsecs)
> -				fmt = "T:%2d (%5d) I:%ld C:%7lu "
> -					"Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n";
> -			else
> -				fmt = "T:%2d (%5d) I:%ld C:%7lu "
> -					"Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
> -			fprintf(fp, fmt, index, stat->tid,
> -				sd->deadline_us, stat->cycles, stat->min, stat->act,
> -				stat->cycles ?
> -				(long)(stat->avg/stat->cycles) : 0, stat->max);
> -		}
> -	} else {
> -		while (stat->cycles != stat->cyclesread) {
> -			long diff = stat->values
> -			    [stat->cyclesread & sd->bufmsk];
> +	if (quiet)
> +		return;
>  
> -			if (diff > stat->redmax) {
> -				stat->redmax = diff;
> -				stat->cycleofmax = stat->cyclesread;
> -			}
> -			stat->cyclesread++;
> -		}
> -	}
> +	if (use_nsecs)
> +		fmt = "T:%2d (%5d) I:%ld C:%7lu Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n";
> +	else
> +		fmt = "T:%2d (%5d) I:%ld C:%7lu Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
> +
> +	fprintf(fp, fmt, index, stat->tid,
> +		sd->deadline_us, stat->cycles, stat->min, stat->act,
> +		stat->cycles ?
> +		(long)(stat->avg/stat->cycles) : 0, stat->max);
>  }
>  
>  static u64 do_runtime(struct sched_data *sd, u64 period)
> @@ -1109,7 +1093,7 @@ static void loop(struct sched_data *sched_data, int nr_threads)
>  
>  	while (!shutdown) {
>  		for (i = 0; i < nr_threads; i++)
> -			print_stat(stdout, &sched_data[i], i, 0, quiet);
> +			print_stat(stdout, &sched_data[i], i, quiet);
>  		usleep(10000);
>  		if (!quiet)
>  			printf("\033[%dA", nr_threads);
> @@ -1119,7 +1103,7 @@ static void loop(struct sched_data *sched_data, int nr_threads)
>  		printf("\033[%dB", nr_threads + 2);
>  	} else if (!histogram) {
>  		for (i = 0; i < nr_threads; ++i)
> -			print_stat(stdout, &sched_data[i], i, 0, 0);
> +			print_stat(stdout, &sched_data[i], i, 0);
>  	}
>  
>  	if (histogram) {
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

