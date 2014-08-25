From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Mon, 25 Aug 2014 16:03:27 +0100
Message-ID: <CAKudYbPbvNJTuXpf-hnXvawnyD7UHcW9nQExPWX27to-qTkXTg@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
	<20140825101055.731e4a21@gandalf.local.home>
	<53FB4EEF.3060809@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-rt-users@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>
To: pavel@pavlinux.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:64632 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbaHYPD3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 11:03:29 -0400
Received: by mail-la0-f48.google.com with SMTP id gl10so12825546lab.7
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Aug 2014 08:03:27 -0700 (PDT)
In-Reply-To: <53FB4EEF.3060809@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Aug 25, 2014 at 3:57 PM, Pavel Vasilyev <pavel@pavlinux.ru> wrote:
>>>> # Attempt to set min freq of 2GHz (max) of this core2duo
>>>> $ echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
>>>> bash: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq: Permission
>>>> denied
>
> cpuinfo_min_freq - Read-only file, use scaling_min_freq

$ echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
bash: echo: write error: Invalid argument

No success there.
