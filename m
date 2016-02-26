From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] kernfs: create raw version kernfs_path_len and
 kernfs_path
Date: Fri, 26 Feb 2016 15:15:03 -0500
Message-ID: <20160226151503.39d39e45@gandalf.local.home>
References: <1456510505-6620-1-git-send-email-yang.shi@linaro.org>
	<20160226135628.09ce727c@gandalf.local.home>
	<56D0A97E.90706@linaro.org>
	<56D0AEAC.3070002@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
	tglx@linutronix.de, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: "Shi, Yang" <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56D0AEAC.3070002@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 26 Feb 2016 11:59:40 -0800
"Shi, Yang" <yang.shi@linaro.org> wrote:


> BTW, it sounds this is not the only point where kernfs_node could be 
> updated, __kernfs_remove should need synchronize_sched too.
> 

Question is, can the kernfs of a cgroup be removed while the cgroup is
still active?

I don't see the kernfs_rename_lock being held anywhere in that
remove. If it can be an issue there with this patch, then it's an issue
today, because the kernfs_mutex is not held by the tracepoint.

-- Steve
