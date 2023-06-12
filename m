Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D787BC7EE2F
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Jun 2023 18:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjFLSkd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjFLSkT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2023 14:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A9FE6B
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686595177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LVORjZhDWoqfD05f0P8T04QGTAK75Vgorozmu3XrM6s=;
        b=P9mlYs5+9mDhmiwn5R51JYYkQrw98i5iYWWt8UbLyJsruesuaq1i11y34+CZEtAcxyXTRc
        Puyv8XPK7mwN3wZXt/A69R/Nry8EltYB97mfPEf14DSa1fOAG8zifdjo+xUZ6yU5JV4o9u
        MLTAn+uLCkhK6vgcxCxLTMt5k0/HgPA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-tlAZJTZKMai2ehIzo7ILWw-1; Mon, 12 Jun 2023 14:39:36 -0400
X-MC-Unique: tlAZJTZKMai2ehIzo7ILWw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75d51a46b63so31587085a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686595175; x=1689187175;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVORjZhDWoqfD05f0P8T04QGTAK75Vgorozmu3XrM6s=;
        b=Cj6XSUqh3SdXeZb3jbMX25LIEZ5IElEhkDp1eJ7UntQsiHTJpYqIXKOv1UQutH7uRv
         WHVFGXXnKOuxbvK+6RV6/Zf4oMaXkuBGWHDX7q//u7WLJ06a/p0xhJbBIY4XmEm6W0SX
         1s0XtJSMYtH1OpVvxKcDOF0nILoeft2IvLcA2YYP1gCjeJ9hixSs4VkonrVHIWUpTjZQ
         KmFV+by+EjcPAkZmEIRWpRzEnrh4XXqhN2IYDNp7+Xqq1sYh/a7UmsxtSLeaP7dqMzQI
         QMIWGgAr9LkNda/O6YlhngiEu1qtbhuES4y9PZ+rRQqghLTOYFmkmKac1LXYA55KoU7c
         RShg==
X-Gm-Message-State: AC+VfDzM8tAE0ILIe7U2eilZxOd6nEr25xH5CB/NEhBWxaSJUuNUOD+O
        Dr1hKFshbIf5bpoLgGBo0mPOGyBwu3e8CVJwJcyNBUQoCxJJtt90L5opXK2HTC9LNnpVTsDkQgB
        i9q3vAH+OQJfhNt2gCwSG5umt3B/jX4lnpIc=
X-Received: by 2002:a37:6844:0:b0:75b:23a1:3629 with SMTP id d65-20020a376844000000b0075b23a13629mr11000993qkc.58.1686595175512;
        Mon, 12 Jun 2023 11:39:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5iwXIWmYkkkqqegOH8/SK9Gyz+W1atsmPhwMbmgptwoJ+rKDsq0iiaSJWHV6Vv5JdgLNcYjg==
X-Received: by 2002:a37:6844:0:b0:75b:23a1:3629 with SMTP id d65-20020a376844000000b0075b23a13629mr11000982qkc.58.1686595175267;
        Mon, 12 Jun 2023 11:39:35 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id oo24-20020a05620a531800b007617ebce28dsm22385qkn.67.2023.06.12.11.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:39:34 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:39:33 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 05/10] rteval: Use f-strings in memory.py
In-Reply-To: <20230601202734.813515-6-ashelat@redhat.com>
Message-ID: <ad27e14-24d9-6db-11be-cac5de61caf@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com> <20230601202734.813515-6-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

o

On Thu, 1 Jun 2023, Anubhav Shelat wrote:

> Use f-strings in memory.py
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/sysinfo/memory.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/rteval/sysinfo/memory.py b/rteval/sysinfo/memory.py
> index 7c5fd6f315cf..cc2fa2cfa4be 100644
> --- a/rteval/sysinfo/memory.py
> +++ b/rteval/sysinfo/memory.py
> @@ -49,7 +49,7 @@ class MemoryInfo:
>              if l.startswith('MemTotal:'):
>                  parts = l.split()
>                  if parts[2].lower() != 'kb':
> -                    raise RuntimeError("Units changed from kB! (%s)" % parts[2])
> +                    raise RuntimeError(f"Units changed from kB! ({parts[2]})")
>                  rawsize = int(parts[1])
>                  f.close()
>                  break
> @@ -76,7 +76,7 @@ class MemoryInfo:
>  
>          memsize = self.mem_get_size()
>          mem_n = libxml2.newNode("memory_size")
> -        mem_n.addContent("%.3f" % memsize[0])
> +        mem_n.addContent(f"{memsize[0]:.3f}")
>          mem_n.newProp("unit", memsize[1])
>          rep_n.addChild(mem_n)
>  
> @@ -88,8 +88,8 @@ def unit_test(rootdir):
>      import sys
>      try:
>          mi = MemoryInfo()
> -        print("Numa nodes: %i" % mi.mem_get_numa_nodes())
> -        print("Memory: %i %s" % mi.mem_get_size())
> +        print(f"Numa nodes: {mi.mem_get_numa_nodes()}")
> +        print(f"Memory: {int(mi.mem_get_size()[0])} {mi.mem_get_size()[1]}")
>      except Exception as e:
>          import traceback
>          traceback.print_exc(file=sys.stdout)
> -- 
> 2.31.1
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

