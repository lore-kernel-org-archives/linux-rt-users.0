From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [RFC 0/4] Improving SPI driver latency (vs v3.8.13.14-rt31)
Date: Mon, 1 Sep 2014 13:13:28 -0500
Message-ID: <20140901181328.GB81857@unpythonic.net>
References: <1409581835-70814-1-git-send-email-jepler@unpythonic.net>
 <540493AA.2020207@dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Philipp Lutz <philipp.lutz@dlr.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rrcs-76-79-27-186.west.biz.rr.com ([76.79.27.186]:32947 "EHLO
	rrcs-76-79-27-186.west.biz.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754677AbaIASNb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Sep 2014 14:13:31 -0400
Content-Disposition: inline
In-Reply-To: <540493AA.2020207@dlr.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Sep 01, 2014 at 05:41:30PM +0200, Philipp Lutz wrote:
> Have you looked into setting a RTPRIO for the SPI worker threads
> (spi_init_queue() in spi.c)? As far as I see hardly any SPI
> hardware-dependent driver sets the "rt" property in the respective
> spi_master struct, so that the main SPI driver (spi.c) will not use a RT
> priority, which will be MAX_RT_PRIO - 1.

Sort of.

I was unaware of the "rt" property so I never tried setting it on the
kernel side.  However, I did run into the idea of using "chrt" on the
kernel tasks [spi1] and [irq/99-spi-s3c6].  This improved things
somewhat, but this plus eliminating DMA acquistion still left me with
some 800+us latencies that I didn't want.

(it may have also helped somewhat to to use cpuset to bind these tasks
to the same CPU where my realtime task runs--the U3 is a 4-core chip,
and linuxcnc binds to the last CPU by default)

Jeff
