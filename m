From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH V4 1/4] workqueue: Add system wide
 system_freezable_unbound_wq
Date: Mon, 08 Apr 2013 12:59:41 -0400
Message-ID: <1365440381.25498.22.camel@gandalf.local.home>
References: <cover.1364740180.git.viresh.kumar@linaro.org>
	 <147bfb5aa81790f94df75858bf20570cbacc9dca.1364740180.git.viresh.kumar@linaro.org>
	 <CAP245DV-4d4hRGCnKUtyVV1ycHuYF4dKwh568kvHfKHdJR3xpw@mail.gmail.com>
	 <CAKohponXTYSdmk71DNYsYtwU9GEYwnGcj-_wjLEZfxvEhzPWWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Amit Kucheria <amit.kucheria@linaro.org>,
	Tejun Heo <tj@kernel.org>, axboe@kernel.dk,
	Robin Randhawa <robin.randhawa@arm.com>,
	linux-rt-users@vger.kernel.org,
	Patch Tracking <patches@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org,
	Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
	Steve Bannister <Steve.Bannister@arm.com>, airlied@redhat.com,
	Arvind Chauhan <arvind.chauhan@arm.com>, mingo@redhat.com,
	davem@davemloft.net,
	Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:5860 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933171Ab3DHQ7p (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Apr 2013 12:59:45 -0400
In-Reply-To: <CAKohponXTYSdmk71DNYsYtwU9GEYwnGcj-_wjLEZfxvEhzPWWQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-04-01 at 10:55 +0530, Viresh Kumar wrote:
> On 1 April 2013 10:50, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > On Sun, Mar 31, 2013 at 8:01 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> This patch adds system wide system_freezable_unbound_wq which will be used by
> >> code that currently uses system_freezable_wq and can be moved to unbound
> >> workqueues.
> >
> > _Why_ do i need this change?
> 
> Block layer uses system_freezable_wq for some work and to migrate them to a
> UNBOUND wq it was required. Sorry if it is yet not clear.

Looks like Amit was left off the patch 0, and missed the power savings
explanation that you did there. Perhaps you should have included that in
each patch change log.

-- Steve


