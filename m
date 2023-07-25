Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB07FC001DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jul 2023 13:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjGYNlv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGYNlu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jul 2023 09:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45581BDB
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690292464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rlT6pCXV/m3jAFGFGiNU4axT1LMQRJx9l64gp0T+elg=;
        b=ADDp/oRPqEzwmWTsyxPAy+YlXcN6+3hPCft5SbjmcaggokxpCRBsn7Ned7B/KcRNyo1LM0
        AdqILNGR1RtBBMlcKCEpMr85JBUdzgdApPMM39790ldB0sAkEcmCRamawHTh8AkrW2Ylzz
        KaqrG1Hq4K1Ukpmrg7O+W+mPIY26Hmw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-sGVNzYFYMNekuGJucJhbFA-1; Tue, 25 Jul 2023 09:41:02 -0400
X-MC-Unique: sGVNzYFYMNekuGJucJhbFA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7683f415a45so861670485a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292462; x=1690897262;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlT6pCXV/m3jAFGFGiNU4axT1LMQRJx9l64gp0T+elg=;
        b=kPVea/ESJiTgAvtlp68OME6Q1AcPEbEIQhoEEmrzniyEnMKrGEkGjegJeIkCJP/pZN
         1gQOOyzGQnP9mGlBT4S9fGEgncZWFAijtFJ22syUSdhOq1f3GmjcCE/3siXvxjbCwXNI
         Mz2nrMkdfxkvuoLigaQbHEV+D5R2AZSvYM9psxEwCSfgfF41zDlsMA/OB+CBnNsK1O/g
         p0ikmJgeRh4TLTQknNlSq2GbD12nAWaj3MMb+0lQ3xyfWPzOgogeIzznvh4C6ERoFn+y
         Lj1bFnXlUsWzLELb4Ap8ouplbo7RgFftUrP9FiUHIeQsCvOAVTPHGq4amnaIXMej/sWw
         ONSA==
X-Gm-Message-State: ABy/qLbfWIUssp2X93WP/56DmxsJGSy3Gs3KdGLeXGr/C4M4MvHvMvx8
        LZ00FlbJjzogtyp3m4zl14t1bKOfPZqwlYHAF01PHvaI9LU/tmLKw8e0D52wTDpmFLeYdqxOUGo
        J6zm8wQPjYNvGPNMTn0Z34F5VhbeswNn48uo=
X-Received: by 2002:a05:620a:2886:b0:762:499d:d9dc with SMTP id j6-20020a05620a288600b00762499dd9dcmr3789975qkp.54.1690292462299;
        Tue, 25 Jul 2023 06:41:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF4+zpFwKSGZd8tcychDEIcZzcGk7eKVFoTVAVj2ksyKJgZo5h1Q7WenRfAoyb43RtALYnSjw==
X-Received: by 2002:a05:620a:2886:b0:762:499d:d9dc with SMTP id j6-20020a05620a288600b00762499dd9dcmr3789964qkp.54.1690292462107;
        Tue, 25 Jul 2023 06:41:02 -0700 (PDT)
Received: from fionn ([184.147.142.236])
        by smtp.gmail.com with ESMTPSA id k27-20020a05620a143b00b0076211938e93sm3667411qkj.46.2023.07.25.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:41:01 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:40:52 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/6] rteval: Exclude isolcpus from kcompile by default
In-Reply-To: <20230630091951.916865-4-tglozar@redhat.com>
Message-ID: <9f54b61a-50fc-b3f0-5cdb-9037d35f530@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com> <20230630091951.916865-4-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 30 Jun 2023, Tomas Glozar wrote:

> Allows correct calculation of make job count that does not include
> isolated CPUs, on which the loads won't be scheduled.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/modules/loads/kcompile.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 35ee5cb..30c5965 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -37,6 +37,7 @@ from rteval.systopology import CpuList, SysTopology
>  
>  expand_cpulist = CpuList.expand_cpulist
>  compress_cpulist = CpuList.compress_cpulist
> +nonisolated_cpulist = CpuList.nonisolated_cpulist
>  
>  DEFAULT_KERNEL_PREFIX = "linux-6.1"
>  
> @@ -55,17 +56,20 @@ class KBuildJob:
>          if not os.path.isdir(self.objdir):
>              os.mkdir(self.objdir)
>  
> +        # Exclude isolated CPUs if cpulist not set
> +        cpus_available = len(nonisolated_cpulist(self.node.cpus.cpulist))
> +
>          if os.path.exists('/usr/bin/numactl') and not cpulist:
>              # Use numactl
>              self.binder = f'numactl --cpunodebind {int(self.node)}'
> -            self.jobs = self.calc_jobs_per_cpu() * len(self.node)
> +            self.jobs = self.calc_jobs_per_cpu() * cpus_available
>          elif cpulist:
>              # Use taskset
>              self.jobs = self.calc_jobs_per_cpu() * len(cpulist)
>              self.binder = f'taskset -c {compress_cpulist(cpulist)}'
>          else:
>              # Without numactl calculate number of jobs from the node
> -            self.jobs = self.calc_jobs_per_cpu() * len(self.node)
> +            self.jobs = self.calc_jobs_per_cpu() * cpus_available
>  
>          self.runcmd = f"make O={self.objdir} -C {self.kdir} -j{self.jobs}"
>          self.cleancmd = f"make O={self.objdir} -C {self.kdir} clean allmodconfig"
> -- 
> 2.41.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

