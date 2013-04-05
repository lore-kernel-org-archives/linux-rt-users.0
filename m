From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V4 3/4] block: queue work on unbound wq
Date: Fri, 5 Apr 2013 05:22:58 -0700
Message-ID: <CAOS58YOvDGavhffFawMbk1Y4xihL3OwPSpOkEzXKSzORvjyq-Q@mail.gmail.com>
References: <cover.1364740180.git.viresh.kumar@linaro.org>
	<91239cde99aaba2715f63db1f88241d9f4a36e13.1364740180.git.viresh.kumar@linaro.org>
	<20130331181931.GA7533@htj.dyndns.org>
	<CAKohpo=nWsUh5y7y_tacGez7uN76QbRFRVPSQcKQMGM1nUBWtw@mail.gmail.com>
	<20130403215412.GG3411@htj.dyndns.org>
	<CAKohpomTQj-S-32JdtY76_82NraB5uBqnKZXVxk28KxMZ-NSow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org,
	robin.randhawa@arm.com, Steve.Bannister@arm.com,
	Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com,
	arvind.chauhan@arm.com, "David S. Miller" <davem@davemloft.net>,
	airlied@redhat.com, Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:39209 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765141Ab3DEMW7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Apr 2013 08:22:59 -0400
In-Reply-To: <CAKohpomTQj-S-32JdtY76_82NraB5uBqnKZXVxk28KxMZ-NSow@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 5, 2013 at 2:47 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> module_param()?? We can't compile kernel/workqueue.c as a module and
> hence i went with #define + a variable with functions to set/reset it...

module_param works fine for kernel proper.

--
tejun
