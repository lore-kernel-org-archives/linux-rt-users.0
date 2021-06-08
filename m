Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B546C47082
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 20:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD702613AD
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 20:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhFHUeh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 16:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234000AbhFHUeh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 16:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623184363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T4fvOryA1y++8YC8yyNQhXMIpi/8STPDyVcHxPAWD8Q=;
        b=RCtFy44cYgB5ATm5ShPXvgUFagQVjvgpxQnxqUUZWe+eyJU6l+6NWgBqX7z9u99x/BDkF0
        +4S9wEmpKzQivqF3bEA4n6F8Vk2mmuWGb1qc1W3yHCBSPJjBg9SUrFM5860Yagw/r3Y7cT
        3NNHC3KDd4S6XRk+ifixlXfZ+FQXwQE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-w-8xfQzEM2uzbnz5w0nkaQ-1; Tue, 08 Jun 2021 16:32:42 -0400
X-MC-Unique: w-8xfQzEM2uzbnz5w0nkaQ-1
Received: by mail-lf1-f69.google.com with SMTP id k10-20020a05651239cab02902cf19c03142so8061769lfu.8
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Jun 2021 13:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4fvOryA1y++8YC8yyNQhXMIpi/8STPDyVcHxPAWD8Q=;
        b=mazekfgVnPUvjdht7ogqKWWhpreVQGYpQuk9ErxtL0ZkTJcX6iTfm7CFIBZdY3MoPd
         fw42VmRO6PPJKe8pR6Cbpwc3NcDqCGxiZfSOPmizDbpd7xHLC1y/AqUACHIBgpmd/yYK
         nELigUSOf+PR6zNPjQ+IiJuzF3z/2HiADmCTDR29STrH9Vbp9ZCnWsbIT+HbxMb9Wq85
         JpO85bLhW2fqx83zbBbQncPmQhd7I3AWXRA2iWykMFpIdPpustueK0QpjgSYvj6X66Bv
         B+X5LgWUw52TsoSoLNMY0S1DsHaLNP1Vf/dONNifb+S/WOTTyHPHCLrBPo/Ivq1oiBBy
         LbMA==
X-Gm-Message-State: AOAM530IRbCJTnsFgpgd1qG/RCzqLgpBP6F+/Des/Lo/gzNgV4nrdfbo
        tOtXg4vPS612mTEo/ao0gSw27lmhaBIRgVhMYjQgEHaYZA5iWgh6AAYaCP1o91JEQZQHmeff1jz
        upbUhTVdAWtN+A2LXlLEolKaP1pnfl8eG80EbYqI0iRc=
X-Received: by 2002:a05:6512:48d:: with SMTP id v13mr17233929lfq.284.1623184360723;
        Tue, 08 Jun 2021 13:32:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKcn39PD2w3y6es5EmEhqOBzT3DHLv+axbthpnhUimbWV+NgO7mrI1b3MZW2fLhP18SkomC196mfitv8VqWoQ=
X-Received: by 2002:a05:6512:48d:: with SMTP id v13mr17233923lfq.284.1623184360571;
 Tue, 08 Jun 2021 13:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <CALqGcGpVOTGK+WDwqvX=W9140p8xrdAWn01vB8zb_6=mATSjHw@mail.gmail.com>
 <YL842Rg3yRcTpW2r@lx-t490>
In-Reply-To: <YL842Rg3yRcTpW2r@lx-t490>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Tue, 8 Jun 2021 17:32:29 -0300
Message-ID: <CAD8J--9oKRQ2Fb9Q6Rtnfg21iU0NHYk-u8oVN-Rn=HqsEu93gQ@mail.gmail.com>
Subject: Re: Hung task in 4.9 using kvm 5.2
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Christoph Mathys <eraserix@gmail.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jun 8, 2021 at 6:31 AM Ahmed S. Darwish <a.darwish@linutronix.de> wrote:
>
> On Mon, Jun 07, 2021, Christoph Mathys wrote:
> >
> > When running kvm 5.2 on 4.9-rt (I've yet to verify if !RT is also
> > affected), kvm gets stuck regulary requiring a reboot. I get the
> > hung_task warning below.
> >
> > Any thoughts on how to avoid this problem?
> >
>
> Did you try running the same configuration with lockdep ON?

Along with Ahmed's suggestion, would you mind testing with v4.9.271-rt182?

Also, is there any extra step to reproduce this problem or simply
firing up a VM is enough
to trigger the problem?

Luis

