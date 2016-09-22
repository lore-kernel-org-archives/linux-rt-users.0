From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Got stacktrace "irq 17: nobody cared" on Intel GalileoGen2 with
 4.6.7-rt13
Date: Thu, 22 Sep 2016 15:49:12 +0200
Message-ID: <20160922134912.6ttkfpphn2ga4z22@linutronix.de>
References: <1474532371.10922.50.camel@denx.de>
 <b8c6cd44-4a29-fe84-af0d-747584c04ad0@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, Claudius Heine <ch@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38127 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbcIVNtR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Sep 2016 09:49:17 -0400
Content-Disposition: inline
In-Reply-To: <b8c6cd44-4a29-fe84-af0d-747584c04ad0@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-22 10:24:26 [+0200], Jan Kiszka wrote:
> One theory I was thinking about: Could - for whatever reason - disabling
> of the interrupt line from the primary handler be broken / work
> unreliably and cause this storm?

It seems so. If you look at the complete boot log then the core code
attempts multiple times to disable IRQ #17 with zero success.
I would assume that booting an unpatched kernel with the threadirqs
option would give the same result.

> Jan

Sebastian
