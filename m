Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED275C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 May 2022 08:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiERIgZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 May 2022 04:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiERIgR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 May 2022 04:36:17 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D91B78D
        for <linux-rt-users@vger.kernel.org>; Wed, 18 May 2022 01:36:16 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f13so575091uax.11
        for <linux-rt-users@vger.kernel.org>; Wed, 18 May 2022 01:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qPRYWH9FC0R/QFAVviwF1QF3Zm7LslrpqMqi6JDsjhY=;
        b=NSTJiLngDsaWkGHoRa8ByWFEOPheL9bXdEZv0cwAJlnFqMierBRG5Vi8SBIwyNWoq6
         PVRXKUfYkwE24gdkAad1Fy2asqqDv3neeBlH0KAx3RkT2nXnN+lWlB+yUPidA1Yb5ENI
         SczJOqQmyCh8BuQF8ZtVfhogShczFvPQ5L3hIX0kZnzwDSFzOsf6AJFYW00t/v8mszIR
         aZn4gSHPqzsRF6ZH/KzQhKKO2LIoZ28E5G7RNCwX70omMvfxb75B7Dj0HWMjuIRVIAG9
         9FQ04JFK7ZJiBfBp3mCYnmvJIivwy7hpXYS6RvyXFsCdXLzZf+EioI2SUtwisNh9gx24
         iclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qPRYWH9FC0R/QFAVviwF1QF3Zm7LslrpqMqi6JDsjhY=;
        b=MDYsyNKk8qJQA+o9OxTwlkc0/QHG0akkGgRPnwg9GM/tqvT15hQm7+i6ZEDQ6IsUlh
         qcWodf5odQaJMx7yhrGU3klglHsEIL1MOPBgBEm3zvsg0217km0l6ZkZddDtKIp6NtnO
         z8IesnwsysYmprKZRmGATSSuzlh6V/L7G1QmPm0ur2XLeznLvzXcbFlvlw+zBPEK5inU
         UgAEEjBbb7hFIoPiB4X7ADRS1MbBeoxBuYSSGxW7yG3AoQzm7qwiYbAi1Hb6BsN07ISe
         Y3GOy4CUzhtS0U6OrO4Q4SKJ/yfHh8zzgJg8BVCCbPue+EFQYoJOhYIwz9MssvOMbXBJ
         uZqA==
X-Gm-Message-State: AOAM533kCi+njdo8cnt/ox5ERkiSY4Mn8RWrg2V6QhEVN3R33aj6KJy+
        H8GvqbfXsMfEdVwMzNgAOhjZIJ9Awi5ERO1hDcT5xTT/Ws4Q8w==
X-Google-Smtp-Source: ABdhPJyZ9gSKcSKuIg0pMd5ZRKAzTtqUrNLY+PCgNhChe6noizt6qVluaR35CczzIC6EOHo9F6T3+vS3wVBBkx2Ni/g=
X-Received: by 2002:ab0:604f:0:b0:368:caa5:41ea with SMTP id
 o15-20020ab0604f000000b00368caa541eamr566000ual.97.1652862975221; Wed, 18 May
 2022 01:36:15 -0700 (PDT)
MIME-Version: 1.0
From:   Florent Carli <fcarli@gmail.com>
Date:   Wed, 18 May 2022 10:36:04 +0200
Message-ID: <CAJuRqcA02DGBGMh4frvkN8ceQbucMaomiUkOXPUGwhQvnesrfQ@mail.gmail.com>
Subject: CONFIG_HZ impact on system load
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

I was surprised to notice that when I change the HZ value in a patched
preempt-rt kernel from 250Hz to 1000Hz, the system load apparently
drops.
On my setup (x86_64, 24 vcores, hosting a few kvm guests, some ceph
services, pacemaker/corosync, ovs, etc.):
- kernel with RT patch, CONFIG_HZ=1000: system load is between 1 and 1.5
- kernel with RT patch, CONFIG_HZ=250: system load is between 3 and 3.5
And just in case it helps:
- kernel without RT patch, CONFIG_HZ=250: system load is between 1 and 1.5

The rest of the system does not change, I'm just switching kernels for
which there is only this config_hz modification...
I tried this on 5.10rt, 5.15rt, 5.16rt...
Everytime I try to list the runnable/uninterruptible processes (ps -A
r), I see nothing, which makes me think this comes from the kernel but
how exactly, I have no clue (htop showing kernel threads does not
really show any differences).

Does anyone know how CONFIG_HZ can impact system load on a RT kernel?
Is it a "real" system load increase that will impact the performance
of my system or just a by-product of how it's calculted maybe?
It is maybe something to be expected to improve latency?

Thanks.
