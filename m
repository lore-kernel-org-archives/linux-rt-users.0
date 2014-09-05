From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Fri, 5 Sep 2014 18:20:30 +0530
Message-ID: <CAKohpokO6+=5LMr99CVyZYbTHRaUvgkAhHLkgfRaV3LJSfgpkg@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
	<CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
	<CAKohpokc+PiviEt3_2h0JjiH-XUuxiR5Tt6=NnJqTrCL_i98sA@mail.gmail.com>
	<CAKudYbOMKp437Sqq-A8m4A-d-rLHCGLXM5cH3ep13vp11ocJyg@mail.gmail.com>
	<CAKudYbPyN0GZ1pMPLQMd_Ks0hELBhE35SN8A1hi3_v8MMPVAjg@mail.gmail.com>
	<CAKohpokeUufzx7so6FcEd8rAg-MPw+2c9Aug9L_vXdu_4MvNOA@mail.gmail.com>
	<CAKudYbP09tc8JbBt82pOSy5nfQ42BVv=4knEUhHzz6nbs03SvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Harry van Haaren <harryhaaren@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:54773 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183AbaIEMua (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Sep 2014 08:50:30 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so8470013oag.34
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Sep 2014 05:50:30 -0700 (PDT)
In-Reply-To: <CAKudYbP09tc8JbBt82pOSy5nfQ42BVv=4knEUhHzz6nbs03SvQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 5 September 2014 17:36, Harry van Haaren <harryhaaren@gmail.com> wrote:
> The down_read_trylock() fails, the other checks are fine.

So my initial guess was correct :)

> If i'm understanding correctly, the cpufreq_rwsem locks the module
> from being unloaded during critical sections while writing to CPU
> speed etc?

Its not about changing speed, but its more of a lock for critical sections
only.. So, yes its required..

> Would that mean that an un-matched pair of down_read() up_write()
> could cause the failure of changing CPU speed?

Probably yes, but why doesn't that happen without rt?

@Steven: Any guesses ?
