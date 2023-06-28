Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14868EB64D7
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 20:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjF1UmP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjF1Ulp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 16:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A853C2117
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 13:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687984761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vtC78EDYi//8FhW3S8nytRTVOgKtJsUQAtEvNN4m3Mk=;
        b=bNqG0vGUH9qqqUo5/M9eAzJC80hT9oxz6vWFetF03jthI3Ldn7JtFxiSdrG6wp9+rpsdbE
        wShVO+QLHtbiDx27NojF+heccKxGSen2dHXohuu+8Z4Sc/uH8+brIP69YuUrx+Xf0q3OSx
        s3CQpYkIZeQYgSmmCthRxo+yeNlyW3M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-02gbIeFoNl-7wMS23Czk3w-1; Wed, 28 Jun 2023 16:39:19 -0400
X-MC-Unique: 02gbIeFoNl-7wMS23Czk3w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7656cf70228so12975785a.2
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 13:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984758; x=1690576758;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtC78EDYi//8FhW3S8nytRTVOgKtJsUQAtEvNN4m3Mk=;
        b=DO7OTfxBzHKiRySLOArBnBJQi67g8qo7/cFDract5Agn41l38F5JujIm5tD4WpCoUr
         tl4O1fmmcDHgGqM3PlojNQ7loUDwBb2+nZAS/1Egm9mtCc7aLhCCr2HzUqM3urJ/Xl9S
         4ly92xJzflYFL4IXfpERynpFcHOcmrMO5X4U74KHFeFVVUQQgZw5sHDvy6tYJENY7In2
         uXQ/WdCg+Eb96AcGjFxYAhO+epT1+n6O3Fm98PseNh5+vjdJK/mkNuTv/ez69O/Wd+Mm
         w8z0H7Eb6OWUtVT+2Xtjh1m7aM37TcFUcerkMt/8YZYt06BeCfKZyY9IOm6Wzp0ybD2s
         iQ7w==
X-Gm-Message-State: AC+VfDwbD5UqEcCQNaiW6CbTQ8L9gTT69dCVXo2w+33lH5LcwcA4y6Y9
        NQUZzCmqdgGNQO+aTfdbBksasCITsdq0jNGoF8FoM00GMoteOTGvt6iwUp2g4hfQOqM8+kr7Rnz
        jfyirTVRcsAQ9F3BecIWVC32lUF6huR1akgM=
X-Received: by 2002:a05:620a:4496:b0:765:4873:3a88 with SMTP id x22-20020a05620a449600b0076548733a88mr24324450qkp.23.1687984758611;
        Wed, 28 Jun 2023 13:39:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4n6eX4p4ZLFeDrPUocgBpTeE1YLnNk0Ot4mGMXuQtFuZSlXT7e5TkOhY1PB/Qy4mFjfI07sA==
X-Received: by 2002:a05:620a:4496:b0:765:4873:3a88 with SMTP id x22-20020a05620a449600b0076548733a88mr24324438qkp.23.1687984758364;
        Wed, 28 Jun 2023 13:39:18 -0700 (PDT)
Received: from fionn ([184.147.141.56])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a16c400b007653fbbd5ccsm5444202qkn.14.2023.06.28.13.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:39:18 -0700 (PDT)
Date:   Wed, 28 Jun 2023 16:39:08 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/3] rteval: fixed comments
In-Reply-To: <20230628195145.636652-3-ashelat@redhat.com>
Message-ID: <3f7ca5f2-7da-9bee-7bac-4b298fb0f8d8@redhat.com>
References: <20230628195145.636652-1-ashelat@redhat.com> <20230628195145.636652-3-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 28 Jun 2023, Anubhav Shelat wrote:

> rteval-cmd: fixed typo
> __init__.py, rtevalConfig: changed comments to use argparse instead of
> optparse
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
You forgot your SOB, please resend with the SOB

