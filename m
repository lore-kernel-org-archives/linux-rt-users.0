From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch] clockevents: Reinstate the per cpu tick skew
Date: Wed, 28 Dec 2011 14:32:06 +0100
Message-ID: <4EFB1A56.1040902@linux.intel.com>
References: <1324717569.5025.73.camel@marge.simson.net>  <1324968044.5217.103.camel@marge.simson.net> <1324977605.5217.132.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:36662 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507Ab1L1NcI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Dec 2011 08:32:08 -0500
In-Reply-To: <1324977605.5217.132.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/27/2011 10:20 AM, Mike Galbraith wrote:
> 
> Quoting removal commit af5ab277ded04bd9bc6b048c5a2f0e7d70ef0867 
> Historically, Linux has tried to make the regular timer tick on
> the various CPUs not happen at the same time, to avoid contention
> on xtime_lock.
> 
> Nowadays, with the tickless kernel, this contention no longer
> happens since time keeping and updating are done differently. In
> addition, this skew is actually hurting power consumption in a
> measurable way on many-core systems. End quote
> 
> Contention remains a problem if NO_HZ is either not configured, or
> is nohz=off disabled due to workload constraints.  The RT kernel
> running nohz=off was measured to be using > 1.4% CPU just ticking
> 64 CPUs, with tick perturbation reaching ~80us.  For loads where
> measured (>100us) NO_HZ latencies are intolerable, a must have.

I think we need to just say no to this, and kill the nohz=off option
entirely.

Seriously, are people still running with ticks for any legitimate
reasons? (and not just because they goofed their config file)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJO+xpVAAoJEEHdSxh4DVnEMvUH/A5qOO+igivDtdEjw5b39w3h
4fG7VLiyn34+AAFmBqfgx9dKbl4DkYzBBRYXcNVnicnjqnH7ZZ+FOvFo2zOCUiGG
xeDNox4hcl1jJ/6J1o6p1ecJXOUlbwNsXF9SVG38HPpJ4D0mgllAdy1wHJfv3+LA
Ad98sUDmhq2gpcjyupvv7exIor1i3JFo/Q+CFbDTVQrgz99zo/D2IX3ps4wRfhHq
q0rKcU4ZZJVHeHkItHOyEgeex9RPGlxNRSUu50zIHKugVlH9wbTtIzBkPzt1Nn0S
yThyQGd/xcFfQDaiwymWLf78d6wpEZ/BW+QIlPlO2xNMD/Qz980w86yyh0x2FQk=
=yDHd
-----END PGP SIGNATURE-----
