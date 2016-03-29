From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC V4 PATCH] trace: writeback: replace cgroup path to cgroup
 ino
Date: Tue, 29 Mar 2016 16:30:52 +0200
Message-ID: <20160329143052.GC13334@linutronix.de>
References: <1456996137-8354-1-git-send-email-yang.shi@linaro.org>
 <20160304125224.GG13868@htj.duckdns.org>
 <56DCF64A.3070409@linaro.org>
 <20160307090347.12405fe4@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shi, Yang" <yang.shi@linaro.org>, Tejun Heo <tj@kernel.org>,
	gregkh@linuxfoundation.org, lizefan@huawei.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57411 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbcC2Oa7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 10:30:59 -0400
Content-Disposition: inline
In-Reply-To: <20160307090347.12405fe4@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2016-03-07 09:03:47 [-0500]:

>On Sun, 6 Mar 2016 19:32:26 -0800
>"Shi, Yang" <yang.shi@linaro.org> wrote:
>
>> Hi Steven,
>> 
>> Any comment on this one? I'm supposed it will be taken by your tracing tree?
>> 
>
>Usually trace events go in through their subsystem, but since this one
>only touches the include/trace/events/ directory, I could pull it in
>too.

I took this for the next -RT release and dropped the
"!defined(CONFIG_PREEMPT_RT_FULL)" workaround we had in the meantime.

Sebastian
