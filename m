From: Neel Mehta <neelmehta89@gmail.com>
Subject: Re: real time linux - which to use?
Date: Thu, 10 Jun 2010 15:25:29 +0200
Message-ID: <AANLkTin_T8EIJZmIJ7J3hIr2OA0MzQHAXiNnN2xXP3B5@mail.gmail.com>
References: <AANLkTilcpfJLRqKzsN0n6Vx_EGHO7Q56uaOWBPYYaPx7@mail.gmail.com>
	<20100610131629.GA7998@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64374 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab0FJNZu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jun 2010 09:25:50 -0400
Received: by gye5 with SMTP id 5so4652496gye.19
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jun 2010 06:25:49 -0700 (PDT)
In-Reply-To: <20100610131629.GA7998@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you all for your help. I will provide a bit of background as to
what I wish to do.

I am working on an automatic railways project, and we have a lot of
sensors like GPS, laser, infrared, ultrasonic, cameras, etc. Each of
these works in an while loop, and tries to improve the quality of the
results. What I need is results at regular intervals. The time
interval depends on the speed of the train. So, I wish to develop my
application on realtime linux, so as to get the results at regular
intervals. I will be using TDL (Time Definition Language) for this
purpose. I would be generating software interrupts for machines doing
the processing of the sensors, and they in turn will return me the
result of the sensor, at that given moment of time.

I hope this helps to give you a picture of what I wish to do. Maybe
now you can suggest me the best alternative.

Thanks and Regards,
Neel Mehta
Third year Undergraduate student,
Electrical Engineering,
IIT Bombay


On Thu, Jun 10, 2010 at 3:16 PM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
>
> On Thu, 10 Jun 2010, Neel Mehta wrote:
>
> > Hi. I am new to real time linux os. I need to set up one. I came
> > across two realtime linux os/kernels/patches, and there may be more. I
> > came across?http://www.rtlinuxfree.com/?and?https://www.rtai.org/.
> >
>
> regarding RTLinux/RTAI, RTLinux is dead so if one of those to then RTAI
>
> Alternatives are the Xenomain and Xenomai-Solo and of course RT-Preempt
>
> > Are there more such patches? Is anyone better? What do people use
> > normally? I need to set up realtime linux to get results from sensors
> > every periodic intervals. I want this to be hard realtime. Any help
> > will be greatly appreciated. Instructions or links for compilation
> > will also be very helpful.
> >
>
> a bit of background with respect to bandwidth needs, periods involved and
> architecture would be helpfull to give you some hints. There is no
> "one-fits-all" solution around...
>
> hofrat
