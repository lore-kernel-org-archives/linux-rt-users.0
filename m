Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBDD2E091D
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119287; cv=none; b=aurGca+K+J/w8FhF37BjA7DVO6HS9NYy2qRYUNGvje3rfZqK3LjZvTXzBivzRvCPU3gxp+cG8RWjnZAcA1Noolu8RDAAEyxhzi7APaIGsX54Ck2T9CHMASRxTnYcUA249bsWWvXZoRUgT2WjlOR6A5hm5devds3CeHWRhB51toQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119287; c=relaxed/simple;
	bh=wCMa9JZjMsuTwtHdBWa11BJUT423ILJ6vN4oiFiov5U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PwTxctKAA6sJio8ZK42U7r10Ysh7+Ysh0CtcRlHIFFkfCjjrWOVm43bIL2l/4kAo0tAjw+3fIgVIoKArqkgxcgt2UYcJRQCPyrWDyPfksu7Qd066poEgB9OeV133VzbFiNfLGK4OGqLq9hYCguiJEw9byexx/Uy7ujeb1akXjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXki9lZa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXki9lZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753119284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8agIhitwoPbdb6X83IqxqhMEAGZ7uUuvwDsZoeUD/AA=;
	b=TXki9lZajcn455q/BliDw8d7PGE3Ek7jQUcZaKTnJP8/AWZyERKgasiQoFNSoyzsIBPKbI
	rt9/HJZh/23Z8b5SD3iK2fpe/MhmJCGmAefANQpS79sJeekYP4ndsWhr9ROqWhTG5lLepJ
	lhvSsMQCCL9tyiXEKcfoVkTTAJSuq/g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-HAfIQiOSPCuQnioKg0d7tw-1; Mon, 21 Jul 2025 13:34:42 -0400
X-MC-Unique: HAfIQiOSPCuQnioKg0d7tw-1
X-Mimecast-MFC-AGG-ID: HAfIQiOSPCuQnioKg0d7tw_1753119282
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c955be751aso638285385a.2
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 10:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753119282; x=1753724082;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8agIhitwoPbdb6X83IqxqhMEAGZ7uUuvwDsZoeUD/AA=;
        b=WJsd8rPG28SILW+JL9Bp1+tD/lDGBam/ACnGPWuS8nb+7+FV0AEc/FEkl4Voe36vJu
         58swKJLWF24JzlGODWBYaO30k5HXmli2Ltp1Pu/Ov9qeKxx4mbnWiTWflTj6AYW2S3tp
         nJStn1aA1ol/c+SzzvJr7S43iKi89HU/z2tsk3BfM+QLhY08UO7M33Wka1MjJ+yVGRuj
         aTnuZ+cHP69PZ2IRZGiG16qP62tdCDlwCx12dkIz1g4aTqd91X/JfMoPcA/6XjusTf8H
         67Tk0Opk2A96HNrTxFtEvIf38lkRjxvxuD9ejpwDgC56TWwN9DvzUc9TuoUX75FpIbk/
         PVHQ==
X-Gm-Message-State: AOJu0YxbnBsc2ZHp1/6RxGkQNPikqOcff3/JcQSt+/PpLIFAQQYRG+jW
	pdOX8tAIqvxEtScFPPxCcqORzI+iDiCH/YzaRIlIN0Nqg99aXWYSx/c2jnDIjvqZKInnU6rDt7b
	dnszNuZ+6ioB8Ga9Z8UcGt6nxarH5KRdC+YszPK64u6uA1+CZaj5Mw2WM0RVeAoc8W5iGQAH1ve
	Im
X-Gm-Gg: ASbGnctbrmQtIL7Esk2oekpX9R/ieKMXH0hHT5WlqH0086usuTdxgKtVINcUxf7zvfj
	AQkOnlKYHPxpW/N5KlctKvofMeGPKnBpUu8Lil8jaTeoLDMDjKFtpmGU4T+5bH3fUUynRwr6yWU
	rabRH/5UeV49BFqJtlZQh+M8A3hQcic02YXZUkHZqtEPSiIi3bakgdqTCZq4XrTM+2wRG+VnLSZ
	lnCn8RDASfIdK+PwRw4n7XpWIu7ZIldwvJWEwWqFu3VDQO4CM4SLDrjs4cJpxbG0g7I6XpchXlt
	j5aH9fq9XzlCx7uP08BErhQ+P1GTcA==
X-Received: by 2002:a05:620a:1a23:b0:7e3:3010:1fbe with SMTP id af79cd13be357-7e342a602acmr2705491285a.2.1753119281728;
        Mon, 21 Jul 2025 10:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENutsi6s8+azvmiTrib03C9FQ0JJQpYt6zWUlucxZ3i8ePOTEEI0OeVzD4H9enikxdEgwUGQ==
X-Received: by 2002:a05:620a:1a23:b0:7e3:3010:1fbe with SMTP id af79cd13be357-7e342a602acmr2705484885a.2.1753119281102;
        Mon, 21 Jul 2025 10:34:41 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c64171sm448459985a.77.2025.07.21.10.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 10:34:40 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:34:39 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 02/28] cyclictest.8: Synopsis: Remove -U
In-Reply-To: <20250704132721.13325-3-darwi@linutronix.de>
Message-ID: <08edd7fc-a9d4-87cc-9c3e-7aa135c8d15a@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-3-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Commit 7ea837b01d7e ("rt-tests: cyclictest: Remove numa from help")
> removed --numa from the manpage but forgot to remove its shorthand, -U.
> 
> Remove it.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 2871daa..35f7c90 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -19,7 +19,7 @@ cyclictest \- High resolution test program
>  .SY cyclictest
>  .RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
>  [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
> -[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ] [ \-S | \-U ]"
> +[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ]"

But don't remove -S

John Kacur

