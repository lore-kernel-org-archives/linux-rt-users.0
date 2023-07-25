Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C672C001DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jul 2023 13:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjGYNqK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjGYNqB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jul 2023 09:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C951BFF
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690292654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCrA2bu8QS14GFwyJdzUeCRI3N7mxjxGm0oZQmXU7ck=;
        b=fNGVZl2wqqF0lzMhp0oeE4Xvmy7zR9e3U7ouMANIRGQNw6TGknFRkw4kIPptcwQPWpG9Ra
        JGfSWcDCpruXTKGNZ5Tcjvg0eTrtad9MW22cnilOV/2qyEC43YUlQO3ZMOucM9nJrFytyt
        NosPQgGAvUCXxwzU5Fv5EhSqqfVVOtQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-UXld4tR_MRi9ToQWd1Vx7A-1; Tue, 25 Jul 2023 09:44:12 -0400
X-MC-Unique: UXld4tR_MRi9ToQWd1Vx7A-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-403fe35b393so63724091cf.3
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292652; x=1690897452;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCrA2bu8QS14GFwyJdzUeCRI3N7mxjxGm0oZQmXU7ck=;
        b=MK6GFGa1XnzOqIVezsSO1j6vAwGSDcNZ3fRUZfZ/0cB6/ROVv2T2UVVchBIHg1suqJ
         0PwxwUwgP8g36ur6TyDtYBl8qVhpKNxFgmH5Ny25h2XDTmSdE8/0ZzYgI6PMA4bUJzjB
         5wp1ZLDXE9nzrJSPoUXuh5N9TLVHoh1Dpp69X8N0w1/xlfpmaj/rFqKfG3EVWdPn1K2F
         agMzKCabt27QVKpLXCo2gfaGprE1fQuiCkxnEADvOCOV+Q9PGkjNxVeivCFSjNVrrEwO
         w628g3Sej6/HpER2kv3s6rZYOIG6f0S9rkm6YYTCrMPtodhJV+EtPXbEwwfT/n4ToGhP
         W3KQ==
X-Gm-Message-State: ABy/qLbRN3qd/JrhVpQKVWz2Lz7hVQI51SjE9CZRSvnB/sNk6NdXXnlq
        h8qxWijEPEWoOAptuLoqgL+Hc3F4kqNeiNRnN5qmWuEaIKzRcgRDaSWsf3lPQ1omq6zON3Y82x5
        /ft6TlOakFpHppd6rtGEKU2eZRos=
X-Received: by 2002:a05:622a:d1:b0:405:5b23:8866 with SMTP id p17-20020a05622a00d100b004055b238866mr2982271qtw.52.1690292651789;
        Tue, 25 Jul 2023 06:44:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFOZrqFMlFfcM1GiQIdDtEGC/buNKKm8bM1K0exQMKpdn6CRM4Gtz7LFw7SPSYIzkuxoOENAQ==
X-Received: by 2002:a05:622a:d1:b0:405:5b23:8866 with SMTP id p17-20020a05622a00d100b004055b238866mr2982258qtw.52.1690292651501;
        Tue, 25 Jul 2023 06:44:11 -0700 (PDT)
Received: from fionn ([184.147.142.236])
        by smtp.gmail.com with ESMTPSA id o9-20020ac872c9000000b00403c1a19a2bsm4016835qtp.92.2023.07.25.06.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:44:11 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:44:02 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5/6] rteval: Fix CPU count calculation for hackbench
In-Reply-To: <20230630091951.916865-6-tglozar@redhat.com>
Message-ID: <355b14cf-fd7-6551-ea58-815d8385d6a2@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com> <20230630091951.916865-6-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 30 Jun 2023, Tomas Glozar wrote:

> Use count from cpulist when specified and all CPUs on node excluding
> offline ones and isolated ones if not specified.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/modules/loads/hackbench.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
> index 14e60d1..f5a547e 100644
> --- a/rteval/modules/loads/hackbench.py
> +++ b/rteval/modules/loads/hackbench.py
> @@ -38,6 +38,7 @@ from rteval.Log import Log
>  from rteval.systopology import CpuList, SysTopology
>  
>  expand_cpulist = CpuList.expand_cpulist
> +isolated_cpulist = CpuList.isolated_cpulist
>  
>  class Hackbench(CommandLineLoad):
>      def __init__(self, config, logger):
> @@ -77,9 +78,12 @@ class Hackbench(CommandLineLoad):
>              # if a cpulist was specified, only allow cpus in that list on the node
>              if self.cpulist:
>                  self.cpus[n] = [c for c in self.cpus[n] if c in expand_cpulist(self.cpulist)]
> +            # if a cpulist was not specified, exclude isolated cpus
> +            else:
> +                self.cpus[n] = CpuList.nonisolated_cpulist(self.cpus[n])
>  
>              # track largest number of cpus used on a node
> -            node_biggest = len(sysTop.getcpus(int(n)))
> +            node_biggest = len(self.cpus[n])
>              if node_biggest > biggest:
>                  biggest = node_biggest
>  
> -- 
> 2.41.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

