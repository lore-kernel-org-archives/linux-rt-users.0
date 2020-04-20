Return-Path: <SRS0=MBx+=6E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A440C3A5A0
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 16:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B6D20775
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 16:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPIoyt59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgDTQFI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729550AbgDTQFH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Apr 2020 12:05:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E0C061A0C
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2020 09:05:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l78so11159668qke.7
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2020 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ac/OmTrh1a34ERrjOZc/EaYOVee3vRNRbcLPeEDdKRU=;
        b=UPIoyt59eioWP4b69hRn/9BfJ/J8sonJ4aehg6UZJp0GYb4J+ifWgGPbJdpoFLtRPz
         s6MlQVSJY28SpccEuOWvn7SmLGANGoIxicXSV9Ul8JrC8/KuoDI1fGUG7M7ixuJ4cxWB
         hLM5zGKDn980mmdYwSIjK5gYEB1ueAQdJsF0siVpdxigpNPzeH35qIn0B0SmRKcLVQyx
         +gkzYLuUPPWCw8bCY2nPJdrRzDccZe+fEWOFHlGZhQVDMtkn+bEWayQPrwHBBD4cOUg1
         rhfnZQzZoB9Cm/XWa9ZDHYLhRXL6gObb0HVoX+hdBj7jH2eCD0oEOgirfHzUzRpuoKGn
         JCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=Ac/OmTrh1a34ERrjOZc/EaYOVee3vRNRbcLPeEDdKRU=;
        b=GGYVxJHCVyvNSrP5mDHpy1lqa3PO3CHUbfOaXbtgnA+KPbVynEz0ELYCWW2r+M1Z1P
         hyV8ZJ/8Junxb5c08Baap9eHI9xFLjgzvbEKn/3ON/lc0udj8BZcIz2DALyicnlhBEex
         RfFVXUAokGf/ld1zr1sW2WluEwIGuQA2HhD6qZBFZl/CKX/+pri/xU1WoZhBCuZyN6P1
         4q4XQmy/hhP30ThkhJV5MA3hRC8axLw8lMb86A5MYjW9KGoznAp6OjSLZTchrrl2Simg
         A1bb6f9BwRmlNJ6+ztove9d0lVowJ55XrKfrqfg5fIZ/IME53elZkSOwqdgIHTHhOyWo
         V9MQ==
X-Gm-Message-State: AGi0Pubn/e8XSZl7wjddPfSWpGjmy/pLghDRAaVEhYTt+ZaturLczVVD
        GfDAprE9o5b4xyhsTKXc+ls=
X-Google-Smtp-Source: APiQypLo99/pPX+0KwIWezDwWAt+VJs6yQCxMwqa/KY61wWGK6sEqlgoy2Jqvn1Bs34biDwVHarUnQ==
X-Received: by 2002:a05:620a:118b:: with SMTP id b11mr17359513qkk.82.1587398706628;
        Mon, 20 Apr 2020 09:05:06 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id v5sm812398qka.106.2020.04.20.09.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:05:05 -0700 (PDT)
Date:   Mon, 20 Apr 2020 12:04:58 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     trix@redhat.com, williams@redhat.com, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] Import a new test, jitterz
In-Reply-To: <20200420134937.fxyjibufftdt6btr@linutronix.de>
Message-ID: <alpine.LFD.2.21.2004201204210.4545@planxty>
References: <20200418141449.19293-1-trix@redhat.com> <20200420134937.fxyjibufftdt6btr@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463806718-757002363-1587398705=:4545"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806718-757002363-1587398705=:4545
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 20 Apr 2020, Sebastian Andrzej Siewior wrote:

> On 2020-04-18 07:14:49 [-0700], trix@redhat.com wrote:
> > --- /dev/null
> > +++ b/src/jitterz/jitterz.c
> > @@ -0,0 +1,400 @@
> …
> > +/*
> > + * jitterz
> > + *
> > + * Copyright 2019-2020 Tom Rix <trix@redhat.com>
> > + *
> > + */
> > +
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> 
> in general there is no need of that ifndef and this should be taken care
> by the build system (and refuse the build if _GNU_SOURCE makes no
> difference/ is not available). And then include the config.h (or so)
> first header file. 
> In rt-tests, the Makefile already adds this define to the CFLAGS.
> 
> …
> > +/* Returns clock ticks */
> > +static inline uint64_t time_stamp_counter(void)
> > +{
> > +	uint64_t ret = -1;
> > +#if defined(__i386__) || defined(__x86_64__)
> > +	uint32_t l, h;
> > +
> > +	__asm__ __volatile__("lfence");
> > +	__asm__ __volatile__("rdtsc" : "=a"(l), "=d"(h));
> > +	ret = ((uint64_t)h << 32) | l;
> > +#else
> > +	fprintf(stderr,
> > +		"Add a time_stamp_counter function for your arch here %s:%d\n",
> > +		__FILE__, __LINE__);
> > +	exit(1);
> > +#endif
> > +	return ret;
> > +}
> 
> I remember I complained about this in `queuelat' and it ended nowhere
> once it got merged.
> To repeat my question: Is there a reason not to use clock_gettime()?
> With VDSO there should be hardly any difference between this and
> clock_gettime().

I would agree with Sebastian there Tom, also easier to maintain.

Thanks

John
---1463806718-757002363-1587398705=:4545--
