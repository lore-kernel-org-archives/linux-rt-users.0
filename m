Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4A22741D1
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884980; cv=none; b=FqMEFMnCB1lyBnGXbQ3AhGHfGalCwcHagfLXjnbIL3PuE+g5oQ4nknte37ZJhoywzvfGUhT1CgJ2yesjduLtaNjtNdQG2GJl58CBkR62uaExI1HCMqqgZFY5vjbJrkcow0rOuF6e46zo3IcrFNdi3T7xLMDcNYqviGZ5EddKCxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884980; c=relaxed/simple;
	bh=yivgVZ3pU8y5jjYeFzJuizY91MEtic7di4oP0wZ/aY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUdo27h9Lac9ixKm/yYWeKBQuTXpiShSMImrn8BXXns1QivKn2nEKPd9W4U3vhw/wcidhm0O65+iu928NY2x/+QTNS/+icy+z8OJCtE/Fe0pm1OGBqOSOi3GzO8Zblj7db9bgvDXbSUXpu9YOWjwhE8Lcnnu2XQLO4GmTAgM61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGBMz1/a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGBMz1/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758884977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lA+XiEev3sgIieGen1jdDcmHLLqRjcjQGGXYHrxsIhE=;
	b=ZGBMz1/aZtdH6M8dGCA6zexynnxHxKzYZhNLLgXUWti0uCYfJRy55ajjuX+rFQjPbIjAtS
	Rg9QGe5FMtFz+Yzq9hapMM0hIG009b5cklmA8zm6M0ynoBNqCBPT87EwWAzuyjp1av/hCa
	YcFEPEjjVIy7JH6GzGRc5gLNka59/54=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-SrOQT04cOVqnuyuC0d_PRQ-1; Fri, 26 Sep 2025 07:09:36 -0400
X-MC-Unique: SrOQT04cOVqnuyuC0d_PRQ-1
X-Mimecast-MFC-AGG-ID: SrOQT04cOVqnuyuC0d_PRQ_1758884975
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b07cc3f115aso175808566b.3
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 04:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758884975; x=1759489775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA+XiEev3sgIieGen1jdDcmHLLqRjcjQGGXYHrxsIhE=;
        b=tD3UEJCOnUbbA0HqWnM99RnfQWwtue/1EAQU3k6EjYaX6JpdCwdh7+5dlUJiEC6JIV
         1gQrKvG0zOY282OqKyZd5pQFYeStgKnEAjZ1Lho1QNmQfzFyuNgTzw+jYvx/GFUkQU38
         IyZsaUuQc66Tq8b7nVneXBqwSh48NFEzPMxqXvm2RtT1KZYiLGOkHu+CXHwCxvXe6+Lh
         bEoPsh7vvvpdrLsxNw82umXaMLCEpGaOJXQFTV4E//UZx43pFg8p5sNcFivGyys/brIO
         5MvVYDGhFC5hE+AEZS/wj2qI4UojUSFkBUb7ITRGMNcw5g+5aerbmTU6J7tE4w86xBRM
         9jOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKteVPvL4PhIs5pXmun6XWLpOhHlkUnV6KuEsUf78pOemajDcs3gYtPPs1Hf6cSLKxM0mK6YDiZZw33eyG7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNzmnIuy7nzHTIcdJt1nROLi+3iZu2ajG2xd3ZoA/hvfNhQr/
	0Uucj2TzuDJGdT7DxyJybwpGHzQtfFyGkULQuvBuU2UCxQQW45QQzBATNJATwF+Ob9qqOrI3D/q
	qJh4sg2yGu1xilKWReUMgGxQk2hq/Liqj8BF/m3ZqTHLJIjO7SVVMlj9zICZJFKiKTtYyh1Iq8p
	9Z2C27gpYkqNbrGHO64xVk3gWHmvq63tbtzbw1ohntczM=
X-Gm-Gg: ASbGncvFoZorLP2RCkcjarwXJoKVPZ2wsVapVee3cc7BLHAo8URfLbFDv/kF43TyVrG
	UamFoh0bgYjmb+CMucoQgUtRbFoahIlKfvORYRZBtb319P8+Cj4m4zOspHyqKTenmQlFqOBUSUk
	IuKVerlakSTWrAh9fPCrw=
X-Received: by 2002:a17:906:f597:b0:b21:6dce:785 with SMTP id a640c23a62f3a-b34b7209d39mr739994766b.1.1758884974926;
        Fri, 26 Sep 2025 04:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI6BFvnT7KUhjKR1GQYEHV+IOt5TWXUHS5SaKw3chC5wIkzKI87vOKPuj36q51L9YbSq+KU1bcPYgrAZA1MkU=
X-Received: by 2002:a17:906:f597:b0:b21:6dce:785 with SMTP id
 a640c23a62f3a-b34b7209d39mr739991966b.1.1758884974558; Fri, 26 Sep 2025
 04:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725090201.32656-1-tglozar@redhat.com> <43c97d17c3dc4c97a4ec47968c1c52d58c57e4ea.camel@redhat.com>
In-Reply-To: <43c97d17c3dc4c97a4ec47968c1c52d58c57e4ea.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 26 Sep 2025 13:09:23 +0200
X-Gm-Features: AS18NWBfDyVLPaPqD_EFG4AcQcntR5S5S5VjqR4qOuEwhWA3_LRce0UrRbwS0Kc
Message-ID: <CAP4=nvRXtcYdKLbMn-U9TZ3bv+RV_bMkeVoKTMevv9q5+uK64A@mail.gmail.com>
Subject: Re: [PATCH] rteval: Introduce E2E tests with output checking
To: Crystal Wood <crwood@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, Clark Williams <williams@redhat.com>, 
	Linux RT Users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 18. 9. 2025 v 21:22 odes=C3=ADlatel Crystal Wood <crwood@redhat.com=
> napsal:
>
> Can we just put all the tests in tests/ rather than making this
> distinction?  And have the unit tests be something that can be run just
> like any other test?
>

I agree that the organization is not the best. This patch only deals
with end-to-end tests, though. As long as there is a top-level
unit-tests/ directory, adding another one named tests/ would be
confusing.

> > +             if [ $exitcode -eq $expected_exitcode ] && [ $grep_result=
 -eq 0 ]
> > +             then
> > +                     echo "ok $ctr - $1"
> > +             else
> > +                     echo "not ok $ctr - $1"
> > +                     # Add rtla output and exit code as comments in ca=
se of failure
> > +                     echo "$result" | col -b | while read line; do ech=
o "# $line"; done
> > +                     printf "#\n# exit code %s\n" $exitcode
> > +                     [ -n "$expected_output" ] && [ $grep_result -ne 0=
 ] && \
> > +                             printf "# Output match failed: \"%s\"\n" =
"$expected_output"
> > +             fi
>
> Any reason to not take the updated version of the engine from the rtla
> consolidation patchset?
>

This patch was sent quite some time ago, I think it was before the
updated version of the engine.

> It would also be nice if there were a way to just run specific tests by
> number, rather than a whole .t file.
>

Yes, that can be implemented.

Tomas

