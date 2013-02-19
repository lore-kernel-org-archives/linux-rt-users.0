From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PREEMPT RT] SLUB and split softirq lock for v3.2-rt
Date: Mon, 18 Feb 2013 23:06:41 -0500
Message-ID: <1361246801.23152.195.camel@gandalf.local.home>
References: <1360771932-27150-1-git-send-email-bigeasy@linutronix.de>
	 <1360776274.23152.7.camel@gandalf.local.home> <5122DB72.7030100@huawei.com>
	 <5122DBC1.6010507@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Carsten Emde <C.Emde@osadl.org>
To: Li Zefan <lizefan@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5122DBC1.6010507@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-02-19 at 09:56 +0800, Li Zefan wrote:

> Oh ignore me. Just saw the patchset for 3.4-rt.

Note, I already have part of the 3.4-feature (softirq backport) tested
and ready. What I'm waiting on is trying to figure out the best way to
process it.

I already know I'll have a v3.4-features branch, but I'm thinking about
patches and tarballs, if it should be posted as well, or just be in git?

If I choose to post them, I want the scripts done before I do so, but
right now I'll be leaving for ELC and wont get to it till I get back.

-- Steve
