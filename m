From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 00/18] tracing/ring-buffer: fixes for latency tracer
	[2.6.32]
Date: Mon, 7 Sep 2009 13:22:26 +0200
Message-ID: <20090907112225.GC6393@nowhere>
References: <20090904235527.520961911@goodmis.org> <20090905150658.GA13387@ghostprotocols.net> <4de7f8a60909070320j692d746drb06bd635ca7f7c55@mail.gmail.com> <20090907102838.GA6393@nowhere> <20090907104155.GD28804@bolzano.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ulrich Lukas <ulrich.lukas@gmx.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Jan Blunck <jblunck@suse.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753170AbZIGLWc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090907104155.GD28804@bolzano.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Sep 07, 2009 at 12:41:55PM +0200, Jan Blunck wrote:
> On Mon, Sep 07, Frederic Weisbecker wrote:
> > Ah, Ulrich Lukas also reported me such warnings. I would like to
> > track the reason of these messages (the hrtimer hanging detection
> > seems to warn too early).
> > 
> > Could you please send me your config, I hope I could reproduce it.
> > 
> 
> I only see that on one of my systems, a 32 core Opteron and not on my 8
> core. So it seems that size does matter ...


Ah then I have few chances to reproduce it with my boxes :-)

I'll try anyway, thanks!
