Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A755C4332F
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Dec 2022 19:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiLMTdF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Dec 2022 14:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbiLMTdD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Dec 2022 14:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E6248D6
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2022 11:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670959937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ej3QyEi80fQ6NU5bzAHkhcHs44QKJIBZoUMz5WH3f8=;
        b=Jc1vYBvWawNuJ2CpPFUd9g9zTn6UwvHmJFC/qpLqaZBMKMHkAfi0/QIo1X+cnQg+0U4nTF
        SvA+s3fDlXuJ6Ya6OsTYm1jgbmHHh9vUGBa4ojZ/30OF45penFIF9K8O07UaGC+a3+L2Aa
        0y7daSvH516D/QRpNve47m0hQr+vgYs=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-VlKDbr8EMO2qQ0zdDztbsA-1; Tue, 13 Dec 2022 14:32:16 -0500
X-MC-Unique: VlKDbr8EMO2qQ0zdDztbsA-1
Received: by mail-vk1-f198.google.com with SMTP id b127-20020a1f3485000000b003b8a69e5b11so1604837vka.22
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2022 11:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ej3QyEi80fQ6NU5bzAHkhcHs44QKJIBZoUMz5WH3f8=;
        b=MP4EN2cSTTkXlXPak7DxCcUQfGGWQA1Lvt8RSqSV/twORPK6QVasSIM53QnJz7HVVo
         Kkl3NDogs/7lbVDmXa64uXvSLt++Gi+2Gev5utwdfk+fa8MYFSucmr/BlediGAgVqK/3
         wiu9yuBMpChPBwKCuEr4uwib1heajZZrbx9FYZdRgJalFh7ayElF0GZw75MCnwihH1R9
         X+pbSwL8Vm+8jXl6GxQdsUXJFVx0U5Cvnf2E1AgpogbUIbWLxx5MyKxeEVb9l1nGleze
         SwSVA2bALsiJU9r3Hu7W5BgR9l7exauxgWlB9Qz3bR85tge/ZHV6cCeDA6mSY0SlRdnP
         bLmg==
X-Gm-Message-State: ANoB5pk2dpKS15lB2zUseyxUK7vK169osodPMnYnrE0ZazgwTWHa/RMJ
        xXkxRD4D/4rVT2/tTiwcYOTd9QFUmWgz41rxZFKM1H8UWQiRIQXnYRiHBUegAQykNWfb7zx+SQ1
        pQRGltuXb4tqCYgiDWkjhQGymjrI=
X-Received: by 2002:a05:6102:2144:b0:3b0:6b56:cbe5 with SMTP id h4-20020a056102214400b003b06b56cbe5mr10955106vsg.34.1670959935800;
        Tue, 13 Dec 2022 11:32:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4maf/lf7WIC4zR7pl3xLwhaS+9DnGxgZeomIpRjtnsCMZomrMY64ZbKol5Xe1rbnLM4SDm6w==
X-Received: by 2002:a05:6102:2144:b0:3b0:6b56:cbe5 with SMTP id h4-20020a056102214400b003b06b56cbe5mr10955087vsg.34.1670959935440;
        Tue, 13 Dec 2022 11:32:15 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id y18-20020a37f612000000b006fa2cc1b0fbsm8318847qkj.11.2022.12.13.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:32:14 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:31:58 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Crystal Wood <swood@redhat.com>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] oslat: Add command line option for bucket width
In-Reply-To: <e1402a544c74b508b6d2b4cc644fce5909ccd863.camel@redhat.com>
Message-ID: <71d7762e-720-fa73-96de-2e922b371e@redhat.com>
References: <20221209052254.2609767-1-swood@redhat.com> <1624dd34-d12c-38dc-aed1-a34366ceafba@redhat.com> <e1402a544c74b508b6d2b4cc644fce5909ccd863.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463754494-1569556957-1670959934=:19128"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463754494-1569556957-1670959934=:19128
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 9 Dec 2022, Crystal Wood wrote:

> On Fri, 2022-12-09 at 20:03 -0500, John Kacur wrote:
> > 
> > 
> > On Thu, 8 Dec 2022, Crystal Wood wrote:
> > 
> > 
> > >  
> > > @@ -677,6 +699,20 @@ static void parse_options(int argc, char *argv[])
> > >                                 exit(1);
> > >                         }
> > >                         break;
> > > +               case OPT_BUCKETWIDTH:
> > > +               case 'W':
> > > +                       g.bucket_width = strtol(optarg, NULL, 10);
> > > +                       if (g.bucket_size <= 0) {
> > 
> > I think this should be g.bucket_width
> 
> Oops
> 
> > 
> > A quick first look through and run, see the one comment above
> > near "case 'W'"
> > 
> > and then
> > 
> > checkpatch reports some minor easily fixed problems
> > 
> > ../linux/scripts/checkpatch.pl oslat.patch 
> > ERROR: code indent should use tabs where possible
> > #100: FILE: src/oslat/oslat.c:342:
> > +^I^I          g.precision, us);$
> > 
> > ERROR: code indent should use tabs where possible
> > #102: FILE: src/oslat/oslat.c:344:
> > +^I^I         g.precision, us);$
> 
> I was matching the existing style in the file that tended to use spaces for
> alignment.

Hmmn, when I run checkpatch on the file I don't get any other warnings 
about spaces, or when I look in vim I see tabs, maybe check your editor?
Please fix the above when you submit a version two

> 
> > ERROR: spaces required around that '=' (ctx:VxV)
> > #227: FILE: src/oslat/oslat.c:654:
> > +       OPT_BUCKETSIZE=1, OPT_BUCKETWIDTH, OPT_CPU_LIST, 
> > OPT_CPU_MAIN_THREAD,
> >                       ^
> 
> I only added OPT_BUCKETWIDTH to the list; I didn't touch the =1 part.

Yup, you're right, we're not as strict about the formatting in rt-tests as
the kernel is, and sure it will catch stuff that isn't strictly your fault 
but I do normally run checkpatch on the patches. If you want to throw in 
the spaces around the '=' in your patch I'd appreciate it.

Now to the more important stuff, I like your patch, but I have a few 
questions.

What if the user specifies a bucket-width greater than 1000?
Is it meaningful to to have a bucket-width of 2000 for example?

If we have a bucket width of 1500, then we are going to have 
the same precision as if we specified 500?

By the way I am not aware of any tools that are consuming
json output, and if there are, I'm sure they can adapt to
any changes such as decimal, so I wouldn't worry about that.

John

---1463754494-1569556957-1670959934=:19128--

