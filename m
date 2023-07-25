Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EA7C0015E
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jul 2023 13:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGYNfA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjGYNe7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jul 2023 09:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5A91BEE
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690292051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXkljr30gROp885XbZPEyXB5vjDgY8rjsoj9/PhP8Y0=;
        b=MNGR+6i6IA3MqTj+CCgvvNJyFhTHwBbWRYN23RjC+MWQF+8eIJQ6GhzLNqiZMuF6JtrLae
        O0YhsUC2I0kohKwV/cg8SER9FoyTTh6cg3IQru+Tz2UUh4C0t6nIspaszkrzWnbdNRBK0X
        vVlFuHxFzm+As/meFlGIW8ObHdD2RPg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-WLoNyPhbPhSxUjf-VoYToQ-1; Tue, 25 Jul 2023 09:34:06 -0400
X-MC-Unique: WLoNyPhbPhSxUjf-VoYToQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7683cdabcb7so763321485a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 06:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292044; x=1690896844;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXkljr30gROp885XbZPEyXB5vjDgY8rjsoj9/PhP8Y0=;
        b=J2k1Ed2Dp872q85EVf7B4idXf/WdQEC2vziKtPL+YgarxfMFybH31MJgUOCI/3vCjY
         xZY8FP31eLTSySGX6qK/+Cefcx/2c6aMVlW/MzQbjw1krVuXNNjALxzU99z6cgGsF3V+
         Ptz1QVgC6sTznQVZ0Kh6cPHnYj4lDrYFC+OyfQD74pDFsfnbVgeRrkalUqH1p7kSsIpA
         2ktli0svMaf+JY3FKENwqGZOYzlWqk3P8+XIHFEw83LfIH4DC81OV4HHVTTT8H031ELH
         PzLDhF1wTzsSC1mIuQC+7oTIPQhwZeLBhB9JNlXxiWm8CdMAVL0tADgokkojpmr7eqtd
         rmbQ==
X-Gm-Message-State: ABy/qLbe+hIUZX/nvOVawzpfbry/vj0nJnQlgrxlF+Ugx7xIKlrOvjpu
        yhOTpJ2YHNGF2WXpUMxqnML2Hx8q5P4tLJjIUTtiC5d77RSdfnZ6tKGqTE6rPaIPBgz6vNV/+Qh
        1pdjT8I2MZFqIogrT+6Ncn9qacq7Vt11erSA=
X-Received: by 2002:a05:620a:205d:b0:763:e942:f78a with SMTP id d29-20020a05620a205d00b00763e942f78amr2730171qka.32.1690292044561;
        Tue, 25 Jul 2023 06:34:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGaKvo6gKowtLKAt31wqHVO3jTVIyS63tP2nHgKZMNU6P1EtfhAQ2BTOmhS9xVsZRwSquA3Ig==
X-Received: by 2002:a05:620a:205d:b0:763:e942:f78a with SMTP id d29-20020a05620a205d00b00763e942f78amr2730154qka.32.1690292044110;
        Tue, 25 Jul 2023 06:34:04 -0700 (PDT)
Received: from fionn ([184.147.142.236])
        by smtp.gmail.com with ESMTPSA id c6-20020ae9e206000000b00767d8e12ce3sm3677965qkc.49.2023.07.25.06.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:34:03 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:33:34 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/6] rteval: Detect isolcpus in systopology
In-Reply-To: <20230630091951.916865-2-tglozar@redhat.com>
Message-ID: <7280cd6-361b-b973-491e-a41a8f07bcf@redhat.com>
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
--
The code is good, but I don't love the name "default_cpus", but it will 
do. isolated_cpus_str() and default_cpus_str() require docstrings.
I'm signing off on this to move it forward so please send that in a 
separate patch.

