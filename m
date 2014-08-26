From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Tue, 26 Aug 2014 10:04:26 +0530
Message-ID: <CAKohpokc+PiviEt3_2h0JjiH-XUuxiR5Tt6=NnJqTrCL_i98sA@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
	<CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Harry van Haaren <harryhaaren@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:64204 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbaHZEe1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Aug 2014 00:34:27 -0400
Received: by mail-oi0-f46.google.com with SMTP id i138so10298245oig.19
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Aug 2014 21:34:26 -0700 (PDT)
In-Reply-To: <CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 25 August 2014 19:32, Harry van Haaren <harryhaaren@gmail.com> wrote:
> On Mon, Aug 25, 2014 at 2:55 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> You tried both these as root? Even 'sudo' may not work..
> Yes, the original output was all as root (not sudo, genuine root).
>
>> I haven't seen the rt code since sometime, what tag should I look at ?
> I'm running 3.14.12-rt9-1-rt  (as packaged for Arch here:
> https://aur.archlinux.org/packages/linux-rt )

I don't have a clue of what's going wrong here..

But my guess would be that something is not working with locking, as that's
one of the main difference between rt and non-rt kernels.

Can you try to debug it with some prints?

The functions  of interest would be, drivers/cpufreq/cpufreq.c:
- static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
- static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
const char *buf, size_t count)

Try to add some prints there while returning errors and then try to change
governor from userspace and things might get somewhat better then..

--
viresh
