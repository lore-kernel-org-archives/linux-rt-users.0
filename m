Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE88C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Oct 2022 14:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJJOU6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJJOU5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Oct 2022 10:20:57 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AB373312
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Oct 2022 07:20:56 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id f4so3977564uav.3
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Oct 2022 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=epkR4Wr9snpgPu3pCkXw6/dz+Jd6FV65TjxpEY2f1KA=;
        b=dQPu2bUaNtCdCMDlASDNs++xbzMtJyRz6o2I8CjOjPGtv79PCAuuOKN9dbzaw/+UMw
         Gw8PuAQ+3S7ZgJNMcLlSfi8+h4hiA59jGTnW5yiSL+PV2JIeTOh9Zf2DCB1gpP6djAX5
         aR1ZML7lvkdCPJ62urm2UyOryzAqH/7Xr3Yvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epkR4Wr9snpgPu3pCkXw6/dz+Jd6FV65TjxpEY2f1KA=;
        b=wJ2C+7QETH0khe0RGILxS0x+cpQVOMo6DoUwsGuSWvoXQzFZa7ln2POKqmDJwfAv7h
         /EU8bSVIJtaVzDlOQQeMD7Q3YfxhMCLII+uG9q+ELDJTBEyts0ZROmZJK+LyV/lCNCtf
         tw+JG7/lMyvsHEnOdTWPpV+xznqeiV/haN+qxmA+2nnrTXUzUmf1OKRHTGHyQ/8NtZzl
         RnHcBVJFhiSxKMq/YKJaa7nliutSmHicKWFAKtgbshafZr75yncXKd02sUJWlLvPj2I0
         L5zb+3iNXU4aMsfPP57EiBN/2Nl+MQ+u9N8/22utGdyKJZVB/rSSl4g3AVCb17HSpjBX
         Pb6Q==
X-Gm-Message-State: ACrzQf0F3ouTKvOlS3je/TzCPiFzUZs1XWdWOubSdV6LoWSnnjvnoNHo
        25xdCQi+jsL6a/sLt+PvQGAW6+fGcwKFvqXOZvW1qjJ6xf14ug==
X-Google-Smtp-Source: AMsMyM4yT0BxMhQmSNabqoOoModj73lY114umU6uVu2DNMTT9LyDWa4SmafWHGv8zNApAkiyChX8kuP412Q7kJ8OBXg=
X-Received: by 2002:ab0:6053:0:b0:3c0:2a5c:1ac2 with SMTP id
 o19-20020ab06053000000b003c02a5c1ac2mr9559907ual.120.1665411655259; Mon, 10
 Oct 2022 07:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221010140725.125546-1-jkacur@redhat.com>
In-Reply-To: <20221010140725.125546-1-jkacur@redhat.com>
From:   Kate Stewart <kstewart@linuxfoundation.org>
Date:   Mon, 10 Oct 2022 09:20:43 -0500
Message-ID: <CAG_66ZTjb4gs-ZXQGyL+sWxDQV3cF4skdKJDFyF+BXszd84b0g@mail.gmail.com>
Subject: Re: [RFC PATCH] rteval: Replace python-ethtool with inline code
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Oct 10, 2022 at 9:07 AM John Kacur <jkacur@redhat.com> wrote:
>
> This patch adds the file newnet.py which to replace the use of python-ethtool
> The information it generates will appear in the summary.xml
> You can also test the functionality by running
> python rteval/sysinfo/newnet.py
>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  rteval/sysinfo/__init__.py |   3 +-
>  rteval/sysinfo/network.py  | 117 -------------------
>  rteval/sysinfo/newnet.py   | 224 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 226 insertions(+), 118 deletions(-)
>  delete mode 100644 rteval/sysinfo/network.py
>  create mode 100644 rteval/sysinfo/newnet.py

> +++ b/rteval/sysinfo/newnet.py
> @@ -0,0 +1,224 @@
> +''' Module to obtain network information for the rteval report '''
> +#
> +#   Copyright 2022 John Kacur <jkacur@redhat.com
> +#
> +

Please add SPDX license identifier to be explicit about the file's licensing.

Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>
