Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF344C4332F
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Dec 2022 20:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiLMUmO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Dec 2022 15:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiLMUmM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Dec 2022 15:42:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7EE15806
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2022 12:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670964078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k025dvRG34YxjVnT15v2HrXvLRPLROYwkFxsDaNTNeA=;
        b=fBgy9cwv78psrgwvB3MmSdN9sI7z0d3tCcfT2AYgtrvusREiereX5CmNtZ0CCdFvRhJKH+
        olbiDAS7sA6JavDHa6N+Iuml9qQtrpcCS1LYV8efUdel4cnW+xk4pVpvdrOk1nHxhBWr8O
        KiDqCkY+1Kq5VmJh66kGK1TU/Ms6A8Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-ZvDxu5yuP6iKEe99fwiqoA-1; Tue, 13 Dec 2022 15:41:17 -0500
X-MC-Unique: ZvDxu5yuP6iKEe99fwiqoA-1
Received: by mail-qv1-f69.google.com with SMTP id ks19-20020a056214311300b004df5465b26eso6765214qvb.17
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2022 12:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k025dvRG34YxjVnT15v2HrXvLRPLROYwkFxsDaNTNeA=;
        b=079ds6EykpQHrEzc68R8drfEU70MWYroZo4oD7BjeUru0MJdHSZPSSP9oP8bizrjk2
         bdpWA5uXhEBxi+T7ie4IjsLn3iCnNVoARHvWWYUoJYXApGveWpmy6sIY9WkI9PrAnF2G
         GIDify7pN0CMM+vWCnw7mihd/kC4mHRgg1lXrukxYgcq76PubTUDK5HWmqevQfE2LNXK
         XiPpXghSPd+n0AyxiyNT4frvZnPSk5xvjHfiVuvudOfQsnNK+nImTG6fTOcQUpoQN27X
         hdk89wzjmTtDb1nHX67uCX8y1J/fOPYdOdDPVWKm6/99KZ7GVtuPTpQHCuX+R+tDEByG
         TKRw==
X-Gm-Message-State: ANoB5pkODYiajPkFibFYmzobqczl+eij6dH7i0H6Xo2KqkxEPRqqSqL/
        oHFW6AR+Zerv5m9oItJGJ46ZhVg1KzS/SSmEb69Yyfimw9Vn4mikpN0J31yObSUT+/3DbJtc498
        4fOHZv57dgDvoYy5egzgMcuEjKR8=
X-Received: by 2002:a05:622a:1b06:b0:3a7:648d:23d8 with SMTP id bb6-20020a05622a1b0600b003a7648d23d8mr6465994qtb.5.1670964076696;
        Tue, 13 Dec 2022 12:41:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6cxveP5NUO9XUeKSt+ErGA3Y26s7smp02rT8Z4v+GzNimdwr+moH+h+tuvkrGOf5k0ltcljg==
X-Received: by 2002:a05:622a:1b06:b0:3a7:648d:23d8 with SMTP id bb6-20020a05622a1b0600b003a7648d23d8mr6465977qtb.5.1670964076487;
        Tue, 13 Dec 2022 12:41:16 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id q40-20020a05620a2a6800b006f8665f483fsm8635744qkp.85.2022.12.13.12.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:41:16 -0800 (PST)
Date:   Tue, 13 Dec 2022 15:41:14 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Crystal Wood <swood@redhat.com>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] oslat: Add command line option for bucket width
In-Reply-To: <e1402a544c74b508b6d2b4cc644fce5909ccd863.camel@redhat.com>
Message-ID: <b65defab-53af-bc4-8681-f3f982ed6c18@redhat.com>
References: <20221209052254.2609767-1-swood@redhat.com> <1624dd34-d12c-38dc-aed1-a34366ceafba@redhat.com> <e1402a544c74b508b6d2b4cc644fce5909ccd863.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463754494-949304222-1670964075=:19128"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463754494-949304222-1670964075=:19128
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
> 
> > ERROR: spaces required around that '=' (ctx:VxV)
> > #227: FILE: src/oslat/oslat.c:654:
> > +       OPT_BUCKETSIZE=1, OPT_BUCKETWIDTH, OPT_CPU_LIST, 
> > OPT_CPU_MAIN_THREAD,
> >                       ^
> 
> I only added OPT_BUCKETWIDTH to the list; I didn't touch the =1 part.
> 
> -Scott
> 
> 

One more thing that we just saw, if you run oslat without any options, 
just the defaults you get 32 buckets with the highest one being 32us

But if you run
oslat -W 500

You still get 32 buckets but since the width is half, then largest bucket
is 32us

This increases the resolution of the buckets, but it puts all the overflow
in the 16us buckets, wondering if we should double the number of buckets
so that the largest one is still 32us ?

I realize you could do
oslat -b 64  -W 500
to achieve that, but perhaps the default is not good like this.

John
---1463754494-949304222-1670964075=:19128--

