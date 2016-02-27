From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC V2 PATCH] kernfs: create raw version kernfs_path_len and
 kernfs_path
Date: Sat, 27 Feb 2016 00:52:46 -0800
Message-ID: <20160227085246.GC26010@infradead.org>
References: <1456523259-8588-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
	tglx@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456523259-8588-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Feb 26, 2016 at 01:47:39PM -0800, Yang Shi wrote:
> commit 5634cc2aa9aebc77bc862992e7805469dcf83dac ("writeback: update writeback
> tracepoints to report cgroup") made writeback tracepoints report cgroup
> writeback, but it may trigger the below bug on -rt kernel since kernfs_path
> and kernfs_path_len are called by tracepoints, which acquire sleeping lock.

Sounds like the tracepoints simplify shouldn't try to do this path
generation at all..
