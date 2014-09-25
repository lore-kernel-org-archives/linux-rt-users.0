From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Thu, 25 Sep 2014 13:44:06 +0100
Message-ID: <CAKudYbOJPvfX+1EfYC2nNJAtZpNuXugxtzVb6aV=91Tm8-ohkg@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
	<CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
	<CAKohpokc+PiviEt3_2h0JjiH-XUuxiR5Tt6=NnJqTrCL_i98sA@mail.gmail.com>
	<CAKudYbOMKp437Sqq-A8m4A-d-rLHCGLXM5cH3ep13vp11ocJyg@mail.gmail.com>
	<CAKudYbPyN0GZ1pMPLQMd_Ks0hELBhE35SN8A1hi3_v8MMPVAjg@mail.gmail.com>
	<CAKohpokeUufzx7so6FcEd8rAg-MPw+2c9Aug9L_vXdu_4MvNOA@mail.gmail.com>
	<CAKudYbP09tc8JbBt82pOSy5nfQ42BVv=4knEUhHzz6nbs03SvQ@mail.gmail.com>
	<CAKohpokO6+=5LMr99CVyZYbTHRaUvgkAhHLkgfRaV3LJSfgpkg@mail.gmail.com>
	<alpine.DEB.2.10.1409060046530.5472@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Carsten Emde <cbe@osadl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:60588 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbaIYMoI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Sep 2014 08:44:08 -0400
Received: by mail-lb0-f175.google.com with SMTP id w7so6749851lbi.6
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Sep 2014 05:44:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1409060046530.5472@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Small update: there's an mail-thread on Linux-Audio-User of somebody
who seems to have a similar issue as this. The thread in question:
http://linux-audio.4202.n7.nabble.com/Problems-with-real-time-kernel-thermal-throttling-and-cpu-freq-governors-td93209.html

Note that the CPU the OP of that thread has is an i7, and they're
using an older -rt kernel (3.14-2-rt-amd64). On a vanilla 3.14-2-amd64
all is reported to be fine (see forum post mentioned in first mail by
OP, link: http://forums.debian.net/viewtopic.php?f=5&t=117613&p=554270#p554270
)

The OP of that thread mentions that the machine hangs, forcing a
hard-reboot. I've been experiencing that too, but had not concidered
that the issues might be one-and-the-same.

What is the next step I can take to help this issue along?
Cheers, -Harry


On Fri, Sep 5, 2014 at 11:47 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 5 Sep 2014, Viresh Kumar wrote:
>
>> On 5 September 2014 17:36, Harry van Haaren <harryhaaren@gmail.com> wrote:
>> > The down_read_trylock() fails, the other checks are fine.
>>
>> So my initial guess was correct :)
>>
>> > If i'm understanding correctly, the cpufreq_rwsem locks the module
>> > from being unloaded during critical sections while writing to CPU
>> > speed etc?
>>
>> Its not about changing speed, but its more of a lock for critical sections
>> only.. So, yes its required..
>>
>> > Would that mean that an un-matched pair of down_read() up_write()
>> > could cause the failure of changing CPU speed?
>>
>> Probably yes, but why doesn't that happen without rt?
>
> I think Carsten had looked into this.
>



-- 

www.openavproductions.com
