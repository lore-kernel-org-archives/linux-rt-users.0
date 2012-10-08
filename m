From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.4.12-rt20
Date: Mon, 08 Oct 2012 19:23:39 -0400
Message-ID: <1349738619.24256.1.camel@gandalf.local.home>
References: <1349720414.6755.111.camel@gandalf.local.home>
	 <CAP=VYLrg2ouS+fODQMtxAguZ84h-v5T66aX48vTOCdsMhbBckg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP=VYLrg2ouS+fODQMtxAguZ84h-v5T66aX48vTOCdsMhbBckg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2012-10-08 at 19:05 -0400, Paul Gortmaker wrote:
> On Mon, Oct 8, 2012 at 2:20 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Dear RT Folks,
> >
> > I'm pleased to announce the 3.4.12-rt20 stable release.
> >
> >
> > This release is just an update to the new stable 3.4.12 version
> > and no RT specific changes have been made.
> 
> Did I miss something that ruled out the inclusion of your fix for
> moving the per-cpu softirq lock init after setup_per_cpu_areas?
> 

Nope, this was just a stable release. I keep stable merges separate from
added -rt patches. I need to add that, but I was waiting on more patches
coming from Thomas as he releases the 3.6-rt release (hopefully soon ;-)

-- Steve
