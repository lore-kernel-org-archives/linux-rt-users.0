From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Mon, 09 Jul 2012 10:46:48 -0400
Message-ID: <4FFAEED8.5010108@gmail.com>
References: <4FEBCDDE.60503@gmail.com> <4FF68396.2010904@gmail.com> <4FF6CEA6.6080900@osadl.org> <4FFA5F31.4030309@gmail.com> <4FFA7FF9.2030004@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43701 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab2GIOqs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jul 2012 10:46:48 -0400
Received: by bkwj10 with SMTP id j10so6039226bkw.19
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Jul 2012 07:46:47 -0700 (PDT)
In-Reply-To: <4FFA7FF9.2030004@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I tried remove CONFIG_RT_GROUP_SCHED=y, it still had cpu stall, so I 
just captured the original config.

Ok, here is capture of the kernel without CONFIG_RT_GROUP_SCHED=y

The directory URL is here,

http://192.11.154.97:3333/project/

3.2.18-2.el6.preempt_rt.x86_64-rt29

is the system config.

I have kernel function capture and dmesg output.

BTW, the system will lock up and cpu stall repeatly after the initial 
one. Even "cat /sys/kernel/debug/tracing/trace > trace-out.txt" takes 
very long time.

Thanks,

Dong

On 7/9/12 2:53 AM, Carsten Emde wrote:
> On 07/09/2012 06:33 AM, Dong Liu wrote:
>> And here is the URL for kernel's .config
> CONFIG_RT_GROUP_SCHED=y
> Why is this?
>
> -Carsten.

