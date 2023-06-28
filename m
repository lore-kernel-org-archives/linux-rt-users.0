Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27BBEB64DC
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 12:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjF1Mud (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 08:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjF1MuK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 08:50:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC4619B1
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 05:50:08 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635ddf49421so25821196d6.2
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sr-research.com; s=google; t=1687956607; x=1690548607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nHzK1OK+90FFr2akhzfXynTiIwGjfilPTNmH1qRv/o=;
        b=DoqX2wm040xl6W3y0zXzx5Oheif6y8XwP+8M8Rx8imK50cntViAOJMtMHjYIvZVQsl
         /v3AQvlqTDgXq0m+1Q+mwJg+neCjLckCs3CHFK2N9L+vMAWUpYK1kwgOEFvaRbFJeVaD
         BexvmymjuXeUT2S9ZU3OUtm33AHcAP+vp1SVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687956607; x=1690548607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nHzK1OK+90FFr2akhzfXynTiIwGjfilPTNmH1qRv/o=;
        b=gl04WPXxG0ySIVhKamEjcNchLMBe16Bfh00M7DzOWCSMmYErJWpw6eqRh6tgikyq5F
         9ImNAczsBKvProwmN1z67D+dIxM9g/Ivi6NjF9+ARfhXImF96ZbMtX/U1a3pUxpVbA0z
         2mQUo92Kg8JaLED5zR0/SUi/tlnqwjs+yPYoWb3oyOU7aDJOYmmbF2tBm62Q9Hf4m8VY
         Vk/GFDl1z8wp8r/IvYh77UtE/nGrRLc5gUfiK06iVWSRlYUM3YOqS/crLtBg5ejMkxXM
         LFnCnTbS+T8adoDEkPIpvykhOBJh7aKl6lp8/cZ82YnZ7rtag+ltnuPod8UA2zciVmz9
         FQrw==
X-Gm-Message-State: AC+VfDzIS2L2u/Wm+kkd+pVAFAOX1/EIAB2HPTlCSiiDoabaAaFYqjGg
        69hi+kyWTHEDTAXTp2msm5gV/zuOMu3TzLQC506niQ==
X-Google-Smtp-Source: ACHHUZ7bUhaJKDJp31GvyIQUhJLyicpsg4TdrBDCGvl2d1sP+iyFjUz94MVthn4W4pziHh4FT9JKnegNS/P1jCv6iXs=
X-Received: by 2002:a05:6214:e68:b0:635:93fb:fc05 with SMTP id
 jz8-20020a0562140e6800b0063593fbfc05mr14029786qvb.10.1687956607438; Wed, 28
 Jun 2023 05:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMkvodZZKriPgWVwQ7R6ZS9eSbmmE3FC3f35QLg6u40NsnGJpg@mail.gmail.com>
 <20230626150816.RW-ysAqX@linutronix.de> <CAMLffL_R9AE-mTJnsbGoQE_Kf0GcF9X5UPVehtgjVNHrFmkszw@mail.gmail.com>
 <20230628064247.JP_3ZbxL@linutronix.de>
In-Reply-To: <20230628064247.JP_3ZbxL@linutronix.de>
From:   Martin Hicks <martin@sr-research.com>
Date:   Wed, 28 Jun 2023 08:49:56 -0400
Message-ID: <CAMkvodayH35Byv+O6Ck_xUaZ0yVPxV6Fx1+N+9=G3COkn=g-2A@mail.gmail.com>
Subject: Re: POSIX timer wakeups not preempting RT threads
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian and Clark,

The explanations make sense to me.  I now understand some of the
limitations of POSIX timers and I'll probably rework to use
clock_nanosleep() instead.

Thanks for your help,
mh

On Wed, Jun 28, 2023 at 2:42=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-06-27 18:22:51 [+0000], Clark Williams wrote:
> > Martin,
> Hi,
>
> > Building on what Sebastian said, I'd say you have two options for this.=
 The
> > first, if you absolutely must use POSIX timers, is to bump the ktimer/*
> > threads to a SCHED_FIFO priority at least one above your application. T=
hat
>
> Be ware that this thread also handles all _other_ wakeup on the given
> CPU.
> =E2=80=A6
> > Ever since we've been using the PREEMPT_RT series, most people avoid us=
ing
> > signals for regular event delivery. It's not that the signal mechanism =
is
> > wrong, it's just that it's complicated code, having to handle a lot of
> > legacy signal handling behavior that an RTOS probably doesn't care abou=
t. I
> > suspect that after PREEMPT_RT merges, we'll need to do a thorough audit=
, to
> > make sure we don't have any corner cases for unreasonable delays in sig=
nal
> > delivery, but to this point it hasn't really been a priority.
>
> Other than the locks, you have a memory allocation in the sender's path.
>
> > If it were me I'd do it in a dedicated thread.
>
> Either that or rework the logic so that the proper thread gets the
> wakeup.
>
> > Clark
>
> Sebastian
