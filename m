From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: kernel panic in virt-manager
Date: Wed, 2 Nov 2016 11:35:47 +0100
Message-ID: <20161102103546.7xefntxl2i5gutf7@linutronix.de>
References: <CA+Owze4tsj82yyj=sZ03A5QN1d3HgA08anADhaXgUrgE0j9PZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: jkraehemann-guest@users.alioth.debian.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58879 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbcKBKfu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Nov 2016 06:35:50 -0400
Content-Disposition: inline
In-Reply-To: <CA+Owze4tsj82yyj=sZ03A5QN1d3HgA08anADhaXgUrgE0j9PZA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-11-01 21:59:49 [+0100], Joël Krähemann wrote:
> Hi
Hi,

> There is a screenshot of a kernel panic in the attachment.
> The last thing I did was:
> 
> apt-get install gdb valgrind make gcc automake autoconf on TTY2

I see. So there is no backtrace and IP points to "doublefault". If you
can reproduce it then you could redirect ttyS0 somewhere and log
kernel's output there.

> Bests,
> Joël

Sebastian
