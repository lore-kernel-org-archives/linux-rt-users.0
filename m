From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC V4 PATCH] trace: writeback: replace cgroup path to cgroup
 ino
Date: Mon, 7 Mar 2016 09:03:47 -0500
Message-ID: <20160307090347.12405fe4@gandalf.local.home>
References: <1456996137-8354-1-git-send-email-yang.shi@linaro.org>
	<20160304125224.GG13868@htj.duckdns.org>
	<56DCF64A.3070409@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tejun Heo <tj@kernel.org>, gregkh@linuxfoundation.org,
	lizefan@huawei.com, tglx@linutronix.de, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: "Shi, Yang" <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56DCF64A.3070409@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 6 Mar 2016 19:32:26 -0800
"Shi, Yang" <yang.shi@linaro.org> wrote:

> Hi Steven,
> 
> Any comment on this one? I'm supposed it will be taken by your tracing tree?
> 

Usually trace events go in through their subsystem, but since this one
only touches the include/trace/events/ directory, I could pull it in
too.

-- Steve
