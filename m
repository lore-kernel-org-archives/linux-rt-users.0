Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F826657B
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307776; cv=none; b=Dy3FhDj+2lyuyxtE+wfc3+uV3WhDKRpt/tYDWZWhBLNrkhE5kUoc8BIhSBaMNdEtUuayv5gLUZHXGc7+djtAmaOhpP4RCV4BgxSbmVUSIAHzA+W3cxNF80WAnzI/tcvKeByRTgAyLIdzamRuz393+NrucRFxXfXXSc0neUAdaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307776; c=relaxed/simple;
	bh=wQ81bLnvWhnGUQ087BufFPtMMUyAkPbBoOADDivh5BA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ga6KjD5KndGLo5ukrxV8tfuyogzIajhx/Y59WE3A6BfJiRIpo80Ddnk/ycNfre1Ch4warBuoKp/awkMAyKWCeznHT26Y+LeKAfelfm3RSWT78V+OZZtLllBzyGHX42s8eAPx3Edg66O+5K/mKC1lx6qpd6x1a/T1oluSrwkwhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPH9Ey+K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPH9Ey+K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758307772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd/LRQx7jPnLroBwNxVd3yqgagrHOufoMOo9f4rQA0M=;
	b=LPH9Ey+KrW46hymjXvJ5SEdR0FpdUE03ivMv/qQC9K2xLjeHotgeU3RUMaPIjfkJI+yFGR
	m5pCxEeoDDPjPOTCKOEL7j0dO6oC5ChKSfBEjtnAIL81EJiyk2cNkbM0Iq27GX90TOCPKh
	NkRNZQYhgDxW65tG8/R4z8wsw+PR2zc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-H2gZG081PkWWLRhRKQALkw-1; Fri, 19 Sep 2025 14:49:30 -0400
X-MC-Unique: H2gZG081PkWWLRhRKQALkw-1
X-Mimecast-MFC-AGG-ID: H2gZG081PkWWLRhRKQALkw_1758307770
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f290579aso47753701cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307770; x=1758912570;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd/LRQx7jPnLroBwNxVd3yqgagrHOufoMOo9f4rQA0M=;
        b=PASX6n5zsLTKx7mhiUujJkt25RJyN0Vw6Pf56SiwxfH8ecidqTZFFav9w8VQEZHtq4
         Om8jjCS/OEl5ElW/5cBzTEgQKbsKxzHwiIXIJBC/wO1UVa8yF1pPczGQtjTrmqXT3uOw
         BDAYC4I+gb8TQ247KeJOx77mTFxrNMtu0kGZRlD939ofjJKABodw5URjM8I6cyeuQMx+
         0HFGnvBiVT2VSmWI1lYhNg54akvfxdM/ef8yRrgbugOzE452HvYT5D2YXvswRjIOhut0
         HASkZ/zuy25rhJz3xqC2ObpsQpRlaXoBPpWFlMW1HMzk1bBSmKurOxQJygIU2YzxJciL
         JY+w==
X-Gm-Message-State: AOJu0YyIwYHuaXmuULtxhKJW0ZyDYgX9pmR2RGvc7phnVrseoO97ythd
	5BNEgxKdH0HjGnHueTl3UkTw0YW+OHwIsYGYqdpwkZs5wNVh9CYVDAQ+Rb14yHBmCtE1xmNBCyM
	cN5w4vHztKnfhwa1oufeUOAdZGd0LD10v1h4NZRdXdMRBPlZbsTluof81VBaI2oDXuZNh1k2SJ4
	+0ifY=
X-Gm-Gg: ASbGnctrBNsX6QzYodNcKS6nDdMLzqy2Dc082aRpl2FI/99SjqfFF4M+UvjXB/G0Is6
	a964DuP4rp2xy1dcd2UHCcAHMBhHUkge2IlZlMKzFOykkhMEy8nj92Jg855dDnuZvWBvPgjiSiU
	gNPPpOJxrzS6yC5mnCpSSMAaZyG0lb8DkwaFhmqKUMp/+Bz+lG62227gdybgubRrnswv8ghka8s
	i7OP8DvnkvTGzWUX4r2P++bCVW5K9HguUyi/gAyTBb0Kwjdi2tBW5lWT50Vcn0013LdjM5MgozK
	Qfm3vilA7nh4RIx/KV8MammL/w==
X-Received: by 2002:a05:622a:178c:b0:4b5:d932:15c5 with SMTP id d75a77b69052e-4c070f561a6mr54193341cf.25.1758307769791;
        Fri, 19 Sep 2025 11:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOYxzZmY5cEcsxOZ0gE9Tkiycgwa0eraZyBrb1EXsX7BcmSXPbQOkcSddupdZQyeoe+m9VWg==
X-Received: by 2002:a05:622a:178c:b0:4b5:d932:15c5 with SMTP id d75a77b69052e-4c070f561a6mr54193041cf.25.1758307769342;
        Fri, 19 Sep 2025 11:49:29 -0700 (PDT)
Received: from fionn ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda86b29a5sm32101711cf.27.2025.09.19.11.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:49:28 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:49:16 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 07/10] rt-utils: Decouple writting trace-marks with trace
 stopping
In-Reply-To: <20250903111717.1391196-8-bigeasy@linutronix.de>
Message-ID: <c2fa419a-75bd-ca4c-db95-eb09035d0287@redhat.com>
References: <20250903111717.1391196-1-bigeasy@linutronix.de> <20250903111717.1391196-8-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 3 Sep 2025, Sebastian Andrzej Siewior wrote:

> Most users write a trace mark and expect that the trace stops afterwads.
> Decoupling writting and stopping the trace so it can be used in context
> where trace stopping is not needed.
> 
> Make tracemark() writting just to the tracemark file.
> Add tracing_stop() which stops tracing and let current users of
> tracemark() use it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/cyclictest/cyclictest.c         | 1 +
>  src/include/rt-utils.h              | 1 +
>  src/lib/rt-utils.c                  | 8 ++++++--
>  src/oslat/oslat.c                   | 1 +
>  src/sched_deadline/cyclicdeadline.c | 1 +
>  5 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 890da5d869c92..b4bce8915b432 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -852,6 +852,7 @@ static void *timerthread(void *param)
>  				break_thread_id = stat->tid;
>  				tracemark("hit latency threshold (%llu > %d)",
>  					  (unsigned long long) diff, tracelimit);
> +				tracing_stop();
>  				break_thread_value = diff;
>  			}
>  			pthread_mutex_unlock(&break_thread_id_lock);
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index 569023c5d3051..e148dd77fd7d8 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -31,6 +31,7 @@ int parse_mem_string(char *str, uint64_t *val);
>  
>  void enable_trace_mark(void);
>  void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
> +void tracing_stop(void);
>  void disable_trace_mark(void);
>  
>  #define MSEC_PER_SEC		1000
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 294fc9683a122..e504b17738411 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -427,7 +427,7 @@ void tracemark(char *fmt, ...)
>  
>  	/* bail out if we're not tracing */
>  	/* or if the kernel doesn't support trace_mark */
> -	if (tracemark_fd < 0 || trace_fd < 0)
> +	if (tracemark_fd < 0)
>  		return;
>  
>  	va_start(ap, fmt);
> @@ -436,8 +436,12 @@ void tracemark(char *fmt, ...)
>  
>  	/* write the tracemark message */
>  	write(tracemark_fd, tracebuf, len);
> +}
>  
> -	/* now stop any trace */
> +void tracing_stop(void)
> +{
> +	if (trace_fd < 0)
> +		return;
>  	write(trace_fd, "0\n", 2);
>  }
>  
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 9e5a08a2fbd92..4291221dc6521 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -340,6 +340,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
>  		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %.*f us!\n";
>  		tracemark(line, g.app_name, g.trace_threshold, t->core_i,
>  			  g.precision, us);
> +		tracing_stop();
>  		err_quit(line, g.app_name, g.trace_threshold, t->core_i,
>  			 g.precision, us);
>  	}
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 04e61edc68d83..e2f827deb275a 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -885,6 +885,7 @@ void *run_deadline(void *data)
>  				break_thread_value = stat->max;
>  				tracemark("hit latency threshold (%lld > %d)",
>  						 (unsigned long long) stat->max, tracelimit);
> +				tracing_stop();
>  			}
>  			pthread_mutex_unlock(&break_thread_id_lock);
>  			break;
> -- 
> 2.51.0
> 
> 
    - Fixed spelling of "writing" and "afterwards"
    Signed-off-by: John Kacur <jkacur@redhat.com>

