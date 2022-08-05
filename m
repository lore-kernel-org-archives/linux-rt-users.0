Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7CBC00140
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 17:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiHEROp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbiHEROn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Aug 2022 13:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A89C74356
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Aug 2022 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659719681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A5a1YzadCWv9KEk4hLqWY7RCOrINmhMmorRobbt1IrY=;
        b=SNUi96I4GbjjpWw1z+IOo9WcEi/xCNFrFCQ7uX2VEG26eLRmFQ7JJCAVoigtH3NvmLcYwM
        4x1kvJKTeg/SySOvHpWx12leMC/4mG8RaUGQqJC/VJsAQe/ytEJqEsfKwQhpX9h2d47eH4
        d12qOPTzemWStlUjFrHyftDQMon2PZs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-DZRifD1NOTiTKfCbTPh_UA-1; Fri, 05 Aug 2022 13:14:40 -0400
X-MC-Unique: DZRifD1NOTiTKfCbTPh_UA-1
Received: by mail-qk1-f199.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so2433552qkp.20
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Aug 2022 10:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=A5a1YzadCWv9KEk4hLqWY7RCOrINmhMmorRobbt1IrY=;
        b=h0ezhPil1oTQoFq27teHafMk/aLJEAiNtu6Js2aiuzItENe4qwmjt4P0O0hjEOs7Y2
         UFxADUvygxyciOupNzi13Nj/XP9yWSbSiwiYaQlXxl1qCZ7R7dwUq1Xzs6srwpxruFJB
         ElXDUo05vAV+o8L2DBnqFTGIj/vrcewDXszf3oIIvmxVvy6lproDh6YxC26TN+MjzZN3
         /AYMw0mdfCfqmjDSVSJ4ggK0R2tXAj6XAtRwAbf6VbSyKGxAwdx3h5NKjPsrwIEL7aS4
         n1z4iCetvTGwjSwpBVkH7gB0BNogoUADYgGNeoHwqcJjUIw6rDH06JW+Rkvq5y8puuhZ
         ggvQ==
X-Gm-Message-State: ACgBeo2vGDyDgyVO/4lgIYMXo5VRKz25DCsKtqqOi1Q1NgmHAK/INBDL
        TwiXXL8atvCOvX5YS/9VmxbzkBBO5BJF1K6iZloFEPAtUqKINo1vFvvgTV43YfTeOWY43u8DPb+
        H6CsRI7wjjrLWWroRdGw0pKjBtq0=
X-Received: by 2002:ac8:5991:0:b0:31f:4d30:4127 with SMTP id e17-20020ac85991000000b0031f4d304127mr6663853qte.688.1659719679319;
        Fri, 05 Aug 2022 10:14:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5cS42sW8iv/rpN+1uF8Gi5CMzKUco04BNYs10Xd81ITlcTAPloyNUZBlJbED968x4CuI0MXg==
X-Received: by 2002:ac8:5991:0:b0:31f:4d30:4127 with SMTP id e17-20020ac85991000000b0031f4d304127mr6663825qte.688.1659719678916;
        Fri, 05 Aug 2022 10:14:38 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id p4-20020ac87404000000b0031ea2328edcsm3024353qtq.82.2022.08.05.10.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:14:38 -0700 (PDT)
Date:   Fri, 5 Aug 2022 13:14:36 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Leah Leshchinsky <lleshchi@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rteval: Add measurement and load location to run
 report
In-Reply-To: <Yu1NZ2YFbOLsmFdU@lleshchi.bos.csb>
Message-ID: <1292baea-a27e-df36-a7cb-e155f7fa416e@redhat.com>
References: <20220804154807.252163-1-lleshchi@redhat.com> <Yu0dNzEf76KtzQ+I@lleshchi.bos.csb> <8047d387-1396-c2ff-70e5-aa448a907fb4@redhat.com> <Yu1NZ2YFbOLsmFdU@lleshchi.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 5 Aug 2022, Leah Leshchinsky wrote:

> On Fri, Aug 05, 2022 at 12:32:32PM -0400, John Kacur wrote:
> > 
> > 
> > On Fri, 5 Aug 2022, Leah Leshchinsky wrote:
> > 
> > > On Thu, Aug 04, 2022 at 11:48:07AM -0400, Leah Leshchinsky wrote:
> > > > The run report produced at the end of a run does not contain information
> > > > on load and measurement thread locations.
> > > > 
> > > > Adjust MakeReport() functions of LoadModules and MeasurementModules
> > > > class so that new properties with number of loads and cpu information
> > > > are added to the XML report and can be read by rteval_text.xsl.
> > > > 
> > > > Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>
> > > > 
> > > > diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
> > > > index 2c2105efa964..5e5a5d85b616 100644
> > > > --- a/rteval/modules/loads/__init__.py
> > > > +++ b/rteval/modules/loads/__init__.py
> > > > @@ -30,6 +30,7 @@ import libxml2
> > > >  from rteval.Log import Log
> > > >  from rteval.rtevalConfig import rtevalCfgSection
> > > >  from rteval.modules import RtEvalModules, rtevalModulePrototype
> > > > +from rteval.systopology import collapse_cpulist, SysTopology
> > > >  
> > > >  class LoadThread(rtevalModulePrototype):
> > > >      def __init__(self, name, config, logger=None):
> > > > @@ -131,6 +132,12 @@ class LoadModules(RtEvalModules):
> > > >      def MakeReport(self):
> > > >          rep_n = RtEvalModules.MakeReport(self)
> > > >          rep_n.newProp("load_average", str(self.GetLoadAvg()))
> > > > +        rep_n.newProp("loads", str(self.ModulesLoaded()))
> > > > +        cpulist = self._cfg.GetSection(self._module_config).cpulist
> > > > +        if not cpulist:
> > > > +            st = SysTopology()
> > > > +            cpulist = collapse_cpulist(st.online_cpus())
> > > > +        rep_n.newProp("loadcpus", cpulist)
> > > >  
> > > >          return rep_n
> > > >  
> > > > diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> > > > index 318248bd7e35..371fc5d08f44 100644
> > > > --- a/rteval/modules/measurement/__init__.py
> > > > +++ b/rteval/modules/measurement/__init__.py
> > > > @@ -24,7 +24,7 @@
> > > >  
> > > >  import libxml2
> > > >  from rteval.modules import RtEvalModules, ModuleContainer
> > > > -
> > > > +from rteval.systopology import collapse_cpulist, SysTopology
> > > >  
> > > >  class MeasurementProfile(RtEvalModules):
> > > >      """Keeps and controls all the measurement modules with the same measurement profile"""
> > > > @@ -189,6 +189,12 @@ measurement profiles, based on their characteristics"""
> > > >  
> > > >          # Get the reports from all meaurement modules in all measurement profiles
> > > >          rep_n = libxml2.newNode("Measurements")
> > > > +        cpulist = self.__cfg.GetSection("measurement").cpulist
> > > > +        if not cpulist:
> > > > +            st = SysTopology()
> > > > +            cpulist = collapse_cpulist(st.online_cpus())
> > > > +        rep_n.newProp("measurecpus", cpulist)
> > > > +
> > > >          for mp in self.__measureprofiles:
> > > >              mprep_n = mp.MakeReport()
> > > >              if mprep_n:
> > > > diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
> > > > index c40063e3dd19..7ecfac6b6140 100644
> > > > --- a/rteval/rteval_text.xsl
> > > > +++ b/rteval/rteval_text.xsl
> > > > @@ -13,6 +13,14 @@
> > > >      <xsl:value-of select="run_info/date"/><xsl:text> </xsl:text><xsl:value-of select="run_info/time"/>
> > > >      <xsl:text>&#10;</xsl:text>
> > > >  
> > > > +    <xsl:text>   Loads:        </xsl:text>
> > > > +    <xsl:value-of select="loads/@loads"/><xsl:text> loads run on cores </xsl:text><xsl:value-of select="loads/@loadcpus"/>
> > > > +    <xsl:text>&#10;</xsl:text>
> > > > +
> > > > +    <xsl:text>   Measurement:  </xsl:text>
> > > > +    <xsl:text>measurement threads run on cores </xsl:text><xsl:value-of select="Measurements/@measurecpus"/>
> > > > +    <xsl:text>&#10;</xsl:text>
> > > > +
> > > >      <xsl:text>   Run time:     </xsl:text>
> > > >      <xsl:value-of select="run_info/@days"/><xsl:text> days </xsl:text>
> > > >      <xsl:value-of select="run_info/@hours"/><xsl:text>h </xsl:text>
> > > > -- 
> > > > 2.31.1
> > > > 
> > > 
> > > Hi John,
> > > 
> > > I do believe the cpulist variable can be empty. I was able to test this by running rteval without specifying and load and measurement cpus.
> > 
> > Ok, you are correct, cpulist can be empty if the following are not set
> > --loads-cpulist=LIST
> > --measurement-cpulist=LIST
> > 
> > So you do need some code to initialize the list of it is empty.
> > But there are still problems
> > 
> > For example if you shut off cpu 3
> > su -c 'echo 0 > /sys/devices/system/cpu/cpu3/online '
> > 
> > And then request measurement on cpus 0-5
> > su -c './rteval-cmd -d5s --measurement-cpulist=0-5'
> > 
> > The report should say 
> > Measurement:  measurement threads run on cores  0-2,4,5
> > Loads:        3 loads run on cores 6-11 (the inverse)
> > but instead with your patch it says
> > Loads:        3 loads run on cores 1,2,4,6,7,8,9,10,11
> > Measurement:  measurement threads run on cores 0-5
> > 
> > Now there are problems that exist even before your patch, so for example, 
> > the initial info to the screen not included in the report doesn't consider 
> > offline cpus. (We should fix that too of course, but we can do this 
> > stepwise)
> > 
> > And it's also possible that I have introduced some new problems with the 
> > changes to systopology that will hopefully make things simpler in the long 
> > run but may be interferring with your code. So, there are many things to 
> > untangle here.
> > 
> > > 
> > > This patch is attempting to replicate the behavior found in rteval/__init.py lines 187-201, which also finds the cpulist using
> > >             cpulist = self._loadmods._cfg.GetSection("loads").cpulist
> > > and if the cpulist is empty, defaults to reporting the online cpus. I assume this is because the rteval program uses all available cpus
> > > to run measurement and load threads if no specific cpus are specified.
> > > 
> > > Please let me know if I am misunderstanding any of the above.
> > > 
> > > I will investigate why the xsl code is not working for you. It seems to be working for me at the moment.
> > 
> > 
> > > 
> > > Thank you for the review,
> > > Leah
> > > 
> > > 
> > Thanks Leah
> > 
> > John
> > 
> 
> Hi John,
> 
> > The report should say
> > Measurement:  measurement threads run on cores  0-2,4,5
> > Loads:        3 loads run on cores 6-11 (the inverse)
> > but instead with your patch it says
> > Loads:        3 loads run on cores 1,2,4,6,7,8,9,10,11
> > Measurement:  measurement threads run on cores 0-5
> 
> Now that I'm looking at the rteval program prior to my changes, I see that this issue existed in the initial pre-report posted to stdout.
> This seems to be a separate bug in the way that 'self._loadmods._cfg.GetSection("loads").cpulist' and self.__cfg.GetSection("measurement").cpulist are calculated.
> 
> When I test your example on the rteval main branch, this is the result:
> 
> su -c 'echo 0 > /sys/devices/system/cpu/cpu3/online '
> su -c './rteval-cmd -d5s --measurement-cpulist=0-5'
> 
> started 3 loads on cores 1,2,4,6,7
> started measurement threads on cores 0-5
> 
> Should we file this as a separate bug, since the scope of it goes beyond my current patch?
> 
> Thanks,
> Leah
> 

Please send a separate patch to fix this.

John

