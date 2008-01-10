From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Thu, 10 Jan 2008 14:17:02 +0100
Message-ID: <47861ACE.9060301@grandegger.com>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <20080109090345.GG3177@pengutronix.de> <20080109225107.GV3177@pengutronix.de> <20080110000124.GW3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:42721 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbYAJNRI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jan 2008 08:17:08 -0500
In-Reply-To: <20080110000124.GW3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Robert,

Robert Schwebel wrote:
> Wolfgang,
> 
> On Wed, Jan 09, 2008 at 11:51:07PM +0100, Robert Schwebel wrote:
>> Throwing in the versions from 2.6.23.3-rt5 doesn't help, the effect
>> stays the same. So I assume it is a side effect.
> 
> Can you test the following patch by John Stulz (thanks to John for the quick
> help on irc!), which fixes the issues on my board:
> 
> ----------8<----------
> Index: linux-2.6.24-rc5/arch/powerpc/kernel/time.c
> ===================================================================
> --- linux-2.6.24-rc5.orig/arch/powerpc/kernel/time.c
> +++ linux-2.6.24-rc5/arch/powerpc/kernel/time.c
> @@ -773,7 +773,7 @@ void update_vsyscall(struct timespec *wa
>  	stamp_xsec = (u64) xtime.tv_nsec * XSEC_PER_SEC;
>  	do_div(stamp_xsec, 1000000000);
>  	stamp_xsec += (u64) xtime.tv_sec * XSEC_PER_SEC;
> -	update_gtod(clock->cycle_last, stamp_xsec, t2x);
> +	update_gtod(clock->cycle_last-clock->cycle_accumulated, stamp_xsec, t2x);
>  }
>  
>  void update_vsyscall_tz(void)
> ----------8<----------
> 
> With this patch ontop of 2.6.24-rc5-rt1 plus the board support patches
> for the phyCORE-MPC5200B-tiny, I get this result from cyclictest, again
> under "(while true; do hackbench 10; done) &" load:
> 
> T: 0 (  867) P:80 I:   10000 C:  105002 Min:      31 Act:      48 Avg:      51 Max:      92

Unfortunately, it doesn't really help on my Icecube board.

bash-3.00# ./cyclictest -n -p80 -i1000
129.85 93.18 38.05 4/45 6354
130.41 162.23 83.05 3/49 8395
T: 0 ( 4621) P:80 I:1000 C: 477097 Min:     25 Act:   64 Avg:   67 Max:
    286

bash-3.00# ./hackbench 10
Time: 95.402

Could you run your cyclictest much longer?

And hackbench takes ages, already without running cyclictest:

  bash-3.00# time ./hackbench 10
  Time: 83.157
  real    1m23.935s
  user    0m5.692s
  sys     1m18.240s

With a standard non-rt kernel it just takes 10 seconds.

  bash-3.00# time ./hackbench 10
  Time: 9.690
  real    0m10.343s
  user    0m0.404s
  sys     0m9.928s

Is this the normal/expected behavior under -rt?

Wolfgang.
