From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] hwlat_detector: Detect hardware-induced latencies
Date: Thu, 9 Apr 2015 10:10:37 -0400
Message-ID: <20150409101037.4dd0837a@gandalf.local.home>
References: <1428508021-28166-1-git-send-email-daniel.wagner@bmw-carit.de>
	<20150408123550.7dbd61b4@gandalf.local.home>
	<5526458E.5050202@bmw-carit.de>
	<552682A4.4000309@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-rt-users@vger.kernel.org, Jon Masters <jcm@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Tom Zanussi <tom.zanussi@linux.intel.com>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <552682A4.4000309@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 09 Apr 2015 15:46:12 +0200
Carsten Emde <C.Emde@osadl.org> wrote:

> Hi Daniel,
> 
> > BTW, are you also taking care of the latency-hist.patch patch?
> I do.
> 
> However, the request (and the challenge) is not to simply rewrite the 
> code. The idea is to provide a general histogram framework that can be 
> used from anywhere in the kernel and to equip it with everything needed 
> by the existing histograms. This framework should no longer be part of 
> the RT patches but submitted directly to mainline Linux. In a second 
> step, we will then rewrite the existing histogram code to use the new 
> framework.
> 
> Any help is greatly appreciated!

Hmm, Currently Tom Zanussi is working on a hist trigger for tracing.
Not sure it can be used here, but perhaps ideas can be spawned.

http://marc.info/?l=linux-kernel&m=142807630917288

-- Steve
