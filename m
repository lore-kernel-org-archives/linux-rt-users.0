From: Andreas O <andreas2025@gmail.com>
Subject: Linux tracing time stamps on 2.6.33.7 OMAP L138
Date: Mon, 26 Sep 2011 00:25:45 +0100
Message-ID: <CAAVaN8zW4R+rKaVFY1wvVTo5toOBmqc+J3=KQ1cHqYgS5PdsNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58007 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab1IYXZr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Sep 2011 19:25:47 -0400
Received: by bkbzt4 with SMTP id zt4so5177369bkb.19
        for <linux-rt-users@vger.kernel.org>; Sun, 25 Sep 2011 16:25:45 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am using a Real-Time linux kernel 2.6.33.7 and I try to measure some
latencies on the platform ARM926 OMAPL138.
I think something is wrong with the timestamps
.
The platform timer.c file provides a timer, for time events, and one
free running clocksource.

Any ideas of what may be wrong?

/*
 * clocksource
 */
static cycle_t read_cycles(struct clocksource *cs)
{
        struct timer_s *t = &timers[TID_CLOCKSOURCE];

        return (cycles_t)timer32_read(t);
}

static struct clocksource clocksource_davinci = {
        .rating         = 300,
        .read           = read_cycles,
        .mask           = CLOCKSOURCE_MASK(32),
        .shift          = 24,
        .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
};



 kmmcd-188     0dNh4. 134260000us :    188:120:R   + [000]    12: 50:S
sirq-rcu/0
   kmmcd-188     0...2. 134260000us :    188:120:R ==> [000]     4:
50:R sirq-timer/0
sirq-tim-4       0d..3. 134260000us :      4: 50:R   + [000]
366:120:S TPS6507x Touchs
sirq-tim-4       0...2. 134260000us :      4: 50:S ==> [000]    12:
50:R sirq-rcu/0
sirq-rcu-12      0...2. 134260000us :     12: 50:S ==> [000]
366:120:R TPS6507x Touchs
TPS6507x-366     0...2. 134260000us!:    366:120:S ==> [000]   188:120:R kmmcd
   kmmcd-188     0d.h4. 134270000us :    188:120:R   + [000]     4:
50:S sirq-timer/0
   kmmcd-188     0dNh4. 134270000us :    188:120:R   + [000]    12:
50:S sirq-rcu/0
   kmmcd-188     0...2. 134270000us :    188:120:R ==> [000]     4:
50:R sirq-timer/0
sirq-tim-4       0...2. 134270000us :      4: 50:S ==> [000]    12:
50:R sirq-rcu/0
sirq-rcu-12      0...2. 134270000us!:     12: 50:S ==> [000]   188:120:R kmmcd
   kmmcd-188     0d.h4. 134280000us :    188:120:R   + [000]     4:
50:S sirq-timer/0
   kmmcd-188     0dNh4. 134280000us :    188:120:R   + [000]    12:
50:S sirq-rcu/0
   kmmcd-188     0...2. 134280000us :    188:120:R ==> [000]     4:
50:R sirq-timer/0
sirq-tim-4       0...2. 134280000us :      4: 50:S ==> [000]    12:
50:R sirq-rcu/0
sirq-rcu-12      0...2. 134280000us!:     12: 50:S ==> [000]   188:120:R kmmcd
   kmmcd-188     0d.h4. 134290000us :    188:120:R   + [000]     4:
50:S sirq-timer/0
   kmmcd-188     0dNh4. 134290000us :    188:120:R   + [000]    12:
50:S sirq-rcu/0
   kmmcd-188     0...2. 134290000us :    188:120:R ==> [000]     4:
50:R sirq-timer/0
sirq-tim-4       0d..3. 134290000us :      4: 50:R   + [000]
366:120:S TPS6507x Touchs
sirq-tim-4       0...2. 134290000us :      4: 50:S ==> [000]    12:
50:R sirq-rcu/0
sirq-rcu-12      0...2. 134290000us :     12: 50:S ==> [000]
366:120:R TPS6507x Touchs
TPS6507x-366     0...2. 134290000us!:    366:120:S ==> [000]   188:120:R kmmcd
   kmmcd-188     0d.h4. 134300000us :    188:120:R   + [000]     4:
50:S sirq-timer/0
   kmmcd-188     0dNh4. 134300000us :    188:120:R   + [000]    12:
50:S sirq-rcu/0
   kmmcd-188     0...2. 134300000us :    188:120:R ==> [000]     4:
50:R sirq-timer/0
sirq-tim-4       0...2. 134300000us :      4: 50:S ==> [000]    12:
50:R sirq-rcu/0
sirq-rcu-12      0...2. 134300000us!:     12: 50:S ==> [000]   188:120:R kmmcd
   kmmcd-188     0d.h4. 134310000us :    188:120:R   + [000]     4:
50:S sirq-timer/0
   kmmcd-188     0dNh4. 134310000us :    188:120:R   + [000]    12:
50:S sirq-rcu/0
   kmmcd-188     0...2. 134310000us :    188:120:R ==> [000]     4:
50:R sirq-timer/0
sirq-tim-4       0...2. 134310000us :      4: 50:S ==> [000]    12:
50:R sirq-rcu/0
sirq-rcu-12      0...2. 134310000us!:     12: 50:S ==> [000]   188:120:R kmmcd
   kmmcd-188     0d.h4. 134320000us :    188:120:R   + [000]     4:
50:S sirq-timer/0
   kmmcd-188     0dNh4. 134320000us :    188:120:R   + [000]    12:
50:S sirq-rcu/0
   kmmcd-188     0...2. 134320000us :    188:120:R ==> [000]     4:
50:R sirq-timer/0
sirq-tim-4       0d..3. 134320000us :      4: 50:R   + [000]    15:
98:S events/0

TIA
Andreas
