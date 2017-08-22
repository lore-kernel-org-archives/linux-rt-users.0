From: afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: Re: how fast can you run a hrtimer?
Date: Tue, 22 Aug 2017 18:15:54 +0530
Message-ID: <20170822124554.GA5898@afzalpc>
References: <CAOd_LFwErYmZS-5b=a1O8DkqpAZqhgGXwnLhHHWZ8NnheK72Xw@mail.gmail.com>
 <CAOd_LFx5Bn6HtnzD59Hn6feY=ZS3Re+GXHcRU2x2J54cuJDagw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rt-users <linux-rt-users@vger.kernel.org>,
        Cliff Brake <cbrake@bec-systems.com>
To: Cliff Brake <cliff.brake@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34460 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932720AbdHVMqD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 Aug 2017 08:46:03 -0400
Received: by mail-pf0-f177.google.com with SMTP id h75so9643877pfh.1
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Aug 2017 05:46:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOd_LFx5Bn6HtnzD59Hn6feY=ZS3Re+GXHcRU2x2J54cuJDagw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

> On Fri, Aug 18, 2017 at 8:35 AM, Cliff Brake <cliff.brake@gmail.com> wrote:

> > I have an application where we need to tweak a PWM setting every 10uS.
> > My impression is this is beyond the capabilities of linux+rt, but want
> > to verify I'm not missing anything before we add an external
> > microcontroller to handle this.
> >
> > I've run some experiments on a i.MX6UL with v4.1+rt, and observe
> > delays of ~50us when toggling a GPIO in a Linux driver using a
> > hrtimer.

On Fri, Aug 18, 2017 at 10:34:19AM -0400, Cliff Brake wrote:
> After a suggestion of using a NMI and a bit of research, it seems
> something like the following article is the probably a reasonable
> approach:
> 
> http://free-electrons.com/blog/fiq-handlers-in-the-arm-linux-kernel/

If a PWM IP is present on the chip, won't updating the PWM compare
registers within 10us (PWM @100KHz) achieve the required ?, toggling
delay & jitter shouldn't be a worry here, right ? (assuming PWM
compare registers can be updated every 10us using hrtimers)

afzal
