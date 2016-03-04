From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC V4 PATCH] trace: writeback: replace cgroup path to cgroup
 ino
Date: Fri, 4 Mar 2016 07:52:24 -0500
Message-ID: <20160304125224.GG13868@htj.duckdns.org>
References: <1456996137-8354-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gregkh@linuxfoundation.org, lizefan@huawei.com, tglx@linutronix.de,
	rostedt@goodmis.org, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33017 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbcCDMw0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Mar 2016 07:52:26 -0500
Content-Disposition: inline
In-Reply-To: <1456996137-8354-1-git-send-email-yang.shi@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Mar 03, 2016 at 01:08:57AM -0800, Yang Shi wrote:
> commit 5634cc2aa9aebc77bc862992e7805469dcf83dac ("writeback: update writeback
> tracepoints to report cgroup") made writeback tracepoints print out cgroup
> path when CGROUP_WRITEBACK is enabled, but it may trigger the below bug on -rt
> kernel since kernfs_path and kernfs_path_len are called by tracepoints, which
> acquire spin lock that is sleepable on -rt kernel.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
