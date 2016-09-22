From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Got stacktrace "irq 17: nobody cared" on Intel GalileoGen2 with
 4.6.7-rt13
Date: Thu, 22 Sep 2016 16:41:22 +0200
Message-ID: <20160922144122.ywq7p27fcxlplo6d@linutronix.de>
References: <1474532371.10922.50.camel@denx.de>
 <b8c6cd44-4a29-fe84-af0d-747584c04ad0@siemens.com>
 <20160922134912.6ttkfpphn2ga4z22@linutronix.de>
 <1474553779.10922.87.camel@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-rt-users@vger.kernel.org
To: Claudius Heine <ch@denx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38353 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756299AbcIVOl0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Sep 2016 10:41:26 -0400
Content-Disposition: inline
In-Reply-To: <1474553779.10922.87.camel@denx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-22 16:16:19 [+0200], Claudius Heine wrote:
> Thanks for your help, but I am sorry to disappoint:

I am surprised. You have UART and SPI sharing the interrupt and from
output it is SPI that does not cooperate.
Disable SPI and the warning/error should go.
Maybe RT hits a condition the SPI driver return IRQ_NONE instead of
doing something.

> 
> Claudius

Sebastian
