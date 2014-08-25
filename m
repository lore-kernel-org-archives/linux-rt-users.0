From: Harry van Haaren <harryhaaren@gmail.com>
Subject: CpuFreq Laptop Scaling broken?
Date: Mon, 25 Aug 2014 13:28:27 +0100
Message-ID: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rjw@sisk.pl, viresh.kumar@linaro.org, tglx@linutronix.de,
	rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:54444 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379AbaHYM22 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 08:28:28 -0400
Received: by mail-lb0-f178.google.com with SMTP id c11so12090446lbj.37
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Aug 2014 05:28:27 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi -rt users, and CC's,

I'm attempting to squeeze the lowest audio-latency out of a laptop as possible,
and in doing so would like to set the CPU to performance.

CPU in laptop: Intel(R) Core(TM)2 Duo CPU T7300 @ 2.00GHz

$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
ondemand performance

$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
acpi-cpufreq

# Attempt to set performance governer
$ echo "performance" >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
bash: echo: write error: Invalid argument

# Attempt to set min freq of 2GHz (max) of this core2duo
$ echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
bash: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq: Permission denied

As far as I can tell, it is currently impossible on the -rt kernel to
change CPU governer?
This is necessary for reliable low-latency audio for laptop musicians.

What is necessary to fix cpufreq on -rt? Cheers, -Harry

PS: I've CC'd maintainers of cpufreq, I hope that's OK, otherwise
please inform me of
normal practices on linux-rt-users ML
