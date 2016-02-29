From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [RFC V2 PATCH] kernfs: create raw version kernfs_path_len and
 kernfs_path
Date: Mon, 29 Feb 2016 10:00:53 -0800
Message-ID: <56D48755.9070604@linaro.org>
References: <1456523259-8588-1-git-send-email-yang.shi@linaro.org>
 <20160227111719.GV3965@htj.duckdns.org>
 <alpine.DEB.2.11.1602271236510.3638@nanos>
 <20160227114137.GZ3965@htj.duckdns.org>
 <alpine.DEB.2.11.1602271243350.3638@nanos>
 <CAOS58YNAgyCcepowr=gFrL+dZZ04ua-zLUtsOY6qGh=+_J52_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Li Zefan <lizefan@huawei.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org,
	Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
	hch@infradead.org
To: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34513 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbcB2SA4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 13:00:56 -0500
Received: by mail-pf0-f177.google.com with SMTP id 4so17844913pfd.1
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Feb 2016 10:00:56 -0800 (PST)
In-Reply-To: <CAOS58YNAgyCcepowr=gFrL+dZZ04ua-zLUtsOY6qGh=+_J52_w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2/27/2016 3:51 AM, Tejun Heo wrote:
> Hello,
>
> On Sat, Feb 27, 2016 at 6:45 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> It can be, but we can print out the ino and userland can match that up
>>> with path if necessary.
>>
>> Wouldn't be cgroup id the better choice?
>
> AFAIK we aren't exposing cgroup id to userland anywhere right now.
> Eventually, I think the right thing to do is using the same number for
> both.

Thanks for all the comments.

Since the current tracepoints print the path length too by 
__trace_wb_cgroup_size and __trace_wbc_cgroup_size, but we can't get the 
path length if we switch to group ino. So, I'm supposed I have to drop 
all the *_size stuff.

And, when CONFIG_CGROUP_WRITEBACK is not enabled, 
__trace_wb_assign_cgroup and __trace_wbc_assign_cgroup return 
"strcpy(buf, "/")", so to get aligned with this, I need print out the 
ino of "/", right? But, the ROOT_INO may vary from different filesystems.

All of them will be addressed in V4, but it may experience some delay 
since I have to travel this week.

Regards,
Yang

>
> Thanks.
>

