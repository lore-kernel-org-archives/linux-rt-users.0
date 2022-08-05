Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E13C00140
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 15:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbiHEPfw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 11:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiHEPfu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Aug 2022 11:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0744FD20
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Aug 2022 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659713747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHO1itvPqRAlrc3LEDFoJ+A0mT1nAmwz7EvMFV0CCX4=;
        b=XNDAGsGkI62BKzp3jQAw/o70KSh10kid4wcEcNijEb+mQhYexPAOUv6Du+dwX2/5lEbZ0O
        VZqZ7pboGQVumxL/9i8maEIqJTGQi5bYhr2aqpMxrEqVleTSp0GsnPAQT9CVAZtC99Up/U
        S64SHMW11eSAJQJhK5f6Twc1pGTaMg8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-dYYXNN2xOT2BVVbnBw__zQ-1; Fri, 05 Aug 2022 11:35:46 -0400
X-MC-Unique: dYYXNN2xOT2BVVbnBw__zQ-1
Received: by mail-qk1-f198.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so2237139qkp.20
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Aug 2022 08:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=sHO1itvPqRAlrc3LEDFoJ+A0mT1nAmwz7EvMFV0CCX4=;
        b=TuMROVAkUIi1DtF4EnhHqUXEmeqWJy1P300BvTEJtUSenQ8kUNgHSdXMfezfW5KOhk
         aXoyhlp13iWqcWrlHe4HvqI9zdOH28mm9qwmIyhJwPJrdIAFc3xr021X4rCQaR18rxCw
         GZUiGepEgR40MwdUs6bIJ0v4VR2TO3jot85jLP20GOtCJEGHRRZYfPq4yJkgUvup/oa+
         gOQgYw7pWlStfq9WSW67T0Iq7YQD2RrbPYw1PrICTHu2yvePgrIJfg3hInJBfY2yBy45
         OCFqZQfH4CY1tLaWL7PGleviiXjDVtpM1FqC4Gkz2OCwnCWyuSCcQcGAEHD+STGpWf+9
         qSIw==
X-Gm-Message-State: ACgBeo0GBFh+dDwZ8D+4s1f6l5JGK+sGmNYpk6vlMTmcG7T+66D/skCZ
        ceAnxQkVeWrM5gaZgQRbQVc1zTpCDGEk+aOb6Qg40qQ/zB9r+wEf/PLDSk7jGPRJxHr41p3eVuy
        XBfYis3is+hxfE+avdQqgAjCHI/Q=
X-Received: by 2002:a0c:8bd2:0:b0:474:7d1a:eb5b with SMTP id a18-20020a0c8bd2000000b004747d1aeb5bmr6027380qvc.18.1659713745891;
        Fri, 05 Aug 2022 08:35:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4bl34k6JuVyQH5jjd6IgWVNpNJLqhtZYVj/y5tpxSS0mgSsWxwA35QFpZzvFMQPWyqjVeahA==
X-Received: by 2002:a0c:8bd2:0:b0:474:7d1a:eb5b with SMTP id a18-20020a0c8bd2000000b004747d1aeb5bmr6027366qvc.18.1659713745662;
        Fri, 05 Aug 2022 08:35:45 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id dm16-20020a05620a1d5000b006b8cb64110bsm3352894qkb.45.2022.08.05.08.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:35:44 -0700 (PDT)
Date:   Fri, 5 Aug 2022 11:35:18 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Manasi Godse <magodse@redhat.com>
cc:     linux-rt-users@vger.kernel.org, lleshchi@redhat.com,
        kcarcia@redhat.com, gmanasi13@gmail.com
Subject: Re: [PATCH] rteval: enhancement to --kcompile-source option for
 kernel tarball
In-Reply-To: <20220805003219.1248947-1-magodse@redhat.com>
Message-ID: <927ccc3-3beb-d923-abd4-a5e63b2a8c3@redhat.com>
References: <20220805003219.1248947-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 4 Aug 2022, Manasi Godse wrote:

> The --kcompile-source option is enhanced such that it can find the
> kernel source tarballs using the values as 'linux-5.18.1' , '5.18.1',
> 'linux-5.18.1.tar.xz' This eliminates the need to type the entire
> source filename as a value to the option. The enhancement will look for
> the tarballs in the loadsource directory.
> 
> Signed-off-by: Manasi Godse <magodse@redhat.com>
> ---
>  rteval/modules/loads/kcompile.py | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 6dd8d940f8b3..7d78d0ff9cae 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -166,16 +166,33 @@ class Kcompile(CommandLineLoad):
>              raise rtevalRuntimeError(self, \
>                  f"error removing builddir ({self.buildir}) (ret={ret})")
>  
> +    def _find_tarball(self):
> +       # If the user specifies the full kernel name, check if available
> +        tarfile = os.path.join(self.srcdir, self._cfg.source)
> +        if os.path.exists(tarfile):
> +            return tarfile
> +
> +        if 'rc' in self._cfg.source:
> +            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", self._cfg.source).group(0)
> +        else:
> +            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", self._cfg.source).group(0)
> +
> +        # either a tar.xz or tar.gz might exist. Check for both.
> +        xz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.xz" )
> +        gz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.gz" )
> +        if os.path.exists(xz_file):
> +            return xz_file
> +        elif os.path.exists(gz_file):
> +            return gz_file
> +        raise rtevalRuntimeError(self, f"tarfile {tarfile} does not exist!")
> +
>      def _WorkloadSetup(self):
>          if self._donotrun:
>              return
>  
>          # find our source tarball
>          if self._cfg.source:
> -            tarfile = os.path.join(self.srcdir, self._cfg.source)
> -            if not os.path.exists(tarfile):
> -                raise rtevalRuntimeError(self, f" tarfile {tarfile} does not exist!")
> -            self.source = tarfile
> +            self.source = self._find_tarball()
>              kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
>          else:
>              tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
> -- 
> 2.31.1
> 
> 
Reviewed-by: Leah Leshchinsky <lleshchi@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>

