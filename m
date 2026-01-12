Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61619EED3
	for <linux-rt-users@vger.kernel.org>; Mon, 12 Jan 2026 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252409; cv=none; b=DLSB7E7aLAoEUQg1kmtDxaOiy/E3tOKIT2PltIihjPdJzaYsi3kMi73P1TgJBrBLZhh7hmrOR5g2Zl7MsxZEi5gK18UIgTlmU9+nGYVsWSj3tGtpZBFzhPzaSc9rXpwKRg61+8ZO3P40YBj8No09lEonyvJr49owNW8fxsOOwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252409; c=relaxed/simple;
	bh=oNM0rrfCDMs8Y/1hDVQXSfORdyaLp+vaOSt4/AU9D5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1kfnlrWiFXJtu4MsSGbxUhlh4OEol/uLqKnYOQ0OJivgfpLnXyP1Dcfe01F7hM1wIYd/q3kzbZW1kjJ9H0F0m6lK8R+9WQj7NnfpzBj2HPXRkMwhcYruMP/k/ORQ0X24OJi6pfQC/9dQyLoWmpkbob4LuzGpr/ilKlMUcZvKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLJjfAYQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bz9KJxJ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLJjfAYQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bz9KJxJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768252406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBmJrckovBN6m63Lvu6GjUaMDBBis9iNYDL2adrkHvk=;
	b=eLJjfAYQ+toYtV87eizz+Xkv4IerN7Ez/se29P+oyFUJmN1B1ccwFSX9bPlywLzerZR2l/
	IE9Xb67tCUnc378krRDp67ibdEIGoWIfbM+PT9GSMwag0twpkEQ7ax8Tz81UFtGuvoX1aN
	0Fh5xyUVqo5PlEjt2sMrCHB6wEJIiOg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-hPAhMdSlPluw55S3bepLcA-1; Mon, 12 Jan 2026 16:13:25 -0500
X-MC-Unique: hPAhMdSlPluw55S3bepLcA-1
X-Mimecast-MFC-AGG-ID: hPAhMdSlPluw55S3bepLcA_1768252405
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8804b991a54so277832326d6.2
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jan 2026 13:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768252405; x=1768857205; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KBmJrckovBN6m63Lvu6GjUaMDBBis9iNYDL2adrkHvk=;
        b=Bz9KJxJ+7rFEdE2fQCyAGXKpCO722+937/VcrPVjJWDOwYzFV2J0UCHqcEdQ1NkqPt
         3C3xFeVj3cPZ9frbqjufmiEjaxs90UD7sUu96K78lVkZ6ptJmi8jywf3lj5YvlpChjr2
         1XlsNq/iWIecA8mgAEAUPzpixE4K7AlRYRcefBdTeV3Otif+wsTS6lHhfXkPC8pwmwxo
         ZXXg+KpGnLZRJAUVnT8qI3l2B8+qKmeP0sasAIDafiH/q0H6p2s8/8t2mUB8PnB7yyaC
         fH9skHxmmQIbEu2Dnp+tHqIgvLPSKCqu2ZoIFm4bkaFg7c1eCqtyDYeOY2x5VPQRQKVG
         c4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252405; x=1768857205;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBmJrckovBN6m63Lvu6GjUaMDBBis9iNYDL2adrkHvk=;
        b=MoLnj6kcKASCgAzL/QamZ8pnAUc2Trk5kL8+tZbmxotpLfvP+vSvSREOaV9QOdFkuJ
         ISvw1KPg4ruLOUJezi1pLUW0ktzGBFZCd46QTJQ59ZqEPT8OiirVCBdcldyPstry9LDK
         G64aK6W26TbGkVjZQTDgFcdM3Uh4WExrTOn8Z16vtsPAnic7mbNcR7LGrw8SDuJ7NhBE
         oihcNgsKI/XJKWnOmjTdTOqyvkToRLgctrilFStNc/hKHduN75AXeJ6zqGPvCKFilvcg
         KdW4LgIhRdpre+hxpXvd+OfMHRUpd2mBk9NckMTUnWQkm2nF4GGGpN6eu8NS8t3F1byX
         xDoA==
X-Forwarded-Encrypted: i=1; AJvYcCXWq/688h2yImEEjMHsilGTgkXkhTjkUxoObp+tBsR62JRp12L7mWjzrjwxZtZl1vpbAOVvw3ItnqRw1vXgsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPzHQeiXjk9192WtgoEweTVo4D8kzVY/8GvrjtxLVgtYpdeJO
	N8NZ3mH+Xi/V4kgCsYeATm2uUF9kga0vf4mpC63bYr8subdGoKEZi2RRdrvcBdnQ6FbKYsv3O0R
	oY+zaB3uERfAKlTnTsl47tuCGctLmcOEuR0ZNNC7+/O6o+TT+Bq9GrJN7S2xwxIYeMnxS
X-Gm-Gg: AY/fxX5DMHyTc8BW2gM5Zj9Yc1awl/ye8QWIpfyPnFzlR99VV0Z40+Y0bzlVgr8krVU
	795Nh2c9Ch+2yzYOScVmfDtzt2Tbyohegbvq8z143/rOJukEeLU1jRuQJBmx1tedQU7Ks8MJiln
	GTgXkdzQHEGgrMju9fzoywEyRZcBHEZY0s9a5eCuT7u3hfqGZ1Pt9knaLJi08TmidBznRC9uDfY
	eyx4qTLdMzhXDPaKAHOIKdSP9bk0T0FJ/y2i2rOiSn4DIGyxlnPJu7XnWC0FqcEqYPb9EivfHXI
	VxoxwkQ6Lqwuwl9QynMdIb9sV12NNkUH3+9agAM+XJZVVty9iKO2YGjTebUgTgdfwIHC9P1QBf7
	wG/9Oq6bzA2WueojS8skZo6lBEE/F75CYWc64AczQiA==
X-Received: by 2002:a05:6214:2d49:b0:882:42e6:171a with SMTP id 6a1803df08f44-890841d10e2mr284545056d6.29.1768252404855;
        Mon, 12 Jan 2026 13:13:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcbscr8dY1sdx+sYF+g92wnfjm6SLgWCFAOzX6jhak2+CMV8OXAwknnn6UtIs1IckeiuiO8g==
X-Received: by 2002:a05:6214:2d49:b0:882:42e6:171a with SMTP id 6a1803df08f44-890841d10e2mr284544756d6.29.1768252404511;
        Mon, 12 Jan 2026 13:13:24 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907726041fsm150634786d6.45.2026.01.12.13.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:13:24 -0800 (PST)
Message-ID: <e64e7188a920634fce126fc71ccc09696984f42f.camel@redhat.com>
Subject: Re: [PATCH v1] cyclictest: Generate optstring dynamically from
 long_options
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, linux-rt-users
	 <linux-rt-users@vger.kernel.org>, John Kacur <jkacur@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tomas Glozar
	 <tglozar@redhat.com>
Date: Mon, 12 Jan 2026 15:13:22 -0600
In-Reply-To: <20260110113738.2376456-1-costa.shul@redhat.com>
References: <20260110113738.2376456-1-costa.shul@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-01-10 at 13:37 +0200, Costa Shulyupin wrote:

> diff --git a/src/include/opt.h b/src/include/opt.h
> new file mode 100644
> index 000000000000..4d01917be024
> --- /dev/null
> +++ b/src/include/opt.h
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#pragma once
> +
> +#include <getopt.h>
> +
> +/*
> + * build_optstring - allocate and build optstring from long_options
> + *
> + * Free resulted optstring aftre use.
> + */

"Free resulting optstring after use"

> +char *build_optstring(const struct option *long_opts);
> diff --git a/src/lib/opt.c b/src/lib/opt.c
> new file mode 100644
> index 000000000000..d235788001d9
> --- /dev/null
> +++ b/src/lib/opt.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <stdlib.h>
> +
> +#include "opt.h"
> +
> +char *build_optstring(const struct option *long_opts)
> +{
> +	char *opts =3D NULL;
> +	int n =3D 0;
> +
> +	for (int i =3D 0; long_opts[i].name; i++) {
> +		opts =3D realloc(opts, n + 4);

I realize this isn't going to be noticeable even if it ends up being a
copy each time, but linear realloc like this makes me twinge and think
of how just about every other language in common use would have a
readily available growable string implementation :-P

> +
> +		if (long_opts[i].flag || long_opts[i].val < 32 || long_opts[i].val > 1=
27)
> +			continue;

What happens if the OPT enum grows beyond 32 entries?  It's already at
16.  Maybe start the enum at 0x100, and print an error if val is less
than that but not valid for getopt?

Why is the implementation (slightly) different here versus the rtla
patch?  We should probably use an enum in rtla instead of '4', '\1',
etc. as well.

-Crystal

