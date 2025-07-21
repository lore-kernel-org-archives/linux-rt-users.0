Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AF223323
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128173; cv=none; b=t1UHXGCaENswAff+FqDSA8kb7vZb1qP9WQEdbhenSH5pjRJ5MOcJQxF8lmMUra+Lh9TCbOGcJ2zAuTZ24G/NVuxnP5cvBic3o7sv1uD+QvCd8ce+Qkd9elA85CUf9NWcIaSSyhARi+Afiek6mbenSgbzwv1OG0nbgYvsl56MdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128173; c=relaxed/simple;
	bh=uDnD/03v4o1X0WIe2PwVhhqTq/6i79tAr8jsfjn2C4I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pw0+yRvgbtby3My7mCRa7pboSsJxd+PNPQKfZfiSFy1xy/S1sg5+HtBPLWjN7mLiX3xkxc9nnuqgATAX9co1dKMVOamZF8Y5mwA3gDFemZHUr5IG/Z17g0n/03k+QhC3VBywCwTo2ctPBPsmYywrK3rWHXw4Knbz87D0tgozbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yn/YOhQn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yn/YOhQn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753128171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q6PO7IYjurKTXpu2Ao9TVWNJmjFklTvUiphr92kE1eY=;
	b=Yn/YOhQnEI3pE9DkyUogrbk6rA0aVp6F0AWbnByRKC70U+hnAu/QNMwIz9zhImYLsI/q4D
	mPfvB4ROhN/B86t5B7V6d7mYJNcOpcDiCCM9VjtVcK0SXaq6AUE0p/pMv4bVIeKsF7AkhE
	b6mJg88Cz8ert5ebNf4eOGeX01I7ihc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-MSQJOMynOw-3NuYVs22law-1; Mon, 21 Jul 2025 16:02:50 -0400
X-MC-Unique: MSQJOMynOw-3NuYVs22law-1
X-Mimecast-MFC-AGG-ID: MSQJOMynOw-3NuYVs22law_1753128169
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fad2a25b65so79584116d6.3
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128169; x=1753732969;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6PO7IYjurKTXpu2Ao9TVWNJmjFklTvUiphr92kE1eY=;
        b=K2YOi6bFPuoNokfkM/0B4CI0iBJjg/BrA1ftXt+y/TCvpiKr6jXTkX6/kfDfke7nWW
         jkKkJkjr996gvD8TQvhLubBXcSQ9Bu2r26AJkA7KG+MEhSjeMtK571bNpHQlUDrL2NVK
         YFhZvzd3G5Kzt0d4pDwQh+jJZYzFe4hA9g974Wc+MWtngE/ZHrB2w4qq35V2Ia5IgJ8w
         SLfu9ByEysk1eEComgFBeh+LrgXS/IhmBnvLZJ2OQpEfTvyya6UNv4Iy1ElDqEgmemol
         bhryXvf2T3Qr0LRn9J8GC9tgpeffwWhZPwDX1KkqRKGsdK21p5o4ygOKBUW030MD4t6R
         bVYQ==
X-Gm-Message-State: AOJu0Yzo6S8L7nVOaCD4BqOVsx32NpXqEIZQR4+Ru5ZFW5sq6QX0CoLr
	bb8Wrql0/g6jW8WwVL1yX08KStU/47hbHKSyCtimmBRRrH9JDlL61xWGff0txrP+8DIvDF85MWv
	18Vl/8hLpBxtRje0QdHlnQ187mRP/zLvvSshTgKUYJ1JIXdvVcUr2ziovb83LBYlJk2iMOd9l0W
	Af
X-Gm-Gg: ASbGncsOSTn9Zzxe2P7mRB02dAKaB275kzuy4msCWQRyNVZyvaXT+2MRC+zNEEZhGaX
	VEXGSveQsjr0nG1Cat8SHZAOKZGeQhtyMr/spZqNWKdHNROHnabD1mwVvEGp2OrXQpYsIt65BJh
	wjVMllne/6oi7tXqzbD9jtN+JvOBuMtqUsiLMLuRVW+ocZ6cHmLw537PmDh05K3/LqrYCljmwke
	cbAj/AkOlsbyhcAKB+GnVRZoDkrBV0S81E0NymJWkgIlFpYnJQc+tpJfr/FHNJc5i365i+3GBxP
	V3ngC/AkyAzZAaS1ZXs0bR6C8VlIjA==
X-Received: by 2002:a05:6214:4907:b0:701:a5d:7e37 with SMTP id 6a1803df08f44-704f6a3d2dfmr395787046d6.13.1753128168701;
        Mon, 21 Jul 2025 13:02:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxbmTvJMK55KYoY51d1ONvBya07+qXsLfs41eS9WkN/AWShxvGyAOjjSxnxFCqqam9AGooJQ==
X-Received: by 2002:a05:6214:4907:b0:701:a5d:7e37 with SMTP id 6a1803df08f44-704f6a3d2dfmr395786546d6.13.1753128168252;
        Mon, 21 Jul 2025 13:02:48 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051bab471esm42414346d6.105.2025.07.21.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:02:47 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:02:46 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 19/28] cyclictest.8: Group thread priority options
In-Reply-To: <20250704132721.13325-20-darwi@linutronix.de>
Message-ID: <00a8f3d7-0e73-ae7b-d39d-897f680cb51a@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-20-darwi@linutronix.de>
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
> Put the cyclictest's thread priority options:
> 
>        --policy=NAME
>        -p, --prio=PRIO
>        --priospread
> 
> into their own group.  Adjust the Synopsis accordingly as well.
> 
> Further groupings will be added next.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index a099416..90a3e08 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -30,6 +30,11 @@ cyclictest \- High resolution test program
>  .IR proc-set ]
>  .RB [ \-a\~\c
>  .IR proc\-set ]
> +.RB [ \-\-policy\~\c
> +.IR threads\-sched\-policy ]
> +.RB [ \-p\~\c
> +.IR thread\-prio ]
> +.RB [ \-\-priospread ]
>  .RB [ \-b\~\c
>  .IR break\-usec ]
>  .RB [ \-D\~\c
> @@ -44,20 +49,15 @@ cyclictest \- High resolution test program
>  .IR num\-loops ]
>  .RB [ \-o\~\c
>  .IR oscope\-red ]
> -.RB [ \-p\~\c
> -.IR thread\-prio ]
>  .RB [ \-\-histfile\~\c
>  .IR file\-path ]
>  .RB [ \-\-json\~\c
>  .IR file\-path ]
> -.RB [ \-\-policy\~\c
> -.IR threads\-sched\-policy ]
>  .RB [ \-\-spike\~\c
>  .IR trigger\-point-usec ]
>  .RB [ \-\-spike\-nodes\~\c
>  .IR num\-nodes ]
>  .RB [ \-\-dbg_cyclictest ]
> -.RB [ \-\-priospread ]
>  .RB [ \-\-smi ]
>  .RB [ \-\-tracemark ]
>  .YS
> @@ -243,21 +243,6 @@ unit.
>  Oscilloscope mode, reduce verbose output by RED.
>  .
>  .TP
> -.B \-p, \-\-prio=PRIO
> -Set the priority of the first thread. The given priority is set to the
> -first test thread. Each further thread gets a lower priority:
> -Priority(Thread N) = max(Priority(Thread N\-1) \- 1, 0)
> -.
> -.TP
> -.B \-\-policy=NAME
> -set the scheduler policy of the measurement threads where NAME is one of:
> -other, normal, batch, idle, fifo, rr
> -.
> -.TP
> -.B \-\-priospread
> -spread priority levels starting at a specified value
> -.
> -.TP
>  .B \-q, \-\-quiet
>  Print a summary only on exit. Useful for automated tests, where only the
>  summary output needs to be captured.
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

