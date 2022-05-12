Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E16C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 May 2022 03:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345308AbiELD4U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 May 2022 23:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345278AbiELD4E (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 May 2022 23:56:04 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1712AC9
        for <linux-rt-users@vger.kernel.org>; Wed, 11 May 2022 20:56:02 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z18so4094159iob.5
        for <linux-rt-users@vger.kernel.org>; Wed, 11 May 2022 20:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xcm/62+yD5RSL2gQPzQLNX4HYx+/RpaPEGiKu8NTGnw=;
        b=kL1Mq0FwsuxWhOS96WGJfZT1xPKCPM8PPZv4CFAUhmz2MvfFHBdumNrk8fi98qtJVk
         E/Oy93XY45I+ghqlSdeXckWOTXxLO18wAHIP2fw+jh+ODJLLq6nrKD8uht7y1ZWq0EJj
         2vUFZbnXx/cFK9saVbWGHfR1oiuk23fNqV/JcRzjrWMrNovP0rxLLrStZeOgqJRXzb1M
         u+SmzBzzC52JY8b8voekcdnNyiC6+T692HEmUSKlNhRQGXthul0p5TzDupOlwzmTTsJt
         iw4JpUzQ34R+ibK9P3uwiqeuc1qpQGqPGFcHMtdpqrFkEaWcUntDz2LOWCHMiPZqM5IX
         /XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xcm/62+yD5RSL2gQPzQLNX4HYx+/RpaPEGiKu8NTGnw=;
        b=0Hx5v8pCpb4/HL98diHmhVbQWVFxGmaUQppX7VRIqW6c3dmtVceRyhE0cXi3YFMWjD
         zH6b/GzDtI8XiCzL6nOoD1m5GmPiEWZQnP9RiOdngxdXHAC2wrCskObWD2XuTfRDqdaw
         mOChBomY7U6jFF1tAK5nra6rxNMVyMWB1Ze45cfbAOl0m640zBYfGMG+b73oHFn32KFd
         KWFTUZASfszLTVCluDSwxUJqlrC00SIwNasn5LaZZ3BkVoVqq6/ehS9O8lv1AUNImCT9
         /axOWbPLdfKMhSe0AWHFUEa/u/uhYOlFGvlDKhbFNRpTHzazrgIkKoNvmAtggwvUWYP1
         /qjQ==
X-Gm-Message-State: AOAM530217NVINodB/8ULzPPmBOczATOwPkWntnmEVVLb9BhidV4ldsA
        lQXShWYEfoz2MOUiAxOV9mDVP4M4G/tjv+LlvB/IYSjQEpjj6w==
X-Google-Smtp-Source: ABdhPJy9ShouKSdr5fjmjzZQawvdUr6iVVNo/xwmLJ3Aj4z2VTzz8AVfDfaI2tedbzzb/DZvjuVw/70c9M8A4IBktLI=
X-Received: by 2002:a02:860d:0:b0:32b:2210:95c with SMTP id
 e13-20020a02860d000000b0032b2210095cmr13811533jai.175.1652327761608; Wed, 11
 May 2022 20:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAAh1qtktzZQxXp_t43YhxL6FZTS58rn_xvK2Zrq33-s3=j_sGQ@mail.gmail.com>
 <Ynvh8Nh7hyp4tSKk@linutronix.de>
In-Reply-To: <Ynvh8Nh7hyp4tSKk@linutronix.de>
From:   Yimin Deng <yimin11.deng@gmail.com>
Date:   Thu, 12 May 2022 11:55:49 +0800
Message-ID: <CAAh1qtme2Lefj5XZsNoPOmGqhjcf=qkWzs3z_=tbYH209QgLyQ@mail.gmail.com>
Subject: Re: Oops or bad page in page_alloc.c
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

Thanks a lot for your quick reply!

CONFIG_HAVE_PREEMPT_LAZY=3Dy
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT__LL is not set
# CONFIG_PREEMPT_RTB is not set
# CONFIG_PREEMPT_RT_FULL is not set

CONFIG_SLAB=3Dy
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set

CONFIG_PREEMPT_RT_FULL is not enabled, neither CONFIG_SLUB. I think
it's not related to the issue fixed in f1aca90802af9 ("Revert "slub:
delay ctor until the object is requested""). We share the kernel
source code but using different configuration on different products.
The applications on this product are non-RT applications.

This issue was reported on different nodes, so it seems not related to
hardware bad RAM. I'm checking whether it's possible for other CPUs in
AMP to overwrite the memory.

I will consider your suggestion on disabling the memory compacting and
enabling the list-debugging.

Sincerely appreciate your support!

B.R.
Yimin

Sebastian Andrzej Siewior <bigeasy@linutronix.de> =E4=BA=8E2022=E5=B9=B45=
=E6=9C=8812=E6=97=A5=E5=91=A8=E5=9B=9B 00:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2022-05-09 15:40:43 [+0800], Yimin Deng wrote:
> > Hi
> Hi,
>
> > I encountered an oops in isolate_pcp_pages() and a bad page in
> > get_page_from_freelist().
> >
> > linux: 3.12.37-rt51  (CONFIG_PREEMPT_RT_BASE not enabled)
> > arch: PowperPC (e500)
> =E2=80=A6
> What you mean by CONFIG_PREEMPT_RT_BASE is not enabled? Is
> CONFIG_PREEMPT_RT_FULL enabled or none of those options?
>
> > Any suggestions will be appreciated!
> >
> > [18857088.953420] Unable to handle kernel paging request for data at
> > address 0x00100104
> > [18857089.046143] Faulting instruction address: 0xc0075624
> =E2=80=A6
> > [18857090.073578] NIP [c0075624] isolate_pcp_pages+0x84/0xc4
> > [18857090.138173] LR [c0078f24] free_hot_cold_page+0x124/0x174
> =E2=80=A6
>
> I can't even tell if I saw a report as yours earlier or not. I do
> remember that I saw the "bad page state" reports earlier but I don't
> remember how they went away. I know that I had two 8572DS systems and
> one started to report all kind different errors (including "bad page
> state") but this was due to bad RAM (probably) since the other system
> never had this error despite that they had the same configuration.
>
> Your kernel is kind of old. The latest v3.12 is v3.12.74-rt99 which
> contains a few bug fixes including commit
>     f1aca90802af9 ("Revert "slub: delay ctor until the object is requeste=
d"")
>
> which is probably not what you see but a possible crash.
> You could disable memory compacting and so on but as far as I remember
> they could lead higher latencies in some cases, not to a crash.
> You could enable list-debugging in case an entry is added/removed
> multiple times.
> The e500 support is quite good upstream so you could upgrade to a later
> kernel (one of the current LTS kernels).
>
> > B.R.
> > Yimin
>
> Sebastian
