Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30C239E82
	for <linux-rt-users@vger.kernel.org>; Tue,  1 Jul 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379944; cv=none; b=XMW9+a6GKVWgIoFb2Zmxqy80kUkAMzr2lfP6sXp57qS20siSt/a+xw5CZr58NhPfk5slePc6bEdIZ2cxRocvUTTGAD9xX+xe1ue/Gw3ANojjv5TNIF0uYmnWH4ROFcsWVDsuuD5jzS7HGmbixEM/kZY3/K2JHuv+f4hkfJ85RWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379944; c=relaxed/simple;
	bh=w50pH/SbcZ1Let863Zo8iyIV2rMs7B+nkzGTv9gd89w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JKN97Z1eB9VZeK71W5nBfvlgFvqA2Hw13Lg+QxyABFqAfbMa7ZKG8rMt3L0hhqqt/IEtlnC+LCR2M7Kic7ga8+a3IHV8iPW0QO9rg6oq+qCljirvLTye9sTQN/byY99It7gU5xCbQJHmifiGAx1wf2Mv3zITEebRA0nLAYniGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1zhVP2r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1zhVP2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751379941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ri4E2zimO8pOX+Btln9h9KAss8a2o5zN1Ub/dssBLxU=;
	b=C1zhVP2rRHp/oTtJ4H/8gh0jfp3t5ElofKRWklYB4K4CQSidP+D8+bkpC/S/dzmal42vbF
	F4a5AtDniyoRT4xDYVFl93oRj/IDT6FkgFeyOaNdJvUMcLhzWcGJ1HJvvrUQWZD3ZvgFSd
	IhBJiZao6nrVHQI9rM1KmIGA4QElTk8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-_jy74CnKM8SIF8ygAhjynw-1; Tue, 01 Jul 2025 10:25:40 -0400
X-MC-Unique: _jy74CnKM8SIF8ygAhjynw-1
X-Mimecast-MFC-AGG-ID: _jy74CnKM8SIF8ygAhjynw_1751379940
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6face45b58dso53866226d6.3
        for <linux-rt-users@vger.kernel.org>; Tue, 01 Jul 2025 07:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379939; x=1751984739;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri4E2zimO8pOX+Btln9h9KAss8a2o5zN1Ub/dssBLxU=;
        b=GwAriL3oOc/Gl35X07GC7OXmpWpCcQ7NwSjdqLN9e867xL4IiGzXw5bYreE3zKbJmE
         fYxtv+SGvdVbcRA7amNl9EqAyAG2WCd/omMsBBoUhX2LMvzzNoIzXO2kFoPDS5uUjJyu
         dNr7n7nEh5uarhYpipq7joVgbeRDHDjlIc+pwmaGCUplaXiCdFLoB3x4MX36e1lAtI5k
         thIcTt2q3AdillOqLb0HmVpTXsDu4zoYzosXR3zPKCC+JFvi0EzCF2OjgyfPdsEtN3Hb
         g1zda5qAZ7B9KCTkHTkwa+ZY9jYgK5rIzzSUwLpF6AhepZtMp6JxKaYakKHF/de5YvX5
         fXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw5ZDX0ucynCL+Z9epXLrvJyOqE2eJCqIVq2+X1UkiemLXbjPn3Awhvy06CdY+UYQ9ZkI7Ci7CGxTmpjFUnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp52Pc/laD9VEiOZsrI2caQxyfe1exoHzGCOJ0RkjjpUxWbZC8
	d2mLQuUHT9zwiP5hFPrRc37w4CPhGW8b57zJdsFK1KdckqmcIYmtR3gRwfyn1lQnDsyVcMWJwli
	xf5feiHUhdNqYNRUcZ3isCeN3oLg2UcaHXzz8MqXY6tFGKKkt/0VmJIxN+ferlAW7UqdMeCXRXX
	Lv
X-Gm-Gg: ASbGnctuVpFmDYujbW7JgWQRa4zYkz9isYWFhzx8OaagpjoZuaKvuVgA0BGbc9uD/s8
	42RBIlJeCfI7g5tatCvsolXRpgGWkhW1pOT+ypsk3KyXOtFUxDqs8ItHSaVrcE6p63HtUzAgbNE
	yC4y4sdvYwO7Zp58BClk3eTQ/masVlCbMnOTr/aLJy5WHrllubDuRm9O66n48xH3gdALimZyVDe
	bk88GYS6SKAW3JPEHonpdDFhoT84SBWZFIESAfLSCEEf7Xmu2Otz2PlC2I0xRH800vmMkfFOnxk
	Xr+DQmNWYA==
X-Received: by 2002:a05:6214:2604:b0:6fd:74df:896 with SMTP id 6a1803df08f44-6fffdcfbf32mr244047856d6.3.1751379938647;
        Tue, 01 Jul 2025 07:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjmO0SrzQEdKmPJFEmNnp/kVs7VcaJyeY9Z+1ixMMtLvtPadpdxyNgWdkZY9oLFy3vo5BIDg==
X-Received: by 2002:a05:6214:2604:b0:6fd:74df:896 with SMTP id 6a1803df08f44-6fffdcfbf32mr244047216d6.3.1751379938069;
        Tue, 01 Jul 2025 07:25:38 -0700 (PDT)
Received: from fionn ([76.71.123.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd77301bd4sm85827036d6.97.2025.07.01.07.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:25:37 -0700 (PDT)
Date: Tue, 1 Jul 2025 10:25:26 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 1/1] Makefile: Use -Wno-error=unused-result
In-Reply-To: <20250618201738.635735-2-yphbchou0911@gmail.com>
Message-ID: <418c2b1b-600b-8d30-de26-0a3c3f965f6c@redhat.com>
References: <20250618201738.635735-1-yphbchou0911@gmail.com> <20250618201738.635735-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 19 Jun 2025, Cheng-Yang Chou wrote:

> Since compile warnings are treated as errors, use -Wno-error=unused-result
> to avoid build failures caused by ignored return values from functions
> like write(), system(), and ftruncate(). This allows the build to succeed
> until proper error handling can be added where appropriate.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 6215541..e3d02cd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -33,7 +33,7 @@ prefix  ?= /usr/local
>  bindir  ?= $(prefix)/bin
>  mandir	?= $(prefix)/share/man
>  
> -CFLAGS ?= -Wall -Werror -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-error=format-truncation=
> +CFLAGS ?= -Wall -Werror -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-error=format-truncation= -Wno-error=unused-result
>  CPPFLAGS += -D_GNU_SOURCE -Isrc/include
>  LDFLAGS ?=
>  
> -- 
> 2.48.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

