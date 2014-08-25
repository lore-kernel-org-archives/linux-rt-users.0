From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Mon, 25 Aug 2014 19:25:28 +0530
Message-ID: <CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Harry van Haaren <harryhaaren@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:55744 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbaHYNz2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 09:55:28 -0400
Received: by mail-oi0-f44.google.com with SMTP id x69so9691516oia.3
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Aug 2014 06:55:28 -0700 (PDT)
In-Reply-To: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 25 August 2014 17:58, Harry van Haaren <harryhaaren@gmail.com> wrote:
> I'm attempting to squeeze the lowest audio-latency out of a laptop as possible,
> and in doing so would like to set the CPU to performance.
>
> CPU in laptop: Intel(R) Core(TM)2 Duo CPU T7300 @ 2.00GHz
>
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
> ondemand performance
>
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
> acpi-cpufreq
>
> # Attempt to set performance governer
> $ echo "performance" >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> bash: echo: write error: Invalid argument
>
> # Attempt to set min freq of 2GHz (max) of this core2duo
> $ echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
> bash: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq: Permission denied

You tried both these as root? Even 'sudo' may not work..

I haven't seen the rt code since sometime, what tag should I look at ?

I don't think there should be any such issues there..

> As far as I can tell, it is currently impossible on the -rt kernel to
> change CPU governer?
> This is necessary for reliable low-latency audio for laptop musicians.
>
> What is necessary to fix cpufreq on -rt? Cheers, -Harry
>
> PS: I've CC'd maintainers of cpufreq, I hope that's OK, otherwise
> please inform me of
> normal practices on linux-rt-users ML

That's fine I suppose.
