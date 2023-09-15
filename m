Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D047EEEC01
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Sep 2023 19:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjIOTD3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbjIOTDV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Sep 2023 15:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AD552D70
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Sep 2023 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694804516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gr3IcVDrUksE4OkReViBIh7teenFZJMsoBJdO/8jGWU=;
        b=AHd4W7NqZv+dAGlivTA4S8uVU/y6wleP8WAfIGehoPe+gAQ1Rsyk+nykXdcNy/eZkKSUk3
        YzKMBQ75f2L6zUbGjRTai0lgHMdkmETQuyGDGZHPG/D/iw/dDzKUJvaIxiU9KDDZrsYsPy
        Ogj46NWCNf2ByDXCK4bqkH3FXxc/ASM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-Q7AMYSZrPsu1jXNLhpy5tQ-1; Fri, 15 Sep 2023 15:01:55 -0400
X-MC-Unique: Q7AMYSZrPsu1jXNLhpy5tQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76efd8bf515so282700685a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Sep 2023 12:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804514; x=1695409314;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gr3IcVDrUksE4OkReViBIh7teenFZJMsoBJdO/8jGWU=;
        b=RH0L5vVy4VWvFVgIphnxA/9R6vuxp42o/lQFHVTQrx36/vim5Qllrxc1/wPHz29cmJ
         dy69nfJyQ6+ht1E9ZkoGY0xpbEudjmjNz6Z78+EXGo4dv++d5m+Hkc9RZ/O2ZrSwIrk2
         h6ssmWcEpp3nzDTONao8VkC/jjhw6UpS8Ihz36VExtIUYcWcfM6aImIPzNmhp2cTjEz6
         QJYQFYEnmbett4z4fVffdBOoej33een/sBdyPCS1puXwJZeWSW1JB+f/GBLoQJ1Pd92N
         LB5QOjS3RIHwDRyM8ACqkt5NZ1kIYTUIMozDphDx7D8oY0PiODQk5fzugoAcu0p2Enlo
         m8HQ==
X-Gm-Message-State: AOJu0YwqkYrAvU57slVbAJZ4hn6MkQgPTkObNsTO85xlXGV25v3isuhx
        T6Eh+u/ZJYFGSFfyKeHyiuHmkKbHuamwLIZ7l0tTi1/a5qo8OtAzN6lBXu8o7AgRtzmOIP5uU1C
        /Ai8r0B2qcta9RrycQGOl8kYsxkG0LhapXuA=
X-Received: by 2002:a05:620a:4553:b0:765:734b:1792 with SMTP id u19-20020a05620a455300b00765734b1792mr7572727qkp.23.1694804514433;
        Fri, 15 Sep 2023 12:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvpdUZsc8kEOC/Ffz4pR6/tnD+MoIeCR8tvYjpU6KCnr1Aog6Kk578fFElTs+Bbk1N/fBG0g==
X-Received: by 2002:a05:620a:4553:b0:765:734b:1792 with SMTP id u19-20020a05620a455300b00765734b1792mr7572702qkp.23.1694804514203;
        Fri, 15 Sep 2023 12:01:54 -0700 (PDT)
Received: from fionn ([174.88.88.130])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a13f000b0076d6a08ac98sm1410472qkl.76.2023.09.15.12.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:01:53 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:01:39 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rteval: Add run_on_isolcpus option to
 measurements
In-Reply-To: <20230811095228.200772-3-tglozar@redhat.com>
Message-ID: <8e40bb39-a52b-9a58-23d3-0bfeb88abf@redhat.com>
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

