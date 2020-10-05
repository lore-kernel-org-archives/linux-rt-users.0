Return-Path: <SRS0=wVJd=DM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF01C4363A
	for <linux-rt-users@archiver.kernel.org>; Mon,  5 Oct 2020 19:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FD02100A
	for <linux-rt-users@archiver.kernel.org>; Mon,  5 Oct 2020 19:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMo4t+R9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgJETkz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 5 Oct 2020 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgJETky (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Oct 2020 15:40:54 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7A2C0613CE
        for <linux-rt-users@vger.kernel.org>; Mon,  5 Oct 2020 12:40:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id q26so5426413qtb.5
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2020 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kREpN8rcJJLtCBTQUYiHgZjJZAnrY0I4F3PH4U9ndTE=;
        b=kMo4t+R9fnVLvEtCqYPLlPZma/Q/Mulwc69kjbzVApfmJrgQCvDwMx4/DBVyAWfrTA
         BgP2/kRofzrSph4Izijw5wVMW+ARzmMpP0u7Na4lopHcxBqTgBABUKPCEwdjxOV8CSnk
         dnrfxryVRXg5J7wB1zLzu9xmM6N50vUI9gKJyglDOC70U3tgwbkjfaiEjT1GLqYEZyEA
         2DkbugZSeplRYZeP8b0cL7/p9qjcipDN2dI1f/qcZP3QbJIeXSUsDzmNPaRoqKSTrVBr
         qFcFIFiLGe02O3VLc8q42EVt2on7QQEnUhlc7Sn5xjsliOkfhssoydk81fRRMklRJhlf
         EU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kREpN8rcJJLtCBTQUYiHgZjJZAnrY0I4F3PH4U9ndTE=;
        b=ZMtRqdwRtgd/MeCtYEwQIq8+HXBMWuIsy3r3t3uaEvVrZL8rgChQdG/GfQKaTfSUBg
         H6vspPeZP2dlCOJsO5MhiXGA2c3BnaFgceZlviwMhtO8sUVgSxxjE9BkUiKKi4gBVZzU
         XZo7IcHuIlGWbfrrsu3WmKteA8V+eFY3TBp3lbASan9754yqRyNKFT9wlw8SDe47uMdF
         er4Ec6M1+2hx4AJeRjdwaH5Q5vLMtiRJ5zkEcXQkRpDqBXuuO7hj6g9NxxYl8ZyWCyCs
         01AXtfYHg27Ig2i7YewME/frlpgb6xIPmLg28nCrf8m6RskdL84YjID++SC5hSqAbOli
         7DdA==
X-Gm-Message-State: AOAM530APFinn1oPmiZIFLtWIX5AIV7o8HVg7azvOknuVn38XhupU6Q7
        4eUzNholdmksoyEszYESoWEkm2qjjAOk7TYWaco=
X-Google-Smtp-Source: ABdhPJyvX7lDuoiNmFHAM2F3zm+jL3v+xUUsrEJOv1TZtXDkzYPe2PT+cQ6EZ9Uy0GZaoYogpCKZGeiUx29MLrXFUPM=
X-Received: by 2002:ac8:6a06:: with SMTP id t6mr1548767qtr.1.1601926853729;
 Mon, 05 Oct 2020 12:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200925095715.poa62noo7dq2zyyp@linux-8csb> <20200925151635.dar46x7shgu4nqms@linutronix.de>
In-Reply-To: <20200925151635.dar46x7shgu4nqms@linutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 5 Oct 2020 21:40:42 +0200
Message-ID: <CAFLxGvziCBYp4qNZQnnmjbuV9TZ5_20A5QQwAQAdd1yTaf1rbw@mail.gmail.com>
Subject: Re: Debugging reboot freeze
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Aaron Marcher <aaron@sigma-star.at>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sebastian,

On Fri, Sep 25, 2020 at 5:18 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> - try a later kernel (v5.9)
> - implement ->write_atomic() and make sure the output goes to
>   printk_emergency() (so the output hits the uart right away).
> - enable lockdep and check what explodes.

thanks a lot for your suggestions.
Testing on 5.9 will happen soon (custom hardware, you know the dance...).
I'm looking right now into implementing >write_atomic() for the i.mx8.

What we found so far:
The root of the problem seems to be in ci_hdrc_remove_device(), called
by ci_hdrc_imx_shutdown().
With ci_hdrc_imx_driver.shutdown being a no-op, reboot works fine.
Peng Fan, does this ring a bell?

The issue seems to be timing sensitive, enabling lockdep makes the
problem go away. :-(

-- 
Thanks,
//richard
