From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Mon, 25 Aug 2014 18:36:30 +0100
Message-ID: <CAKudYbM+p_2MNHH=ytwkQ5R3P-xiGmhpK_zdyCRgX2e_UiMUtg@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
	<CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
	<53FB6FE6.30408@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:55505 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbaHYRgc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 13:36:32 -0400
Received: by mail-la0-f43.google.com with SMTP id gi9so10971821lab.2
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Aug 2014 10:36:30 -0700 (PDT)
In-Reply-To: <53FB6FE6.30408@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Aug 25, 2014 at 6:18 PM, Fernando Lopez-Lezcano
<nando@ccrma.stanford.edu> wrote:
> Hi Harry,
Hey!

> Check to see if you see something in /sys/devices/system/cpu/intel_pstate/
My core2duo doesn't have intel_pstate, its too old!

> https://wiki.archlinux.org/index.php/CPU_frequency_scaling
These options (cpupower frequency-set -g performance) don't work, see
output as root user:

[root@audio ~]# cpupower frequency-set -g performance
Setting cpu: 0
Error setting new values. Common errors:
- Do you have proper administration rights? (super-user?)
- Is the governor you requested available and modprobed?
- Trying to set an invalid policy?
- Trying to set a specific frequency, but userspace governor is not available,
   for example because of hardware which cannot be set to a specific frequency
   or because the userspace governor isn't loaded?

Cheers, -Harry
