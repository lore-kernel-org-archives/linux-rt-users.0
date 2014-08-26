From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Tue, 26 Aug 2014 23:44:16 +0100
Message-ID: <CAKudYbOMKp437Sqq-A8m4A-d-rLHCGLXM5cH3ep13vp11ocJyg@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
	<CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
	<CAKohpokc+PiviEt3_2h0JjiH-XUuxiR5Tt6=NnJqTrCL_i98sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:44589 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798AbaHZWoS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Aug 2014 18:44:18 -0400
Received: by mail-la0-f49.google.com with SMTP id hz20so15856487lab.36
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Aug 2014 15:44:16 -0700 (PDT)
In-Reply-To: <CAKohpokc+PiviEt3_2h0JjiH-XUuxiR5Tt6=NnJqTrCL_i98sA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Aug 26, 2014 at 5:34 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Can you try to debug it with some prints?
>
> The functions  of interest would be, drivers/cpufreq/cpufreq.c:
> - static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
> - static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
> const char *buf, size_t count)
>
> Try to add some prints there while returning errors and then try to change
> governor from userspace and things might get somewhat better then..

I will: unfortunatly I won't have time due to buisness trip until next week.
I've scheduled some time for rebuilding with prints then.

Thanks for the suggestion, I'll update once I have more info, -Harry
