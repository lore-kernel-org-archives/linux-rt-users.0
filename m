From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: [RT] [RFC] simple SMI detector
Date: Sun, 25 Jan 2009 16:38:37 -0500
Message-ID: <1232919517.1326.7.camel@jcmlaptop>
References: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org>
	 <75b66ecd0901231833j2fda4554sb0f47457ab838566@mail.gmail.com>
	 <alpine.LFD.2.00.0901241716540.3424@localhost.localdomain>
	 <1232845026.3990.71.camel@perihelion.bos.jonmasters.org>
	 <1232849565.29318.112.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sven-Thorsten Dietrich <sdietrich@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753339AbZAYVi7@vger.kernel.org>
In-Reply-To: <1232849565.29318.112.camel@sven.thebigcorporation.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2009-01-25 at 13:12 +1100, Sven-Thorsten Dietrich wrote:

> I envision documentation of these specs, in a similar fashion to the
> manner in which CPU clock-cycles are documented for specific instruction
> executions - for those systems eligible (certified?) for low-latency
> operation.

I'd love to see a generic API that OS's could use to interface with
BIOS-level SMI implementations. Something provided in ACPI data. For all
I know, there already is something generic, but I've not heard of it?
It'd be really nice to have generic functions like:

disable_random_vendor_extensions_crap()
disable_all_non_essential_smis()

or whatever else.

> Providing benchmarking tools is definitely an excellent step in that
> direction (imo) - thanks.

Yeah. The more of this stuff, the better I think. So if someone wants to
help me polish what I posted then cool - it's in our "MRG" internal tree
already in the current form since we're only using it for debugging now.

Jon.
