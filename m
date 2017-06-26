From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Variance, Standard Deviation, Skewness and Kurtosis for
 cyclictest results?
Date: Mon, 26 Jun 2017 16:30:35 +0200
Message-ID: <20170626143035.kir3ym6so6yifrza@linutronix.de>
References: <trinity-bc729c2f-fd82-4804-bc70-99fab82bf762-1498257529316@3capp-webde-bs65>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: r t <linux-rt-users@vger.kernel.org>
To: rolf.freitag@email.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40887 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdFZOah (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 10:30:37 -0400
Content-Disposition: inline
In-Reply-To: <trinity-bc729c2f-fd82-4804-bc70-99fab82bf762-1498257529316@3capp-webde-bs65>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-24 00:38:49 [+0200], rolf.freitag@email.de wrote:
> Hi,
Hi,

> many programs, e. g. ping also print the standard deviation of the measured times, so i would like get the standard deviation(s) also from cyclictest.
> It's easy to also calculate Variance, Skewness and Kurtosis in the same pass: https://www.johndcook.com/blog/skewness_kurtosis/
> Has someone planned to implement this in cyclictest?

cyclictest prints min/avg/max. min and avg are nice to look at. The
important part is the max value. If you have avg at 30us and max at
500us then you know, that you can't meet your deadline for a cycle of
400us.

> Regards,
> 
> Rolf

Sebastian
