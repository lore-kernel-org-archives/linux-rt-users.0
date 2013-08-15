From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.10.6-rt3
Date: Thu, 15 Aug 2013 15:22:10 -0400
Message-ID: <20130815152210.5ed93696@gandalf.local.home>
References: <20130812163413.GI23040@linutronix.de>
	<520D212F.7030400@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <520D212F.7030400@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 15 Aug 2013 11:42:55 -0700
Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> On 08/12/2013 09:34 AM, Sebastian Andrzej Siewior wrote:
> > Dear RT folks!
> >
> > I'm pleased to announce the v3.10.6-rt3 patch set.
> 
> I'm getting this when trying to build:
> 
> drivers/md/bcache/request.c: In function 'cached_dev_write_complete':
> drivers/md/bcache/request.c:1008:2: error: implicit declaration of 
> function 'up_read_non_owner' [-Werror=implicit-function-declaration]
>    up_read_non_owner(&dc->writeback_lock);
>    ^
> drivers/md/bcache/request.c: In function 'request_write':
> drivers/md/bcache/request.c:1034:2: error: implicit declaration of 
> function 'down_read_non_owner' [-Werror=implicit-function-declaration]
>    down_read_non_owner(&dc->writeback_lock);
>    ^
> cc1: some warnings being treated as errors
> 

Can you send us your config.

Thanks,

-- Steve
