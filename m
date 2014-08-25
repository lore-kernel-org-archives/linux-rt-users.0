From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Mon, 25 Aug 2014 10:18:30 -0700
Message-ID: <53FB6FE6.30408@localhost>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com> <CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: nando@ccrma.Stanford.EDU, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, rjw@rjwysocki.net
To: Harry van Haaren <harryhaaren@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.219.81]:45809 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932187AbaHYR2d (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 13:28:33 -0400
In-Reply-To: <CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/25/2014 07:02 AM, Harry van Haaren wrote:
> On Mon, Aug 25, 2014 at 2:55 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> You tried both these as root? Even 'sudo' may not work..
> Yes, the original output was all as root (not sudo, genuine root).
>
>> I haven't seen the rt code since sometime, what tag should I look at ?
> I'm running 3.14.12-rt9-1-rt  (as packaged for Arch here:
> https://aur.archlinux.org/packages/linux-rt )

Hi Harry,

Check to see if you see something in /sys/devices/system/cpu/intel_pstate/

If so then the intel pstate driver is what is controlling cpu speed for 
you (that changed since 3.9 or so). You can set min_perf_pct to "100" to 
set your minimum cpu speed to the maximum possible. Even then you will 
see some variation but in my usage case jackd is again usable after this 
change[*].

See:
https://wiki.archlinux.org/index.php/CPU_frequency_scaling

-- Fernando

[*] I think the intel pstate drive is not yet aware of what the 
scheduler does with tasks (or visceversa). In the case of jackd I think 
that the scheduler can move a task to a processor that is throttled down 
and the change in speed after detecting high load does not happen fast 
enough. Jackd runs out of cpu cycles and you get an xrun. By the next 
jackd cycle the cpu is running up to speed and everything is fine but 
the task might be moved again to a different core. Just speculation on 
my part.

