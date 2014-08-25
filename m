From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Mon, 25 Aug 2014 19:26:03 +0530
Message-ID: <CAKohpo=i0x+GGfV7T7gbZxOqgQCjGRKDvS=YVx+SiBTW0oh6Gg@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Harry van Haaren <harryhaaren@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:34462 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbaHYN4D (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 09:56:03 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so10752232oag.2
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Aug 2014 06:56:03 -0700 (PDT)
In-Reply-To: <CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Fixing Rafael's id..

On 25 August 2014 19:25, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25 August 2014 17:58, Harry van Haaren <harryhaaren@gmail.com> wrote:
>> I'm attempting to squeeze the lowest audio-latency out of a laptop as possible,
>> and in doing so would like to set the CPU to performance.
>>
>> CPU in laptop: Intel(R) Core(TM)2 Duo CPU T7300 @ 2.00GHz
>>
>> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
>> ondemand performance
>>
>> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>> acpi-cpufreq
>>
>> # Attempt to set performance governer
>> $ echo "performance" >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>> bash: echo: write error: Invalid argument
>>
>> # Attempt to set min freq of 2GHz (max) of this core2duo
>> $ echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
>> bash: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq: Permission denied
>
> You tried both these as root? Even 'sudo' may not work..
>
> I haven't seen the rt code since sometime, what tag should I look at ?
>
> I don't think there should be any such issues there..
>
>> As far as I can tell, it is currently impossible on the -rt kernel to
>> change CPU governer?
>> This is necessary for reliable low-latency audio for laptop musicians.
>>
>> What is necessary to fix cpufreq on -rt? Cheers, -Harry
>>
>> PS: I've CC'd maintainers of cpufreq, I hope that's OK, otherwise
>> please inform me of
>> normal practices on linux-rt-users ML
>
> That's fine I suppose.
