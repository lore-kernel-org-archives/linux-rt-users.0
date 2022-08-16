Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C67FC32772
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Aug 2022 17:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiHPR2I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Aug 2022 13:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiHPR2G (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Aug 2022 13:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760EC7D1F4
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Aug 2022 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660670883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YZVf4wTgfpyRhYmlUOENldrTixh86xuYZF3NGx8+4Ng=;
        b=Q4fIvEl/GrjuBrOjg3DbYsxxni7IJeOfug8gJVfyp8FRxabi4MsqpB2I04nzRMzTUUnNvY
        hjC8fQHyILU2+gG0Iwza0loA2zAb6W+6YkXt7cXyD82InxDcR7j1iYZgyVe0ZYRunUxgvg
        DXY0Jgl+4+CXSXzoCc0FehLcCvuN3Q8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-198-x0cBc9LpMJm3uiVBYTeAgg-1; Tue, 16 Aug 2022 13:28:02 -0400
X-MC-Unique: x0cBc9LpMJm3uiVBYTeAgg-1
Received: by mail-qk1-f200.google.com with SMTP id w17-20020a05620a425100b006b97978c693so9770255qko.19
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Aug 2022 10:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=YZVf4wTgfpyRhYmlUOENldrTixh86xuYZF3NGx8+4Ng=;
        b=PzYWk7KeP92VVxxtBPIb8AQSVkDF+4mmOyvUesqB1opzHoOO9tAwMvl34MhUoVUnrb
         QR4tlnq3Dyjqh4WGZv95oCRz7HuCMCF2JhWDxQvwu1EoWJd4QLyRrz4xlzqvjE6yo0Kp
         5Q7DH5ZGUY25J4xrNMTVd4TlU4eeVBFPwG1tkfN25dTVZN/Tckkq7+wCFeRVTZda39Oz
         Nptdf2joMXa2waYkIEVmTE/ct9FWx3So0dlbfie8uoWxWcn0uheKbN7r8s+BFua2PaF/
         21IBHlj93mxtpqnZwGjxd13oDuHNZtx4EZvaEx4vFpdRmB+8mN+vASfyS35YYuCs/lZD
         c4ZQ==
X-Gm-Message-State: ACgBeo2xyfjmHyKQUBuXZp1yaOchjXxLrtXilqERG0j07P/NzU77HLdJ
        LYfu5/pCvLgR6o/ATkFPdUiQM6S1crwWHB36N4BD6gF8wufZtSl5PgyCST6aFDXvghT+T9QRgBa
        eWqN5hzYkVD+5KsCr0VYy4pS9Y3o=
X-Received: by 2002:ac8:5ad1:0:b0:343:5e13:795d with SMTP id d17-20020ac85ad1000000b003435e13795dmr19389015qtd.625.1660670881623;
        Tue, 16 Aug 2022 10:28:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ga/njsd21qZ9fZuJrUlKEDK17RhNTcLhidY2UUkRnAtN+F7dxtF2GGidTYmic1TksNCKUrg==
X-Received: by 2002:ac8:5ad1:0:b0:343:5e13:795d with SMTP id d17-20020ac85ad1000000b003435e13795dmr19389001qtd.625.1660670881368;
        Tue, 16 Aug 2022 10:28:01 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a288f00b006b8d9d53605sm12174548qkp.125.2022.08.16.10.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:28:00 -0700 (PDT)
Date:   Tue, 16 Aug 2022 13:27:41 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Leah Leshchinsky <lleshchi@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3] rteval: Add measurement and load location to run
 report
In-Reply-To: <20220816162011.606213-1-lleshchi@redhat.com>
Message-ID: <14e0849d-3b59-4582-aeff-d7882780261c@redhat.com>
References: <20220816162011.606213-1-lleshchi@redhat.com>
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
> index 2c2105efa964..2f7f1d4356ae 100644
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
> @@ -131,6 +132,13 @@ class LoadModules(RtEvalModules):
>      def MakeReport(self):
>          rep_n = RtEvalModules.MakeReport(self)
>          rep_n.newProp("load_average", str(self.GetLoadAvg()))
> +        rep_n.newProp("loads", str(self.ModulesLoaded()))
> +        cpulist = self._cfg.GetSection(self._module_config).cpulist
> +        if cpulist:
> +            cpulist = CpuList(cpulist).cpulist
> +        else:
> +            cpulist = SysTop().online_cpus()
> +        rep_n.newProp("loadcpus", collapse_cpulist(cpulist))
>  
>          return rep_n
>  
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index 318248bd7e35..90e1839333bb 100644
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
> @@ -189,6 +189,13 @@ measurement profiles, based on their characteristics"""
>  
>          # Get the reports from all meaurement modules in all measurement profiles
>          rep_n = libxml2.newNode("Measurements")
> +        cpulist = self.__cfg.GetSection("measurement").cpulist
> +        if cpulist:
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
Great!
I tested this with:
no args
--measurement-cpulist=CPULIST
--loads-cpulist=CPULIST
--measurement-cpulist =CPULIST1 --loads-cpulist=CPULIST2
and they all worked as expected.
Then I repeated all of the above after turning off cpu3

The only thing I would request is to add a hash style comment above
the two lines
cpulist = CpuList(cpulist).cpulist
to explain that this takes a string and transforms it to a list and 
removes any cpus that are offline. I'll let you figure out how to say that 
succinctly! After that it's ready to be integrated.

Thanks

John

