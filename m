From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Thu, 10 Jan 2008 15:35:27 +0100
Message-ID: <20080110143527.GI3177@pengutronix.de>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <20080109090345.GG3177@pengutronix.de> <20080109225107.GV3177@pengutronix.de> <20080110000124.GW3177@pengutronix.de> <47861ACE.9060301@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:43970 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753907AbYAJOfg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jan 2008 09:35:36 -0500
Content-Disposition: inline
In-Reply-To: <47861ACE.9060301@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 10, 2008 at 02:17:02PM +0100, Wolfgang Grandegger wrote:
> Unfortunately, it doesn't really help on my Icecube board.
> 
> bash-3.00# ./cyclictest -n -p80 -i1000
> 129.85 93.18 38.05 4/45 6354
> 130.41 162.23 83.05 3/49 8395
> T: 0 ( 4621) P:80 I:1000 C: 477097 Min:     25 Act:   64 Avg:   67 Max:
>     286
> 
> bash-3.00# ./hackbench 10
> Time: 95.402
> 
> Could you run your cyclictest much longer?

I'll re-test with your parameters.

> And hackbench takes ages, already without running cyclictest:
> 
>   bash-3.00# time ./hackbench 10
>   Time: 83.157
>   real    1m23.935s
>   user    0m5.692s
>   sys     1m18.240s
> 
> With a standard non-rt kernel it just takes 10 seconds.
> 
>   bash-3.00# time ./hackbench 10
>   Time: 9.690
>   real    0m10.343s
>   user    0m0.404s
>   sys     0m9.928s
> 
> Is this the normal/expected behavior under -rt?

I've no idea where it comes from.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
