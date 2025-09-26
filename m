Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340522F75C
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917033; cv=none; b=JjolinnW2upBgKUaxT+Dl8u6675q1J926+p8k5c20YFKDmFR6e7hhzA0a9Eo5Xz4/vST4fq5HdcL5KYF0CFpnhMbKd93uph22ftNUZ+y3lX5M962VzoJ+Ac6buz7H/OhhYLttEHdhAOhujAoPlcTlSIMfBgF2BSnfP7xeqiNwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917033; c=relaxed/simple;
	bh=kCsw/f3ArVET9HHtZZHA+WYYBc4gGXOVD2yro7FYzjM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lfp7XIdeiWUbStSJLg/3KYvdP3mwoR35h0ApkLBaMlYe+Oeen0I6jjfstt5uGqhAVjPJVgbOGCajnU4TzshIaDM0Kl9RdBO1qLCRU1f8qaaapmJtX93darE+jZMfvEK/70DzwXtec4Ce/n45iUWLNwRD+JFN1GEwutI/IHJ3o64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzNc9QAo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzNc9QAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758917029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a24ivi/mdaFnrdyCIepo4QO0dz4HN+JUjQ348qMhTl4=;
	b=KzNc9QAorudYvpU2S420XMiuwKNVjepzeOafUaFt2hPVPkBUKQT/RRvLLl/n5u7zDU1xki
	NJRJ3rlKIYIVWvkuRscp8cGBFxll6w9iYkexoggmSYnxoZAWiHQLyjaF6cKYqn6H0uPZBI
	tT13KVdFxS2GBTriqhR/XKhNwzO8Apk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-2vvhcozDOX6lRcNs-of3YQ-1; Fri, 26 Sep 2025 16:03:48 -0400
X-MC-Unique: 2vvhcozDOX6lRcNs-of3YQ-1
X-Mimecast-MFC-AGG-ID: 2vvhcozDOX6lRcNs-of3YQ_1758917028
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-857003e911fso570786985a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 13:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758917028; x=1759521828;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a24ivi/mdaFnrdyCIepo4QO0dz4HN+JUjQ348qMhTl4=;
        b=JigEYzndfNXlwt9Iw2qh+PYphWd5Wv6rRFABBjcGlBgVe0Y+VRn+nF/po27+WB0aE3
         ozjeMl8cGqqQsWSWFqEouKLatxVfck69AiSZk8Dh6Ag6HcxSb+wTDbd+nVFQieWqCbeJ
         Cd4U5q/CjplE7EbLh/mfS2CBAZKEgUsa2tzyfXQo7ETILxZsuPcIybTsb8ZuOr8zoNgv
         OiSBHEjTYrXukW9gk+CRWIwO9fByrRIVv7TQjEq5qRclwEvsV4T+05z0b1DSJ+GQfOp5
         5eE/brS6XXGTEI/0pZ6HiYJwgGXc1Hwe5U4fGEeditaluwcHPfgy0Nd0ZykJ8s1ey8No
         y8LA==
X-Forwarded-Encrypted: i=1; AJvYcCWeMW3qDyQOx+ayQ1INXkKrGwHHwOR+ZsXL8ydgt4U8iEhMFNOhDaovvvG2eOVJl6kXGSjtUo9xWbiuG3XZSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtD4XrXC5HRorMJ4yhDRT+xOo38j/rDyUOCmB16rp7Xw/xNXeP
	sPpTMZwin3bw3mKVwjpKlOnuyMaSLRO/1h5ggrukkBUIuHZC1H/yuATjA4msXkS89ejaYaR+40J
	+TyqYeApazCFo42FBL+2sxyjbJPR/oVHcpLYNv8idmGE4VhvMj+GNm8nTmS21JD1GjOme
X-Gm-Gg: ASbGncuSdRpOzM2FCfI/VoFJBi+gkgEhvu45aq80SvXTRfkR80Nfr1nLs4i0YwnNHtK
	ptxE8DxZ003quQe2GvSP8VGIkudkVzhF9mOKmpb314QiZpwDPw9dVkidwnd9cLV5lLadFBK+bea
	qugcRbilNxKJm+lwBSLH3s9dyJX2lh7GnhKksonQL4DggbJgNSTK5gvTW8Z+KnsklADkZIP9Crt
	gr7rfdCaDPEtvLD1zGGSBmYeI2M0NNdcN9zF9rxuJVgbK1cknv2wVLnkTIT0PFdxLJ6i+sjO1Ys
	qiuPsswfL3kio0yVfPnuzz16NxkQsb03Obx32KHfBk9ZceYoVFvLv0/UoPq/Do+BqcztML/Sil5
	uoes5DJf7Xpwk
X-Received: by 2002:a05:620a:460d:b0:84d:a352:1853 with SMTP id af79cd13be357-85adf5d2564mr1055369785a.10.1758917027657;
        Fri, 26 Sep 2025 13:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWtCqSXe7CPJxhOo5R1GZg0tlatfOky2xX3xkZ6da4DA4cAT1j9GRshWyNYvU1gUkfWwEwKg==
X-Received: by 2002:a05:620a:460d:b0:84d:a352:1853 with SMTP id af79cd13be357-85adf5d2564mr1055365485a.10.1758917027201;
        Fri, 26 Sep 2025 13:03:47 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c32e0a646sm323174085a.54.2025.09.26.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 13:03:46 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:03:45 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 8/8] svsematest.c: Check return values of write() and
 ftruncate()
In-Reply-To: <20250726091837.493915-9-yphbchou0911@gmail.com>
Message-ID: <7da77d7a-7604-420e-de1b-8a7029d17224@redhat.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com> <20250726091837.493915-9-yphbchou0911@gmail.com>
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
>  src/svsematest/svsematest.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index f3cddf8..bdc82bc 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -84,6 +84,7 @@ void *semathread(void *param)
>  	struct sched_param schedp;
>  	struct sembuf sb = { 0, 0, 0};
>  	sigset_t sigset;
> +	int ret;
>  
>  	sigemptyset(&sigset);
>  	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
> @@ -175,7 +176,10 @@ void *semathread(void *param)
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
> @@ -544,7 +548,12 @@ int main(int argc, char *argv[])
>  			fprintf(stderr, "Could not create shared memory\n");
>  			return 1;
>  		}
> -		ftruncate(shmem, totalsize);
> +		if (ftruncate(shmem, totalsize) == -1) {
> +			perror("ftruncate failed");
> +			close(shmem);
> +			shm_unlink("/sigwaittest");
> +			return 1;
> +		}
>  		param = mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
>  		    shmem, 0);
>  		if (param == MAP_FAILED) {
> -- 
> 2.48.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

