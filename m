Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19997C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 May 2022 15:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359468AbiEBPVI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 May 2022 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343519AbiEBPVH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 May 2022 11:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3B95E19
        for <linux-rt-users@vger.kernel.org>; Mon,  2 May 2022 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651504656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVn2KyQtKzyKm/48Hm1HlVWKOL6FYLxTE/WnVU3vThA=;
        b=PI+0YX/DtkUO304d9vkJ19Lpjl6zMq7uP6OtMKsHbOHy7iVMQ6vRjRqp0JcDE8r9FD45D6
        R0Smyuh+JZsVdX+p4NH2Ww7KjXbPbME8QdwSZlKUrnecAE03KYaswHRkt92ytLKn4YXsoW
        H0oQiIIjrWEQVTY/KL8XnRqSUrHwtmA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-SwA_spgAOe20gX70g_tpfQ-1; Mon, 02 May 2022 11:17:36 -0400
X-MC-Unique: SwA_spgAOe20gX70g_tpfQ-1
Received: by mail-qv1-f70.google.com with SMTP id a12-20020a056214062c00b0045a7b4a1a29so4037026qvx.10
        for <linux-rt-users@vger.kernel.org>; Mon, 02 May 2022 08:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=MVn2KyQtKzyKm/48Hm1HlVWKOL6FYLxTE/WnVU3vThA=;
        b=hLOjWwSHcPPGdvf1sA/oAcVUL8/x7mgwOrJXLvhiTSCPfAPAhXNGK7SzhwOF3wh3jM
         mqoBagfqlyNa7O1h8VmPVDTlB7vHc5Cz8Te7Ak0OAllvxEvgPD/f05ahbo4I9NLP9+aB
         CtqnQ8fIE/t9USV+opytMblqQUUcMgVNYJ/vYAPW/qe+QcbutQpMRx3nXHh7fA0+65Io
         BUg8HfuSEaPZ16Pe1WbeLTJeKdw9drAF84M2phzGOz7Ri8VeIMirUObDh+xWo5+5LNzQ
         c5d+PKBzVqgPhHFsjxIXa/9AZ2Evv/mI2exzex01/tpC7LbbqnTPBmsS531tX9vyuYVp
         Wjmg==
X-Gm-Message-State: AOAM530lV9wJgyoPKUFeimwNj24AUdt39DYP6+5tfhBzn1uUi9M6EURZ
        QAyj2xPEXTZ05Q/JfYpfF5Gr2kJ9yI3mKDVSYJUGXp9cDSrG8dQU0wovBuQrAScFHK68CJ+Hybx
        tdEgMBXUAM3pvhIbTUCzciHSlCVQ=
X-Received: by 2002:a05:620a:c86:b0:69f:c7cb:935a with SMTP id q6-20020a05620a0c8600b0069fc7cb935amr7105073qki.229.1651504655597;
        Mon, 02 May 2022 08:17:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDtuj+2Ei9W2KDn4sqjDVeCob8Q2daEGRB1y0RapKNTS5iUm3p0HLoDSXPvCe/oGatgsu/JA==
X-Received: by 2002:a05:620a:c86:b0:69f:c7cb:935a with SMTP id q6-20020a05620a0c8600b0069fc7cb935amr7105059qki.229.1651504655375;
        Mon, 02 May 2022 08:17:35 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id a4-20020ac87204000000b002f39b99f6a8sm4214947qtp.66.2022.05.02.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 08:17:34 -0700 (PDT)
Date:   Mon, 2 May 2022 11:17:18 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rteval: kcompile: Tweak default source tarball
 selection
In-Reply-To: <20220419162142.91470-1-vschneid@redhat.com>
Message-ID: <bea14b39-5875-e180-a714-bc6ed7bf465@redhat.com>
References: <20220419162142.91470-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 19 Apr 2022, Valentin Schneider wrote:

> Kcompile._WorkloadSetup() looks for a "tarball" and "tarfile" entry in
> the CfgSection, but I couldn't find a single setter for thoses. The
> only way for a user to specify a file is via --kcompile-source, which
> doesn't seem to be actually used by the module.
> 
> As it stands, this method will look for a tarball matching the
> hardcoded kernel_prefix.
> 
> Make Kcompile
> - actually use --kcompile-source
> - use the latest tarball in the loadsource if no source is specified.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
> I'm not entirely sure about that one, I tried to dig up the git
> history for uses of those "tarball" and "tarfile" options but didn't
> really get anywhere, so maybe I'm completely wrong...
> ---
>  rteval/modules/loads/kcompile.py | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 367f8dc..2747913 100644
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
> +RE_KERNEL_TAR = re.compile(r"linux-(?P<maj>\d+)\.(?P<min>\d+).*\.tar.*")
>  
>  class KBuildJob:
>      '''Class to manage a build job bound to a particular node'''
> @@ -163,18 +164,27 @@ class Kcompile(CommandLineLoad):
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
>          else:
> -            tarfiles = glob.glob(os.path.join(self.srcdir, "%s*" % kernel_prefix))
> +            tarfiles = [f for f in os.listdir(self.srcdir)
> +                        if RE_KERNEL_TAR.match(f)]
>              if tarfiles:
> -                self.source = tarfiles[0]
> +                # Use (one of) the most recent kernels
> +                def verkey(f):
> +                    match = RE_KERNEL_TAR.match(f)
> +                    return (match.group("maj"), match.group("min"))
> +
> +                tarfiles.sort(key=verkey)
> +                self.source = tarfiles[-1]
>              else:
>                  raise rtevalRuntimeError(self, " no kernel tarballs found in %s" % self.srcdir)
>  
> +        kernel_prefix = re.search(r"linux-\d\.\d", self.source).group(0)
> +
>          # check for existing directory
>          kdir = None
>          names = os.listdir(self.builddir)
> @@ -322,7 +332,7 @@ class Kcompile(CommandLineLoad):
>  
>  def ModuleParameters():
>      return {"source":   {"descr": "Source tar ball",
> -                         "default": "linux-5.13.2.tar.xz",
> +                         "default": "",
>                           "metavar": "TARBALL"},
>              "jobspercore": {"descr": "Number of working threads per core",
>                              "default": 2,
> -- 
> 2.27.0

I think we wanted to make sure we were doing an apples to apples 
comparison, so we restricted the default kernel to the the one we supply 
in rteval-loads. I am thinking of changing this in the future to using the 
one supplied by the distribution, but still mulling this over.

However, --kcompile-source should work as advertised. Do you think you 
could resend a patch with just the part to make --kcompile-source work 
correctly?

Thanks

John


