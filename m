From: Niels Kolthoff <nkolthoff@gmail.com>
Subject: Re: Low USB polling frequency with RT-PREEMPT
Date: Tue, 5 Sep 2017 19:53:17 +0200
Message-ID: <CAD2hpBUsMz70-502BhOzxnH8H6zka3N86CNBspXizKr4WH5aNQ@mail.gmail.com>
References: <20170905150539.GF2607@anonymous>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-rt-users@vger.kernel.org
To: Simon Thelen <urday@student.kit.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:32939 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbdIERxS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Sep 2017 13:53:18 -0400
Received: by mail-yw0-f169.google.com with SMTP id c191so10696635ywb.0
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Sep 2017 10:53:18 -0700 (PDT)
In-Reply-To: <20170905150539.GF2607@anonymous>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Simon,

Not sure if this helps; are you polling the actuators using usb-serial io?

I've had performance issues reading from the raspberry pi serial port.
see: http://www.spinics.net/lists/linux-rt-users/msg16880.html


On Tue, Sep 5, 2017 at 5:05 PM, Simon Thelen <urday@student.kit.edu> wrote:
> Hello,
>
> We have some Dynamixel robitic actuators hooked up via USB to an Ubuntu
> 14.04 system running the 4.4.79-rt92 kernel. When using a kernel built
> without the realtime patches (CONFIG_PREEMPT not set) we can query the
> bus at 1000Hz (2 devices at 500Hz each) whereas with the realtime kernel
> (CONFIG_PREEMPT=y, CONFIG_PREEMPT_RT_FULL=y) we only get 62.5Hz per
> device. The USB device requests Ivl=0ms in both cases and the issue
> isn't related to load etc. The polling rate is always 62.5Hz (It takes
> ~15ms for every read()).
>
>
> Is this a known limitation of USB with the CONFIG_PREEMPT_RT patches and
> is there any method to improve the polling rate?
>
> --
> Simon Thelen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
