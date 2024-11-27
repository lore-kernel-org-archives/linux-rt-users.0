Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047A198E75
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Nov 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700766; cv=none; b=ZRYij+L0qL/oCXf8QVf2CL+2SJQG56cUgo4T8zHcMEYZsB7jq+Tu9oHzOoVyP6hmMaJwgcuvTbPdaTnvu+2Fpcj5B9fXWqED7HrEjbft7Dzd+CNfIMj8nDBHcm5Xjg22U3jcCX1O7K1U6UzjDh61iwuMBIBv96cC4cRzkQTdesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700766; c=relaxed/simple;
	bh=MJuniSQ18Whja2TGzD2wZj9+fAPeNIIu2/wybj1tCi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fzzk15Soscn7UUV92wLMh6Vsi7MWMTKUGnMuQhrMJIE2U7Xdk1ANIp2PMSX0oW14OpkDgMN+n3HsC3tqaa/ktCWuZHzni9F3wNMKVyv6a6ZBwJGRk7zDAgZFoEsExmGBiX6MzlTZp3q8IbHP3ieaEqWJ4/klEEhbkjrjPWmhLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jg14wzVN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jg14wzVN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732700763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJuniSQ18Whja2TGzD2wZj9+fAPeNIIu2/wybj1tCi4=;
	b=Jg14wzVN/Q1SDiyP+H4cghzbrM0i6g/xF9jGzMdGUFONf2mgIEZJuQD6NjMCPH2lYfG0Lx
	Ixv6aLnDj3Fsthe2UVrLaXd/AOnYESpM2QAGDxkj3+d/yWkkeOBIzf31ytl9lNnRoQ71O7
	Dt3f2c8CVQCqWo2lZvokIk7gcZCfZIw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-Ka1xI4xJO0qXk0gdtybAxw-1; Wed, 27 Nov 2024 04:46:01 -0500
X-MC-Unique: Ka1xI4xJO0qXk0gdtybAxw-1
X-Mimecast-MFC-AGG-ID: Ka1xI4xJO0qXk0gdtybAxw
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa529e35844so63351666b.0
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Nov 2024 01:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732700760; x=1733305560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJuniSQ18Whja2TGzD2wZj9+fAPeNIIu2/wybj1tCi4=;
        b=Ci5W8aKQjlroPb8Q/pVCO9MR0pzys6tLHs4I2FJpGv8nb4aP8s9l/K4L89CKYWcGUn
         7GGbwkQAZP39YIZw0zmWwb2/i637Nwzzpmv86f/kHqklNIb2iVJFHbL4BkcRR7f+ZGg1
         kdsLq1ioRLxoPOtuO4KjZzvZe74HzTN3RMDkHVlJbqK+toc4f701ERsE0fp6Jyv8p/p3
         /bhNuqwMDblvBJZUI/N9+cHxi8/UoG2Pegp1C2zwqQrQcywZSLLWlqxEDyiRQKKQ7AoN
         szasIT2bX2wt8DT4z8vGOnSrRk3rpGGch8VSryER5/r6nu+q2LQrkqvLok0KcRlksbd8
         wKMw==
X-Forwarded-Encrypted: i=1; AJvYcCXVRPv942m9R5MZ5yl4Qr6UQZBb7eUzhDvt4wmTYaW3MriIxrVsIueP8DnsK0RnVQOlVCqr7EIavqMMRtVjpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqi0MMaTwhVf5eIVYKaiHvz0i3bMbSaW+8KoAtH/7kRO6unfP
	tIUJcSlhsuWH5eCfZaofO3qTRxG7NbYU3X73O3IoHS7sMnoXT6oc1vNBgQ+9UfMoA4qVzJA5UJ5
	opRpHmnRS22O+MiO/jWXcInRWKpJaLkWfeHG/Ez32GtwLs7oiWFUgTLZfb1yxA7c29eWdVPNobF
	MWlcO9nz6K24HqdZbKBFKtkmsQ+J3UKeCXtrFrTEo=
X-Gm-Gg: ASbGncsAT21S3yNrBlAYRLJ+QlTrw8S266bRci26O9L2NWXnAYDlBifiL2jYdflz3yJ
	j0n2XZwgxwNXiOHuZXjMppPj9NrjW+J3Zg/URrrhWsXcWnt3g9xKiOdA3FcUpTqM=
X-Received: by 2002:a17:906:1da9:b0:aa5:44cf:3ea9 with SMTP id a640c23a62f3a-aa57fbe983bmr201675866b.28.1732700760648;
        Wed, 27 Nov 2024 01:46:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA/sJSCOBIjvfl5IcL6DgsbDfxE35GwOhMc+px1LbxyTobn26iBe6EamzHYwrEprTcTJ47ZPQmojCnVJlBdM0=
X-Received: by 2002:a17:906:1da9:b0:aa5:44cf:3ea9 with SMTP id
 a640c23a62f3a-aa57fbe983bmr201673866b.28.1732700760314; Wed, 27 Nov 2024
 01:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113114509.1058593-1-tglozar@redhat.com> <20241113114509.1058593-3-tglozar@redhat.com>
 <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com> <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com>
In-Reply-To: <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 27 Nov 2024 10:45:49 +0100
Message-ID: <CAP4=nvTZ5nLrP6O7rSU+c269M-=OFTX=3zNSp6TDDxzg2Fq2fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state disabling
 via libcpupower
To: Crystal Wood <crwood@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org, williams@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 27. 11. 2024 v 1:09 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> nap=
sal:
>
> This could be said about the laptop and power_management checks too...
> I'd go with verbose info prints rather than warnings for all three, if
> anything.
>

I agree. I believe my code is consistent with what we already have.
When you do cyclictest --default-system, you also get a warning about
not setting cpu_dma_latency, despite it being what you have explicitly
requested. My patch just does the same thing for --deepest-idle-state.

I suggest deferring this to a future patch that would remove the
warnings and another one to refactor the code.

> I'm not sure how cluttering up main() with more logic would help, but
> turning set_latency_target() into something like
> setup_power()/cleanup_power() sounds good.
>
> -Crystal
>

Yeah, main() is already long enough, I'd prefer to avoid cluttering it up m=
ore.

Tomas

