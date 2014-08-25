From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Mon, 25 Aug 2014 10:10:55 -0400
Message-ID: <20140825101055.731e4a21@gandalf.local.home>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Harry van Haaren <harryhaaren@gmail.com>,
	linux-rt-users@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:42268 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932233AbaHYOK5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 10:10:57 -0400
In-Reply-To: <CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 25 Aug 2014 19:25:28 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:


> > # Attempt to set min freq of 2GHz (max) of this core2duo
> > $ echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
> > bash: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq: Permission denied
> 
> You tried both these as root? Even 'sudo' may not work..
> 
> I haven't seen the rt code since sometime, what tag should I look at ?
> 

Can you also try the matching vanilla kernel to see if that works? That
is, if you are using 3.14.12-rt9, build and boot 3.14.12 with the same
config (except change CONFIG_PREEMPT_RT_FULL to just CONFIG_PREEMPT)
and see if that doesn't work either.

-- Steve
