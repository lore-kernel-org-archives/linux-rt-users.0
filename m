Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68FEC25B06
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Aug 2022 23:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiHDX42 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 19:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiHDX40 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Aug 2022 19:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 923346BD54
        for <linux-rt-users@vger.kernel.org>; Thu,  4 Aug 2022 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659657384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o7679C8M1OtILQvP7kTI1Kwd/Xf0fKHm3w0M5OM8PC8=;
        b=SNavTa/2UoGSravNPwtTH3hApFhAmtCddhu6WC24wO4sCMVDmNZz5hFy9MP2O7dBt+8PuD
        r4Z7uI85Zaikqm+78bVxujAMCFFR96YlKp6V8UBDdRG0aiz27Z6eyzrElrGgnsLcWDwJ3d
        RjKPO7r8CATEHXPqogxrdBWX+HUa6rI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-EPi7lCtVMaiNJUtJMaMXBA-1; Thu, 04 Aug 2022 19:56:23 -0400
X-MC-Unique: EPi7lCtVMaiNJUtJMaMXBA-1
Received: by mail-qv1-f70.google.com with SMTP id ea7-20020ad458a7000000b00476b8d9bfdcso546864qvb.18
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Aug 2022 16:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=o7679C8M1OtILQvP7kTI1Kwd/Xf0fKHm3w0M5OM8PC8=;
        b=53t5RyPfkrr/Ck9HcDkmdc2V/i04wEHAEmHdijxaxaalTH4Y1GX/YraOwegjMKvHZC
         LRXXm8lLrQ5OekrSmQ3gi0grwfpYc0KBHvuNm5Ud4FbK26S3i5362Pyq3wNC95BoRNRt
         sn8rx7+4PBsz94N2Gla+oEYxp4G+KIyQ4NnUlkCCDePMOWbBmocjLGaKnXH57PeU+o0b
         waQlELRaSvIRBXWsV2AcqJZW1EM+Jvznbcp00bzC4+VlgwhsRKC0r194Kv4IF2L3AIlB
         pATpf+xXbnURE4xpD3a5Ne9PC3ELte+uvecFYBNWQuK0I7fzB4IEboDXPrk/xA/kTJy9
         5sDw==
X-Gm-Message-State: ACgBeo0b6PQyEfIBVWK+afBxH1fKQrqtKNO3Vr8ZsIV0rcD917g51I14
        VeqC2SgN9QwDFKAB3vEIk1/6Ri3vUePb9QxzW9iuScviW7XUpw6MlIc9vYhnJPDtS+ttoeO60AY
        8LOi+B87KlgoY0FdaPvBlWPVJNyM=
X-Received: by 2002:a05:622a:1a85:b0:31e:f623:7b39 with SMTP id s5-20020a05622a1a8500b0031ef6237b39mr3841731qtc.151.1659657382244;
        Thu, 04 Aug 2022 16:56:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4u7SEVKwsHwJgjY8dww5vCP/Ah/gylOELDTvGOHmzS/69OShdogJuZGVxmf1WE4PBw45yVew==
X-Received: by 2002:a05:622a:1a85:b0:31e:f623:7b39 with SMTP id s5-20020a05622a1a8500b0031ef6237b39mr3841724qtc.151.1659657382044;
        Thu, 04 Aug 2022 16:56:22 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id y20-20020a05620a44d400b006a6ebde4799sm1808049qkp.90.2022.08.04.16.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 16:56:21 -0700 (PDT)
Date:   Thu, 4 Aug 2022 19:56:19 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Leah Leshchinsky <lleshchi@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rteval: Add measurement and load location to run
 report
In-Reply-To: <20220804154807.252163-1-lleshchi@redhat.com>
Message-ID: <42453c6d-d873-5b78-511e-11152f238d3c@redhat.com>
References: <20220804154807.252163-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 4 Aug 2022, Leah Leshchinsky wrote:

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

add CpuList, and you might not need collapse_cpulist, and SysTopology

>  
>  class LoadThread(rtevalModulePrototype):
>      def __init__(self, name, config, logger=None):
> @@ -131,6 +132,12 @@ class LoadModules(RtEvalModules):
>      def MakeReport(self):
>          rep_n = RtEvalModules.MakeReport(self)
>          rep_n.newProp("load_average", str(self.GetLoadAvg()))
> +        rep_n.newProp("loads", str(self.ModulesLoaded()))
> +        cpulist = self._cfg.GetSection(self._module_config).cpulist

The above value is either going to be all cpus, or the value of 
--loads-cpulist=LIST or the inverse of --measurement-cpulist=LIST
I don't think it can be empty, so the following code after if not cpulist
is deadcode

> +        if not cpulist:
> +            st = SysTopology()
> +            cpulist = collapse_cpulist(st.online_cpus())

If the above code were to run it would just be a list of all online cpus

Admitedly the systopology api is a bit confusing but since it does a lot, 
I think all you really need is
cpulist = CpuList(self._cfg.GetSection(self._module_config).cpulist)
 rep_n.newProp("loadcpus", str(cpulist))

And that's it. You need to do something similar to the measurement section 
too.

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
> 

Something in the xsl code is not working, I'm not picking up any values in 
the reports for "Measurements/@measurecpus" for example.

Thanks

