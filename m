Return-Path: <SRS0=vtwn=A3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D3C433E2
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA222074B
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 19:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6V/ZjkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgGPT00 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgGPT0Z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Jul 2020 15:26:25 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBCDC061755
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 12:26:24 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id k7so2120433uan.13
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mMbgdwDtP27CXsZjfhivFu9jhDR9mwGH1nJkgK5VWA4=;
        b=l6V/ZjkLcriHPckaGAhCydz/u19BsZgYcCww8XquYbbpy5LwQvsEWbqNtQ9EHakqEW
         vXH9XTjUY4vxOFStBVSXVpm6d3Jdn27EKaGP30cCRQRoYAuETmq0ozpX+VS9nhMH9rb2
         MOazxwCuiazGuB3DfmDvxEd4oX7NFNcL+Ebtw+JyABM5qVCmJGvS88PZ33uoL66o5RjE
         DHUXc4md7s5yo7o1e7NnC71uCaRCAquHQ8jn1UiupyKnXgfEWaOGIMpGKCCMlcNVtdxT
         NI0DLeDDQLr+iDd0LlmVV6L1CF2MMf1uKeiaxNBaEfYUQLXsLJWDdY8nPE3EGrZFkqWn
         0K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mMbgdwDtP27CXsZjfhivFu9jhDR9mwGH1nJkgK5VWA4=;
        b=Zta5aiV5LbbPYbfvDYb6tkjuc8V5/LtaXeGycLU4L8jAcwli2SED1svNbvZ1Ez1lN1
         m3+0pUZVfTB2vrCx6QB3KgctBiniy8LGtH6NuymjG4v4u3bcUbZhD+sjJaH0Ilum3jYH
         72XRPEtIvUY0k/r9gN/yyyzO7mx6/RuoRsQ6bPon3XzCn1GTWRKCgvNtbhA3CMBN8Yqt
         ggJPIN/sf6zHnnvfVm6awoj0gbcv4m7A4S6btyiMf6bFVi5MTXx0QJIGgouKKOc3FeB9
         zS1pyDrDyrYXkqyYLkMZVyNHx4U7HeDYiyz2UgqwLq8hjy/C7QY61ha8xoikteXaRHFV
         aPZQ==
X-Gm-Message-State: AOAM530rLwHUdrrLTSucmp5CakTe1lo3XCZnaFlcM/JeW6mjfza/Xv3D
        orxwuLnBnt/K4/tlq6r28kFs8/z4AQeht9mmZqPYXg==
X-Google-Smtp-Source: ABdhPJxI27D2ZjgmllSiN9CyNj2NIN/I6IAP4IKY7/3C7HSigJuRY8/xn/dM8qDCzz1k5QaZPDzYGw5UVzYmXAI4ZSg=
X-Received: by 2002:ab0:55da:: with SMTP id w26mr4372735uaa.28.1594927584029;
 Thu, 16 Jul 2020 12:26:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:fd69:0:0:0:0:0 with HTTP; Thu, 16 Jul 2020 12:26:23
 -0700 (PDT)
In-Reply-To: <CAKkbJ-yB4XGuexzmwfkR8g76HR8iCkXaHsXaLaS6V+Wfy86bvg@mail.gmail.com>
References: <CAKkbJ-yB4XGuexzmwfkR8g76HR8iCkXaHsXaLaS6V+Wfy86bvg@mail.gmail.com>
From:   Itai Handler <itai.handler@gmail.com>
Date:   Thu, 16 Jul 2020 22:26:23 +0300
Message-ID: <CAFpOueQm5MhbrV53=kAcw=ES2LzsZPkmX2SqTVKuYTf0QDt=7w@mail.gmail.com>
Subject: Re: Serial port driver usage and status
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Michel,

On 7/16/20, Michel Macena Oliveira <michel@austral-dynamics.com> wrote:
> Hi, sorry for my newbie question,
> What is the status of the serial port driver?
> I've written some code to use serial ports  for the generic kernel linux,
> And now I want to write something similar for the real time kernel, do
> I have to use some specific library, flags or something or is it just
> the same settings?
>
> I'm asking because now I need to take into account the serial access
> in the scheduler to ensure a real time behavior .
>
> Any help, advice, hint or tips would be appreciated.
>

Do you mean that you wrote some code that works with a /dev/tty* serial port?

In some kernel versions (e.g 4.19) we saw high latencies in the rx
path of serial drivers.
I think that this is due to rx handled in the context of a workqueue
which also handles other system activities.
We found a workaround to this problem. If I remember correctly we
create a dedicated thread for the port and assign it a high priority.

Itai Handler
