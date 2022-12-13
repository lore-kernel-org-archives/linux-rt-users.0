Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73373C4167B
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Dec 2022 20:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiLMUr3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Dec 2022 15:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbiLMUrZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Dec 2022 15:47:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524FD1DA53
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2022 12:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670964397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xRSXPwitTA1xILQKQgeascfjFaPjiq28Spx4Jg/JbF8=;
        b=TN+1ZNPG7RsNFIuuTRWD4PA4kH96VLGOSuaaty3C6PCmliKsDoJnJzi66wPxmlqPA4NvZ1
        t6dhdCEbiWw1XkFJhTnqj3pI0a7of4HlR5u9vsmWQwNYYW8avGp7VqbPWMcMNbpiWwHWg6
        GFrQPmEnBrTWVLeoJm0Gvz4OxDoDmkk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-Rwprk13IMeqcyG4bjR8mTA-1; Tue, 13 Dec 2022 15:46:36 -0500
X-MC-Unique: Rwprk13IMeqcyG4bjR8mTA-1
Received: by mail-qt1-f199.google.com with SMTP id fz10-20020a05622a5a8a00b003a4f466998cso742664qtb.16
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2022 12:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRSXPwitTA1xILQKQgeascfjFaPjiq28Spx4Jg/JbF8=;
        b=xhEdcNlI/CYO0rh+5QECCcYry2zdZDTHA9BwpZLj0dawvY6SYluW5ca9BePDNm2uMM
         FSf7GOlz+8xj279Dfmf9I2Sux1IbjVRUaC2MKwOZFvrYrCPXuR6VCC0EDzkn4TbRpW30
         3BIIDG2fn0gYOYuj6eo9GjCCovvfXfqEA5EN8de01+OMD4olzmqIb+Cjk7LUwXLawGKW
         huIUXeur/mhbL+W9eF9Tj578ukN4qH5xCpQSsjQ9LxOrZ3PdTaDvtDq1kG/YYvDkCBqW
         c5rGvzQ8Jw3ICJCVw/figCn6zp83xcL4pcjBERqiowEAmoBFeMuiMZsCgm9V2h5eGRRa
         +3Qw==
X-Gm-Message-State: ANoB5pkT5oVPw7DR0Qf/r//2cnLkguRIE0mivojW6GpSx0EoyKN3kxA1
        Q40s6FQbP/Co9WtKjKf4PcurhGRKVTfMnv0ZBs/e54kWZuiGAp8e0YnW1FTF+FsfmKVwTV/99xO
        aPhbRT+Ry69M8/qorIYzaTameqnU=
X-Received: by 2002:a05:622a:2287:b0:39c:da21:6c11 with SMTP id ay7-20020a05622a228700b0039cda216c11mr30598976qtb.19.1670964395507;
        Tue, 13 Dec 2022 12:46:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4mTV++irOuOpWgFrA214wSBlwrdSR4kxI77q7EKuj9wrBtWOvxWEU8J7dr82Za8t/H4zu5dw==
X-Received: by 2002:a05:622a:2287:b0:39c:da21:6c11 with SMTP id ay7-20020a05622a228700b0039cda216c11mr30598955qtb.19.1670964395214;
        Tue, 13 Dec 2022 12:46:35 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id s19-20020ac85293000000b003a5c6ad428asm440178qtn.92.2022.12.13.12.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:46:34 -0800 (PST)
Date:   Tue, 13 Dec 2022 15:46:27 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Crystal Wood <swood@redhat.com>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] oslat: Add command line option for bucket width
In-Reply-To: <b65defab-53af-bc4-8681-f3f982ed6c18@redhat.com>
Message-ID: <5222e9cd-6a86-13df-1ea-3b36cf3d824d@redhat.com>
References: <20221209052254.2609767-1-swood@redhat.com> <1624dd34-d12c-38dc-aed1-a34366ceafba@redhat.com> <e1402a544c74b508b6d2b4cc644fce5909ccd863.camel@redhat.com> <b65defab-53af-bc4-8681-f3f982ed6c18@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463754494-1080320217-1670964394=:22494"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463754494-1080320217-1670964394=:22494
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 13 Dec 2022, John Kacur wrote:

> 
> 
> On Fri, 9 Dec 2022, Crystal Wood wrote:
> 
> > On Fri, 2022-12-09 at 20:03 -0500, John Kacur wrote:
> > > 
> > > 
> > > On Thu, 8 Dec 2022, Crystal Wood wrote:
> > > 
> > > 
> > > >  
> > > > @@ -677,6 +699,20 @@ static void parse_options(int argc, char *argv[])
> > > >                                 exit(1);
> > > >                         }
> > > >                         break;
> > > > +               case OPT_BUCKETWIDTH:
> > > > +               case 'W':
> > > > +                       g.bucket_width = strtol(optarg, NULL, 10);
> > > > +                       if (g.bucket_size <= 0) {
> > > 
> > > I think this should be g.bucket_width
> > 
> > Oops
> > 
> > > 
> > > A quick first look through and run, see the one comment above
> > > near "case 'W'"
> > > 
> > > and then
> > > 
> > > checkpatch reports some minor easily fixed problems
> > > 
> > > ../linux/scripts/checkpatch.pl oslat.patch 
> > > ERROR: code indent should use tabs where possible
> > > #100: FILE: src/oslat/oslat.c:342:
> > > +^I^I          g.precision, us);$
> > > 
> > > ERROR: code indent should use tabs where possible
> > > #102: FILE: src/oslat/oslat.c:344:
> > > +^I^I         g.precision, us);$
> > 
> > I was matching the existing style in the file that tended to use spaces for
> > alignment.
> > 
> > > ERROR: spaces required around that '=' (ctx:VxV)
> > > #227: FILE: src/oslat/oslat.c:654:
> > > +       OPT_BUCKETSIZE=1, OPT_BUCKETWIDTH, OPT_CPU_LIST, 
> > > OPT_CPU_MAIN_THREAD,
> > >                       ^
> > 
> > I only added OPT_BUCKETWIDTH to the list; I didn't touch the =1 part.
> > 
> > -Scott
> > 
> > 
> 
> One more thing that we just saw, if you run oslat without any options, 
> just the defaults you get 32 buckets with the highest one being 32us
> 
> But if you run
> oslat -W 500
> 
> You still get 32 buckets but since the width is half, then largest bucket
> is 32us

I mean 16us of course

> 
> This increases the resolution of the buckets, but it puts all the overflow
> in the 16us buckets, wondering if we should double the number of buckets
> so that the largest one is still 32us ?
> 
> I realize you could do
> oslat -b 64  -W 500
> to achieve that, but perhaps the default is not good like this.
> 
> John
---1463754494-1080320217-1670964394=:22494--

