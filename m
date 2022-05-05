Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50DDC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 May 2022 14:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378668AbiEEOhx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 May 2022 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349341AbiEEOhx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 May 2022 10:37:53 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E03F5AA6B
        for <linux-rt-users@vger.kernel.org>; Thu,  5 May 2022 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651761252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hmtDhBMpBNP5F1NbebqjSDQRe35h2O8vk+AARiw6T5E=;
        b=YJedeNum74trgZTPz++DsqBUbgs9nQnguTVSH7JyzpZvtlf2kn2k88V2v4SlTBGgM+lnCS
        5odW230kStbAECy6Ws2q1zXl/cbroLL7gF40KgIgM/Xnz6wQmJkLVRXMWJlY9wbBECtYSV
        svS/dCMbqKdBMknYbpdgp36EEWNK+O4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-rgMRcabkMiuK7UEw61ejNw-1; Thu, 05 May 2022 10:34:11 -0400
X-MC-Unique: rgMRcabkMiuK7UEw61ejNw-1
Received: by mail-qt1-f197.google.com with SMTP id w2-20020ac87e82000000b002f3a6e81a56so3481231qtj.14
        for <linux-rt-users@vger.kernel.org>; Thu, 05 May 2022 07:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=hmtDhBMpBNP5F1NbebqjSDQRe35h2O8vk+AARiw6T5E=;
        b=BdTXNSnG+tJjIKchKr+NzT2gXrgleO2DhfeZ4bmS0SqyuUswn2WAuarA2AfnfxtiOQ
         7JJAoo76suws8vJ945TSrvwhGzvP/Q+LhpBjGm8y2b4tX59UOZtneqfrBNPc7+jNoRp+
         7R0zmfyxxeazW3E4jiTpuWNWPdenrR+2St9rgdeEC6ob/lz7aLLzqj5LkjMzAYZXJ6CA
         jly3mh1l+Q0+ZvLTDrkECKV42ZA9oXDcy5Qptna+xCosKFU/+giLSakqh6uHGASE/pd1
         SWWadhXkdnx2DltUn+TVMgUGpzpqRo1mKOVSf5+OHKOd39Vn26mJF/W7aSTbGVrBQjWa
         tTSA==
X-Gm-Message-State: AOAM533XHizJAbcFROQZuimNv/kIZ4KFKFLlo+5kTZFSyUR3rgH3jDW4
        R5MDDI8XW8I8o+eji5SqxuufgdoShzVKRdMwMVWZxRtQXy6wFqc+/DiJpvyv+Vi4/8RClL0rCxx
        J9450DcUy/+lmTTUfGTFn7N3UYTw=
X-Received: by 2002:a0c:f68f:0:b0:456:38b0:7b9c with SMTP id p15-20020a0cf68f000000b0045638b07b9cmr21939937qvn.26.1651761250642;
        Thu, 05 May 2022 07:34:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzguvlWSe1PUpWpzP0teBMYdaixDLtT/DuapZLUiRWzDywRjiSEM77p8zqPiHFEYCqSomEOpg==
X-Received: by 2002:a0c:f68f:0:b0:456:38b0:7b9c with SMTP id p15-20020a0cf68f000000b0045638b07b9cmr21939917qvn.26.1651761250469;
        Thu, 05 May 2022 07:34:10 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id bj32-20020a05620a192000b0069fc2a7e7a5sm851967qkb.75.2022.05.05.07.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:34:09 -0700 (PDT)
Date:   Thu, 5 May 2022 10:33:48 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rteval: kcompile: Fix source tarball argument handling
In-Reply-To: <20220503110106.40564-1-vschneid@redhat.com>
Message-ID: <21467ee5-7dd1-645c-36fa-512a1e8f1799@redhat.com>
References: <20220503110106.40564-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 3 May 2022, Valentin Schneider wrote:

> Kcompile._WorkloadSetup() looks for a "tarball" and "tarfile" entry in
> the CfgSection, but I couldn't find a single setter for thoses. The
> only way for a user to specify a file is via --kcompile-source, which
> doesn't seem to be actually used by the module.
> 
> Make Kcompile actually use --kcompile-source.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  rteval/modules/loads/kcompile.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 367f8dc..023b9d6 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -28,6 +28,7 @@ import sys
>  import os
>  import os.path
>  import glob
> +import re
>  import subprocess
>  from rteval.modules import rtevalRuntimeError
>  from rteval.modules.loads import CommandLineLoad
> @@ -35,7 +36,7 @@ from rteval.Log import Log
>  from rteval.misc import expand_cpulist, compress_cpulist
>  from rteval.systopology import SysTopology
>  
> -kernel_prefix = "linux-5.13"
> +DEFAULT_KERNEL_PREFIX = "linux-5.13"
>  
>  class KBuildJob:
>      '''Class to manage a build job bound to a particular node'''
> @@ -163,17 +164,19 @@ class Kcompile(CommandLineLoad):
>              return
>  
>          # find our source tarball
> -        if 'tarball' in self._cfg:
> -            tarfile = os.path.join(self.srcdir, self._cfg.tarfile)
> +        if self._cfg.source:
> +            tarfile = os.path.join(self.srcdir, self._cfg.source)
>              if not os.path.exists(tarfile):
>                  raise rtevalRuntimeError(self, " tarfile %s does not exist!" % tarfile)
>              self.source = tarfile
> +            kernel_prefix = re.search(r"linux-\d\.\d", self.source).group(0)
>          else:
> -            tarfiles = glob.glob(os.path.join(self.srcdir, "%s*" % kernel_prefix))
> +            tarfiles = glob.glob(os.path.join(self.srcdir, "%s*" % DEFAULT_KERNEL_PREFIX))
>              if tarfiles:
>                  self.source = tarfiles[0]
>              else:
>                  raise rtevalRuntimeError(self, " no kernel tarballs found in %s" % self.srcdir)
> +            kernel_prefix = DEFAULT_KERNEL_PREFIX
>  
>          # check for existing directory
>          kdir = None
> -- 
> 2.27.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

