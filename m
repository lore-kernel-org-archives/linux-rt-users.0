From: Paolo <prallo@gmail.com>
Subject: Problems with FTrace
Date: Mon, 28 Sep 2009 17:32:22 +0200
Message-ID: <6f2879e10909280832x3e5fadebha9b2966495812da8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:51569 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbZI1Pcj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Sep 2009 11:32:39 -0400
Received: by ewy7 with SMTP id 7so4538673ewy.17
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Sep 2009 08:32:42 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I need to know if a task is periodic or not and other informations (as
the duration). I used the sched_switch function of ftrace to trace
this behaviour.
In order to have a proof of the tracing I used the cyclictest program.

The first time I tested the tracing goddness with a single cpu and the
second time with all cpu online (2).
In the first call the times was correct, in the second not: the
periodicity of the cyclictask doesn't seem correct.

The periodicity is the interval between two wakes up of the same task
and has to be  more or less constant, right?
The difference between two wakes up in my test (with 2 cpu) is not
constant, and the misured time is very different from the time set.

The test was:

mount -t debugfs nodev /tmp

echo nop > /tmp/tracing/current_tracer
echo 1 > /tmp/tracing/tracing_enabled
echo 0 > /tmp/tracing/tracing_enabled

echo sched_switch > /tmp/tracing/current_tracer
echo 1 > /tmp/tracing/tracing_enabled

./cyclictest -l 1000 -i 500 -n -t1

echo 0 > /tmp/tracing/tracing_enabled

The trace file shows (cat trace | grep + | grep 5036, where 5036 is
the pid of the cyclictest thread):
...
          <idle>-0     [001]   174.705470:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.705559:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.705648:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.705738:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.705966:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.706056:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.706500:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.706999:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.707505:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.707602:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.707691:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.707781:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.707868:      0:140:R   + [001]  5036:120:S
          <idle>-0     [001]   174.707957:      0:140:R   + [001]  5036:120:S
...

Maybe I didn't set correctly the parameter of cyclictest and/or sched_switch.
Is it possible a bug? Notice I use the 2.6.29.rc6 kernel.
