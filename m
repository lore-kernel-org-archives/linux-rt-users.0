Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5765EEEC00
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Sep 2023 19:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjIOTOJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjIOTNm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Sep 2023 15:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 601C298
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Sep 2023 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694805176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nTC5NgEQMoRv25Tvg86OVSuaxs+4gBHcJhWWqcus1bg=;
        b=LgGo6yRuqjIZZrobTEk3myK4nUHyaJIMoIAiZTWr+/R9LIRJFSSBH5uzimwIF0qw6+cXxd
        DU6Sz9hppa8aoEaItt5OZpaSonD1HkBlRMR/OoHsTsnbVpJc+t+S8h7SlF16y0MMmbAFYT
        +HYwZ63kjjbc+l4+4ncFCm37ok+/W6c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-b3_Il1YrPb-tCCMjp8uJ7Q-1; Fri, 15 Sep 2023 15:12:54 -0400
X-MC-Unique: b3_Il1YrPb-tCCMjp8uJ7Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76ef92fadefso323522585a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Sep 2023 12:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694805174; x=1695409974;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTC5NgEQMoRv25Tvg86OVSuaxs+4gBHcJhWWqcus1bg=;
        b=v+OD2BcbkCcHsQIpWNBy5nskUivM29/4uEEDtCb4urv7FCLtsbJfVvv6V0Rl/tfnwt
         J/kw3QW8iBYAWNvprTlL+M0qY2N6ZH9PCTyJqJ10Ar/AWyEuRxwK+ewMX8kGuj0DGDPC
         HE13zRPlDPfXl0vic4TcpwOCsJu0xf9tBguSC0etCUeanl92zb8nBQCJCUpuiHIkE+vl
         ZJPgXRnjLtonV5cecAk70xEisUpwGjMfn+qchPAObxLHMR34aTklqbTVNsBWjPh4z3gk
         /7vLGj44MQQX2S04p6QFTe7aIOmY5i70HBYdIBsY7v3AW+8sZicH5iGHvoFKsf3WTx5S
         lgSA==
X-Gm-Message-State: AOJu0Yxcqc/DBraUXuPo3Ljgsuunu4bfEXvMoD9O9F0hs4N+fTMBMn4I
        wEAeBRvjCvQ6N0FCOpf6XlcojI4jdbquOM0XqHDtlmYNxbjK+n/pK5lWgmHGeO/ZxOHokjO2ncK
        GS6RUijht4Ag90nZnOrrZKc3qBgE=
X-Received: by 2002:a05:620a:17a2:b0:76f:1808:997c with SMTP id ay34-20020a05620a17a200b0076f1808997cmr3101210qkb.20.1694805174306;
        Fri, 15 Sep 2023 12:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7rXD7Agwny85MXTmjpCGfy72BjiX6arK7E+ZQkxClJQj/h4lotOHqmPpHOiyc78T4EELaRw==
X-Received: by 2002:a05:620a:17a2:b0:76f:1808:997c with SMTP id ay34-20020a05620a17a200b0076f1808997cmr3101197qkb.20.1694805174061;
        Fri, 15 Sep 2023 12:12:54 -0700 (PDT)
Received: from fionn ([174.88.88.130])
        by smtp.gmail.com with ESMTPSA id b1-20020a05620a118100b0076ca401d8c7sm1411341qkk.111.2023.09.15.12.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:12:53 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:12:40 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 3/3] rteval: Support run-on-isolcpus in cyclictest
In-Reply-To: <20230811095228.200772-4-tglozar@redhat.com>
Message-ID: <aa9abe34-5aa-ace0-dba1-7324562d967@redhat.com>
References: <20230811095228.200772-1-tglozar@redhat.com> <20230811095228.200772-4-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 11 Aug 2023, Tomas Glozar wrote:

> If --measurement-run-on-isolcpus is enabled, add isolated CPUs to the
> cpumask for the case when --measurement-cpulist is not specified. If
> both options are specified, display a warning.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/modules/measurement/cyclictest.py | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index ace8db4..4d7fcf2 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -214,6 +214,7 @@ class Cyclictest(rtevalModulePrototype):
>          self.__cpus = []
>          self.__cyclicdata = {}
>          self.__sparse = False
> +        self.__run_on_isolcpus = bool(self.__cfg.setdefault('run-on-isolcpus', False))
>  
>          if self.__cfg.cpulist:
>              self.__cpulist = self.__cfg.cpulist
> @@ -224,14 +225,21 @@ class Cyclictest(rtevalModulePrototype):
>              self.__cpulist = collapse_cpulist(self.__cpus)
>              self.__cpus = [str(c) for c in self.__cpus]
>              self.__sparse = True
> +            if self.__run_on_isolcpus:
> +                self._log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
>          else:
>              self.__cpus = SysTopology().online_cpus_str()
>              # Get the cpuset from the environment
>              cpuset = os.sched_getaffinity(0)
>              # Convert the elements to strings
>              cpuset = [str(c) for c in cpuset]
> -            # Only include cpus that are in the cpuset
> -            self.__cpus = [c for c in self.__cpus if c in cpuset]
> +            # Get isolated CPU list
> +            isolcpus = [str(c) for c in SysTopology().isolated_cpus()]
> +            # Only include cpus that are in the cpuset and isolated CPUs if run_on_isolcpus is enabled
> +            self.__cpus = [c for c in self.__cpus if c in cpuset or self.__run_on_isolcpus and c in isolcpus]
> +            if self.__run_on_isolcpus:
> +                self.__sparse = True
> +                self.__cpulist = collapse_cpulist(self.__cpus)
>  
>          # Sort the list of cpus to align with the order reported by cyclictest
>          self.__cpus.sort(key=int)
> -- 
> 2.41.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
--

I'm including this but we might need to finess the model.
Right now this is the intersection of isolated cpus plus the mask if 
given.
Other possibilities would be for the mask to override the isolated cpus, 
but perhaps we want the user to indicate, are we adding to the isolated 
cpus to include more cpus, are we subtracing, etc

