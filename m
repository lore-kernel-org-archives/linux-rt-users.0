From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] 3.0.4-rt13
Date: Mon, 12 Sep 2011 13:33:56 +0200
Message-ID: <1315827236.6285.9.camel@marge.simson.net>
References: <alpine.LFD.2.02.1109101052340.2723@ionos>
	 <1315737307.6544.1.camel@marge.simson.net>
	 <1315821899.26517.22.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315821899.26517.22.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2011-09-12 at 12:04 +0200, Peter Zijlstra wrote:
> On Sun, 2011-09-11 at 12:35 +0200, Mike Galbraith wrote:
> > [  134.105291] Pid: 6224, comm: lmsched Not tainted 3.0.4-rt13 #2040
> 
> What's this lmsched thing you're running and where does one get it? I
> can't seem to make it go bang using kernel compiles ;-)

It's a simple model of a realtime simulation executive.. and
non-releasable despite containing no rocket science.  It's a high
priority timer thread synchronizing lower priority workers via ipc.

	-Mike
