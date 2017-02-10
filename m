From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Fri, 10 Feb 2017 20:07:08 +0100
Message-ID: <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
References: <1486579285.29816.105.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: "Patel, Vedang" <vedang.patel@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:33904 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753277AbdBJTHY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Feb 2017 14:07:24 -0500
Content-Disposition: inline
In-Reply-To: <1486579285.29816.105.camel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-08 18:41:25 [+0000], Patel, Vedang wrote:
> Hi, 
Hi,

> The results for the POSIX timers were not as I expected. The latency
> for real-time kernel (v4.9.4-rt2) was worse compared to the mainline
> kernel (v4.9.4). In almost all the cases, the latency is almost doubled
>  with the max value reaching about 10 times when performing the tests
> under load.

Is it also the case if you boost the priority of ktimersoftd/X threads?
For clock_nanosleep, the wake-ups happen directly from hard-timer
interrupt. For the posix-timer we have to delay those to the ktimersoftd
thread which runs usually RT prio 1.

> Thanks,
> Vedang Patel
> Software Engineer
> Intel Corporation

Sebastian
