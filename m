Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF90198E86
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Dec 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501487; cv=none; b=fmxK+AMN1KWgdrTUn7mouKeJ8cWmz9/BtfA8OuZVs/KDOHM0N5b28mcS7extlOycKXlJE0zKcdHsJWXuRuJBZZnsqvVxCiB4G8FIFzocFZmUAI4VZ/v+srIL+kjCoTulmgoya1SiVcw1tsRQtYkYhXbU+Tx8bNwQTEc7n+XFMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501487; c=relaxed/simple;
	bh=F/aBHTsIFKDNWePew1m6pMPvud6kNvdV0nkaR+poBRY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D4UtZFYMmyUlASlb5kFo6C6kW9GdgUCKuNF0Z0VNcYSKuHA9YLTqVHojhokK+SPE0ta0P2E33IkxEv8Ln2POl1623YcctWVTsyATNg2aj9Aob0TKWjgjfOEZWAaIGVzMysNy8cKEBkj2rUhb/RozT8kWixdmh0lxMBlaP2LIe6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzoKW8Ie; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzoKW8Ie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733501485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjwS7gfT6mpIOu7SlOvoaC4GUi1rK1E3+sZHwtG9RGs=;
	b=dzoKW8IesD7oahle2yF28r5XkXMNXYs2dZ8j4Ug13EX0/C1SxQfiA36kHIvSk6qc9p145q
	Cu+/s6Fg+RNxt2HJtiEh4ieALcm9UkzSD3Ml+Po7PLtNS90cXdnrbLAetMbq1SCI95Etbi
	ewicU9gYGnVbIjPljmHDBIgpG2yYanE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-2qiZb4WcPfODCd6eBOcPPA-1; Fri, 06 Dec 2024 11:11:23 -0500
X-MC-Unique: 2qiZb4WcPfODCd6eBOcPPA-1
X-Mimecast-MFC-AGG-ID: 2qiZb4WcPfODCd6eBOcPPA
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b66ee9b902so181362385a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Dec 2024 08:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501483; x=1734106283;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjwS7gfT6mpIOu7SlOvoaC4GUi1rK1E3+sZHwtG9RGs=;
        b=V4Mvc/Igev6jGHfwMpTGTWu9wOl+PtPhepJ4cpL/4FpHVfG6pcVskkmzXT8EzF8Chd
         pFGTxfHFsmwDOcQw80X3HFL/qHwPwNwtHFMLVWEEl1yEbWhfjDlyOqhkXybxQZO9auZS
         zkbjLD2wB0aOU8aRZCmACDCjiuNFPVSUxFbuB3wEaC9mWDmRQvd4/YfkgJ9z3dK3ge/o
         FswKwcaHEWSJgo2KlmNETgU1JuTfWoPf2KMA+yMWD4EJYIGzJZFyqJpfYTNSXE/hmWVu
         O754g06b5+ubxNoO8HQR1njumGhWHoJ7EXYOvmFJYZlmL/q0Kd9xtFyO4F8jMiZ3tFDq
         8rFA==
X-Forwarded-Encrypted: i=1; AJvYcCVHXtn2Oa6/IKUtifqwYcZiA13XJ/GtbBEEtUKe9lrP4eO0AooyP0hDqzyDDZ4rjA7Pfly6AW4wRNvAKjXEKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMBWQ83nu4SAMl5DKbXC9Td0IuP5aWrOwkFgAJu1eRZptxjBz
	1cIdqalTDcV5+NI5VUeivNuG3ruVwYNRqNcMfqXmP6iLqE18V5vCxsaeZHARb47U65BI+8z3AOH
	lIc95dtclwNK3Wyu0ffw8wAJQRB68j1SDGgX8xBF4dc9c5FGU8CiA2QrnNf/YyF0j
X-Gm-Gg: ASbGncutx3G2vICIBaWgbh8bTUqH4V+jpxmPde962Ol72xxFyOOGzOMYCEQlZdPKrTs
	+tfa3JCievsF2FkmQEbTEDizuWpHkGdzAi6I86bDZp7ZEt91PD+Gl1n0gD+Ws1srF0g3b2i0DT8
	Tnc6S4abrB8d2QuLAWWiHqQqEmEf2n1/iyRsunhlw54twtqLeo19x8Ddr0euTw45zCgs/hHMhsU
	CbnsYBC53JQnBj48l/7oymMy/XpCUX2DlGutJbw
X-Received: by 2002:a05:620a:24d2:b0:7b6:79c8:d036 with SMTP id af79cd13be357-7b6bcabfb9bmr427968385a.3.1733501483274;
        Fri, 06 Dec 2024 08:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKf4V36p5rp1jLPnrc4iZDOmCI5LixQgi6AcUT0MVRbHwNBWZjuC8P3+TFpSPDRJdl1DjUZg==
X-Received: by 2002:a05:620a:24d2:b0:7b6:79c8:d036 with SMTP id af79cd13be357-7b6bcabfb9bmr427966585a.3.1733501483002;
        Fri, 06 Dec 2024 08:11:23 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a4644asm186357985a.16.2024.12.06.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:11:22 -0800 (PST)
Date: Fri, 6 Dec 2024 11:11:21 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/2] rt-tests: Put variables in test-feature in quotes
In-Reply-To: <20241204154004.560615-2-tglozar@redhat.com>
Message-ID: <f19c6e2c-0880-0432-8d5f-2370555b84b2@redhat.com>
References: <20241204154004.560615-1-tglozar@redhat.com> <20241204154004.560615-2-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 4 Dec 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> test-feature passes several variables (OBJDIR, CFLAGS, CPPFLAGS,
> LDFLAGS) to make via a shell command from inside the Makefile. If there
> are spaces in either of these, it gets parsed as a second argument
> to make and feature detection fails.
> 
> Add quotes around the values to prevent them being passed as multiple
> arguments.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  feature/test-feature.mak | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/feature/test-feature.mak b/feature/test-feature.mak
> index 0b3e51c..aef915a 100644
> --- a/feature/test-feature.mak
> +++ b/feature/test-feature.mak
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  define test-feature
> -$(shell $(MAKE) OBJDIR=$(OBJDIR) CFLAGS=$(CFLAGS) CPPFLAGS=$(CPPFLAGS) LDFLAGS=$(LDFLAGS) \
> +$(shell $(MAKE) OBJDIR="$(OBJDIR)" CFLAGS="$(CFLAGS)" CPPFLAGS="$(CPPFLAGS)" LDFLAGS="$(LDFLAGS)" \
>  -f feature/Makefile feature-$1 clean >/dev/null 2>/dev/null; echo $$?)
>  endef
> -- 
> 2.47.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

