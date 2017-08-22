From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: how fast can you run a hrtimer?
Date: Tue, 22 Aug 2017 09:13:08 -0400
Message-ID: <CAOd_LFx_7nKXo16NWXec+WW+QbuyY4FPxLosNrSyPXbXEYcfog@mail.gmail.com>
References: <CAOd_LFwErYmZS-5b=a1O8DkqpAZqhgGXwnLhHHWZ8NnheK72Xw@mail.gmail.com>
 <CAOd_LFx5Bn6HtnzD59Hn6feY=ZS3Re+GXHcRU2x2J54cuJDagw@mail.gmail.com> <20170822124554.GA5898@afzalpc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: afzal mohammed <afzal.mohd.ma@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34963 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbdHVNNK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 Aug 2017 09:13:10 -0400
Received: by mail-lf0-f41.google.com with SMTP id k186so23407614lfe.2
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Aug 2017 06:13:10 -0700 (PDT)
In-Reply-To: <20170822124554.GA5898@afzalpc>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Aug 22, 2017 at 8:45 AM, afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> If a PWM IP is present on the chip, won't updating the PWM compare
> registers within 10us (PWM @100KHz) achieve the required ?, toggling
> delay & jitter shouldn't be a worry here, right ? (assuming PWM
> compare registers can be updated every 10us using hrtimers)
>

There is timers on the cpu that can generate a PWM in hardware, but
what we need to do is update the PWM duty cycle every 10us (so the PWM
freq will be say 1MHz).  The idea is to ramp up/down the PWM value
over time (waveform generation).  I suppose if we could somehow feed
the capture/compare registers with DMA, that might work.  Gives me an
idea -- we should look into audio hardware and see if any of that can
generate a 100KHz waveform.

Cliff

-- 
=================
http://bec-systems.com
