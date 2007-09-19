From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for
	powerpc machines.
Date: Wed, 19 Sep 2007 08:43:14 -0700
Message-ID: <1190216594.11899.3.camel@imap.mvista.com>
References: <20070919064947.4B5A1399910@thor>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>,
	johnstul@us.ibm.com
To: Tony Breeds <tony@bakeyournoodle.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:35984 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbXISPqr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Sep 2007 11:46:47 -0400
In-Reply-To: <20070919064947.4B5A1399910@thor>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-09-19 at 16:49 +1000, Tony Breeds wrote:
> +/* clocksource code */
> +/* FIXME: provide an RTC clocksource /or/ use a better name */
> +static cycle_t timebase_read(void)
> +{
> +       if (__USE_RTC())
> +               return (cycle_t)get_rtc();
> +       return (cycle_t)get_tb();
> +}

If you switch to the rtc do the shift and mult need to change?

> +void update_vsyscall(struct timespec *wall_time, struct clocksource
> *clock)
> +{
> +       u64 t2x, stamp_xsec;
> +
> +       if (__USE_RTC() || clock != &clocksource_timebase)
> +               return;
> +
> +       /* Make userspace gettimeofday spin until we're done. */
> +       ++vdso_data->tb_update_count;
> +       smp_mb();
> +
> +       /* XXX this assumes clock->shift == 22 */
> +       /* 4611686018 ~= 2^(20+64-22) / 1e9 */
> +       t2x = (u64) clock->mult * 4611686018ULL;

It might make the code more readable if you put that constant into a
macro that gives it a name.

Daniel
