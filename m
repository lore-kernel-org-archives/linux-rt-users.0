From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC V2 PATCH] kernfs: create raw version kernfs_path_len and
 kernfs_path
Date: Sat, 27 Feb 2016 12:37:23 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602271236510.3638@nanos>
References: <1456523259-8588-1-git-send-email-yang.shi@linaro.org> <20160227111719.GV3965@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yang Shi <yang.shi@linaro.org>, gregkh@linuxfoundation.org,
	lizefan@huawei.com, rostedt@goodmis.org, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35658 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492AbcB0Lit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 06:38:49 -0500
In-Reply-To: <20160227111719.GV3965@htj.duckdns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 27 Feb 2016, Tejun Heo wrote:
> On Fri, Feb 26, 2016 at 01:47:39PM -0800, Yang Shi wrote:
> > Call synchronize_sched() when kernfs_node is updated since tracepoints are
> > protected by rcu_read_lock_sched.
> 
> Adding synchronize_sched() to operations which can be triggered from
> userland usually turns out to be problematic.  If this can't be solved
> any other way, I think the right thing to do is replacing the path
> with cgroup id as Christoph suggested.

Agreed. The path is not that important, right?

Thanks,

	tglx
