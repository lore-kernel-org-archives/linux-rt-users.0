From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Fri, 5 Sep 2014 13:06:49 +0100
Message-ID: <CAKudYbP09tc8JbBt82pOSy5nfQ42BVv=4knEUhHzz6nbs03SvQ@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
	<CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
	<CAKohpokc+PiviEt3_2h0JjiH-XUuxiR5Tt6=NnJqTrCL_i98sA@mail.gmail.com>
	<CAKudYbOMKp437Sqq-A8m4A-d-rLHCGLXM5cH3ep13vp11ocJyg@mail.gmail.com>
	<CAKudYbPyN0GZ1pMPLQMd_Ks0hELBhE35SN8A1hi3_v8MMPVAjg@mail.gmail.com>
	<CAKohpokeUufzx7so6FcEd8rAg-MPw+2c9Aug9L_vXdu_4MvNOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:53586 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbaIEMGw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Sep 2014 08:06:52 -0400
Received: by mail-la0-f47.google.com with SMTP id el20so5061719lab.6
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Sep 2014 05:06:50 -0700 (PDT)
In-Reply-To: <CAKohpokeUufzx7so6FcEd8rAg-MPw+2c9Aug9L_vXdu_4MvNOA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Aug 27, 2014 at 4:07 PM, Viresh Kumar
> Some more prints inside  cpufreq_get_policy() might take us closer..

I've time to continue this bug hunt again:

With more prints:

struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
{
    struct cpufreq_policy *policy = NULL;
    unsigned long flags;

    if ( cpufreq_disabled() )
  {
    printk("RT test errror: cpufreq_disabled(), returning NULL\n");
    return NULL;
  }
  if (cpu >= nr_cpu_ids)
  {
    printk("cpu > nr_cpu_ids\n");
        return NULL;
  }

    if (!down_read_trylock(&cpufreq_rwsem))
  {
    printk("RT debug: down_read_trylock( &cpufreq_rwsem ) returned NULL\n");
        return NULL;
  }

   <snip>

The down_read_trylock() fails, the other checks are fine.

If i'm understanding correctly, the cpufreq_rwsem locks the module
from being unloaded during critical sections while writing to CPU
speed etc?

Would that mean that an un-matched pair of down_read() up_write()
could cause the failure of changing CPU speed?

-Harry

www.openavproductions.com
