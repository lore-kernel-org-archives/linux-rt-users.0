From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: how fast can you run a hrtimer?
Date: Fri, 18 Aug 2017 10:34:19 -0400
Message-ID: <CAOd_LFx5Bn6HtnzD59Hn6feY=ZS3Re+GXHcRU2x2J54cuJDagw@mail.gmail.com>
References: <CAOd_LFwErYmZS-5b=a1O8DkqpAZqhgGXwnLhHHWZ8NnheK72Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Cliff Brake <cbrake@bec-systems.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33031 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdHROeV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2017 10:34:21 -0400
Received: by mail-lf0-f54.google.com with SMTP id d17so43332818lfe.0
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Aug 2017 07:34:21 -0700 (PDT)
In-Reply-To: <CAOd_LFwErYmZS-5b=a1O8DkqpAZqhgGXwnLhHHWZ8NnheK72Xw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

After a suggestion of using a NMI and a bit of research, it seems
something like the following article is the probably a reasonable
approach:

http://free-electrons.com/blog/fiq-handlers-in-the-arm-linux-kernel/

Cliff

On Fri, Aug 18, 2017 at 8:35 AM, Cliff Brake <cliff.brake@gmail.com> wrote:
> Hi,
>
> I have an application where we need to tweak a PWM setting every 10uS.
> My impression is this is beyond the capabilities of linux+rt, but want
> to verify I'm not missing anything before we add an external
> microcontroller to handle this.
>
> I've run some experiments on a i.MX6UL with v4.1+rt, and observe
> delays of ~50us when toggling a GPIO in a Linux driver using a
> hrtimer.
>
> Thanks,
> Cliff
>
> --
> =================
> http://bec-systems.com



-- 
=================
http://bec-systems.com
