From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 3/4] block: queue work on unbound wq
Date: Mon, 8 Apr 2013 16:44:47 +0530
Message-ID: <CAKohpompyx33F7WKjq3gXEpJs5BUxq6Md1hcd=h1ZxF0a6T5vg@mail.gmail.com>
References: <cover.1364740180.git.viresh.kumar@linaro.org>
	<91239cde99aaba2715f63db1f88241d9f4a36e13.1364740180.git.viresh.kumar@linaro.org>
	<20130331181931.GA7533@htj.dyndns.org>
	<20130408111328.GA12244@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tejun Heo <tj@kernel.org>, linaro-kernel@lists.linaro.org,
	patches@linaro.org, robin.randhawa@arm.com,
	Steve.Bannister@arm.com, Liviu.Dudau@arm.com,
	charles.garcia-tobin@arm.com, arvind.chauhan@arm.com,
	davem@davemloft.net, airlied@redhat.com, tglx@linutronix.de,
	peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:53225 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934522Ab3DHLOs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Apr 2013 07:14:48 -0400
Received: by mail-oa0-f53.google.com with SMTP id m17so5902632oag.40
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Apr 2013 04:14:47 -0700 (PDT)
In-Reply-To: <20130408111328.GA12244@kernel.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 8 April 2013 16:43, Jens Axboe <axboe@kernel.dk> wrote:
> And lets please have it off by default. The specialized configs / setups
> can turn it on, but we should default to better performance.

Yes, we will.
