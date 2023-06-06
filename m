Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598FEC77B73
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Jun 2023 15:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjFFPXo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjFFPXn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Jun 2023 11:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B014E1BD
        for <linux-rt-users@vger.kernel.org>; Tue,  6 Jun 2023 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686064972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hlTOOhEOHCW/FUpnNiRlvBmF0Egq7OexbD5LzFUCi2M=;
        b=J5ndREGhV3RXFMIS9aHVG+l/rcfUE62IHkFhSSJmviRcyT2KEO/M3La29p61QCSm9Amrm8
        kTGu+YWDE45uoxOQs0RwZnYzAzCBhX/aNDD1R5/abJSlMCQAyAyVTEY7RE7YMNF391G44Q
        9jHP1+9aQxRDK1u2dP6JCh99ywJLiEY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-n6_5XLuJO9-6Miysdli3fA-1; Tue, 06 Jun 2023 11:22:51 -0400
X-MC-Unique: n6_5XLuJO9-6Miysdli3fA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6260b40eac6so45525966d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Jun 2023 08:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686064970; x=1688656970;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlTOOhEOHCW/FUpnNiRlvBmF0Egq7OexbD5LzFUCi2M=;
        b=HZfNw4mTFLO9+6uuQoNJnGCfDEKS/wLQWy37pNi0cBS9F/ea4vXf+PaTxbqiUYjmRy
         xKfltMG56cFWcupJhCc4cQnBdnf1gPpJVl8vF/Oob2sj5jwJiFz1YsCnWvc4xjb9qpZC
         /H/V5KQFSSyOijMzjRGDTRNvm3Z9zFeToGH2EfZirtnWGoriARZzee5PEGNu7X/nmoqB
         Y5NVm0FXOUlOyympEv4wX70gfpbrC+uIQLWYK0WlVFPuL56yWnZA1mdbEj+qu+HhwSXZ
         XVZqBg+OODKQNQz9fAQ5CgJxhi20yghLr8547nO1XFd6xnDpXDqv8Q+MeuKd3ZpcusGd
         wUAQ==
X-Gm-Message-State: AC+VfDxHTKOoib+V3oXw9fm6X7kthcEqKgm/xApBxMdaroDaHD3b4wU+
        qbEW4M6qObqxQlpCTq8VqE9zbhEi3Qhi1iCUtNGX7alrYdC6iPMo48Wrf7HKuDwcUojVHpN7u80
        NyOsogAB+VVznUacc57svWbP5etc2TIsSqp0=
X-Received: by 2002:ad4:5f87:0:b0:5e9:48da:9938 with SMTP id jp7-20020ad45f87000000b005e948da9938mr38521qvb.11.1686064970026;
        Tue, 06 Jun 2023 08:22:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4T0xOlBQzMtc3qXbC4d6er6na+A1RC2ABHqco+T9hrxtzknSkrv3zb+4uWGLWGglMCQkCKyQ==
X-Received: by 2002:ad4:5f87:0:b0:5e9:48da:9938 with SMTP id jp7-20020ad45f87000000b005e948da9938mr38499qvb.11.1686064969774;
        Tue, 06 Jun 2023 08:22:49 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id s9-20020a0cf789000000b005dd8b934579sm5443559qvn.17.2023.06.06.08.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:22:49 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:22:35 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 09/10] Added code to check if the proc/net/if_inet6
 file exists while loading IPv6 addresses in the IPv6Addresses class
In-Reply-To: <20230601202734.813515-10-ashelat@redhat.com>
Message-ID: <7cf09341-9f6e-cc2-6f77-eeffa1b7c2da@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com> <20230601202734.813515-10-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 1 Jun 2023, Anubhav Shelat wrote:

> Added code to check if the proc/net/if_inet6 file exists while loading IPv6 addresses in the IPv6Addresses class. If it doesn't, then the system has IPv6 disabled, and that chunk of code is passed.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/sysinfo/newnet.py | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/rteval/sysinfo/newnet.py b/rteval/sysinfo/newnet.py
> index 63417d9e59f1..2911400ceb6c 100644
> --- a/rteval/sysinfo/newnet.py
> +++ b/rteval/sysinfo/newnet.py
> @@ -72,19 +72,23 @@ class IPv6Addresses():
>              and a list of ipv6addresses
>          '''
>          MYP = '/proc/net/if_inet6'
> -        with open(MYP, 'r') as f:
> -            mystr = f.readline().strip()
> -            while len(mystr) > 0:
> -                ipv6addr , _, _, _, _, intf = mystr.split()
> -                ipv6addr = compress_iv6(ipv6addr)
> -                if intf == 'lo':
> -                    mystr = f.readline().strip()
> -                    continue
> -                if intf not in self.data:
> -                    self.data[intf] = [ipv6addr]
> -                else:
> -                    self.data[intf].append(ipv6addr)
> +        try:
> +            with open(MYP, 'r') as f:
>                  mystr = f.readline().strip()
> +                while len(mystr) > 0:
> +                    ipv6addr , _, _, _, _, intf = mystr.split()
> +                    ipv6addr = compress_iv6(ipv6addr)
> +                    if intf == 'lo':
> +                        mystr = f.readline().strip()
> +                        continue
> +                    if intf not in self.data:
> +                        self.data[intf] = [ipv6addr]
> +                    else:
> +                        self.data[intf].append(ipv6addr)
> +                    mystr = f.readline().strip()
> +        # if IPv6 is disabled, the if_net6 files does not exist, so we can pass
> +        except FileNotFoundError:
> +            pass
>  
>  class IPv4Addresses():
>      ''' Obtains a list of IPv4 addresses from the proc file system '''
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

