From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Thu, 8 Sep 2016 13:37:44 +0200
Message-ID: <20160908113743.xpcnhw5izdjglhch@linutronix.de>
References: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
 <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de>
 <20160808164505.GA13707@linutronix.de>
 <CAL7_A_Vz+BCg-QXraob1ndDF4b3ggGN-j+fnQ9FTqY1FdbVvug@mail.gmail.com>
 <20160812123735.zboeocbv4o5sjnwb@linutronix.de>
 <CAL7_A_WcvqmghJiQaDdnYRZmPf9=-s3eveMfM1uYtHfKykbmVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Jens Koehler <jenskxxx@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:43779 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934676AbcIHLhq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Sep 2016 07:37:46 -0400
Content-Disposition: inline
In-Reply-To: <CAL7_A_WcvqmghJiQaDdnYRZmPf9=-s3eveMfM1uYtHfKykbmVg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-08 12:36:08 [+0200], Jens Koehler wrote:
> Hello Sebastian,
Hallo Jens,

> After adding of your patch "disable preemption during CR3 read+write"
> we have since 2 weeks no rt throttling event. This is very good
> improvement.

didn't see that coming. Glad it works now.

> Thanks a lot,
> Jens

Sebastian
