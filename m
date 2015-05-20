From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/5] Linux 3.14.39-rt38-rc1
Date: Tue, 19 May 2015 22:51:51 -0400
Message-ID: <20150520025151.GB28383@home.goodmis.org>
References: <20150514135936.609231479@goodmis.org>
 <555B5ABF.1030701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Muli Baron <muli.baron@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <555B5ABF.1030701@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, May 19, 2015 at 06:46:07PM +0300, Muli Baron wrote:
> On 14/5/2015 16:59, Steven Rostedt wrote:
> >Dear RT Folks,
> >
> >This is the RT stable review cycle of patch 3.14.39-rt38-rc1.
> >
> >Please scream at me if I messed something up. Please test the patches too.
> >
> 
> Is it possible to include the rt-nohz_full-fix-nohz_full-for-PREEMPT_RT_FULL
> patch from 3.18-rt as well, to make NO_HZ_FULL work again on the stable
> trees?

Yep, I added it to 3.10-rt 3.12-rt and 3.14-rt. I'll be posting the releases
within the next 24 hours.

-- Steve
