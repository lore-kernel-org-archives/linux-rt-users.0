Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D93EECAAA1
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 Oct 2022 14:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJaOIE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 Oct 2022 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiJaOIC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 Oct 2022 10:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9825E10B4D
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Oct 2022 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667225226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mq/zn5XUM8uoPhN9vYaQtRnxVLN3cHULMoBRhejHVPU=;
        b=QCNJjsh8hAfC+ijVWkGk2qEtN06+u4fdWtLeGks3Hg+dNhpc8g15HXTThA29j/GmhuJ2Mf
        VGw7yQaal0msChhS348Js85b5dYHVO20ZRJAiUT1yP1mKvLhYQGw9H+vOAJcXJ7QYCZ8K+
        k6QP9IZKcobWLicib73tDCIdEz3LVog=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-241-wIm_SdRrMOKnP__Q48_1LQ-1; Mon, 31 Oct 2022 10:07:05 -0400
X-MC-Unique: wIm_SdRrMOKnP__Q48_1LQ-1
Received: by mail-lj1-f200.google.com with SMTP id e23-20020a2e9e17000000b0026e8e74be94so4721180ljk.3
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Oct 2022 07:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq/zn5XUM8uoPhN9vYaQtRnxVLN3cHULMoBRhejHVPU=;
        b=HcetOLgO1er34cpqMFzR/5bWorioJCpybAL8ENbULpy0bmoxn1qPLivDwQgxlOCLCo
         pO/7tT5tT3GE8eUPdZz30tkylMilS9eE4dlcdzVk6OseGQKTcYHeq7Asn+Vc4JtY4Up1
         erFUdyclDECsDaAXhARxmnxvTSFlMmu8Y5vu39EuIFjXwkNHpqJDSa/16hh5MIHkE2+P
         ZGyD1viXwEr790tzIcwpdetK8MWgm8Ae0hOsCUAzjKFRDqwWdr+7Kis/tR7m9oypL0Md
         xxVORsw1uToOHIs9/P9NQzNkTqRq6YnwAn43qF3hmzj2GIG3MU9oegPwEbQTcHrjo4XV
         /jBA==
X-Gm-Message-State: ACrzQf13wSnuCOddshNjdQC9HhVV8eBen1I6oILpvKcmcDeQRg4abqAn
        hmM0tGgwoJF3RgY7u3MzCqYOCgw0tVGTSXErVPWkMXGzVqe/Sksz5/+CoIOfMj6W6JzzCio/WBf
        a93qJo0W6YwADYRFZ6B+Zy211miw760bt+46geSBErtA=
X-Received: by 2002:a19:a40d:0:b0:4b0:144:a246 with SMTP id q13-20020a19a40d000000b004b00144a246mr5258247lfc.416.1667225223871;
        Mon, 31 Oct 2022 07:07:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4nP4VuPVv+KnmBgDYg3Uvd6e/+CwmE7wzskgnpclP548X5qkDALuIJZA47pQQPTLocxmcIA3FxdFGgrz+fygY=
X-Received: by 2002:a19:a40d:0:b0:4b0:144:a246 with SMTP id
 q13-20020a19a40d000000b004b00144a246mr5258230lfc.416.1667225223647; Mon, 31
 Oct 2022 07:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <Y1o8hqwQKDpOTkNr@linutronix.de> <649af0f6-e5e2-c450-879c-e9153e0c0abc@arm.com>
 <Y1/NFIjRFZzszZB6@linutronix.de>
In-Reply-To: <Y1/NFIjRFZzszZB6@linutronix.de>
From:   Clark Williams <williams@redhat.com>
Date:   Mon, 31 Oct 2022 14:06:52 +0000
Message-ID: <CAMLffL_VY52DAHxVO_BE=nAjXwzvq-jmAOO4JwDT3vw3sHy15A@mail.gmail.com>
Subject: Re: [ANNOUNCE] v6.0.5-rt14
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, stable-rt@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I can pick them up for v5.19-rt

On Mon, Oct 31, 2022 at 1:28 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-10-28 11:47:28 [+0200], Pierre Gondois wrote:
> > Hello Sebastian,
>
> Hi Pierre,
>
> > About the issues Valentin reported:
> >
> > - [SPLAT 1/3] arm_pmu: Sleeping spinlocks down armpmu_alloc_atomic()
> > will be fixed by:
> > https://lore.kernel.org/all/20220930111844.1522365-1-mark.rutland@arm.com/
>
> This is still pending and I don't see it in next. Could someone give me
> a ping once this is merged, please?
>
> > - [SPLAT 2/3] irqchip/gic-v3-its: Sleeping spinlocks down gic_reserve_range()
> > was fixed by:
> > https://lore.kernel.org/lkml/20211027151506.2085066-3-valentin.schneider@arm.com/
>
> That is
>    d23bc2bc1d634 ("irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve")
>    v5.17-rc1
>
> > - [SPLAT 3/3] gpio: dwapb: Sleeping spinlocks down IRQ mapping
> > was fixed by:
> > https://lore.kernel.org/all/20220419012810.88417-1-schspa@gmail.com/
>   3c938cc5cebcb ("gpio: use raw spinlock for gpio chip shadowed data")
>   v5.19-rc1
>
> Is someone picking the two up or RT-stable?
>
> > Regards,
> > Pierre
>
> Sebastian
>

