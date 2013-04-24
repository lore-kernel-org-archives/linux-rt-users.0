From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V5 1/5] workqueues: Introduce new flag WQ_POWER_EFFICIENT
 for power oriented workqueues
Date: Wed, 24 Apr 2013 09:12:08 -0700
Message-ID: <20130424161208.GA16991@mtj.dyndns.org>
References: <cover.1366803121.git.viresh.kumar@linaro.org>
 <480f5d6da920e2f2b868f311228c81635727799e.1366803121.git.viresh.kumar@linaro.org>
 <CAP245DWtwguSp8ubid_KJnLSOqvCbmTXN+0Bg_MtDrUhBqve-Q@mail.gmail.com>
 <CAKohpokN_o-RUX6MDwqqfzu4NKRysG-hSzmB=MHV7Y0aDbztuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Amit Kucheria <amit.kucheria@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Robin Randhawa <robin.randhawa@arm.com>,
	linux-rt-users@vger.kernel.org,
	Patch Tracking <patches@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	mingo@redhat.com, Steve Bannister <Steve.Bannister@arm.com>,
	airlied@redhat.com, Arvind Chauhan <arvind.chauhan@arm.com>,
	davem@davemloft.net,
	Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
	Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:37746 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab3DXQMQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Apr 2013 12:12:16 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpokN_o-RUX6MDwqqfzu4NKRysG-hSzmB=MHV7Y0aDbztuA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Apr 24, 2013 at 05:57:09PM +0530, Viresh Kumar wrote:
> If this line is not present i believe it is 'default n' only. So, i skipped it.

I think the difference is that when you configure the option for the
first time - ie. building kernel with .config used for an older kernel
- that it prompts for selection, thus annoying the big penguin.  You
probably want the explicit 'N'.

Thanks.

-- 
tejun
