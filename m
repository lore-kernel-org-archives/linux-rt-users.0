Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B219C433FE
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 May 2022 10:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbiECKap (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 May 2022 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiECKam (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 May 2022 06:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E8F41EEFA
        for <linux-rt-users@vger.kernel.org>; Tue,  3 May 2022 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651573628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4Z/N1Bbqxi55EHCBoqJlrBOal5vlH6tL6vj/qcCpbQ=;
        b=DqfdiDVg1C5/ElEPRtmIIxxWYPgMdmLPPqL/Q7eaTl7EKqnOkr4rdWRII9tAHWZFjDmFmA
        //SoqM81wNa308mva506LZcoZCm29mXkpKToHAaVwJQLriRrkTGzhsjOzfKfY07ahcDOOP
        6HONOHoL8ti3vhD5+bAOSh1zCRGLYfA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-Ywb6Xl_cOAiF8T4YgG0XfQ-1; Tue, 03 May 2022 06:27:07 -0400
X-MC-Unique: Ywb6Xl_cOAiF8T4YgG0XfQ-1
Received: by mail-wm1-f70.google.com with SMTP id p32-20020a05600c1da000b00393fbf9ab6eso1159230wms.4
        for <linux-rt-users@vger.kernel.org>; Tue, 03 May 2022 03:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x4Z/N1Bbqxi55EHCBoqJlrBOal5vlH6tL6vj/qcCpbQ=;
        b=p8/KptBXxiCpcKrHJ4EkjG7GbSwUlBD/2R2OtAmAnJS/XRPtsUP1glVbISnuElcQMB
         acT+2GU1qzr3jL8blUsxSUQu51HR+hCO/k112VQhI9+lSdVMcK2s12Z0CVk0HC42Q3LT
         XXwjUSwRKEINdBsknJ+ZGN0H23xdDbOSokGYSA/8gLf0vhaAaOgE3F+QiTLnP2IW+KzM
         Gjw7WmYXUqJdwHAkEkfm/dg5gXLCuM4W0wD2Zzh0TZkJ/3WQDPEZX/WuSuxUrBlyTbxM
         wgeTmrq9X5AU5LhV+vQpqbbKoxi4U25larX+dg7H5Fs8M+IB/eNCTwfaSLWe37lD+cpx
         4vlw==
X-Gm-Message-State: AOAM533kabMjBGAort8FTqQLx+Vp5P70rt4aDkj8Q43bTyNajBDprOgu
        VpTqhK3yzXxLZHs9ElpI+xk/6FGm4ILoFDkz/3qhUY0EA+NbYGul8dwwi8GdGY+F7Y+/ZvSaYzp
        9hfQO6VBMTKYt+FdDdW+woBmhizY=
X-Received: by 2002:a5d:408d:0:b0:20a:ce37:1306 with SMTP id o13-20020a5d408d000000b0020ace371306mr12364660wrp.215.1651573626187;
        Tue, 03 May 2022 03:27:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOFndpqOlZOH5gm24W4IqU9jXq5WYKHbLSfLw6mB8eFr9vhvxsxuYawg23PYi6qUpvPBZqnw==
X-Received: by 2002:a5d:408d:0:b0:20a:ce37:1306 with SMTP id o13-20020a5d408d000000b0020ace371306mr12364645wrp.215.1651573626006;
        Tue, 03 May 2022 03:27:06 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b0020c5253d924sm8829886wra.112.2022.05.03.03.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:27:05 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rteval: kcompile: Use systopology to get a list of cpus
 on a node
In-Reply-To: <20220429202202.23499-1-jkacur@redhat.com>
References: <20220429202202.23499-1-jkacur@redhat.com>
Date:   Tue, 03 May 2022 11:27:04 +0100
Message-ID: <xhsmhlevivrlz.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 29/04/22 16:22, John Kacur wrote:
> kcompile gets a lists of cpus on a node but doesn't take into account
> whether the cpus are online or not.
>
> Instead of using the method in kcompile, use the method in systopology,
> since that will consider whether the cpus are online or not.
>
> Reported-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: John Kacur <jkacur@redhat.com>

Tested-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  rteval/modules/loads/kcompile.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 367f8dc1ca86..add0cd86cde4 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -202,7 +202,7 @@ class Kcompile(CommandLineLoad):
>          self.cpus = {}
>          self.nodes = self.topology.getnodes()
>          for n in self.nodes:
> -            self.cpus[n] = [int(c.split('/')[-1][3:]) for c in glob.glob('/sys/devices/system/node/node%s/cpu[0-9]*' % n)]
> +            self.cpus[n] = self.topology.getcpus(n)
>              self.cpus[n].sort()
>
>              # if a cpulist was specified, only allow cpus in that list on the node
> --
> 2.35.1

