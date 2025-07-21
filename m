Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3142236FD
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128941; cv=none; b=huERV1QRc8LFgYmarwTNhObmNry16seAB0TOdFAsXFaByH0BFXyzMxdc/7L7g6Ke7ohUkormbOHYZaZiWBZVgw6wzZnuYlLJBGh0Sed0zKe2ObQ1WQq5+msagc8DWAmAOGgau1PoyP5EdZs/i6CBg7L4b2fehpRMjgN9V0K2AUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128941; c=relaxed/simple;
	bh=jzfjzy9kWBkDyCcdXBwuERzp36u5pck+yNSdovXKeZs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nJc0w5wpVKmXsT+k0YPqRH/BPdXBCeJo0Kl3fCJlAV1mJoKXyfs0deTTxO/RASVcll5XKpAV3/WTKL3qZ07Aw0ZTP0ZTjAbbKsYQpgUBa/IhkdgP3r2JSbeIConSwxjsPX6xePcACPgO5rQT1zg6QrG9kHI3ZrT2QHzik4XvtK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1MDCpxH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1MDCpxH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753128938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fcmNyE7LN3+Q8P5rziX7iX204RlmMX9aaCylH3imjs=;
	b=e1MDCpxH7awMp50atYWvi4+F9Tq+sR8pB2e8rd/4dcRCj3bwGFMFkVfdPowE4c4czseYdM
	r2KqOOaUDOTq22F7YuPQ0c2gn20mTkbylMv+akqKNhIrlGEJuUjW446KvJeeQrz/dLjQet
	z7LXvl+Gb/F6cX9oB9h0a6oIRi+Xkwo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-7ScLzoU4PfG6sEvUYnGyyA-1; Mon, 21 Jul 2025 16:15:35 -0400
X-MC-Unique: 7ScLzoU4PfG6sEvUYnGyyA-1
X-Mimecast-MFC-AGG-ID: 7ScLzoU4PfG6sEvUYnGyyA_1753128935
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fac216872cso99822516d6.2
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128935; x=1753733735;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fcmNyE7LN3+Q8P5rziX7iX204RlmMX9aaCylH3imjs=;
        b=AUQ8+8tRVAb8uTGFDKx5x+9MCjLhC0wpyj07+QiH8cYmAn8dc2SsWuco2tCFIRusQV
         PlhqkBKqrkl19ga4VJKVi0dWXXHCnnJtDpkzGT6QHKbOvxYatpt1Jslx8Te0gze3MKL6
         aU/kYA9R/sYw6YUviuqiMJZqPkTWS1nt98VS2uK3tLh2QeO9NFUEZziANJIljtIGbwD1
         NKC+nAYDRUELNbd1rD7H6amSed4ZPLC/rJlUfZhyh875CbR+BWHD3a7QbQTu0pKaYHQd
         t5ZlW3230PwR9xtZyqMkx/9qjF0XnzPfixsiX0aPUHnDjnSdI0g3yC7Kw6Qn2ZyZEHEu
         HJvw==
X-Gm-Message-State: AOJu0YwK59uvFRX/GP1KMNZJLOPE56iKrzVdp0h4en0SRTwOLXD8PJoD
	DvtMvBxY0BwrDvk7ltmGXeEXt+p7Ow4CdV3cgY25eHI9dURmwqpSd16iNTaxyQ0ki9CT9ldCz94
	zUtCtFUcM+s9DXzcS8q/MJA/2jrC36ZDTNZHI3O349h4D88AGPXT3j+eB8uZVaQCkk/Rp
X-Gm-Gg: ASbGncuAsH+WNAhjmRjSkU4DMFK7RmU6A/rCX7HXEOLztay8k7NDk/iIuX1EgwoJcFg
	Dvf7Air66y86r0Yo5da8LOk/8qUpy8E9rANFM5UD/sbY4ER7vT/uqIqwZVZkG9MftN28ztcixNL
	Dnk5fjnn43WJAU4ptKn+ZdtUnxT+ZurLijfeRaEDN9FhlJ8bzGpgGDRoDEedvya7yrl06rsGuRa
	8FR5eDkKnZB6pvPKnK0KgqpndPRDUrm+Zly0yq3v9A4+vjeUh9ndRFbKsMG15VWf+vSnHvsIXgJ
	6/h0b6kULn4R9ChT5+JD4Z3LKGjkKQ==
X-Received: by 2002:ad4:5aa8:0:b0:703:98ef:8a71 with SMTP id 6a1803df08f44-704f69b51d8mr258895606d6.0.1753128934548;
        Mon, 21 Jul 2025 13:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+MzBQtjh7bve9HegHGrHryV62ruiXmRkZYONnexy5LxgS9QQZGIQYkHkx/9/FZ842z34lRg==
X-Received: by 2002:ad4:5aa8:0:b0:703:98ef:8a71 with SMTP id 6a1803df08f44-704f69b51d8mr258895196d6.0.1753128934036;
        Mon, 21 Jul 2025 13:15:34 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8bd516sm42525246d6.10.2025.07.21.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:15:33 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:15:32 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 25/28] cyclictest.8: Options: Expand --default-system
 description
In-Reply-To: <20250704132721.13325-26-darwi@linutronix.de>
Message-ID: <1baccd75-0c56-4be2-071f-2bf22a026b6d@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-26-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Now that --laptop is explicitly obsoleted and --default-system is
> recommended as its replacement, better formulate the latter's help text.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index aff900d..6982234 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -75,9 +75,11 @@ display a usage message and exit.
>  .
>  .TP
>  .B \-\-default\-system
> -Don't attempt to tune the system from cyclictest. Power management is not
> -suppressed. This might give poorer results, but will allow you to discover
> -if you need to tune the system.
> +Stop cyclictest from force-tuning the system. Without this option,
> +cyclictest writes a value of 0 to /dev/cpu_dma_latency, which prevents the
> +CPU from entering deep sleep states.  While such force-tuning might help at
> +showing lower latency numbers, it obscures the fact that the system may
> +require additional tuning.
>  .
>  .TP
>  .B \-\-latency=PM_Q0S
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

