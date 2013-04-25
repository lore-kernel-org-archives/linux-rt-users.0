From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: cgroup_fj tests will stick the nort kernel
Date: Thu, 25 Apr 2013 08:53:57 -0400
Message-ID: <1366894437.10248.8.camel@gandalf.local.home>
References: <5170F28F.3060002@huawei.com> <51750563.8050301@huawei.com>
	 <1366646447.9609.131.camel@gandalf.local.home>
	 <5176217E.8030008@huawei.com> <5178C922.3060506@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Li Zefan <lizefan@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Qiang Huang <h.huangqiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:31906 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203Ab3DYMx6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 08:53:58 -0400
In-Reply-To: <5178C922.3060506@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2013-04-25 at 14:11 +0800, Qiang Huang wrote:

> What's more, I don't see why we need to clear this flag any more,
> because "cpu/rt: Rework cpu down for PREEMPT_RT" already remove the
> optimization for PF_THREAD_BOUND on migrate_disable/enable.

I'll have to think about this. That is, take a deeper look.

Thanks,

-- Steve


