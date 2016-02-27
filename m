From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC V2 PATCH] kernfs: create raw version kernfs_path_len and
 kernfs_path
Date: Sat, 27 Feb 2016 06:41:37 -0500
Message-ID: <20160227114137.GZ3965@htj.duckdns.org>
References: <1456523259-8588-1-git-send-email-yang.shi@linaro.org>
 <20160227111719.GV3965@htj.duckdns.org>
 <alpine.DEB.2.11.1602271236510.3638@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yang Shi <yang.shi@linaro.org>, gregkh@linuxfoundation.org,
	lizefan@huawei.com, rostedt@goodmis.org, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:32939 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303AbcB0Llj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 06:41:39 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1602271236510.3638@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Feb 27, 2016 at 12:37:23PM +0100, Thomas Gleixner wrote:
> On Sat, 27 Feb 2016, Tejun Heo wrote:
> > On Fri, Feb 26, 2016 at 01:47:39PM -0800, Yang Shi wrote:
> > > Call synchronize_sched() when kernfs_node is updated since tracepoints are
> > > protected by rcu_read_lock_sched.
> > 
> > Adding synchronize_sched() to operations which can be triggered from
> > userland usually turns out to be problematic.  If this can't be solved
> > any other way, I think the right thing to do is replacing the path
> > with cgroup id as Christoph suggested.
> 
> Agreed. The path is not that important, right?

It can be, but we can print out the ino and userland can match that up
with path if necessary.

Thanks.

-- 
tejun
