Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE312135C4
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894356; cv=none; b=XSaP9FCGed/ghp26zs8+SdCCwfwPMGQD09W42vdWVAhDfsZiaYcMKtCO66vS2qk98Ee9/NXi5CgrOmwuHatkIZRhHubLiXUDqmG40dma/dcmZn4IVYz97Ix72lLEaM0QXie4SqHBapl356AecpPtQwl8FH+lESekhe980Im6afc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894356; c=relaxed/simple;
	bh=TeUtFFYBj0LNih6M78vLbvR/fZ0JcHseXmENxi9ZTGk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ncUsx+aJRbxaPHm1Y5beiAVXgUMCggwpp3cCUiP8bG0Rq3B3ypBjZosN56HW7wGu7dA5rI3nolbtgl32ZJVC6p2hnWLvVM4YqPuqtjTVUvSaSOq2ao9//XZs7l3VryVqmA/vzMvYoDxNjEsWiu7ZIbAY+6p+szUqC+IzOu8Yy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5PTk6jG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5PTk6jG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736894352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VRe2qqbARkWC1ngLtY3+AE+ywRHWdy6P90qMux9Lt0U=;
	b=Y5PTk6jGPR0aoEC/i9j0iFzTsA0sDJBCqHdEDP5LDHzO1pKBPMl22fjBf6N984876+WJz1
	DUw9OidiJLDzJ5jHen3a1k+8oGTa1ZH2NUJKMq7UdL8gl3/9m5PUZfEy1vKhzJT50JH9z4
	r2p8dP/4oJ2mhv1mee5ZDmX3pRZr16o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-QNREek6NPg-3BsnjxEqysA-1; Tue, 14 Jan 2025 17:39:11 -0500
X-MC-Unique: QNREek6NPg-3BsnjxEqysA-1
X-Mimecast-MFC-AGG-ID: QNREek6NPg-3BsnjxEqysA
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6d0be4fb8so986125985a.2
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 14:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894350; x=1737499150;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRe2qqbARkWC1ngLtY3+AE+ywRHWdy6P90qMux9Lt0U=;
        b=qP+5QUvD+1Duv8ZtrH72092Dq3w65KGD2cvG/LIky3NMSMRrmKjWnoUemYJJ8DIAtT
         MWwR3PbZKNohwfADfOM/MIyvcxVcDCpNkXlUChT63vfnhtor73g+ZhXolWexgi+FkIkL
         8stKUv4VE2179sGwnn/lm0NsbvmkON9lSTlZSfqiidFnbkG3rFkVMa8oZzBEWSxe7pj0
         MjokLBzjYMVsTx7UGbJJa2EtFounZRwM6joYt8wtlSy62r6zaBipkKLDrnE7AQWTv3vr
         ThZDnEOQs2htycx9VQUKWwsCIxelT3A6k12Mw9mDZx1e/T9KrwquH1nUg3zIUN6Arj0o
         RFsA==
X-Gm-Message-State: AOJu0YwO/Inp5xBoBqUSWvP/Jv6kkgJWk5iPzCmv4zE3NeRLjw3StgAg
	lFZNceEfr3vXgYmO7YElcIU7TzGUH2Vv3gRuEPf4TK3uG8vle801v/Zv5oQJtZRR8N871YsGvFQ
	fBtOsXiwueO0hY4genSAc3LPdFv2N9ZqjrovL5FUJToTiymFzAZxs/cpVuhByt4S2
X-Gm-Gg: ASbGnctbTe18dvZUm/glrDEgWyFT90mfnzwjB6fTUeKrcoi6kliyRfSZJqNE2zqauMY
	i1xnFpFaHbqLUp4PdU3W4Izuef6ME4zGPpE6PPMbp80BmfO3Pktn3fQuYiPipEEAtW6qHxhtGjt
	2INpLk/IuM+seZLwkl6EvslJfIy8HcEB2b4liOrg5f7w+ydLQEKzwCwjLQP+A8Ovr9KjEdH2U/k
	RvfT4jVI2jPEyMvnMxh8hKw0CGkf81GtswuJVJ54b0w148=
X-Received: by 2002:a05:620a:4011:b0:7b7:142d:53a4 with SMTP id af79cd13be357-7bcd976d7e5mr4281133185a.51.1736894350458;
        Tue, 14 Jan 2025 14:39:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb/1Z4pVFrfZFIOlEMhT5dCz+kvi12KJLS3AI+PkFB5XY5VtG019nheSk9s8wLliyNwNUFAw==
X-Received: by 2002:a05:620a:4011:b0:7b7:142d:53a4 with SMTP id af79cd13be357-7bcd976d7e5mr4281131785a.51.1736894350240;
        Tue, 14 Jan 2025 14:39:10 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516068sm648300485a.100.2025.01.14.14.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:39:09 -0800 (PST)
Date: Tue, 14 Jan 2025 17:39:09 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 2/3] rt-tests: Enable -Werror
In-Reply-To: <20250107220229.156201-3-crwood@redhat.com>
Message-ID: <01f94f08-067c-2c56-8fa6-74ca17b4eef4@redhat.com>
References: <20250107220229.156201-1-crwood@redhat.com> <20250107220229.156201-3-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 7 Jan 2025, Crystal Wood wrote:

> Now that the most obvious nuisance warnings have been disabled, don't let
> the actual bad stuff slip in.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index dda29c3..26acffe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -33,7 +33,7 @@ prefix  ?= /usr/local
>  bindir  ?= $(prefix)/bin
>  mandir	?= $(prefix)/share/man
>  
> -CFLAGS ?= -Wall -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter
> +CFLAGS ?= -Wall -Werror -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter
>  CPPFLAGS += -D_GNU_SOURCE -Isrc/include
>  LDFLAGS ?=
>  
> -- 
> 2.47.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@gmail.com>

