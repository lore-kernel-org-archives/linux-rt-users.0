From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Why is real time pinging not possible with RT kernels?
Date: Tue, 13 Jun 2017 13:58:18 +0200
Message-ID: <20170613115818.yjjoec3kojryuxam@linutronix.de>
References: <trinity-c4969a6b-8eeb-4799-93a4-349c300c9363-1497118391298@3capp-webde-bap09>
 <f60f3487-64d7-141c-6d6c-aec8318a87da@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rolf.freitag@email.de, linux-rt-users@vger.kernel.org
To: Corey Minyard <cminyard@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38184 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdFML6V (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Jun 2017 07:58:21 -0400
Content-Disposition: inline
In-Reply-To: <f60f3487-64d7-141c-6d6c-aec8318a87da@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-12 07:57:18 [-0500], Corey Minyard wrote:
> A few notes on what you have done:
> 
>  * ionice doesn't affect network I/O.
>  * renice does not set real-time priorities.
>  * You don't do anything with memory locking.  What happens
>    if memory in your program gets paged out then is required?
>  * Something on the other end of the ping is running, too.  It
>    also needs to be real-time, too, and it's not by default.

You forgot to mention that the real-time kernel is not automatically
overclocking the software in terms of performance (but providing
determinism).

> I'd suggest you need to spend some time learning before you attempt
> something like this.
> 
> -corey

Sebastian
