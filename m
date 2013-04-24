From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 1/5] workqueues: Introduce new flag WQ_POWER_EFFICIENT
 for power oriented workqueues
Date: Wed, 24 Apr 2013 17:57:09 +0530
Message-ID: <CAKohpokN_o-RUX6MDwqqfzu4NKRysG-hSzmB=MHV7Y0aDbztuA@mail.gmail.com>
References: <cover.1366803121.git.viresh.kumar@linaro.org>
	<480f5d6da920e2f2b868f311228c81635727799e.1366803121.git.viresh.kumar@linaro.org>
	<CAP245DWtwguSp8ubid_KJnLSOqvCbmTXN+0Bg_MtDrUhBqve-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
To: Amit Kucheria <amit.kucheria@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:56173 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757729Ab3DXM1K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Apr 2013 08:27:10 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so1435595obb.29
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Apr 2013 05:27:10 -0700 (PDT)
In-Reply-To: <CAP245DWtwguSp8ubid_KJnLSOqvCbmTXN+0Bg_MtDrUhBqve-Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 24 April 2013 17:50, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> On Wed, Apr 24, 2013 at 5:12 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> +config WQ_POWER_EFFICIENT
>> +       bool "Workqueue allocated as UNBOUND (by default) for power efficiency"
>> +       depends on PM
>
> default n

If this line is not present i believe it is 'default n' only. So, i skipped it.

All others comments accepted.
