Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A735DC0015E
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jul 2023 13:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjGZNoX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jul 2023 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjGZNoS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jul 2023 09:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAAC2691
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690379004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sMDhaKQCGKc8ddy97pT/vsd4pZJqD/DWOCC4Ey5ehVE=;
        b=V7KxvUa0nWhCfPeByK9ZDCJOmSChpDHNFS4UPCnsxsKPph/Frf89sLPBm1dSC/mMCif8t+
        zUM3xrrVEkRjyzwG3rI6e6N6FbwGe8eL9Q5MwkkUFSuLSaER+mfGw4t3ImSfiaOHYsTPrR
        Jsze3GNRXT/0oW6aCtC2b00ABe7jZts=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-9S-Aboa5MXylswyW4Faw2w-1; Wed, 26 Jul 2023 09:43:22 -0400
X-MC-Unique: 9S-Aboa5MXylswyW4Faw2w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403ab5a9a83so77480561cf.1
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 06:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379001; x=1690983801;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMDhaKQCGKc8ddy97pT/vsd4pZJqD/DWOCC4Ey5ehVE=;
        b=Y2TVF4Eb8DDSGvOWe1LpBDVVAN0o2MdfxToU1wxh5LrvCmylHmJvlKY7w1QqQvr5mp
         9Cb3D6T9leVLRDGaOXE96Tdf85mcsSwluSuYYpjRBgSO4D2sanuDM4dm6i3n+LsUZvUJ
         3/BA0YtzZ/0Ufh6sM2rSj4ZaDRU8UyPPjBm1JMQ1YwB+O4AbRWqmFBbe2UCZeLGBbxxG
         8Y25A8hrCcGDmvdURU2JsFW/QdV2/zqbDOBRNS/lUTxzyQvfYTEXLqwvq8lAD6+RWqZK
         pqAskj/tq1c6mxtKW2Nx1raHfyg9GXJECjPXeKWfYHi+RsWg5b6m0WaI/jWMYjPuP74P
         3G9Q==
X-Gm-Message-State: ABy/qLYEanLfvthCUTZejDxk5FxPyeKSNH/GfI2VTE3+uqCrja+oFaGA
        f6dWSBcCosoeAOCV1dNK71uzYRJS2xZLbwaWskPMJsSGw6TGceE0vnndSkNmejbsvR95I7rKM1e
        T5mNQvQ8+gD+UD70JHrSvOqXQEKgCraV9rkc=
X-Received: by 2002:a05:622a:1815:b0:403:a93b:2c02 with SMTP id t21-20020a05622a181500b00403a93b2c02mr3081869qtc.21.1690379001284;
        Wed, 26 Jul 2023 06:43:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3y0XsLYS8THdkLQf2fwn83dI69KMrnMCUUQItcHitiMUcbFhwhu+oVz3rdLPEsRgs0WkVPw==
X-Received: by 2002:a05:622a:1815:b0:403:a93b:2c02 with SMTP id t21-20020a05622a181500b00403a93b2c02mr3081852qtc.21.1690379001064;
        Wed, 26 Jul 2023 06:43:21 -0700 (PDT)
Received: from fionn ([184.147.142.236])
        by smtp.gmail.com with ESMTPSA id v13-20020ac8748d000000b004053bcffe49sm4812258qtq.9.2023.07.26.06.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:43:20 -0700 (PDT)
Date:   Wed, 26 Jul 2023 09:42:53 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Add missing docstrings in SysTopology
In-Reply-To: <20230726082212.258414-1-tglozar@redhat.com>
Message-ID: <c8cfc15-eda6-782a-ebdc-eba63bf95538@redhat.com>
References: <20230726082212.258414-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 26 Jul 2023, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Add docstrings for isolated_cpus_str and default_cpus_str.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/systopology.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index 19443f9..a991e70 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -407,10 +407,12 @@ class SysTopology:
>          return cpulist
>  
>      def isolated_cpus_str(self):
> +        """ return a list of strings of numbers of all isolated cpus """
>          cpulist = [str(cpu) for cpu in self.isolated_cpus()]
>          return cpulist
>  
>      def default_cpus_str(self):
> +        """ return a list of strings of numbers of all default schedulable cpus """
>          cpulist = [str(cpu) for cpu in self.default_cpus()]
>          return cpulist
>  
> -- 
> 2.39.3
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

