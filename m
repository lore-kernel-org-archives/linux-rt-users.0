From: David L <idht4n@gmail.com>
Subject: idle task starvation with rt patch
Date: Wed, 6 May 2009 12:47:11 -0700
Message-ID: <b79371120905061247o72198a1ak6b4527ebfb60098a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:34849 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbZEFTrN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 May 2009 15:47:13 -0400
Received: by ey-out-2122.google.com with SMTP id 9so138224eyd.37
        for <linux-rt-users@vger.kernel.org>; Wed, 06 May 2009 12:47:12 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm a newbie trying to see if the rt patch will improve
the performance of a PPC Linux receiver.  We need
to read data from an FGPA correlator about every msec
although we can tolerate 5-10 msecs from time to time.

Without the real-time patches, we find that we sometimes
miss our timing deadlines especially when we have multiple
processes with "real-time" (SCHED_FIFO) threads.  I tried
to use the 2.6.29.2-rt11 patch to see if it helped, but things
got much worse.  We have about 30-60 percent idle CPU
without the patches... after applying the patches, I found
that we had essentially no idle time.  Below are excepts
from the kernel sched_switch trace file while our process
is running with and without the real-time patches applied.

I notice there are IRQ-related processes with the real-time
patches that don't exist in without the patches.  But the main
thing to notice is that there is no idle time which eventually
causes the process to crash because low priority threads
are starved for too long.  Am I doing something wrong or
is it expected overhead of the real-time patches will cause
problems like this under this kind of interrupt load?

Thanks,

                 David


       rx-10082 [000]  2123.751923:  10082: 50:R   + [000]   181: 49:D IRQ-151
        rx-10082 [000]  2123.751942:  10082: 50:R ==> [000]   181: 49:R IRQ-151
         IRQ-151-181   [000]  2123.751989:    181: 49:D   + [000] 10081: 48:D rx
         IRQ-151-181   [000]  2123.752006:    181: 49:D ==> [000] 10081: 48:R rx
        rx-10081 [000]  2123.752065:  10081: 48:T ==> [000]   181: 48:D IRQ-151
         IRQ-151-181   [000]  2123.752095:    181: 48:D   + [000] 10081: 48:T rx
         IRQ-151-181   [000]  2123.752116:    181: 49:D ==> [000] 10081: 48:S rx
        rx-10081 [000]  2123.752209:  10081: 48:R   + [000]   900: 49:D IRQ-18
        rx-10081 [000]  2123.752345:  10081: 48:R   + [000]     4:
49:D sirq-timer/0
        rx-10081 [000]  2123.753061:  10081: 48:D ==> [000]   181: 49:D IRQ-151
         IRQ-151-181   [000]  2123.753184:    181: 49:D ==> [000]
900: 49:R IRQ-18
          IRQ-18-900   [000]  2123.753231:    900: 49:R   + [000]
181: 49:D IRQ-151
          IRQ-18-900   [000]  2123.753304:    900: 49:D ==> [000]
4: 49:R sirq-timer/0
    sirq-timer/0-4     [000]  2123.753366:      4: 49:D ==> [000]
181: 49:R IRQ-151
         IRQ-151-181   [000]  2123.753442:    181: 49:D ==> [000] 10082: 50:R rx
        rx-10082 [000]  2123.753482:  10082: 50:R   + [000]   181: 49:D IRQ-151
        rx-10082 [000]  2123.753502:  10082: 50:R ==> [000]   181: 49:R IRQ-151
         IRQ-151-181   [000]  2123.753549:    181: 49:D   + [000] 10081: 48:D rx
         IRQ-151-181   [000]  2123.753565:    181: 49:D ==> [000] 10081: 48:R rx
        rx-10081 [000]  2123.753626:  10081: 48:T ==> [000]   181: 48:D IRQ-151
         IRQ-151-181   [000]  2123.753655:    181: 48:D   + [000] 10081: 48:T rx
         IRQ-151-181   [000]  2123.753676:    181: 49:D ==> [000] 10081: 48:S rx
        rx-10081 [000]  2123.754014:  10081: 48:R   + [000]   900: 49:D IRQ-18
        rx-10081 [000]  2123.754511:  10081: 48:D ==> [000]   181: 49:D IRQ-151
         IRQ-151-181   [000]  2123.754597:    181: 49:D ==> [000]
900: 49:R IRQ-18
          IRQ-18-900   [000]  2123.754654:    900: 49:D   + [000]
181: 49:D IRQ-151
          IRQ-18-900   [000]  2123.754708:    900: 49:D ==> [000]
181: 49:R IRQ-151
         IRQ-151-181   [000]  2123.754787:    181: 49:D ==> [000] 10082: 50:R rx
        rx-10082 [000]  2123.754826:  10082: 50:R   + [000]   181: 49:D IRQ-151
        rx-10082 [000]  2123.754844:  10082: 50:R ==> [000]   181: 49:R IRQ-151
         IRQ-151-181   [000]  2123.754903:    181: 49:D   + [000]
900: 49:D IRQ-18
         IRQ-151-181   [000]  2123.754930:    181: 49:D   + [000] 10081: 48:D rx
         IRQ-151-181   [000]  2123.754946:    181: 49:D ==> [000] 10081: 48:R rx
        rx-10081 [000]  2123.755006:  10081: 48:T ==> [000]   181: 48:D IRQ-151
         IRQ-151-181   [000]  2123.755036:    181: 48:D   + [000] 10081: 48:T rx
         IRQ-151-181   [000]  2123.755058:    181: 49:D ==> [000] 10081: 48:S rx
        rx-10081 [000]  2123.755799:  10081: 48:D ==> [000]   900: 49:R IRQ-18
          IRQ-18-900   [000]  2123.755903:    900: 49:D ==> [000]
181: 49:D IRQ-151
         IRQ-151-181   [000]  2123.755960:    181: 49:D   + [000] 10081: 48:D rx
         IRQ-151-181   [000]  2123.755977:    181: 49:D ==> [000] 10081: 48:R rx
        rx-10081 [000]  2123.756033:  10081: 48:T ==> [000]   181: 48:D IRQ-151
         IRQ-151-181   [000]  2123.756063:    181: 48:D   + [000] 10081: 48:T rx


        rx-2440  [000]   642.061841:   2440: 48:S ==> [000]  2451: 72:R
        rx-2451  [000]   642.061979:   2451: 72:R   + [000]  2447: 50:S
        rx-2451  [000]   642.062015:   2451: 72:R ==> [000]  2447: 50:R
        rx-2447  [000]   642.062205:   2447: 50:S ==> [000]  2451: 72:R
        rx-2451  [000]   642.062303:   2451: 72:S ==> [000]   905:120:R
         telnetd-905   [000]   642.062503:    905:120:R   + [000]  2440: 48:S
         telnetd-905   [000]   642.062560:    905:120:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.062798:   2440: 48:S ==> [000]   905:120:R
         telnetd-905   [000]   642.063368:    905:120:R   + [000]  2440: 48:S
         telnetd-905   [000]   642.063427:    905:120:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.063747:   2440: 48:S ==> [000]   905:120:R
         telnetd-905   [000]   642.063996:    905:120:S ==> [000]     0:140:R
          <idle>-0     [000]   642.064275:      0:140:R   + [000]  2440: 48:S
          <idle>-0     [000]   642.064362:      0:140:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.064580:   2440: 48:S ==> [000]     0:140:R
          <idle>-0     [000]   642.065170:      0:140:R   + [000]  2440: 48:S
          <idle>-0     [000]   642.065257:      0:140:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.065437:   2440: 48:S ==> [000]     0:140:R
          <idle>-0     [000]   642.066070:      0:140:R   + [000]  2440: 48:S
          <idle>-0     [000]   642.066156:      0:140:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.066352:   2440: 48:S ==> [000]     0:140:R
          <idle>-0     [000]   642.066969:      0:140:R   + [000]  2440: 48:S
          <idle>-0     [000]   642.067056:      0:140:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.067364:   2440: 48:S ==> [000]     0:140:R
          <idle>-0     [000]   642.067872:      0:140:R   + [000]  2440: 48:S
          <idle>-0     [000]   642.067958:      0:140:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.068167:   2440: 48:S ==> [000]     0:140:R
          <idle>-0     [000]   642.068770:      0:140:R   + [000]  2440: 48:S
          <idle>-0     [000]   642.068857:      0:140:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.069032:   2440: 48:S ==> [000]     0:140:R
          <idle>-0     [000]   642.069668:      0:140:R   + [000]  2440: 48:S
          <idle>-0     [000]   642.069755:      0:140:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.069956:   2440: 48:S ==> [000]     0:140:R
          <idle>-0     [000]   642.070569:      0:140:R   + [000]  2440: 48:S
          <idle>-0     [000]   642.070655:      0:140:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.070851:   2440: 48:S ==> [000]     0:140:R
          <idle>-0     [000]   642.071529:      0:140:R   + [000]  2440: 48:S
          <idle>-0     [000]   642.071722:      0:140:R ==> [000]  2440: 48:R
        rx-2440  [000]   642.071866:   2440: 48:R   + [000]  2451: 72:S
