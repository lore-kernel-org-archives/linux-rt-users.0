From: Li Zefan <lizefan@huawei.com>
Subject: Re: cgroup_fj tests will stick the nort kernel
Date: Tue, 23 Apr 2013 18:46:15 +0800
Message-ID: <51766677.2010909@huawei.com>
References: <5170F28F.3060002@huawei.com> <51750563.8050301@huawei.com> <1366646447.9609.131.camel@gandalf.local.home> <5176217E.8030008@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Qiang Huang <h.huangqiang@huawei.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:30697 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab3DWKrP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Apr 2013 06:47:15 -0400
In-Reply-To: <5176217E.8030008@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> [  146.702056] BUG: using smp_processor_id() in preemptible [00000000 00000000] code: kworker/
> 4:0/23
> [  146.702069] caller is vmstat_update+0x22/0x60
> [  146.702075] Pid: 23, comm: kworker/4:0 Not tainted 3.4.24.05+ #49

Oh, I have to make it clear that I firstly tested an older kernel and then tested
the latest 3.4.39-rt53.

> [  146.702077] Call Trace:

