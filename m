Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B29C00140
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 13:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiHENiJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 09:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiHENiG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Aug 2022 09:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 631201AD92
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Aug 2022 06:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659706684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZES9mjW+J5vdoqjz31909aBIdkmzhYD04ZMM6RLCBSs=;
        b=SxKSi7JY/Fu2eC09wn66VgnosSQRuaLwHPPRXlKJ4y8mze/oHJ/+x58RmkGygKWQYNcgtC
        dYac8h8kAjnuDBbcnqSuLv1dozUA7cf/RhdkbmnR+HBuj1NcqapSpTugRNtB0ZslEDqcNF
        5FSQuTe27YmW+40iBZ5M0qTXfOFVkWY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-_X6cjjJMPFivjCP7t8et4Q-1; Fri, 05 Aug 2022 09:38:03 -0400
X-MC-Unique: _X6cjjJMPFivjCP7t8et4Q-1
Received: by mail-qt1-f199.google.com with SMTP id u12-20020a05622a17cc00b0031ede432916so1955754qtk.1
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Aug 2022 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZES9mjW+J5vdoqjz31909aBIdkmzhYD04ZMM6RLCBSs=;
        b=yqmiDOCpFLSDPTTAqtggNUH1+kuc+ZuCCmLVfx4sSQBEyzoLre5FiI9v7VwK2SpwVz
         zC1IgiNqlnrsawJo1NHtfvNYQK2r0A0CmwXF+Qnp64Jr7x4nNNKDpHb9yu/2xBQHKnjX
         CjlvClgg/J/aiGK6Hue0WQnHQ4kQUiLFzaX4e+zt2rjj3h/fXHZjitM5wfT+SXEQKqF3
         7bN59NEGCJwKCjZJOL+fNIHEcqa6rxSvsS/rVbrK2u4bWEj0PmsYKg0sxbF7+ZIAyPYM
         w9W2di39t3qbHWKLUbW/2eeJzPxd0efIMkbwPofen358FSGB8cNOL2mndnNZECHto/FX
         E75g==
X-Gm-Message-State: ACgBeo3bOpCNEe3kzVLdCBo0dNgfIjrLGAFMYPNBjQaGr4gFVfPkpGTz
        zhrddI4PnwV/edY2bRRVDpfK4Hty4cYSO+fliuDuCXqSKog7Ko3Kam9eAddPnNLbxQVQg9hC3WZ
        rVG+PGGpB6K+MNKYLABDb3PDVY1Q=
X-Received: by 2002:a05:620a:424f:b0:6b6:7a9d:c5c7 with SMTP id w15-20020a05620a424f00b006b67a9dc5c7mr5084219qko.479.1659706682657;
        Fri, 05 Aug 2022 06:38:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4bV5WJ9Qb47ETxENHkLZmD5DjzkVqVsJePFhVRZuf1IPEE2TfIAIcfjEt8EHG11Fx3IeTxBQ==
X-Received: by 2002:a05:620a:424f:b0:6b6:7a9d:c5c7 with SMTP id w15-20020a05620a424f00b006b67a9dc5c7mr5084189qko.479.1659706682267;
        Fri, 05 Aug 2022 06:38:02 -0700 (PDT)
Received: from lleshchi.bos.csb (cpe-24-198-132-134.maine.res.rr.com. [24.198.132.134])
        by smtp.gmail.com with ESMTPSA id a127-20020a379885000000b006af039ff090sm2827104qke.97.2022.08.05.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 06:38:01 -0700 (PDT)
Date:   Fri, 5 Aug 2022 09:37:59 -0400
From:   Leah Leshchinsky <lleshchi@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rteval: Add measurement and load location to run
 report
Message-ID: <Yu0dNzEf76KtzQ+I@lleshchi.bos.csb>
References: <20220804154807.252163-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804154807.252163-1-lleshchi@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 04, 2022 at 11:48:07AM -0400, Leah Leshchinsky wrote:
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
> index 2c2105efa964..5e5a5d85b616 100644
> --- a/rteval/modules/loads/__init__.py
> +++ b/rteval/modules/loads/__init__.py
> @@ -30,6 +30,7 @@ import libxml2
>  from rteval.Log import Log
>  from rteval.rtevalConfig import rtevalCfgSection
>  from rteval.modules import RtEvalModules, rtevalModulePrototype
> +from rteval.systopology import collapse_cpulist, SysTopology
>  
>  class LoadThread(rtevalModulePrototype):
>      def __init__(self, name, config, logger=None):
> @@ -131,6 +132,12 @@ class LoadModules(RtEvalModules):
>      def MakeReport(self):
>          rep_n = RtEvalModules.MakeReport(self)
>          rep_n.newProp("load_average", str(self.GetLoadAvg()))
> +        rep_n.newProp("loads", str(self.ModulesLoaded()))
> +        cpulist = self._cfg.GetSection(self._module_config).cpulist
> +        if not cpulist:
> +            st = SysTopology()
> +            cpulist = collapse_cpulist(st.online_cpus())
> +        rep_n.newProp("loadcpus", cpulist)
>  
>          return rep_n
>  
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index 318248bd7e35..371fc5d08f44 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -24,7 +24,7 @@
>  
>  import libxml2
>  from rteval.modules import RtEvalModules, ModuleContainer
> -
> +from rteval.systopology import collapse_cpulist, SysTopology
>  
>  class MeasurementProfile(RtEvalModules):
>      """Keeps and controls all the measurement modules with the same measurement profile"""
> @@ -189,6 +189,12 @@ measurement profiles, based on their characteristics"""
>  
>          # Get the reports from all meaurement modules in all measurement profiles
>          rep_n = libxml2.newNode("Measurements")
> +        cpulist = self.__cfg.GetSection("measurement").cpulist
> +        if not cpulist:
> +            st = SysTopology()
> +            cpulist = collapse_cpulist(st.online_cpus())
> +        rep_n.newProp("measurecpus", cpulist)
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

Hi John,

I do believe the cpulist variable can be empty. I was able to test this by running rteval without specifying and load and measurement cpus.

This patch is attempting to replicate the behavior found in rteval/__init.py lines 187-201, which also finds the cpulist using
            cpulist = self._loadmods._cfg.GetSection("loads").cpulist
and if the cpulist is empty, defaults to reporting the online cpus. I assume this is because the rteval program uses all available cpus
to run measurement and load threads if no specific cpus are specified.

Please let me know if I am misunderstanding any of the above.

I will investigate why the xsl code is not working for you. It seems to be working for me at the moment.

Thank you for the review,
Leah

