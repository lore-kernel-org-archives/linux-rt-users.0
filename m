Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A56C433ED
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 May 2021 19:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58E8613FB
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 May 2021 19:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhEMT25 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 May 2021 15:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230415AbhEMT24 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 May 2021 15:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620934065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ic7Prg9ymNu674E5BB8qrp1ts2GJlFLlP/YJUkAGK/g=;
        b=Jg5bMb0Udn8cFbvBedfS5UeGf4sksCpclasRyIgZ4adCju2scV9RG3N7k9nF8G2uw6rrLt
        Mu+o+cnok0ziMorl75ONwvrk8gJUGg7Jnh0IqfUBRywmXVOr3YrmeRVtZC7XKtOtkP5FaI
        3eM/u1vqtZwkkmw4OWNLmF3TCO9FvQM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-UZFAAhivMk6QH4LiwcP66Q-1; Thu, 13 May 2021 15:27:43 -0400
X-MC-Unique: UZFAAhivMk6QH4LiwcP66Q-1
Received: by mail-wr1-f70.google.com with SMTP id l2-20020adf9f020000b029010d6bb7f1cbso11830797wrf.7
        for <linux-rt-users@vger.kernel.org>; Thu, 13 May 2021 12:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ic7Prg9ymNu674E5BB8qrp1ts2GJlFLlP/YJUkAGK/g=;
        b=TOjFFH8XMQFM2YG027NFPtbnqdz6Ts3lUsUasaAruTTaxAN5cBE4b+9PgBi6UWAro7
         EQuvIO00pUfrsnD3UBkhmIINq76j9WFohEv8GqD3683QWXcpjkNjOn3nkAZwlzPFSlvt
         XQAXeXfFjCcXkxJtp53+NygW/cHRCle8579lvd8/0p8s5WRJrqGomY1qiRwfQ5lX5kK/
         G97nBcuXBpzGuYg6pzBB+IFAOJrl/cwUKWrzsXKHU1lygTgyBQBrEg11AB4TMd/VXtxZ
         P1ZfaTtcZQTGVuunNU4Z1a3rL/NtJH4R4P9kxeDLG/+Tep1yQk2X5h6+af+kGY64aL79
         4JsA==
X-Gm-Message-State: AOAM5319fnngSTgoweTT9LbUJtKQF2Bm5dXLJE1p9C3/2JbMAk4FaNhn
        T8zNNGS0oAX5nJyZCoOvup1l8iv93Cy9B8WOsj74g5z0iN4ID5vrplTZ6OkwWT3ejcTnuNnDtFW
        q1VmPOFjTAIFy3AuGoktLOKbMGcKvvpocrV+ZAVRNedM=
X-Received: by 2002:a05:600c:3592:: with SMTP id p18mr26718384wmq.44.1620934062432;
        Thu, 13 May 2021 12:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybqskrHdDXAk/eEJEWq7B7UBu+qqh3manMfNdMdPgInzyAStnkJCeE1WkSb8Hdpi6NVIvVKh0aQqS3mmsGzqQ=
X-Received: by 2002:a05:600c:3592:: with SMTP id p18mr26718377wmq.44.1620934062273;
 Thu, 13 May 2021 12:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-28-dwagner@suse.de>
 <d979f62-e4bc-3f4d-b520-da3ca6e48199@redhat.com> <20210512073554.ocoaqweoibkeyxgx@beryllium.lan>
In-Reply-To: <20210512073554.ocoaqweoibkeyxgx@beryllium.lan>
From:   John Kacur <jkacur@redhat.com>
Date:   Thu, 13 May 2021 15:27:31 -0400
Message-ID: <CANwBOh0+vYu69ab_iuG_492a2JVzkCxn53bdrHQTfQvRTD7G2g@mail.gmail.com>
Subject: Re: [PATCH rt-tests v3 27/33] pip_stress: Return failure code if test fails
To:     Daniel Wagner <wagi@monom.org>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 12, 2021 at 3:36 AM Daniel Wagner <wagi@monom.org> wrote:
>
> > It isn't really an error if no priority inheritance occurs.
> > An error from this program would be something like mmap returning an error
> > code.
> >
> > I'm not sure this one is suitable for the json treatment, it's more of a
> > demonstration of how to use priority inheritance with processes instead of
> > threads. Thomas told me this was possible and I was curious to see if this
> > was true, so I scratched that itch. Not sure if it is useful as a test.
> >
> > Let's leave pip_stress alone for now please
>
> If it's a for demonstration purposes only, could we remove it from the
> source tree? I don't think it should be left there if it's not
> considered a proper test.
>

I suppose this is a fair question, although another question would be
is it useful in the rt-tests suites for other reasons?
It could be used as the "engine" of a test that would be similar to
pi_stress, with a different kind of mechanism.

So then the question would be, is there a value in another pi_stress
like test that avoids pthreads?
If so, I could work it up into a test.

John

