Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5739C2DF68
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909444; cv=none; b=MB25Sj4FxURV0BlnvFky0+Gypkmna1ZhiKw7il4LNheef+D/u9cBY20nRYr99isvpSpQE9rfuqqYpifqXieKWgavu/naPkoarbzv/WmPzEVe+cWFNPlED5ue+ReSPAeWWzvHTkGf4aIJLz0LVAz3jFzxD615n8jnHwULa7UMo5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909444; c=relaxed/simple;
	bh=j/+vPUFnq66lWvCbkiKiGwymR1hdaFNHpdAMUkJDm/Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KCq5JOn82O0McBmNeRcnv5Qutnyl39mqskFuDMDVVkaJqtgRB2rd5ZD1zxUMxaMPIfvagTPaU3zDhQXKfBU1z/RJjvEvWLs/ogIDFEaOaz+gq+QJtpBBhJpw3ADSzAiT/qdRRydT4bovuec686Z6wQdn0VASSvl7vMYHyusfF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEZAJkvR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEZAJkvR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758909439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJsh4qti2HS3r28CJpo2BIW+k/pg9+KQFWfyNkWU2tI=;
	b=ZEZAJkvRAhvPUqEKuma4C1FIxYStmNVBMMzHwkcwFo2qWyx5EQRfySrlbDVNxjVQOWbrIf
	7rQTuG7sg0mo16A85a+FrF6xg8pdEOsyb7cH7MSNxsSzOlDnMlFotL+zGeJP340xOVpKF9
	SlMjCPZ6oelDYQoEhYh7OI0ZtMrEzRs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-k9PWxY-aN4ugmlx7_cDDOQ-1; Fri, 26 Sep 2025 13:57:17 -0400
X-MC-Unique: k9PWxY-aN4ugmlx7_cDDOQ-1
X-Mimecast-MFC-AGG-ID: k9PWxY-aN4ugmlx7_cDDOQ_1758909437
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d6fc3d74a2so68963511cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 10:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758909437; x=1759514237;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJsh4qti2HS3r28CJpo2BIW+k/pg9+KQFWfyNkWU2tI=;
        b=s496/qblFiSB4SfVgOgAUuKxzbUPMMsmMqSBWckBoQgoR1lvukcSfcRd3D2Q7k24UW
         eYVV+h9jtiZO5YK4gV5dm8nw40lAoPemhTUgI6clfR5LGoQtrahf3FrjXA/c7+pEe/mb
         mLqe/kAXKmT9sYIr2rLX26cyhqUyTijqJIXtA2xLD7WbvtAhOx3FMe6K/a8tlDagzPQq
         WLWZ0zPH6wRn9osUTLYnfryAPDzLCEQCMVN8T/9nYhv43fnxhDzIP1m5+skkzPYyunFm
         GIo9fsdky2bY9JWlbFkS0WhrlVd+r+dRl66dcclGFMiYJ1oMHGJO/g8IdNRUVBFkg3tT
         no7w==
X-Forwarded-Encrypted: i=1; AJvYcCUGELlwPxyt/MPnHpZN3n1YuEQ5Gr+krjE9rWvakW3bWajgAAi6IPHX2q1P5/z5nfxREPdQG3gt9M/RFnmnTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAkZUG8JX5x3E/VOS7PUCtWIVKHqlCZGiz+HfuiSTb3ICGwJuz
	TKHeGkREZLFDHzFk7QVbfR/A3g4tddVUToWX3S7RpBSlT27gy67aSjaC7CvaLUTe6+CPrEoFXSh
	ptUWlJlU5Fjgw5gB7doXQgI0j8wSyNO+YhzuGrIRKbprdqasFpq+b2pDcgeacr8xxTf2m
X-Gm-Gg: ASbGnctWTELLlzIo1XiW3xr5u/q3c3PEDkvIA5XJOXlZTmvxJHb4xxZpcQhViS3iDHU
	Nhpb6NpJALh7FsQMr4ExQ382MbJmP9Mv8MEg+brKIqBcVKOoXPCfRtRSK76o0DhWM7Dj9eoU4A6
	fIAfpQlWaI8xAC5IVmYWJVFF+Eo/O/xVrUFfBur+Tt2qIWb12Yz17xmXdXQg30dgFQTrIq7EzuJ
	/PhdNqO51d0Xo5k0yTxhqSHmC2DHyGe78DPpk36oLTH7GSJ/7RcQpkUhQdlA8J/FNupRrvhH4jx
	Y11iCwxbmtzODBYyrdpfBfFOYw==
X-Received: by 2002:ac8:7d8e:0:b0:4b5:e7e4:ba74 with SMTP id d75a77b69052e-4da4c39d3a7mr128188391cf.56.1758909437287;
        Fri, 26 Sep 2025 10:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+9kFcxorcuLaQBDQ/Dhoyv2zMhBlny7hSUFL86agSuSWXBOH5VZRFAPJyfK/cZz/yRkhCJA==
X-Received: by 2002:ac8:7d8e:0:b0:4b5:e7e4:ba74 with SMTP id d75a77b69052e-4da4c39d3a7mr128187971cf.56.1758909436712;
        Fri, 26 Sep 2025 10:57:16 -0700 (PDT)
Received: from fionn ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-801351c3277sm30494796d6.5.2025.09.26.10.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:57:16 -0700 (PDT)
Date: Fri, 26 Sep 2025 13:57:05 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 3/8] ptsematest.c: Check return values of write() and
 ftruncate()
In-Reply-To: <20250726091837.493915-4-yphbchou0911@gmail.com>
Message-ID: <8e770061-3bae-62f6-39d4-6eb603766905@redhat.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com> <20250726091837.493915-4-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 26 Jul 2025, Cheng-Yang Chou wrote:

> Add error handling for write() to tracefs and ftruncate() on shared memory
> to avoid ignoring errors.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  src/ptsematest/ptsematest.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index d211669..787909c 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -62,6 +62,7 @@ void *semathread(void *param)
>  	cpu_set_t mask;
>  	int policy = SCHED_FIFO;
>  	struct sched_param schedp;
> +	int ret;
>  
>  	memset(&schedp, 0, sizeof(schedp));
>  	schedp.sched_priority = par->priority;
> @@ -112,7 +113,10 @@ void *semathread(void *param)
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
>  					fatal("Could not access %s\n",
> -- 
Signed-off-by: John Kacur <jkacur@redhat.com>

