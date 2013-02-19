From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PREEMPT RT] SLUB and split softirq lock for v3.2-rt
Date: Tue, 19 Feb 2013 07:17:45 +0100
Message-ID: <1361254665.5804.32.camel@marge.simpson.net>
References: <1360771932-27150-1-git-send-email-bigeasy@linutronix.de>
	 <1360776274.23152.7.camel@gandalf.local.home> <5122DB72.7030100@huawei.com>
	 <5122DBC1.6010507@huawei.com>
	 <1361246801.23152.195.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Li Zefan <lizefan@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Carsten Emde <C.Emde@osadl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361246801.23152.195.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-02-18 at 23:06 -0500, Steven Rostedt wrote: 
> On Tue, 2013-02-19 at 09:56 +0800, Li Zefan wrote:
> 
> > Oh ignore me. Just saw the patchset for 3.4-rt.
> 
> Note, I already have part of the 3.4-feature (softirq backport) tested
> and ready. What I'm waiting on is trying to figure out the best way to
> process it.
> 
> I already know I'll have a v3.4-features branch, but I'm thinking about
> patches and tarballs, if it should be posted as well, or just be in git?

If I had a vote, it'd be for git only.

Extracting patches or using git directly is trivial.  The less time
maintainers spend on trivial crud, the more time they have for hard
stuff.  Git only is a win for maintainers _and_ us greedy users :)

-Mike
