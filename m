From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC V2 PATCH] kernfs: create raw version kernfs_path_len and
 kernfs_path
Date: Sat, 27 Feb 2016 06:17:19 -0500
Message-ID: <20160227111719.GV3965@htj.duckdns.org>
References: <1456523259-8588-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gregkh@linuxfoundation.org, lizefan@huawei.com, tglx@linutronix.de,
	rostedt@goodmis.org, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456523259-8588-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

On Fri, Feb 26, 2016 at 01:47:39PM -0800, Yang Shi wrote:
> Call synchronize_sched() when kernfs_node is updated since tracepoints are
> protected by rcu_read_lock_sched.

Adding synchronize_sched() to operations which can be triggered from
userland usually turns out to be problematic.  If this can't be solved
any other way, I think the right thing to do is replacing the path
with cgroup id as Christoph suggested.

Thanks.

-- 
tejun
