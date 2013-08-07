From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 4/4] timer: Migrate running timer
Date: Wed, 7 Aug 2013 15:25:55 +0530
Message-ID: <CAKohpokzTj-=2BgrAH4UabiCAe_sZXhdyKu1L-VDnYBJ97BAyA@mail.gmail.com>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
	<d12b25130db5a8b645929eb93d1cf4ddc2d68826.1352196505.git.viresh.kumar@linaro.org>
	<1354024039.6276.72.camel@gandalf.local.home>
	<CAKohponv-AKZzM98Ujeek4oXQx+8ba+sMgMbM9eV8PgQR38kZw@mail.gmail.com>
	<CAKohpo=St0z0L9ei248s3KL_DqZtewQ50o7d=BTdwLFcpM+x3w@mail.gmail.com>
	<CAKohpo=0r=HY5w-XqnXv42eSJcH08C47J+TqWn7vY1aNBhGT_A@mail.gmail.com>
	<CAKohpo=eAGVA540jN8+t0aaqCV9qJRkH0q9-q6QVUYusWQqSYw@mail.gmail.com>
	<alpine.LFD.2.02.1305131223470.2863@ionos>
	<CAKohpokfKPQ3EhMf3WB8koXuH2rF6QoejwNOTw08X+XfnVhpEg@mail.gmail.com>
	<CAKohpomoSHS0wSCBrJApZuSTr9fbm2py6WdNg1MNzRWjb55Y_Q@mail.gmail.com>
	<CAKohpon0dC6O_QBXnbyxUOO0DcrRxTzFkZSJNh6VrNL5kzT66Q@mail.gmail.com>
	<CAKohpomGSoU5VOcrbonD1=NE-6xDVr+pveAmuXdrzjmLotmEug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: pjt@google.com, paul.mckenney@linaro.org, tj@kernel.org,
	mingo@redhat.com, peterz@infradead.org, Arvind.Chauhan@arm.com,
	linaro-dev@lists.linaro.org, patches@linaro.org,
	pdsw-power-team@arm.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	John Stultz <john.stultz@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:38797 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757225Ab3HGJzz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Aug 2013 05:55:55 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so3333939obc.12
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Aug 2013 02:55:55 -0700 (PDT)
In-Reply-To: <CAKohpomGSoU5VOcrbonD1=NE-6xDVr+pveAmuXdrzjmLotmEug@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 24 July 2013 14:47, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18 June 2013 10:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Hi Thomas,
>
> Do you still see some light of hope in this patch :) ?

Ping!!
