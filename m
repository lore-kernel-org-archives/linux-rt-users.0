From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.22.1-rt5
Date: Tue, 24 Jul 2007 22:05:46 +0200
Message-ID: <20070724200546.GA24964@elte.hu>
References: <20070723210236.GA25104@elte.hu> <46A51D9E.8040104@rncbc.org> <20070724073932.GA18740@elte.hu> <1185305679.16400.17.camel@cmn3.stanford.edu> <1185305725.16400.19.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764113AbXGXUGu@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1185305725.16400.19.camel@cmn3.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> On Tue, 2007-07-24 at 12:34 -0700, Fernando Lopez-Lezcano wrote:
> > On Tue, 2007-07-24 at 09:39 +0200, Ingo Molnar wrote:
> > > * Rui Nuno Capela <rncbc@rncbc.org> wrote:
> > > 
> > > > Maybe I was too quick, but `make all` on is failing here:
> > > 
> > > does -rt6 work better?
> > 
> > Hmmm, -rt6 seems to be gone... was about to download it and it
> > dissapeared. 
> 
> Never mind, I see it migrated back to the main page. 

apparently you caught that 3 seconds window where the .23-rc1-rt1 
release script moved old patches into the older/ directory :-)

	Ingo
