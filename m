From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng 0.193 fixes RT kernel support
Date: Wed, 17 Feb 2010 18:08:54 -0500
Message-ID: <20100217230854.GA25636@Krystal>
References: <f5a7b3811002160717y65b4577buf53e5784c71575c3@mail.gmail.com>
	<1266337450.24271.140.camel@gandalf.stny.rr.com>
	<alpine.LFD.2.00.1002161727570.2811@localhost.localdomain>
	<20100216164744.GA25115@Krystal>
	<alpine.LFD.2.00.1002161757050.2811@localhost.localdomain>
	<20100216170540.GA28039@Krystal>
	<f5a7b3811002170236i6c560eadp2de7deb10082db4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, ltt-dev@lists.casi.polymtl.ca,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
To: naresh kamboju <naresh.kernel@gmail.com>
Return-path: <ltt-dev-bounces@lists.casi.polymtl.ca>
Content-Disposition: inline
In-Reply-To: <f5a7b3811002170236i6c560eadp2de7deb10082db4f@mail.gmail.com>
List-Unsubscribe: <http://lists.casi.polymtl.ca/cgi-bin/mailman/options/ltt-dev>,
	<mailto:ltt-dev-request@lists.casi.polymtl.ca?subject=unsubscribe>
List-Archive: <http://lists.casi.polymtl.ca/pipermail/ltt-dev>
List-Post: <mailto:ltt-dev@lists.casi.polymtl.ca>
List-Help: <mailto:ltt-dev-request@lists.casi.polymtl.ca?subject=help>
List-Subscribe: <http://lists.casi.polymtl.ca/cgi-bin/mailman/listinfo/ltt-dev>,
	<mailto:ltt-dev-request@lists.casi.polymtl.ca?subject=subscribe>
Errors-To: ltt-dev-bounces@lists.casi.polymtl.ca
List-Id: linux-rt-users.vger.kernel.org

* naresh kamboju (naresh.kernel@gmail.com) wrote:
> Hi,
> 
> On Tue, Feb 16, 2010 at 10:35 PM, Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:
[...]
> > Oh, right. Thanks for the explanation. I'll look into moving LTTng to a
> > saner del_timer_sync() scheme to delete the timers.
> 
> Could you give more info regarding, what kind of changes we can work on.
> let me also work around on it.
> 

I just released LTTng 0.193 for kernel 2.6.32.4 which includes patches
fixing these odd per-cpu timer teardowns. The patches concerned are:

lttng transport lockless add timer on works with del timer sync
omap trace clock use del timer sync
x86 trace clock use mod timer
trace clock 32 to 64 use del timer sync

(they are at the end of the LTTng 0.193 tree)

Feedback is welcome,

Thanks,

Mathieu

-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
