Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C486C25B0E
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Aug 2022 18:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiHPSba (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiHPSb2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Aug 2022 14:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D078769F
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Aug 2022 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660674686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UMjf4xogIcUUIObrsKZjPoE2kGR3lD7mwZxetfGVnmY=;
        b=HLTbT4v+2MHfSZwAFi7KxutDMlIS10X61Sw8R+UeYSdYK4q0Yls3Ph95QcoIMnNgo6t7xE
        UFYXixZU4Jn67j+0q6wpISbwO0GHKdGnUh4djarKX4pW5TQasbqPsmQP7qo/qgTAn+GPEn
        UveSoFCgMkPSr5gFDOS+LeG7+xDCG1I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-nm9xUuepPmSko5PMgfXaqA-1; Tue, 16 Aug 2022 14:31:18 -0400
X-MC-Unique: nm9xUuepPmSko5PMgfXaqA-1
Received: by mail-qv1-f70.google.com with SMTP id oh2-20020a056214438200b0047bd798af75so4789540qvb.6
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Aug 2022 11:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=UMjf4xogIcUUIObrsKZjPoE2kGR3lD7mwZxetfGVnmY=;
        b=CXZsn12GOjCLKuIAIUJyGd/yIm19AsUxBrqpix82fwqXNJy87kncalOsYRzTYSnrwk
         YO0DyHjnQ3RCdgQeBHqgNiAXSMrZ1z+1Xs+ubD8D3g2Gh73oep4eyUT5C0/RUDxFzHHd
         ADjUppwoHgi7cwsJOVdfp6ct8qXaM4oJBfqozdxEy99pe2maWQT5o1SsDRPiwcLZkyXw
         LuXm8VDLNo19TyG+rZKNDGN6k35P0lROmqy2cd7uzpFM35nj7HHIgGI4y5hr+ropS9FC
         hhynMwoIn27OmD/tI83H9PnVDm2wuzWZ5tUvKcebW5OGFHEHlgalf1CDdzWdyVEKTbCn
         gogg==
X-Gm-Message-State: ACgBeo1pFFfQBpLRvL39i6AnuauptJly2Po4MjJlYqJbpf9kCdS+phS4
        rDFz9fQU5bjrfX1yi2ucbCTifIEwRfC8H6Y5KAJCAS7Rv+fKkqwXP8ITr8VoMQlznefY5r2XU9s
        755WnKv8Yxze98dQtFJwwSHk5PF8=
X-Received: by 2002:ac8:5f47:0:b0:31f:1087:525a with SMTP id y7-20020ac85f47000000b0031f1087525amr19169764qta.619.1660674677587;
        Tue, 16 Aug 2022 11:31:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5wmW3fbfipBqLs0YmoDP3qQYaZEhEc5T25ia0wO2cdm+cutS1tMzLcjnwFzVYguQN81aFCnQ==
X-Received: by 2002:ac8:5f47:0:b0:31f:1087:525a with SMTP id y7-20020ac85f47000000b0031f1087525amr19169738qta.619.1660674677358;
        Tue, 16 Aug 2022 11:31:17 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a288f00b006b8d9d53605sm12278426qkp.125.2022.08.16.11.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:31:16 -0700 (PDT)
Date:   Tue, 16 Aug 2022 14:31:15 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Leah Leshchinsky <lleshchi@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4] rteval: Add measurement and load location to run
 report
In-Reply-To: <20220816181931.617514-1-lleshchi@redhat.com>
Message-ID: <71354ff4-e44e-cb6c-754b-93918f5e4aaa@redhat.com>
References: <20220816181931.617514-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 16 Aug 2022, Leah Leshchinsky wrote:

> The run report produced at the end of a run does not contain information
> on load and measurement thread locations.
> 
> Adjust MakeReport() functions of LoadModules and MeasurementModules
> class so that new properties with number of loads and cpu information
> are added to the XML report and can be read by rteval_text.xsl.
> 
> Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>
> 
> diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
> index 2c2105efa964..7daa57a19c66 100644
> --- a/rteval/modules/loads/__init__.py
> +++ b/rteval/modules/loads/__init__.py
> @@ -30,6 +30,7 @@ import libxml2
>  from rteval.Log import Log
>  from rteval.rtevalConfig import rtevalCfgSection
>  from rteval.modules import RtEvalModules, rtevalModulePrototype
> +from rteval.systopology import collapse_cpulist, CpuList, SysTopology as SysTop
>  
>  class LoadThread(rtevalModulePrototype):
>      def __init__(self, name, config, logger=None):
> @@ -131,6 +132,14 @@ class LoadModules(RtEvalModules):
>      def MakeReport(self):
>          rep_n = RtEvalModules.MakeReport(self)
>          rep_n.newProp("load_average", str(self.GetLoadAvg()))
> +        rep_n.newProp("loads", str(self.ModulesLoaded()))
> +        cpulist = self._cfg.GetSection(self._module_config).cpulist
> +        if cpulist:
> +            # Convert str to list and remove offline cpus
> +            cpulist = CpuList(cpulist).cpulist
> +        else:
> +            cpulist = SysTop().online_cpus()
> +        rep_n.newProp("loadcpus", collapse_cpulist(cpulist))
>  
>          return rep_n
>  
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index 318248bd7e35..d99873e64a1a 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -24,7 +24,7 @@
>  
>  import libxml2
>  from rteval.modules import RtEvalModules, ModuleContainer
> -
> +from rteval.systopology import collapse_cpulist, CpuList, SysTopology as SysTop
>  
>  class MeasurementProfile(RtEvalModules):
>      """Keeps and controls all the measurement modules with the same measurement profile"""
> @@ -189,6 +189,14 @@ measurement profiles, based on their characteristics"""
>  
>          # Get the reports from all meaurement modules in all measurement profiles
>          rep_n = libxml2.newNode("Measurements")
> +        cpulist = self.__cfg.GetSection("measurement").cpulist
> +        if cpulist:
> +            # Convert str to list and remove offline cpus
> +            cpulist = CpuList(cpulist).cpulist
> +        else:
> +            cpulist = SysTop().online_cpus()
> +        rep_n.newProp("measurecpus", collapse_cpulist(cpulist))
> +
>          for mp in self.__measureprofiles:
>              mprep_n = mp.MakeReport()
>              if mprep_n:
> diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
> index c40063e3dd19..7ecfac6b6140 100644
> --- a/rteval/rteval_text.xsl
> +++ b/rteval/rteval_text.xsl
> @@ -13,6 +13,14 @@
>      <xsl:value-of select="run_info/date"/><xsl:text> </xsl:text><xsl:value-of select="run_info/time"/>
>      <xsl:text>&#10;</xsl:text>
>  
> +    <xsl:text>   Loads:        </xsl:text>
> +    <xsl:value-of select="loads/@loads"/><xsl:text> loads run on cores </xsl:text><xsl:value-of select="loads/@loadcpus"/>
> +    <xsl:text>&#10;</xsl:text>
> +
> +    <xsl:text>   Measurement:  </xsl:text>
> +    <xsl:text>measurement threads run on cores </xsl:text><xsl:value-of select="Measurements/@measurecpus"/>
> +    <xsl:text>&#10;</xsl:text>
> +
>      <xsl:text>   Run time:     </xsl:text>
>      <xsl:value-of select="run_info/@days"/><xsl:text> days </xsl:text>
>      <xsl:value-of select="run_info/@hours"/><xsl:text>h </xsl:text>
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

