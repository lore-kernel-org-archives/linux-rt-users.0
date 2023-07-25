Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D77CC001DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jul 2023 13:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjGYNnQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjGYNnM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jul 2023 09:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A2D1BF8
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690292541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Guvedz68P7r5rhpwlglfAC5MurinaFM41wEjRk+T+s=;
        b=C4XoD7vUYOGR/79gl5Jb/pt06p4Kt0tuAOnR9rjT9H5Fc/z5VOvJl8CdEC7WRrEQBaIufA
        mXnZNy66OW8ylw50Muyr4o7sKGEuNivIvctO+c1teq5bg7XNQ3agm3iFtxzRRSkOPjfHht
        f7U0NNjH4V1sBR8eS/XHDaD08kj4R/Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-aYisuI5-MGeIOMQQkVukng-1; Tue, 25 Jul 2023 09:42:19 -0400
X-MC-Unique: aYisuI5-MGeIOMQQkVukng-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7623d5cb0caso680810185a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292539; x=1690897339;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Guvedz68P7r5rhpwlglfAC5MurinaFM41wEjRk+T+s=;
        b=l2F1hKM3i+Xg9pNnJEOXu6U0HfEUMaWZu0JPTqk8jG2+QogeIo5TNRuAUnuipEDwRH
         dXqRWMRu9ILBylh2YfxHi+NJ75FQIq0202U7Wjx1zV4XRabRKIBZt8TTfKMgVKPmu+F/
         b3IUoxIPWzK68pb4UpH2JoXFiRr9wfgLOVt4V7eGjYJxtQo5SE0ZVkxWtm/vWv52kTgG
         8LKfraCObhCyxDKqf3PvNvW6+mmzttwYXnGRBMNtG8gTKKKw5RqkH+oVpoI/YeksSqvI
         UsGaN+ePLfjjTZD+7E0qiIWMGNT5SogMUFrKqOPfDqP5H0sbq23463g5TYcOIzrlffjG
         7rgw==
X-Gm-Message-State: ABy/qLZJtoQ2Tj1WT5n8YudvPSZaDvE8Mkl0VoPo/dIB1mJxL3yuv+PP
        NNQHFSl8s8tatPT15sTG7GM+GfWN2F1BlHgLfYASwGTmqbBMMmGbjRDZZPk9+KSdiS7ll3+Lzmq
        sWtBDKbiVF2WmfmtYrMHijxZjEU1tfS0bwJY=
X-Received: by 2002:a05:620a:4f0:b0:76a:d7cd:701b with SMTP id b16-20020a05620a04f000b0076ad7cd701bmr2747253qkh.6.1690292539226;
        Tue, 25 Jul 2023 06:42:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFUBCnMarzhXSHyEb4yUqGkOiA7j25zWl/o9AG/cxaIsaFC5j/jHBTIeafddOGVYbI6qKqJtA==
X-Received: by 2002:a05:620a:4f0:b0:76a:d7cd:701b with SMTP id b16-20020a05620a04f000b0076ad7cd701bmr2747242qkh.6.1690292538982;
        Tue, 25 Jul 2023 06:42:18 -0700 (PDT)
Received: from fionn ([184.147.142.236])
        by smtp.gmail.com with ESMTPSA id q29-20020a05620a039d00b00767177a5bebsm3633856qkm.56.2023.07.25.06.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:42:18 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:42:09 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/6] rteval: Exclude isolcpus from stressng by default
In-Reply-To: <20230630091951.916865-5-tglozar@redhat.com>
Message-ID: <30732a3-781f-342e-3d89-cb9ad7e2a128@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com> <20230630091951.916865-5-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 30 Jun 2023, Tomas Glozar wrote:

> Note: this has little effect now, because the cpus variables is only
> used for removing empty nodes unless a cpulist is specified by the user.
> However, this can change in the future.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/modules/loads/stressng.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
> index 85cb473..800fdec 100644
> --- a/rteval/modules/loads/stressng.py
> +++ b/rteval/modules/loads/stressng.py
> @@ -9,6 +9,7 @@ from rteval.Log import Log
>  from rteval.systopology import CpuList, SysTopology
>  
>  expand_cpulist = CpuList.expand_cpulist
> +nonisolated_cpulist = CpuList.nonisolated_cpulist
>  
>  class Stressng(CommandLineLoad):
>      " This class creates a load module that runs stress-ng "
> @@ -69,6 +70,10 @@ class Stressng(CommandLineLoad):
>              # if a cpulist was specified, only allow cpus in that list on the node
>              if self.cpulist:
>                  cpus[n] = [c for c in cpus[n] if c in expand_cpulist(self.cpulist)]
> +            # if a cpulist was not specified, exclude isolated cpus
> +            else:
> +                cpus[n] = CpuList.nonisolated_cpulist(cpus[n])
> +
>  
>          # remove nodes with no cpus available for running
>          for node, cpu in cpus.items():
> -- 
> 2.41.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

