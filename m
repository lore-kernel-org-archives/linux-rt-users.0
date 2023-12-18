Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92B7348F
	for <linux-rt-users@vger.kernel.org>; Mon, 18 Dec 2023 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2oUGOkp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702933892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BK0+yq7hxXSLtzrMPMDgWH3eRnw6XMRoUKqgORG+LAI=;
	b=N2oUGOkpynROP+xT4Ir1S0rUPQzsJUkxw0bNYFapM3LS7yJ0PDNWg3wJlmmuO7/Vv5eh1R
	2YIbOba0PsttucozWVi/Kw4ZyvQJ3Sbt5pRfuRMqoIsS3lnGVPeXRqBLA7C59A0r5M6uj6
	6qdbB574Lfhd7ycE2RgULYFtWgUKLzQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-KvxXWwlCPtG11Jki1iBwlA-1; Mon, 18 Dec 2023 16:11:30 -0500
X-MC-Unique: KvxXWwlCPtG11Jki1iBwlA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67ef53b1f17so64286426d6.3
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Dec 2023 13:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702933890; x=1703538690;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BK0+yq7hxXSLtzrMPMDgWH3eRnw6XMRoUKqgORG+LAI=;
        b=wFaeqXoSEzFxUlba5GQSNp7jGurdE4nhpVre5qm3aqcSVTGabr4HLL+cVEVm4wjFrv
         m1ZUw2gEu0meaPCO3oymNj9D5p0bWHDC8QPQfc0//tj9rp3wH0zKRMQmFHS/n7FjpEmi
         k37+Gs231ZGPQYyNd0rtb6PU91OClhmbsYKXD40lSnR1epwduSm1e8prNQiZEW7JxZlD
         V+o98YygdAcJcqKA6JG6Sy2u9zrKkuk6SsccwCV7ODK9ItERw4IT+8jLXEzvE6t0A9PF
         tiodmYsv0oGiIsVJKys3wgpKI6Bqudngag89y1ENIGmQpWssqKUuftuO5cpRUW8+tBhu
         O7Zg==
X-Gm-Message-State: AOJu0YwaDaRcx8+X9X+Itb8uoTN6q/zzJmW+KKIOApCunxqp0CHswUrR
	3NFgq+cJamdTuAijxGVbBpMYCsvWOLtN6z4sI6tIRwORKopgr0umJvwBMVPeJMLsc2t2PPneOnW
	7KFQ9xXTyaQqErD+Jcw53rdSbPlY=
X-Received: by 2002:a05:6214:483:b0:67f:52d0:d889 with SMTP id pt3-20020a056214048300b0067f52d0d889mr1201092qvb.37.1702933890384;
        Mon, 18 Dec 2023 13:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXGQCgqJeCPzQJj6pFEfAHwT6/22Fe5nzCkM/wrO2NvpNFGBNDgi3iVgh5rbkLe6l1xnNLRA==
X-Received: by 2002:a05:6214:483:b0:67f:52d0:d889 with SMTP id pt3-20020a056214048300b0067f52d0d889mr1201083qvb.37.1702933890159;
        Mon, 18 Dec 2023 13:11:30 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id a13-20020a05620a124d00b0077f084f4cbbsm8573129qkl.20.2023.12.18.13.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:11:29 -0800 (PST)
Date: Mon, 18 Dec 2023 16:11:20 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/4] rt-tests: Fix warnings
In-Reply-To: <767629d0eec7fa2203d4e6502da9a0d52ae993a2.camel@redhat.com>
Message-ID: <a1744cf8-9fba-9989-71d3-f726f8fadde8@redhat.com>
References: <20231206205508.17148-1-crwood@redhat.com> <20231206205508.17148-2-crwood@redhat.com> <0b4a2f01-2978-9409-7f2b-fa8ed9c18a9e@redhat.com> <767629d0eec7fa2203d4e6502da9a0d52ae993a2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 18 Dec 2023, Crystal Wood wrote:

> On Thu, 2023-12-14 at 10:48 -0500, John Kacur wrote:
> > 
> > I tested this with rteval, and it works fine
> > checkpatch in the linux kernel flags a few minor things.
> > Would you mind fixing those up before I apply the patch?
> > 
> > WARNING: Improper SPDX comment style for 'src/include/histogram.h', please
> > use '/*' instead
> > #227: FILE: src/include/histogram.h:1:
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > 
> > (Yes, I know there are other files in rt-tests that also aren't using
> > the recommended commenting style, you probably copied from there.)
> 
> This confused me for quite a bit, until I saw in
> Documentation/process/license-rules.rst that *sources* get // but *headers*
> get /*.  The rationale seems to be based on the behavior of old toolchains
> when processing assembly code, linker scripts, etc.  Doesn't seem terribly
> relevant to non-kernel projects...
> 
> I can still "fix" it if you want.
> 
> 
> > 
> > ERROR: trailing whitespace
> > #338: FILE: src/lib/histogram.c:64:
> > +^I^I$
> 
> One of these days I need to teach the joe editor not to do this...
> 
> -Crystal
> 
> 
> 
No, your explanation works for me! Just fix the warnings about
the brace styles and I'll apply it.

John

