From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.9-rt21
Date: Mon, 17 Dec 2012 20:44:31 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1212172043390.3148@ionos>
References: <alpine.LFD.2.02.1212051659160.2701@ionos>  <1355543529.20987.6.camel@marge.simpson.net>  <alpine.LFD.2.02.1212171634070.3148@ionos> <1355764176.11540.19.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355764176.11540.19.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 17 Dec 2012, Mike Galbraith wrote:
> On Mon, 2012-12-17 at 16:35 +0100, Thomas Gleixner wrote: 
> > Bah. This reverse user/kernel priority nonsense really should go away!
> 
> Snort, I looked right at it too, looked perfectly fine :)

The real bad news is, that I talked to someone about that reverse prio
issue just a few hours before I committed that crime. Blergh!
