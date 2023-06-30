Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D9BEB64D7
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 17:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjF3Rs2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjF3Rs1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 13:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA36273B
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688147256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yu1LZ7f2hecV5slOcXZ1i95xyHHi6BHj1YI69GGMkEo=;
        b=TYlc5Taaz1MLdoPg0zgL7/z5PYToH6G+XcyFUVWIzpHNb1n9rdH+5juDTiBX4ls0aaojod
        L5oO025h28wAw4QzlYlsIvYVeGL9MZlw1ogIHwMi6slmQs9vzJxWqGxM19ptzYS4OAdD80
        WVjQj0/r+7NugS/FEbUbsIppiWo8ICY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-jotHjCywNVibenLGBnobBg-1; Fri, 30 Jun 2023 13:47:35 -0400
X-MC-Unique: jotHjCywNVibenLGBnobBg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-763c36d4748so203990385a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 10:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688147255; x=1690739255;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yu1LZ7f2hecV5slOcXZ1i95xyHHi6BHj1YI69GGMkEo=;
        b=cSFpgGQrZ6r4VWUV3JqhRrpwuZNZY5z2Au6FLQNnpAe3EFqqiXVVlca//pYpHUnMQv
         HgNmxwubgT+2fYv5nrucIaOAnz03a/cfxX5Dbu2gH9GqxnvB5iEdHhm/DDX7v68uK6Tb
         ZxtvKAaVLBxcYIk0lYg7TTcwysFuFEVh2Dl0/QBOQ8Fc2veMSLyrBqxoQrelyqn+hSHg
         VSM0VRRwHSaw5gOme79Vakax2AZPSRqwQbusiT8o+Y0p3esgd9RoYhBcmvCSFVsmp1sw
         d6/Agq8W+OLyC7ahZcU5rUnhVYd2QBg2miCm/HlvftJoFY9vQgFO01j+Cu8+qspC/NE8
         eZdA==
X-Gm-Message-State: AC+VfDyTxG5YYkgK2n/8lIzDgFPbkQ+xZ2i/C3S86XAjPKG8AC8PNPw8
        pCSg8B+WwGcmIyonpPqUHhzbhJaIRbaB0fj9cy517PXgEu0ymKWMNAQDls/TwAq+QxYY3cuSqZv
        hLeJGIgGmeTMxJzCXNpjbE0MrcOk=
X-Received: by 2002:a05:620a:2954:b0:767:29d3:b87 with SMTP id n20-20020a05620a295400b0076729d30b87mr3871407qkp.33.1688147254889;
        Fri, 30 Jun 2023 10:47:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZhrGnWwT2tkZLjDldX0Rfkuh+YexiJlUyp1SY4j4lRtLvGyFdpGCYuIFFlc/5x4to3dXarw==
X-Received: by 2002:a05:620a:2954:b0:767:29d3:b87 with SMTP id n20-20020a05620a295400b0076729d30b87mr3871395qkp.33.1688147254657;
        Fri, 30 Jun 2023 10:47:34 -0700 (PDT)
Received: from fionn ([184.147.141.56])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a167500b0076211938e93sm2623225qko.46.2023.06.30.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:47:34 -0700 (PDT)
Date:   Fri, 30 Jun 2023 13:47:25 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH v3 1/2] Fixed bug in kcompile where run would fail if
 kcompile-source version had the form x.y instead of x.y.z
In-Reply-To: <20230630171017.1072241-1-ashelat@redhat.com>
Message-ID: <df908c3c-bedd-72c8-842-871d773314e4@redhat.com>
References: <20230630171017.1072241-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 30 Jun 2023, Anubhav Shelat wrote:

> Fixed bug in kcompile where run would fail if kcompile-source version
> had the form x.y instead of x.y.z
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/modules/loads/kcompile.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 35ee5cbbb52d..92442468febf 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -175,7 +175,7 @@ class Kcompile(CommandLineLoad):
>          if 'rc' in self._cfg.source:
>              tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", self._cfg.source).group(0)
>          else:
> -            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", self._cfg.source).group(0)
> +            tarfile_prefix = re.search(r"(\d{1,2}\.\d{1,3}\.\d{1,3})|(\d{1,2}\.\d{1,3})", self._cfg.source).group(0)
>  
>          # either a tar.xz or tar.gz might exist. Check for both.
>          xz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.xz" )
> @@ -193,7 +193,7 @@ class Kcompile(CommandLineLoad):
>          # find our source tarball
>          if self._cfg.source:
>              self.source = self._find_tarball()
> -            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
> +            kernel_prefix = re.search(r"(linux-\d{1,2}\.\d{1,3}\.\d{1,3})|(linux-\d{1,2}\.\d{1,3})", self.source).group(0)
>          else:
>              tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
>              if tarfiles:
> -- 
> 2.39.3
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks

