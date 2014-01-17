From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 4/8] rtmutex: use a trylock for waiter lock in
 trylock
Date: Thu, 16 Jan 2014 23:22:28 -0500
Message-ID: <20140116232228.0f3cfb89@gandalf.local.home>
References: <20140116015824.201732155@goodmis.org>
	<20140116020324.637491369@goodmis.org>
	<1389841737.5418.14.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389841737.5418.14.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 16 Jan 2014 04:08:57 +0100
Mike Galbraith <bitbucket@online.de> wrote:

> On Wed, 2014-01-15 at 20:58 -0500, Steven Rostedt wrote:
> 
> 
> > 3.2.53-rt76-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> 
> Not sure this is needed without the tglx don't unconditionally raise
> timer softirq patch, and with that patch applied in the form it exists
> in 3.12-rt9, as well as this one, you'll still eventually deadlock.

Hmm, I'll have to take a look. This sounds to be missing from all the
stable -rt kernels. I'll be pulling in the latest updates from 3.12-rt
soon.

Thanks,

-- Steve
