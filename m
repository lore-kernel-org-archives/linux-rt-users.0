Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A105BEB64D7
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jun 2023 21:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFUVoT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjFUVoR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jun 2023 17:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6926D9B
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Jun 2023 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687383809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bGJrcPzXNVan5rpYRe6/YLh58BqL+fgD2pjKomm8M+4=;
        b=CWi65Hj779Qh6/uDn6FF02Ih5BgBL4EZJRLCJa3QaZqpn6qP39/72NYjJCPG0JPO7gmqiQ
        oKg3Tg1R3FahjQp5nDaRgWHJGWsQ0Ca9drQzfIg6WTGYtzf3wAKexOBqRebVeA6egAX9Rc
        yIcyQRR0rgVr0Db8tRM2qDXxKY6uX1E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-zrjOAl0iOvO9Mvj1nqeM9Q-1; Wed, 21 Jun 2023 17:43:27 -0400
X-MC-Unique: zrjOAl0iOvO9Mvj1nqeM9Q-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62ff97aec4bso48737146d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Jun 2023 14:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383807; x=1689975807;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGJrcPzXNVan5rpYRe6/YLh58BqL+fgD2pjKomm8M+4=;
        b=ayteNkMlu8aTSsR60EjaHFUJflJDDrvcAcYf/sr5PjfkdnvpqVZS99asweIYiCoQUy
         iN36bL+NzfbJJFNjzS57shKiyzD2B7McInbOQn42s5LLHxUm40uunfzQQkfmjDfIbnza
         1G7n54ecgo2VCjcy9o4y9wD/9J4ITiyuYLGcOQh8ww/nOAF1bTv8LVK+w8wr7Au4wn4M
         pQPXtabedV6J3/mRd0xh9VjCg2xK0cZhTawMLnm6l5j5QHuOXCc24forE7BMFNsNiHLa
         2L1dxSa7hXtm1uly3dGEI4dBNtN6JICxGUIhwtqS7Viavk8nTAGOEeUBff12HJMc8xTn
         lhmA==
X-Gm-Message-State: AC+VfDxs7ZIZfrWhsIrhOjkengV0TXfgTWBEXvefx4DqYeQ3EDp1ncQs
        L5uLJzq1b2VGtDd74ztdIje9k28RCHNjfXoHKQ08zCCtk+pbh69dIisdw0tAdjj0XC4VnsdBwhV
        vPmnLKtNeG5m2WNuKX0TmT3hj0JBpAE+Mh+8=
X-Received: by 2002:a05:6214:2a8f:b0:630:14e0:982e with SMTP id jr15-20020a0562142a8f00b0063014e0982emr12932519qvb.22.1687383807094;
        Wed, 21 Jun 2023 14:43:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4cRwYDv1FHvkv89fDuT+wLRzC2EAh06K2GdCl1d62Yxl/ytmFmnlJsIsCwfoFIklG7wsiVJQ==
X-Received: by 2002:a05:6214:2a8f:b0:630:14e0:982e with SMTP id jr15-20020a0562142a8f00b0063014e0982emr12932509qvb.22.1687383806836;
        Wed, 21 Jun 2023 14:43:26 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id g13-20020a0ce4cd000000b00631f40503cbsm2997471qvm.12.2023.06.21.14.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:43:26 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:43:25 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval-cmd: If no kernel version is provided to
 -S/--source-download, download default kernel version
In-Reply-To: <20230613180828.1235964-1-ashelat@redhat.com>
Message-ID: <e0a0e5c1-2055-ecb8-dbe5-68f043b884a3@redhat.com>
References: <20230613180828.1235964-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 13 Jun 2023, Anubhav Shelat wrote:

> Previously, the usuage was "./rteval-cmd -S [KERNEL_VERSION]", and
> rteval-cmd would throw an error if no kernel version was provided.
> Now, rteval-cmd will download the default kernel version, as specified
> in rteval/modules/loads/kcompile.py.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval-cmd | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index cf9326e7dfdd..cbba9cd2e451 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -168,11 +168,13 @@ def parse_options(cfg, parser, cmdargs):
>                        help='print rteval version and exit')
>      # if the -S/--source-download option doesn't include the version, set version to default
>      ind = None
> -    if sys.argv.count("-S") > 0: ind = sys.argv.index("-S")
> -    elif sys.argv.count("--source-download") > 0: ind = sys.argv.index("--source-download")
> +    if sys.argv.count("-S") > 0:
> +        ind = sys.argv.index("-S")
> +    elif sys.argv.count("--source-download") > 0:
> +        ind = sys.argv.index("--source-download")
>      if ind != None:
> -        if ind+1 == len(sys.argv): 
> -            sys.argv.insert(ind+1, ModuleParameters()["source"]["default"].strip(".tar.xz"))
> +        if ind+1 == len(sys.argv):
> +            sys.argv.insert(ind+1, ModuleParameters()["source"]["default"].replace(".tar.xz", ""))
>          cmdargs.append(sys.argv[ind+1])
>  
>      parser.add_option("-S", "--source-download", dest="rteval___srcdownload",
> -- 
> 2.31.1
> 
> 

This patch works and does something that I would like to have.
However the point of parsers like optparse and argparse are to hide 
sys.argv kind of details. I am wondering if there is something you can do 
with nargs in order to make this work in a cleaner fashion.

I know you are working on converting deprecated optparse to argparse,
so I would suggest that instead of fixing this here, finish your argparse 
work, and then try to reimplement this on top of that once it is accepted 
upstream.

Thanks

John

