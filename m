From: Michael Haberler <mail17@mah.priv.at>
Subject: Re: Detecting PREEMPT_RT
Date: Sun, 20 Jan 2013 16:52:51 +0100
Message-ID: <1819DC75-5826-4882-A2B7-20953DE3392A@mah.priv.at>
References: <50FB36A0.7000702@zultron.com> <50FB4BB1.7070005@osadl.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: John Morris <john@zultron.com>, linux-rt-users@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.mah.priv.at ([86.59.12.250]:36407 "EHLO sil1.mah.priv.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329Ab3ATPw6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Jan 2013 10:52:58 -0500
In-Reply-To: <50FB4BB1.7070005@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Carsten

Am 20.01.2013 um 02:43 schrieb Carsten Emde:

> Unfortunately, this wiki article is old and unmaintained. You're probably right to be a bit suspicious when checking for the "-rt" suffix of the kernel release (uname -r). But looking for the occurrence of "PREEMPT RT" in the kernel version (uname -v) should work. An application may use the system call uname() and check the version element of the utsname structure.

the utsname.version string match is fine, however:

> In addition you may want to make sure the system has high-resolution timers. If so, the timers in /proc/timer_list have ".resolution: 1 nsecs". An application may use the function check_timer() from cyclictest for this purpose:
> static int check_timer(void)
> {
>  struct timespec ts;
> 
>  if (clock_getres(CLOCK_MONOTONIC, &ts))
>    return 1;
> 
>  return (ts.tv_sec != 0 || ts.tv_nsec != 1);
> }

Just tried this on a generic kernel (2.6.32-45-generic #102-Ubuntu SMP Wed Jan 2 21:53:06 UTC 2013 i686 GNU/Linux) and I get ts.tv_sec == 0 and ts.tv_nsec == 1, so it looks this cant be used to tell an RT_PREEMPT from a vanilla kernel

- Michael

