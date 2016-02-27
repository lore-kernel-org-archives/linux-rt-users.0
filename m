From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC V2 PATCH] kernfs: create raw version kernfs_path_len and kernfs_path
Date: Sat, 27 Feb 2016 06:51:01 -0500
Message-ID: <CAOS58YNAgyCcepowr=gFrL+dZZ04ua-zLUtsOY6qGh=+_J52_w@mail.gmail.com>
References: <1456523259-8588-1-git-send-email-yang.shi@linaro.org>
	<20160227111719.GV3965@htj.duckdns.org>
	<alpine.DEB.2.11.1602271236510.3638@nanos>
	<20160227114137.GZ3965@htj.duckdns.org>
	<alpine.DEB.2.11.1602271243350.3638@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yang Shi <yang.shi@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Li Zefan <lizefan@huawei.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org,
	Lists linaro-kernel <linaro-kernel@lists.linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:32807 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbcB0LvD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 06:51:03 -0500
In-Reply-To: <alpine.DEB.2.11.1602271243350.3638@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Sat, Feb 27, 2016 at 6:45 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> It can be, but we can print out the ino and userland can match that up
>> with path if necessary.
>
> Wouldn't be cgroup id the better choice?

AFAIK we aren't exposing cgroup id to userland anywhere right now.
Eventually, I think the right thing to do is using the same number for
both.

Thanks.

-- 
tejun
