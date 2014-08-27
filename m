From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Wed, 27 Aug 2014 15:53:52 +0100
Message-ID: <CAKudYbPyN0GZ1pMPLQMd_Ks0hELBhE35SN8A1hi3_v8MMPVAjg@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
	<CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
	<CAKohpokc+PiviEt3_2h0JjiH-XUuxiR5Tt6=NnJqTrCL_i98sA@mail.gmail.com>
	<CAKudYbOMKp437Sqq-A8m4A-d-rLHCGLXM5cH3ep13vp11ocJyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:62695 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933630AbaH0Oxy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Aug 2014 10:53:54 -0400
Received: by mail-la0-f54.google.com with SMTP id hz20so43088lab.27
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Aug 2014 07:53:53 -0700 (PDT)
In-Reply-To: <CAKudYbOMKp437Sqq-A8m4A-d-rLHCGLXM5cH3ep13vp11ocJyg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Aug 26, 2014 at 11:44 PM, Harry van Haaren
<harryhaaren@gmail.com> wrote:
> On Tue, Aug 26, 2014 at 5:34 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> The functions  of interest would be, drivers/cpufreq/cpufreq.c:
>> - static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
>> - static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
>> const char *buf, size_t count)
>>
>> Try to add some prints there while returning errors and then try to change
>> governor from userspace and things might get somewhat better then..
>
> Thanks for the suggestion, I'll update once I have more info

Found a little time to check this: the cpufreq_get_policy() call
returns non-zero:

static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
                    const char *buf, size_t count)
{
    int ret;
    char    str_governor[16];
    struct cpufreq_policy new_policy;

  printk( "RT debug: store_scaling_governor() with %s\n", buf );

    ret = cpufreq_get_policy(&new_policy, policy->cpu);
    if (ret)
  {
    printk( "RT debug: ERROR: get policy() returned \n" );
        return ret;
  }


dmesg:
[   43.186804] RT debug: store_scaling_governor() with performance
[   43.186811] RT debug: ERROR: get policy() returned


This output is from a fresh boot: so it seems that the getting the
current policy after
a boot isn't functioning right here.
