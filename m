From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Variance, Standard Deviation, Skewness and Kurtosis for
 cyclictest results?
Date: Mon, 26 Jun 2017 18:20:32 +0200
Message-ID: <20170626162032.3r4uxnvucrkvitv5@linutronix.de>
References: <trinity-bc729c2f-fd82-4804-bc70-99fab82bf762-1498257529316@3capp-webde-bs65>
 <20170626143035.kir3ym6so6yifrza@linutronix.de>
 <AM3PR02MB1305D909595CD5A0AE25D29C1DF0@AM3PR02MB130.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "rolf.freitag@email.de" <rolf.freitag@email.de>,
        r t <linux-rt-users@vger.kernel.org>
To: Piotr Gregor <pgregor@quadrant-systems.co.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41440 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdFZQUj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 12:20:39 -0400
Content-Disposition: inline
In-Reply-To: <AM3PR02MB1305D909595CD5A0AE25D29C1DF0@AM3PR02MB130.eurprd02.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-26 15:59:20 [+0000], Piotr Gregor wrote:
> Hi Sebastian,
Hi Piotr,

> I think Rolf understands that but he is simply interested in deviation anyway.
Sure. I just tried to clarify why we have what we have and I can't
remember patches floating around implementing something else. I am not
saying no to any other "average" implementation.

That said, there is the latency-histogram output and people feed those
numbers into gnuplot. So there is this.

> cheers,
> Piotr

Sebastian
