From: Jens Koehler <jenskxxx@googlemail.com>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Fri, 12 Aug 2016 20:48:20 +0200
Message-ID: <CAL7_A_VXSgis2sKfJwgit_V5OLYx7GCSVvFr12rsm-iTF7=gMw@mail.gmail.com>
References: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
 <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de> <20160808164505.GA13707@linutronix.de>
 <CAL7_A_Vz+BCg-QXraob1ndDF4b3ggGN-j+fnQ9FTqY1FdbVvug@mail.gmail.com> <20160812123735.zboeocbv4o5sjnwb@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:33108 "EHLO
	mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbcHLSsW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Aug 2016 14:48:22 -0400
Received: by mail-ua0-f170.google.com with SMTP id 74so55724486uau.0
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Aug 2016 11:48:21 -0700 (PDT)
In-Reply-To: <20160812123735.zboeocbv4o5sjnwb@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you for explanation.

In the application running two real time threads. First one runs with
a sleep time of 2 ms and the second one with 100ms. In difference to
Hello World example from
https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO the calculation
of sleep time starts always with clock_gettime. Could this cause the
problem?

while(1)
{
   //do the stuff

   clock_gettime(CLOCK_MONOTONIC, &tsleep);
   tsleep.tv_nsec += TimerThreadPeriod_ns;
   while (tsleep.tv_nsec >= NSEC_PER_SEC)
   {
      tsleep.tv_nsec -= NSEC_PER_SEC;
      tsleep.tv_sec++;
   }
   clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &tsleep, NULL);
}

How can we find the min delta for our CPU?

Jens
