Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD56F06B
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129333; cv=none; b=WRYZU+l0c6s9RTxXYHFkGMci7r0C+aHcSfhMMhfIGUTFKvSD6QQTl2A1b+SHHJ5DBhDAHYQX7dzyrtaknR/98tAzSxuPx5cU5pGCBNSF9yU7tfoEdTxjyDtxEQehOeMEkbGn7ZJW9MpmBsh6/NRwWmGvY18v49UisAscItNXs88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129333; c=relaxed/simple;
	bh=Kut5nEO3WzPYSZBXqsgI2tBGRnBLkZpEcI1fBttVmk0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MsxwppBHdBjsYN+RAND3u+BaCBLIXS/zqBnpXcdhr5p78DyCL0hgH6BQZwbupPfR4SpmOHCaOr6C9Mz9yHTPxQ85bdy2Z9U9cJ++pCc0zHskeJBE1dfP+kWqo87BEWzGRSzJiE1dHy6y41ywOzKuJ8GBF+wKiv4EqQR8jySHaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsXbdK5s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsXbdK5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753129330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHIgeUpdlkmH99OXeWrRIndmSHB0MxYgl5IlTcgkv34=;
	b=PsXbdK5sq+a3oZbDiaJhLtrbRk5ok96Wdo7IsmUxrLSxaeI5/BfzdE92O9Rl7r/HD3n5Ch
	L5T/tvGzVL/TMvH+xSaBr188DuJ3Uq9ESeQhZLckt6gTRzPala8cNWh9N52ndneFEJWz3M
	PBmUHiCcoAPFDrc9qeh6dkyBRaa3LPU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-zyVD9o8wPSmaQ53dqnS2HQ-1; Mon, 21 Jul 2025 16:22:09 -0400
X-MC-Unique: zyVD9o8wPSmaQ53dqnS2HQ-1
X-Mimecast-MFC-AGG-ID: zyVD9o8wPSmaQ53dqnS2HQ_1753129329
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fe182a48acso98168236d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129328; x=1753734128;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHIgeUpdlkmH99OXeWrRIndmSHB0MxYgl5IlTcgkv34=;
        b=VvAWYdSuiTL8MRaX04IEyZyhkeNBVz+wdZD3Px0PTfP+dU2qYrsn5OiE2ONccZq9ij
         18SuzU9qR+wB/mbSuWkTH2RPtfHxaxBtmmFrUbfjridiMUbm87dHFvk3+jFnYU2kzEPK
         yezRO5jnbWriwTahLVC9eoZHQihoZLavvgqmW9wg58/EjbcGUdvT9KYBkZHigXIW1n8Y
         opLcq1hjOhn/zC9LpdSroNCRFMSXk1osoW6/MLUZVXV3FcH9ji7fl+JZElzvCFXMazqc
         zpAIrPNGg/tbpSi+WQ5rhtVbQFCu62DQHBB/x2lKouVwJrRu1T5Gp3aNvn+Uaq7GemXT
         sAtg==
X-Gm-Message-State: AOJu0YzWguCiK5On5vN+JZYow2BFoTCiObnB+ZAX0V2aUouMsUxjMy+y
	tEQXJnECfBj2okvfkq+J+eWwsOnAv61kuGa2B3m9UQu/pMgEdT2AvEGgA0l0Lsff3OWZfHMfjvY
	n0ctH1BxO2uW/2ScO1P7uqRikdlGixx+vVDGoS0Y6bYDm8sDa/ciH2y3K8vUyJajnvRv0byU38z
	pU
X-Gm-Gg: ASbGnctq56h4f7onhVIriMa+DBZk5pD/CaUcw/qjrL+BElRKnV3XRa7ioOFj6FquEzL
	mO1PQQ/S6ioYXozAxbrNYhozzPHqdWvUo35TYm64yOWnxgEneTQJ1+lewjMno2QMcwsN1yLgElH
	T/ZMu6Z0s9RbnL7IHjr0wta1iRCmYzDmAxyjT5KstL64QWOIFbfG72MVuIF0zXpNs9a08jqWyVc
	Lque+az3gCoyq6TJLgAi5gIyvtEn7OevNAksLQHnoTv496tlrGlenjzRrR7XHgMBtRj6Mh2PV/s
	iiZlIw3T5/wZ0WwdbLME/lepOZGltA==
X-Received: by 2002:ad4:5948:0:b0:6fa:abd2:f2bb with SMTP id 6a1803df08f44-706eb6c797dmr14347806d6.8.1753129328262;
        Mon, 21 Jul 2025 13:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrdXNTf1WdcOkbIZXd+i7X3Y0xVTas6nlOo50JTK9Pq3YPkASAVck+8G0okH9DHJq/7APoWA==
X-Received: by 2002:ad4:5948:0:b0:6fa:abd2:f2bb with SMTP id 6a1803df08f44-706eb6c797dmr14347466d6.8.1753129327682;
        Mon, 21 Jul 2025 13:22:07 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b783sm43584336d6.73.2025.07.21.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:22:07 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:22:06 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 28/28] cyclictest.8: Reference rtla-timerlat(1)
In-Reply-To: <20250704132721.13325-29-darwi@linutronix.de>
Message-ID: <4758a008-9c31-76f7-9a58-21bd73daf38a@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-29-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> rtla-timerlat should be the official cyclictest replacement at some point.
> Mention it at the "See also" section.
> 
> While at it, use the correct nroff macro for referencing manpages for the
> whole section.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 16e8190..bbb0b41 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -308,10 +308,11 @@ in mind, below cyclictest example invocation can provide a good start:
>     --histogram=1000
>     --histfile=output.txt
>  .fi
> -
> +.
>  .SH "See also"
> -.BR numa (3),
> -.BR numactl (8),
> +.MR numa 3 ,
> +.MR numactl 8 ,
> +.MR rtla-timerlat 1
>  .
>  .SH Authors
>  cyclictest was written by Thomas Gleixner <tglx@linuxtronix.de>.
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

