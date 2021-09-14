Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3167C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D583360238
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 10:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhINKRa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230508AbhINKR2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 06:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631614569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tcOKdnSQZJ7HprykVXuqsm8r8hGvd6Lmp9+ILHGrCSk=;
        b=e5XFi4C548OqH7s5OG88Y/SDG3dHdh0ZVcVtgQaX1X8dMLIAuT7rUO/4lEAq3J0LJ9sBQE
        JtAUi42I97OoNpGtPronKG8nbaTOk7P5tKKf7ZFs18Qd7NQBBqs+iFMcj0eWSPcsszZSnl
        oKGaYCwnx38kxUu0pHiIazfvWm6ElD8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-jCG7-wXQOH6OeB19Q_14Rg-1; Tue, 14 Sep 2021 06:16:08 -0400
X-MC-Unique: jCG7-wXQOH6OeB19Q_14Rg-1
Received: by mail-wr1-f72.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso3746451wrn.19
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 03:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tcOKdnSQZJ7HprykVXuqsm8r8hGvd6Lmp9+ILHGrCSk=;
        b=qy7dfeeeIFocA8K1yksZouG0VjSrUG6QsOKoD4id8MHTfuncAHxJtfwDg3LBK/tr7P
         A4qS9sL4KDpTiQ3bfXGfGsl1ngjOFq3aGD2h4nM7c6VPASGTUuaOhG7Aj3ZO+uqgXCY7
         EGJiZDIyDvZdj8KUF0UrpuptS85NFWRH8YcpzXF/nJEllJNtJyPTzp0zyVCojUHCADSB
         nIiiStML3zpJI3cErcwyFrPswqC1ZPY7l9D534w6x59biZPlAtbttv+Wofu8SKoL/ujW
         h8b6rHjIS2S3o6wjdH2SSBsc+VvAZ2fGlfBXKtXbsIxpcarvbFgaUSS1ID2vIfoqyQjL
         fhwQ==
X-Gm-Message-State: AOAM533Nx8Y68iQe20/IZTegofMFxHR9EPquOZHApgQJmxfAOTKFCays
        MCpTS1evCl4Xg9X1ZuGJNXcvIl7aQ3C8FaKo7CCjeh4oYH0yOCEksYBjBiBJtWljCRW5qhKoP+C
        Xkk0NNqnp0TUZdMCSd+W4qOMSQAQ=
X-Received: by 2002:adf:e384:: with SMTP id e4mr17761734wrm.163.1631614566361;
        Tue, 14 Sep 2021 03:16:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkut5Zf+Sv3hHg7DrWDgc6+9yS/1cjkXXdsvpUOSjkg8L0BI+Ji6zhP8MoxIG/CaVgtAiNag==
X-Received: by 2002:adf:e384:: with SMTP id e4mr17761716wrm.163.1631614566110;
        Tue, 14 Sep 2021 03:16:06 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123? ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id u25sm784719wmm.5.2021.09.14.03.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 03:16:05 -0700 (PDT)
Message-ID: <fe15dafd9a6b6ee0d7f8a9f53e9acb6f4288046f.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] oslat: Add aarch64 support
From:   nsaenzju@redhat.com
To:     Punit Agrawal <punitagrawal@gmail.com>, jkacur@redhat.com,
        Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, peterx@redhat.com,
        williams@redhat.com, jkacur@redhat.com
Date:   Tue, 14 Sep 2021 12:16:05 +0200
In-Reply-To: <87ee9r9b5e.fsf@stealth>
References: <20210913083908.48408-1-nsaenzju@redhat.com>
         <20210913083908.48408-2-nsaenzju@redhat.com> <87ee9r9b5e.fsf@stealth>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2021-09-14 at 10:52 +0900, Punit Agrawal wrote:
> Hi Nicolas,
> 
> Apologies for the late comment. I just caught up with the thread.

No worries, thanks for the input!

[...]

> > +static inline void frc(uint64_t *pval)
> > +{
> > +	/*
> > +	 * This isb() is required to prevent that the counter value
> > +	 * is speculated.
> > +	 */
> > +	__asm__ __volatile__("isb" : : : "memory");
> > +	__asm__ __volatile__("mrs %0, cntvct_el0" : "=r" (*pval) :: "memory");
> > +
> 
> Although the isb() ensures completion of instructions before the counter
> is read, I think there is still the problem of speculative execution of
> instructions after the counter read being moved forward. See the
> examples in Arm ARM DDI 0487F.b Section D11.2.2 "The Virtual counter"
> 
> So from my understanding the problem would be something like below -
> 
> isb()
> ...  <-  speculatively executed instructions from after the counter read
> mrs %0, cntvct_el0
> 
> This would skew the counter value to a later point than what is intended
> - a following isb() would address the issue.

For the record, here's what the Arm ARM states:

  Accesses to memory appearing in program order after the read of the counter
  are executed before the counter has been read. [...]

  To ensure that a memory access only occurs after a read of the counter, the
  following sequence should be used:

    MRS Xn, CNTVCT_EL0
    ISB
    LDR Xa, [Xb] ; this load will be executed after the timer has been read"

As stated in the commit description, I made sure the program logic can't suffer
from this. I hadn't thought of the timing angle though. I doubt we'll see any
difference, given we have a 1us granularity, but I don't mind adding it for the
sake of correctness.

@John Should I send a v3 of the series or a separate patch adding the extra
isb().

-- 
Nicolás Sáenz

