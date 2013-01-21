From: Scot Salmon <scot.salmon@ni.com>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Mon, 21 Jan 2013 09:36:38 -0600
Message-ID: <OF48F68A41.A33D8F99-ON86257AFA.0053184D-86257AFA.0055C08D@ni.com>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com> <alpine.LFD.2.02.1210311949400.2756@ionos> <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com> <50A55664.2090605@us.ibm.com> <OF701783A6.DD321DA8-ON86257AD9.0065C5C7-86257AD9.0071DB52@ni.com> <50D22A41.2070503@linaro.org> <20130105040946.GA17645@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: John Stultz <john.stultz@linaro.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver6.natinst.com ([130.164.80.6]:47047 "EHLO
	spamkiller06.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab3AUPgv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Jan 2013 10:36:51 -0500
In-Reply-To: <20130105040946.GA17645@netboy.at.omicron.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Richard Cochran <richardcochran@gmail.com> wrote on 01/04/2013 10:09:46 
PM:
> Instead of looking for new system calls, why not just solve this
> problem at the application level?
> 
> 1. boot machine
> 2. start ptp4l
> 3. wait five seconds
> 4. start control app, and just use clock_realtime
> 
> HTH,
> Richard

Richard and I talked about this a bit (thank you again Richard).  My 
solution needs to handle a variety of different clock shift scenarios, 
because I'm not designing the final application but trying to provide a 
system that can support a variety of applications.  I think the two 
variables that matter most are (1) that the two controllers might be on 
the same subnet or in different countries, and (2) that they might be 
synced by 1588 or SNTP.  Another possibly important variable is that the 
time sync server might not be reliably available.  Ideally the same system 
would work on all the combinations. 

Richard suggested a user-mode solution where I just sample the two clocks 
in a tight loop and determine the shift between them by the smallest delta 
across N loops.  That solution is nice for a couple of reasons, first, no 
syscall, second, it supports arbitrary combinations of clockid's really 
nicely.

One drawback of that solution for me is that for the specific clocks I 
care about (MONO and REAL) it is not optimal.  The delta between those two 
clocks is available in the kernel timekeeping data, so a syscall just 
handling those two would be able to get the exact offset quickly.  I'd 
still really like to be able to get that offset.

One way to do that would be to take a small step along the clock_gettime2 
path and just have it return an error if the clockid's are anything other 
than MONO and REAL.  That seems ugly, but it's straightforward to 
implement, and would work for me and maybe others with basically similar 
requirements, so I'll throw it out there.  Another option is to continue 
all the way down the clock_gettime2 path, as John suggested:

> Basically you need to split the current accsessor functions into two 
parts:
> 1) The clocksource hardware read
> 2) The time calculation, given the clocksource value
> 
> Then for the gettime2() implementation, do a *single* read of the 
> hardware, and pass that clocksource value into the different specified 
> clockid functions.
> 
> Another important thing to consider here, is that if we are considering 
> adding a new syscall, we should avoid the 2038 issue, and specify a new 
> time64_t and timespec64 types, and use them in the new interface. This 
> way we can provide a 64bit time interface for 32bit systems.

This is something I'd like to work on, but it seems like a significant 
project, and I'm wondering if it might be acceptable to start with the 
reduced functionality version I mentioned above and work towards this.

As a side note, Richard mentioned that the idea of a CLOCK_TAI has been 
thrown around before.  I agree with him that it would be a useful addition 
for test & measurement applications.

-Scot
