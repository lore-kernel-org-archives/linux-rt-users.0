From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: Network Issue
Date: Thu, 8 Sep 2016 08:19:20 +0200
Message-ID: <20160908061920.msefkdj4nk3exzpr@pengutronix.de>
References: <CAGiFfw4o2c1f=pR+gKkVYAoHQ7V8ywLXu-_g9ahWSZoAoSD7tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: "Hardik A Gohil (WMSC-HW)" <hardik@willowglen.asia>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58830 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756856AbcIHGg7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Sep 2016 02:36:59 -0400
Content-Disposition: inline
In-Reply-To: <CAGiFfw4o2c1f=pR+gKkVYAoHQ7V8ywLXu-_g9ahWSZoAoSD7tA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Thu, Sep 08, 2016 at 09:49:14AM +0800, Hardik A Gohil (WMSC-HW) wrote:
> I am working on Linux 3.2.0.

Wow, you're still developing on a kernel that is 4.5 years old and
you're not even taking the stable updates.

> We had a requirement to make Linux Real Time so using RT-PREEMPT
> (patch-3.2-rt10.patch.bz2)

Even if you stick to 3.2.x, there is 3.2.82-rt118.

> We are facing a network hang issue while running the periodic task of 5 ms.
> 
> cannot ping any more when task is running is ran for some time.
> 
> I am using Timer fd protocol to achieve this.
> 
> I would like to know if there is such know issue in this patch.
> 
> Any help will be appreciated.

I bet you won't find help here until you reproduce the issue with a
recent kernel (currently there is v4.6.7-rt11) and show the code of your
periodic task.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
