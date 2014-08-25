From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Mon, 25 Aug 2014 18:58:29 +0200
Message-ID: <20140825185829.2021da78@alchemy.lu>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
 <CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
 <CAKohpo=i0x+GGfV7T7gbZxOqgQCjGRKDvS=YVx+SiBTW0oh6Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Harry van Haaren <harryhaaren@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:54625 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932985AbaHYRRr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 13:17:47 -0400
In-Reply-To: <CAKohpo=i0x+GGfV7T7gbZxOqgQCjGRKDvS=YVx+SiBTW0oh6Gg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 25 Aug 2014 19:26:03 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > On 25 August 2014 17:58, Harry van Haaren <harryhaaren@gmail.com>
> > wrote:
> > You tried both these as root? Even 'sudo' may not work..
> >
> > I haven't seen the rt code since sometime, what tag should I look
> > at ?

Dont' know how this is supposed to work on a system using the pstate
driver, but i have a similar issue:

With the realtime patch, but built with CONFIG_PREEMPT__LL=y
# uname -r
3.14.12-rt9
# uname -v
#1 SMP PREEMPT Mon Aug 25 17:27:37 CEST 2014

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
intel_pstate
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
performance powersave
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
powersave
# echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
performance

But using i7z, I see no change in behaviour on this cpu, while using the
interface in /sys/devices/system/cpu/intel_pstate does seem to work
rather well.

With the realtime patch enabled CONFIG_PREEMPT_RT_FULL=y
# uname -r
3.14.12-rt9-1-rt
# uname -v
#1 SMP PREEMPT RT Sat Aug 23 04:41:50 CEST 2014

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
intel_pstate
#  cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
performance powersave
# echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
bash: echo: write error: Invalid argument
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
powersave

I don't if this is normal for the pstate driver, but if one can't
change governor, i suppose it shouldn't show one either?

--

   Joakim
