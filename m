From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Question regarding pthread_cond_wait/pthread_cond_signal
 latencies
Date: Sun, 22 May 2011 20:37:23 +0200
Message-ID: <20110522183722.GF13029@pengutronix.de>
References: <1305886116.10494.30.camel@laika>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Pedro Gonnet <gonnet@maths.ox.ac.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42362 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab1EVShY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 May 2011 14:37:24 -0400
Content-Disposition: inline
In-Reply-To: <1305886116.10494.30.camel@laika>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Pedro,

On Fri, May 20, 2011 at 11:08:36AM +0100, Pedro Gonnet wrote:
> The library uses pthreads (plus some OpenMP for some simple loops) and
> uses pthread_cond_wait and pthread_cond_signal to coordinate a group
> of worker threads.

Are you aware of this:

http://sourceware.org/bugzilla/show_bug.cgi?id=11588

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
