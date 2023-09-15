Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D05FEEEC01
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Sep 2023 19:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbjIOTHq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbjIOTHf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Sep 2023 15:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D121898
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Sep 2023 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694804805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gr3IcVDrUksE4OkReViBIh7teenFZJMsoBJdO/8jGWU=;
        b=LwUP/OdHzbPkNaqztyAfZU+vwUkimOWqB2ODHjM8YUBjX0v+QcwBNNGBY36C7etnonIX7S
        iR5oskGeLuEjca5iyj/kX5Iwt4uWMuZwex7sT1q+PQJEdbnoQweKSfe37+eP6YZ9sfdgmE
        SRiXGnIk/pbUf7p7WoZJtOdQ0dp61eQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Cnh9B5r4MzqC5yS7pRCHXw-1; Fri, 15 Sep 2023 15:06:43 -0400
X-MC-Unique: Cnh9B5r4MzqC5yS7pRCHXw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3ac97a6abf6so4068301b6e.1
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Sep 2023 12:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804803; x=1695409603;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gr3IcVDrUksE4OkReViBIh7teenFZJMsoBJdO/8jGWU=;
        b=CJQj2HxC2aMJhRxPEJO4wokZmDdcM9Ak8j+a8/zTOKfDYm7RckJ66pEjanAfRC1dBM
         UP23jn9qxGNT5JCrJKyIOlJtD/Vl0SS3kckf8lgyX56Xfy+9zGB6sIFLkZAxG0J3jaKt
         5iODolt09GiqHmOZLFDA/EcJ7zie6a3opFOzfwiS0BBkLN7k6mlzVBo0ZrDstEybj3cZ
         +AF1d2PPZSl9HY5FBSY6Q2lCIF+h0ohWjHQU2CqS3Imv61Dbpl7SMwNfTqzNPknbKjXa
         ECT9pljWuHBsoHTZ+fEas3sMXU0kp9zEjmBrKaKOn1jRgwVX9lUGMxRYNwuIjrAIbvz0
         TuYQ==
X-Gm-Message-State: AOJu0YzWTeCB6KFNfKoXopmKuKfETS73do8eTjYHi/OH1X8hXDuiUwLR
        5LNjxLFyM4Y1/P46NyRZX1Xa+VRNtxaqhS1VDnu2WD7TLDKUchhaMOQOp2l5nxRnLrGmbV4Rk8+
        /+4J+EuCjr31NCLXVMgaiXF07q7I=
X-Received: by 2002:a05:6808:c:b0:3a1:d075:348b with SMTP id u12-20020a056808000c00b003a1d075348bmr2356227oic.59.1694804803181;
        Fri, 15 Sep 2023 12:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg5EMrXf9VUVDhjwDf/8EC37m4bJgQ2uQuhLXrwG3dyAvxJHesD8Pszr+XrZmlMBRrkyE08g==
X-Received: by 2002:a05:6808:c:b0:3a1:d075:348b with SMTP id u12-20020a056808000c00b003a1d075348bmr2356215oic.59.1694804802935;
        Fri, 15 Sep 2023 12:06:42 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-15-174-88-88-130.dsl.bell.ca. [174.88.88.130])
        by smtp.gmail.com with ESMTPSA id o5-20020ac85545000000b004179e79069asm313742qtr.21.2023.09.15.12.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:06:42 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:06:33 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rteval: Add run_on_isolcpus option to
 measurements
In-Reply-To: <20230811095228.200772-3-tglozar@redhat.com>
Message-ID: <f59349b5-bae5-115c-67c8-95f68502fad@redhat.com>
References: <20230811095228.200772-1-tglozar@redhat.com> <20230811095228.200772-3-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org





On Fri, 11 Aug 2023, Tomas Glozar wrote:

> Add option --measurement-run-on-isolcpus for the user to specify to
> include isolcpus in the default cpulist (without --measurement-cpulist).
> 
> A default value might also be specified in rteval.conf:
> [measurement]
> run-on-isolcpus: true
> 
> Note that values different from true evaluate as false.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/modules/measurement/__init__.py | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index 0e395be..5258dd7 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -146,7 +146,15 @@ measurement profiles, based on their characteristics"""
>  
>      def SetupModuleOptions(self, parser):
>          "Sets up all the measurement modules' parameters for the option parser"
> -        self.__container.SetupModuleOptions(parser, self.__cfg)
> +        grparser = self.__container.SetupModuleOptions(parser, self.__cfg)
> +
> +        # Set up options specific for measurement module group
> +        grparser.add_argument("--measurement-run-on-isolcpus",
> +                              dest="measurement___run_on_isolcpus",
> +                              action="store_true",
> +                              default=self.__cfg.GetSection("measurement").setdefault("run-on-isolcpus", "false").lower()
> +                                      == "true",
> +                              help="Include isolated CPUs in default cpulist")
>  
>  
>      def Setup(self, modparams):
> @@ -157,9 +165,10 @@ measurement profiles, based on their characteristics"""
>  
>          modcfg = self.__cfg.GetSection("measurement")
>          cpulist = modcfg.cpulist
> +        run_on_isolcpus = modcfg.run_on_isolcpus
>  
>          for (modname, modtype) in modcfg:
> -            if modtype.lower() == 'module':  # Only 'module' will be supported (ds)
> +            if isinstance(modtype, str) and modtype.lower() == 'module':  # Only 'module' will be supported (ds)
>                  # Extract the measurement modules info
>                  modinfo = self.__container.ModuleInfo(modname)
>  
> @@ -179,6 +188,7 @@ measurement profiles, based on their characteristics"""
>                  # Setup this imported module inside the appropriate measurement profile
>                  self.__cfg.AppendConfig(modname, modparams)
>                  self.__cfg.AppendConfig(modname, {'cpulist':cpulist})
> +                self.__cfg.AppendConfig(modname, {'run-on-isolcpus':run_on_isolcpus})
>                  mp.Setup(modname)
>  
>          del self.__container
> @@ -190,11 +200,12 @@ measurement profiles, based on their characteristics"""
>          # Get the reports from all meaurement modules in all measurement profiles
>          rep_n = libxml2.newNode("Measurements")
>          cpulist = self.__cfg.GetSection("measurement").cpulist
> +        run_on_isolcpus = self.__cfg.GetSection("measurement").run_on_isolcpus
>          if cpulist:
>              # Convert str to list and remove offline cpus
>              cpulist = CpuList(cpulist).cpulist
>          else:
> -            cpulist = SysTop().default_cpus()
> +            cpulist = SysTop().online_cpus() if run_on_isolcpus else SysTop().default_cpus()
>          rep_n.newProp("measurecpus", collapse_cpulist(cpulist))
>  
>          for mp in self.__measureprofiles:
> -- 
> 2.41.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

