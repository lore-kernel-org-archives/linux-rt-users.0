From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: patch-2.6.33.9-rt31 problem
Date: Thu, 12 Jul 2012 13:17:41 -0400
Message-ID: <4FFF06B5.6060509@gmail.com>
References: <4FFC915C.80202@gmail.com> <1342010632.14828.28.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49691 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161288Ab2GLRRm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2012 13:17:42 -0400
Received: by eekb15 with SMTP id b15so719905eek.19
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2012 10:17:41 -0700 (PDT)
In-Reply-To: <1342010632.14828.28.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steve,

On 7/11/12 8:43 AM, Steven Rostedt wrote:
> On Tue, 2012-07-10 at 16:32 -0400, Dong Liu wrote:
>> Hi All,
>>
>> Because I could not find a solution for the cpu stall problem on kernel
>> 3.2.18-rt29. I thought I might try an older kernel. So I download
>> linux-2.6.33.9 and patch-2.6.33.9-rt31. But 2.6.33 doesn't have
>> vhost_net, so I ported vhost_net from 2.6.34 back to 2.6.33.9.
>>
>> The kernel was patched and built successfully. But when I boot, I got
>> kernel NULL pointer dereference error. After the error, my system seems
>> stable, I can start KVM client without CPU stalls. But very frequently,
>> processes will locked up for long time, the wchan displayed by ps is
>> either sync_page or synchronize_rcu. It looks that rcu still causes
>> problem in the rt-kernel.
>>
>> The dmesg out of NULL pointer is attached.
>
> Um, when you get one of those 'kernel NULL pointer' crashes, the system
> is not in a good state. If the crash happened to a task that holds a
> mutex or worse a spinlock, it will never release it. That means, any new
> task that tries to take that same mutex or spinlock, will just block and
> sit there.
>
> Thus, those processes that are stuck at either sync_page or
> synchronize_rcu, are probably waiting for that processes to release a
> mutex, or finish something else that it will never do.
>
> Basically, once you see a NULL pointer dereference, it's time to save
> the dmesg and reboot the box.
>

I finally tracked down the NULL pointer is caused by

echo -n "0" > /sys/kernel/kexec_crash_size

in /etc/init/kexec-disable.conf.

After I disabled, no more kernel NULL pointer dereference. But I still 
got cpu stall :(

Thanks,

Dong
