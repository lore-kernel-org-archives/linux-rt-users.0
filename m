Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFAEB64D7
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 21:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjF1VCa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 17:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjF1VC3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 17:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A40F19B0
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687986097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGRW/jDAjrqUtsa21EMb8cyw1twhb+MhYAyE6aa0QB4=;
        b=X36wgDcGTItanp7uz113oJzelIfw6Kq7WkK4gzyiJxdKq9Qv1gMlKbR2o2aMqx5/aM6rX3
        eI3PFJ8FmWjYy4gGY/BUTdyGpHVcPhd2vunqMpaeT16UKWg38JIBXqYqi95irjTjV2/oW5
        hULhX4aVtNgRpOkbXoQV2mjL9p2lsmg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-1G9Jp3zsNdii1vYZLTNfUQ-1; Wed, 28 Jun 2023 17:01:36 -0400
X-MC-Unique: 1G9Jp3zsNdii1vYZLTNfUQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-763e092c91aso16868185a.2
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 14:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687986093; x=1690578093;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGRW/jDAjrqUtsa21EMb8cyw1twhb+MhYAyE6aa0QB4=;
        b=Qa8SPAeiy3JHOUt7i8qwnaqyIiCY81J0w/nd/WWKDtQ1L4HKxJqYM0dRZoIcq37DlQ
         DbgvKHobske1cAJ1sRVa3qGqXKoA1vHYAWgZztrbXTpTbWABFoZKmZHBHysOa2/FHoU8
         x21NPTx38ga4nwsEVn6BXUhbwLG14qX4k1XYGNkMWY1lysdKVsiVzkLRsYoXErf4bkD8
         4+DlbAGETgwYhDeTL6c14hImFbdcy5jncnrSa8sopGBTHtLSY3HYzW7Hz3cIN2tZCYDJ
         SUOLIBqPrEnwTpKQbf2QmBwJ1tMIGzDT5y81pCbeYs5TXJO09M+xkAgXhSXpICtJLEtQ
         x23A==
X-Gm-Message-State: AC+VfDyw4T6Vh6Ic1VCHb4qi+EoKeyXf5/Y2qpVPPyJFKiNtGww/009N
        zaqOH2XTHnZhgLlDrYSUlnr12VKIt14AV/ESpYGfvbyPxaov/JZVgGLHX+27G77NJIdkm0MbUR7
        rx+dKZ7aqmnW8DSlGWsuiY4bj7x8=
X-Received: by 2002:a05:620a:2aec:b0:767:6a3:e6a4 with SMTP id bn44-20020a05620a2aec00b0076706a3e6a4mr6541243qkb.13.1687986093068;
        Wed, 28 Jun 2023 14:01:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nJ/Gn+znpZqdS2WHdcUASxsJTRQQVWRV6qgJSw/nAu1cEN9YshHIvCk0T7ccirmzO3hTvIg==
X-Received: by 2002:a05:620a:2aec:b0:767:6a3:e6a4 with SMTP id bn44-20020a05620a2aec00b0076706a3e6a4mr6541224qkb.13.1687986092750;
        Wed, 28 Jun 2023 14:01:32 -0700 (PDT)
Received: from fionn ([184.147.141.56])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b007578b6d060bsm5430425qkk.126.2023.06.28.14.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:01:32 -0700 (PDT)
Date:   Wed, 28 Jun 2023 17:01:23 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rteval: fixed comments
In-Reply-To: <20230628204441.640374-1-ashelat@redhat.com>
Message-ID: <ceb743bf-6045-8874-12d5-e5fcb8f04dd3@redhat.com>
References: <20230628204441.640374-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 28 Jun 2023, Anubhav Shelat wrote:

> rteval-cmd: fixed typo
> __init__.py, rtevalConfig: changed comments to use argparse instead of
> optparse
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval-cmd                 | 2 +-
>  rteval/modules/__init__.py | 4 ++--
>  rteval/rtevalConfig.py     | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index ae94bd98cc11..1f2ea08ef4ff 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -183,7 +183,7 @@ def parse_options(cfg, parser, cmdargs):
>              ind = cmdargs.index('--summarize')
>          cmd_args = cmdargs[ind+1:]
>          cmdargs = cmdargs[:ind+1]
> -    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -Z to cmd_opts
> +    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -H to cmd_opts
>      elif (sys.argv.count('-H')+sys.argv.count('--raw-histogram')) > 0:
>          try:
>              ind = cmdargs.index('-H')
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index 253e72abf8aa..794135d277b5 100644
> --- a/rteval/modules/__init__.py
> +++ b/rteval/modules/__init__.py
> @@ -292,7 +292,7 @@ the information provided by the module"""
>  
>  
>      def SetupModuleOptions(self, parser, config):
> -        """Sets up a separate optptarse OptionGroup per module with its supported parameters"""
> +        """Sets up a separate argparse ArgumentGroup per module with its supported parameters"""
>  
>          grparser = parser.add_argument_group("Group Options for %s modules" % self.__modtype)
>          grparser.add_argument('--%s-cpulist' % self.__modtype,
> @@ -451,7 +451,7 @@ class RtEvalModules:
>          return self.__modules.GetModulesList()
>  
>      def SetupModuleOptions(self, parser):
> -        "Sets up optparse based option groups for the loaded modules"
> +        "Sets up argparse based argument groups for the loaded modules"
>          return self.__modules.SetupModuleOptions(parser, self._cfg)
>  
>      def GetNamedModuleObject(self, modname):
> diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
> index ec14a13adcd9..d0115a052324 100644
> --- a/rteval/rtevalConfig.py
> +++ b/rteval/rtevalConfig.py
> @@ -291,7 +291,7 @@ class rtevalConfig:
>  
>          last_sect = None
>          for sk, v in sorted(vars(cmd_opts).items()):
> -            # optparse key template: {sectionname}___{key}
> +            # argparse key template: {sectionname}___{key}
>              k = sk.split('___')
>              if k[0] != last_sect:
>                  # If the section name changed, retrieve the section variables
> -- 
> 2.39.3
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

