Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C40C0015E
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jul 2023 13:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGYNiD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGYNiC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jul 2023 09:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075CA1FCC
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690292227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psTehX6rjlDvBL0xUbcPIFkR+n5Pp008j8veRIrGdQI=;
        b=i+OyPvT376TMcbQQyZ2Kz8xoxPLnFr+izeQdb8yFfDvA3/afmzpPb9XSui6aFp3TgFVRRz
        pI2xuLNx2FfENIhxp0kv/QlIHwg28m9FGMb36EG2aAGi3SW6yRKU33Txhd9cwMGmZ2hnWZ
        bf8FX7KIBSDkT3J1j/am0tPagKjbMZk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-oQmCGMHtNSOc3G4mmG7aCw-1; Tue, 25 Jul 2023 09:37:04 -0400
X-MC-Unique: oQmCGMHtNSOc3G4mmG7aCw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7659924cf20so601965485a.2
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292223; x=1690897023;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psTehX6rjlDvBL0xUbcPIFkR+n5Pp008j8veRIrGdQI=;
        b=M/cOWSjmZe2PG7lzxdZVm4FG9q0rCoWGlkldP8SMVDXf3ecMx4An1VGcZsFVpNqP/X
         Mv3w3EcOqVU0zEO/2ZnQGz4Fkb/8j8JQ12/86pQPQB2Wj9e/uRD+J/wc8X7goJ6FkDu4
         hT+HAKLc1KasLr9TGLp4kylA4EeHlHjxmAb76hT69GCGQinaP/NpVmCryxNoXHeAxkVo
         KIsngsjQXpN3YKZXGJrw2rnRVTshtP41G+0fBUys5WDaBfZDcYW21WihStwSN5v/Vjms
         0OQrsW/0lyRz/su8EJ3ajmebBCw8OarpXVoBpR6VQlDaj6pwe0ru4QYw9fAKfZc1crkK
         EcKQ==
X-Gm-Message-State: ABy/qLaJb3RxejtFr0p4FqR1qWDPNkV921rIQk2wYyjkeNoogS7yLPqZ
        1T+BToQR913rIVXDd47Gy3OCGDrxFrI+B5U1RX2ri5VINY2uv1J4FoHFICKeslcLErhE/BFZe7h
        GYw5P+/Q6AhfF/FdcrG1Lfz+MF44=
X-Received: by 2002:a05:620a:4549:b0:767:47dd:15f with SMTP id u9-20020a05620a454900b0076747dd015fmr3448189qkp.15.1690292223147;
        Tue, 25 Jul 2023 06:37:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3zbB8XvL/HnYf3Oz42TY8k00pDQ1v+GUQ5JiNKjf5cbwPBV8qA9spkNp3sbQXYU8APfkcrA==
X-Received: by 2002:a05:620a:4549:b0:767:47dd:15f with SMTP id u9-20020a05620a454900b0076747dd015fmr3448169qkp.15.1690292222826;
        Tue, 25 Jul 2023 06:37:02 -0700 (PDT)
Received: from fionn ([184.147.142.236])
        by smtp.gmail.com with ESMTPSA id y24-20020a37e318000000b00767d7fa3d05sm3612061qki.136.2023.07.25.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:37:02 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:36:53 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/6] rteval: Detect isolcpus in systopology
In-Reply-To: <20230630091951.916865-2-tglozar@redhat.com>
Message-ID: <3617d394-6ab-78d1-d5eb-51e1c188fc7a@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com> <20230630091951.916865-2-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 30 Jun 2023, Tomas Glozar wrote:

> Works similarly to online_cpus:
> - add CpuList.isolated_cpulist to filter isolated CPUs
> - add SysTopology.isolated_cpus to get list of isolated CPUs
> - add CpuList.nonisolated_cpulist to do the opposite filter
> - add SysTopology.default_cpus to get CPUs that are used for scheduling
>   by default, i.e. online and non-isolated CPUs
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/systopology.py | 47 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index c8f85c5..19443f9 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -127,6 +127,11 @@ class CpuList:
>              return True
>          return False
>  
> +    @staticmethod
> +    def isolated_file_exists():
> +        """ Check whether machine / kernel is configured with isolated file """
> +        return os.path.exists(os.path.join(CpuList.cpupath, "isolated"))
> +
>      @staticmethod
>      def longest_sequence(cpulist):
>          """ return index of last element of a sequence that steps by one """
> @@ -214,6 +219,24 @@ class CpuList:
>                  newlist.append(cpu)
>          return newlist
>  
> +    @staticmethod
> +    def isolated_cpulist(cpulist):
> +        """Given a cpulist, return a cpulist of isolated CPUs"""
> +        if not CpuList.isolated_file_exists():
> +            return cpulist
> +        isolated_cpulist = sysread(CpuList.cpupath, "isolated")
> +        isolated_cpulist = CpuList.expand_cpulist(isolated_cpulist)
> +        return list(set(isolated_cpulist) & set(cpulist))
> +
> +    @staticmethod
> +    def nonisolated_cpulist(cpulist):
> +        """Given a cpulist, return a cpulist of non-isolated CPUs"""
> +        if not CpuList.isolated_file_exists():
> +            return cpulist
> +        isolated_cpulist = sysread(CpuList.cpupath, "isolated")
> +        isolated_cpulist = CpuList.expand_cpulist(isolated_cpulist)
> +        return list(set(cpulist).difference(set(isolated_cpulist)))
> +
>  #
>  # class to abstract access to NUMA nodes in /sys filesystem
>  #
> @@ -362,11 +385,35 @@ class SysTopology:
>          cpulist.sort()
>          return cpulist
>  
> +    def isolated_cpus(self):
> +        """ return a list of integers of all isolated cpus """
> +        cpulist = []
> +        for n in self.nodes:
> +            cpulist += CpuList.isolated_cpulist(self.getcpus(n))
> +        cpulist.sort()
> +        return cpulist
> +
> +    def default_cpus(self):
> +        """ return a list of integers of all default schedulable cpus, i.e. online non-isolated cpus """
> +        cpulist = []
> +        for n in self.nodes:
> +            cpulist += CpuList.nonisolated_cpulist(self.getcpus(n))
> +        cpulist.sort()
> +        return cpulist
> +
>      def online_cpus_str(self):
>          """ return a list of strings of numbers of all online cpus """
>          cpulist = [str(cpu) for cpu in self.online_cpus()]
>          return cpulist
>  
> +    def isolated_cpus_str(self):
> +        cpulist = [str(cpu) for cpu in self.isolated_cpus()]
> +        return cpulist
> +
> +    def default_cpus_str(self):
> +        cpulist = [str(cpu) for cpu in self.default_cpus()]
> +        return cpulist
> +
>      def invert_cpulist(self, cpulist):
>          """ return a list of online cpus not in cpulist """
>          return [c for c in self.online_cpus() if c not in cpulist]
> -- 
> 2.41.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

