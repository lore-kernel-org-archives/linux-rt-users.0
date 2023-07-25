Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D6CC0015E
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jul 2023 13:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGYNjU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjGYNjT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jul 2023 09:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35E61FD2
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690292308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v4/Iu53yMt0EERl0k0mPxQ2KE46YfEpg3jCMCRDKEXU=;
        b=aJzJ9clTklwDD8YTp9x4Wv4Nvv6akDisVWHkbAYXLPq6G/FGEZAij2PiN0/eAufAz3638/
        VVge0FKFss7emZtUw6umk8foceqlukfB++NwkrhWQZWqLOi1wqFi1Et5BlUJcJdVY1rdx1
        Fx0JDULMcce85z5J+UpcHR/j022OuAc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-XQD1_YKFMz6M5OXhMFZE0A-1; Tue, 25 Jul 2023 09:38:27 -0400
X-MC-Unique: XQD1_YKFMz6M5OXhMFZE0A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7683cdabcb7so763699285a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292305; x=1690897105;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4/Iu53yMt0EERl0k0mPxQ2KE46YfEpg3jCMCRDKEXU=;
        b=lfOSUuaEiY5i4emMUs9iXiawkGbbkE8eO5Fk9Ju15LwwJxS91+uaIlKKjWlQIyFrTM
         bxA13ePWZGz/Jfr6ztYy/bTNB9adSK/STSxvbOBlqyhEeuJuztN1vlyNXUhjqkCAeww8
         eSk6l5N8UqORyHe3DGGDL26fjj0HzLnt04b0bT58YKnLSzr0QHpyJB/h1I5DqyB0/K68
         1i+aXKLTk+iGmE8vVtEZnzweiojCWh+0b/F5tPcmAHroAibPv7EEXYTyBhgleUcj1kXp
         myLuQTljERvhP0CCPPKS9HXpOxYl+4Ai0eh9VM/lj5KYvWZKxIbbwre3e4nSLf/Ys8Ly
         kzrg==
X-Gm-Message-State: ABy/qLbOVmmh+2AzwahCpR12xvEQ36CK8ZZRtRYyeRPNlBmSvC0cNSfP
        4e3gJEgPM+dQ7q+/x0mES5TuLsqW/rPGr62P08Li1xvHQM/aYC42YRXmSwY0NQLa8LmwSy8PTNh
        MiWeeTPPR9y4+yzDYrvcqayeKZGY=
X-Received: by 2002:a05:620a:2018:b0:767:b348:5a9 with SMTP id c24-20020a05620a201800b00767b34805a9mr2889551qka.21.1690292305623;
        Tue, 25 Jul 2023 06:38:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG8Sq7gNx16OpJ1sp6iUh4Uc+DS/uUgSHWZEK+rvJ8JqBdUGWllJS4LCrCCe7yYj6FsMS3Prw==
X-Received: by 2002:a05:620a:2018:b0:767:b348:5a9 with SMTP id c24-20020a05620a201800b00767b34805a9mr2889542qka.21.1690292305417;
        Tue, 25 Jul 2023 06:38:25 -0700 (PDT)
Received: from fionn ([184.147.142.236])
        by smtp.gmail.com with ESMTPSA id g2-20020a05620a108200b00767b07ec8adsm3683854qkk.82.2023.07.25.06.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:38:25 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:38:16 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/6] rteval: Report isolated CPUs
In-Reply-To: <20230630091951.916865-3-tglozar@redhat.com>
Message-ID: <28a0dbf8-75bd-5db0-2825-e63ff87aaa3@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com> <20230630091951.916865-3-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 30 Jun 2023, Tomas Glozar wrote:

> Add a flag for whether a CPU is isolated in CPUtopology and display
> the number of isolated CPUs in text report.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/rteval_text.xsl        |  4 ++++
>  rteval/sysinfo/cputopology.py | 11 +++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
> index 7ecfac6..0ef649b 100644
> --- a/rteval/rteval_text.xsl
> +++ b/rteval/rteval_text.xsl
> @@ -59,6 +59,10 @@
>  	<xsl:value-of select="SystemInfo/CPUtopology/@num_cpu_cores"/>
>  	<xsl:text> (online: </xsl:text>
>  	<xsl:value-of select="SystemInfo/CPUtopology/@num_cpu_cores_online"/>
> +    <xsl:if test="SystemInfo/CPUtopology/@num_cpu_cores_isolated != 0">
> +      <xsl:text>, isolated: </xsl:text>
> +      <xsl:value-of select="SystemInfo/CPUtopology/@num_cpu_cores_isolated"/>
> +    </xsl:if>
>  	<xsl:text>)</xsl:text>
>        </xsl:when>
>        <xsl:when test="hardware/cpu_topology">
> diff --git a/rteval/sysinfo/cputopology.py b/rteval/sysinfo/cputopology.py
> index 2bb6323..f60b059 100644
> --- a/rteval/sysinfo/cputopology.py
> +++ b/rteval/sysinfo/cputopology.py
> @@ -25,6 +25,7 @@
>  
>  import os
>  import libxml2
> +from rteval.systopology import SysTopology
>  
>  class CPUtopology:
>      "Retrieves an overview over the installed CPU cores and the system topology"
> @@ -34,6 +35,7 @@ class CPUtopology:
>          self.__cputop_n = None
>          self.__cpu_cores = 0
>          self.__online_cores = 0
> +        self.__isolated_cores = 0
>          self.__cpu_sockets = 0
>  
>      def __read(self, dirname, fname):
> @@ -51,6 +53,10 @@ class CPUtopology:
>  
>          self.__cputop_n = libxml2.newNode('CPUtopology')
>  
> +        # Get list of isolated CPUs from SysTopology
> +        systopology = SysTopology()
> +        isolated_cpus = {'cpu' + n for n in systopology.isolated_cpus_str()}
> +
>          cpusockets = []
>          for dirname in os.listdir(self.sysdir):
>              # Only parse directories which starts with 'cpu'
> @@ -82,6 +88,10 @@ class CPUtopology:
>                                                        'physical_package_id')
>                              cpu_n.newProp('physical_package_id', str(phys_pkg_id))
>                              cpusockets.append(phys_pkg_id)
> +                            is_isolated = dirname in isolated_cpus
> +                            if is_isolated:
> +                             self.__isolated_cores += 1
> +                            cpu_n.newProp('isolated', str(int(dirname in isolated_cpus)))
>                          break
>  
>          # Count unique CPU sockets
> @@ -97,6 +107,7 @@ class CPUtopology:
>          # Summarise the core counts
>          self.__cputop_n.newProp('num_cpu_cores', str(self.__cpu_cores))
>          self.__cputop_n.newProp('num_cpu_cores_online', str(self.__online_cores))
> +        self.__cputop_n.newProp('num_cpu_cores_isolated', str(self.__isolated_cores))
>          self.__cputop_n.newProp('num_cpu_sockets', str(self.__cpu_sockets))
>  
>          return self.__cputop_n
> -- 
> 2.41.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

