Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1010EAC6
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128108; cv=none; b=PM65kVS/P9s8vS+lFkDX992MD1MjgnC6yAM4Agr0DW7+xyFKR7JWSdNaYeQYPJDQ5mZAJfw6H41eLFF/XC0qufNG3sWuYNQRVeWwubkREzd+mCgomQXOkALm8js+y6UojrdhV3kTNXJuqK42PRbxW8hO9gm/LjoQwH+0M1SjdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128108; c=relaxed/simple;
	bh=N1KxK50qz+qxgs6iDekjpGBpcdW6oW37k9ACBqtnPGo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UGEJ/CcKQmOwxZ6Ji+3cexCHXgCnR6I0uz8VL2VOozreRrzG9Fv9JN//AXouDXQRAWeciEb+zHuMe4qZsSNodaIfDtHjtZSCmwnUp6v29o2CVR+umvezsZLQ2hPVYooFaTDYzdv2r2w6y7GlWmRhSKBaAquyBSH5ReJ3QVD0WnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajwFm8ZJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajwFm8ZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753128105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5EQq2A+0sq4hC87fxjJPt3GI60+zLqjBI368pT74PA4=;
	b=ajwFm8ZJ/Qm0HiktGsR75qofjEVACx71OnZDhv3wSVYOqdL8FtiuVF6pFOUcTRV/q38bPC
	2ZSv7OkHZ2SF5NZ6UW/zukJHiMulLxgHXBlPSNsO0K0krbMWRPENMqFdQgzWOaok16suLt
	Sde4SPj6W/Rw6xzWVhqiMFfjycmYnYU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-3L6vvXzeND-pjtKEcU3aUA-1; Mon, 21 Jul 2025 16:01:37 -0400
X-MC-Unique: 3L6vvXzeND-pjtKEcU3aUA-1
X-Mimecast-MFC-AGG-ID: 3L6vvXzeND-pjtKEcU3aUA_1753128097
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab3c757b2bso91027471cf.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128097; x=1753732897;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EQq2A+0sq4hC87fxjJPt3GI60+zLqjBI368pT74PA4=;
        b=TVeC2jYJSzXdCroBCjMSgecyWYg5SO5E6ySYwipXvIAuuy0sIu1j1zlvrWUoM7E+m+
         CS13vmOJBtVVwL8gcONP7Vghthm4A7S2jmsRgg+pEI4+Qg3WWZZVLh/0EoaWF2LzDuGE
         P1NtQ1CvQf+YZWK8pdP5VRLDOHGqD1imo2avBfDf9sSMg028m+Bi4NC5UrWKAr989uJf
         cikZAAH2prPXqHfIz+1ylVxEPrh6nB34hwrEMLm0ISlBlMAfSGRF6H96z7TaLG6nt8w6
         QBk5PEqjFNQjTdEl985/eQc3R57uCRiMvW4Z8jiREu/kJiXJSByOAiKRd1suzB1OZOf1
         LaWw==
X-Gm-Message-State: AOJu0YwYJPC8QYVhm5JvMwIa3cMP5GYG76roCvcrDXVBUp2ZIhCCtkPP
	PN0T7sCMJt5+Uv6E2lzWHCGltAHckVARDi+XrxKlD7koZRIDL96AztkuPwRrcn7rcjo/QAYXQS4
	6J8/4tlU5mVmzQmb1JqgLnsOcGyT1xgQV3LcepXdzUrJPi5CmTcAeFWA/BEoRWOnqOBRLGEQUyf
	nD
X-Gm-Gg: ASbGncvhCZiTvivZMuyzBRiut9aDPRgWPDFlsc1aT09qdT44tYlEZZncupCNuI3wFCn
	Kb4OnLaWEc2i//gfNbbuger9gA4GS5Eaw4f6mYjX8FVIL0KtTQDrJYDztWqKcPJsGC892giO27f
	RPWJFmNCfp2Ol71V/Eyc+0+5DkV8aMtcc5Tt+CTAWrmg9ON7REmnKYwFp3xzeCRqe5WJ+1urMom
	7M/W0m9rPnp0D/dc9BwHJ32NgBf9pxVLZjE8cgtrMxMvyA8MVBdsgIb7WFGVLtEownN3W2+nMlW
	xnQUbEu24gFoKiAILloYr2qZU115Yg==
X-Received: by 2002:a05:622a:a914:b0:4ab:9586:bdd9 with SMTP id d75a77b69052e-4ab9586c4e8mr313657951cf.56.1753128096576;
        Mon, 21 Jul 2025 13:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9O0lw0TgkjKg3756UkP89hbeSJTphGUrXccjXm6/h3Li08YUOQ+OXPy5464fshZzoeG8fxA==
X-Received: by 2002:a05:622a:a914:b0:4ab:9586:bdd9 with SMTP id d75a77b69052e-4ab9586c4e8mr313657491cf.56.1753128096127;
        Mon, 21 Jul 2025 13:01:36 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b777sm43516346d6.71.2025.07.21.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:01:35 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:01:34 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 18/28] cyclictest.8: Group memory options
In-Reply-To: <20250704132721.13325-19-darwi@linutronix.de>
Message-ID: <1f143cf4-8152-7fba-74f3-d76680d66c60@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-19-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> The number and breadth of cyclictest's options is huge, and just
> exploring them in sequence can get the manpage reader lost.
> 
> Put the cyclictest's memory-related option:
> 
>        -m, --mlockall
> 
> into its own group.
> 
> Further groupings will be added next.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 7fc0420..a099416 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -180,6 +180,12 @@ field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU
>  sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma
>  v1, PROC-SET, if specified, must be a single CPU number.
>  .
> +.SS "Memory options"
> +.
> +.TP
> +.B \-m, \-\-mlockall
> +Lock current and future memory allocations to prevent being paged out
> +.
>  .SS "Other options"
>  .
>  .TP
> @@ -223,10 +229,6 @@ for automated tests with a given number of test cycles. Cyclictest is
>  stopped once the number of timer intervals has been reached.
>  .
>  .TP
> -.B \-m, \-\-mlockall
> -Lock current and future memory allocations to prevent being paged out
> -.
> -.TP
>  .B \\-M, \-\-refresh_on_max
>  Delay updating the screen until a new max latency is hit. (useful for
>  running cyclictest on low-bandwidth connections)
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur@redhat.com>

