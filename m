Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D921C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Mar 2022 15:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbiC1PI5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Mar 2022 11:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiC1PI4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Mar 2022 11:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7859C5046C
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Mar 2022 08:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648480035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=65aLt8ZhvM9hS74QjoSFNbVobCiOXK02ylA6S5uGN1w=;
        b=VxZ0pbWjQ6CF6uJz2J9MTxFVrEFIjmeGUE4mUrkSJrcGOXAW1KH9pY7Z+BU9LUi7C+v/di
        GZXH3Ddb8cB1uy1SXjMiO1/dv6zA4pcsjyllEYG9nRhv8GL/jbly21QLJ08nAFQgiAC/mS
        e87yH0z/rOk4v07wJ1//5OSUi/6cpmQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-5220PRLzO-WzJimODBG50w-1; Mon, 28 Mar 2022 11:07:13 -0400
X-MC-Unique: 5220PRLzO-WzJimODBG50w-1
Received: by mail-ej1-f69.google.com with SMTP id de52-20020a1709069bf400b006dffb966922so6973655ejc.2
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Mar 2022 08:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=65aLt8ZhvM9hS74QjoSFNbVobCiOXK02ylA6S5uGN1w=;
        b=U3TVWe65cmcGXIDClxb0aytq0iwk11W7/KBX+GtXIBAbgZMrzXeohzro+LmRIzj+LZ
         lUrb4o2tgaYRYBMTXN/bvLe9fP0/Nsy5drDfKRpuNQA36nSPa1+18cSv7F+X3Be2dNcx
         xbU/9Jt5ZsjBwvtjhFzQCN6VC4b6Ifz7m4FpYuClz8Eu9ygL1c6d5cn+rQz1U11NNGpQ
         szOaNE1EWWoOKNdYFoipr1otA9A6YUtKni08+EttuE7wT2ePjnwN2r2sR2oHox++Pi/s
         iKzyn8REDoUm/alMxSRIXkhC81TJ0NkLnItNF0q6SWzYk4310qQz52Cx/a9iTM7W0LPc
         5GUw==
X-Gm-Message-State: AOAM532BmrqDdaBZpi3LMpKGWJWQgWTQF7/KVEn+bjC9f0MabGYXk8Md
        9LGOUDofwcBQAUn2nAafFnRUIJ/l0imjE17x1D31PQL1IuNRfxgEK0Erak0jJjGQNAYiKX5yYwm
        ydTxhTA/tIBdGraitqtgwY8QKe6w+WDpGvnx8Mr+Vz0o=
X-Received: by 2002:a17:906:4795:b0:6e0:78b8:42f6 with SMTP id cw21-20020a170906479500b006e078b842f6mr26438451ejc.88.1648480032168;
        Mon, 28 Mar 2022 08:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5JIVcu10MnLQ2zZbEZGlm2/CmisXHiX0sjcMq7UiEgLvtZvBcGeZR9EJPLBpE9qS+ywuYoPsEa3R8ahh8cpU=
X-Received: by 2002:a17:906:4795:b0:6e0:78b8:42f6 with SMTP id
 cw21-20020a170906479500b006e078b842f6mr26438422ejc.88.1648480031836; Mon, 28
 Mar 2022 08:07:11 -0700 (PDT)
MIME-Version: 1.0
From:   Bart Wensley <bwensley@redhat.com>
Date:   Mon, 28 Mar 2022 11:07:05 -0400
Message-ID: <CAGCuPdNVEtSk0jqL+74RiV5YcHmdHzsAOcAu_DqLSdhh4h6-aA@mail.gmail.com>
Subject: Cyclictest doesn't support --smi option for ice lake processors
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Using the --smi option with cyclictest on ice lake processors gives
the following error:
FATAL: SMI counter is not supported on this processor

It looks like the ice lake model (0x6A) is missing from function
has_smi_counter:
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/cyclictest/cyclictest.c#n410

Before submitting a patch for this, I was just wondering if there was
a better way to handle this than having to update cyclictest every
time a new processor model is released?

Bart

