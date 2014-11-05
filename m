From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: [ANNOUNCE] 3.14.23-rt20
Date: Wed, 5 Nov 2014 15:35:51 +0000
Message-ID: <CAKudYbNhjdNmw27tMz261p+6q4OStBp2zUoBsgtJdQGcJ9fkKw@mail.gmail.com>
References: <20141031170326.1491a63f@gandalf.local.home>
	<1414913427.5380.110.camel@marge.simpson.net>
	<CADLDEKvFvw7Aa98tVtM3z5JV8oocKqAdV4PqOMoZH2mXZ6x2jg@mail.gmail.com>
	<20141105092707.7c9bb1ae@gandalf.local.home>
	<CADLDEKsYzpN4uPD7wEE6bxZP21gd3xY4c0fsRqfB1RwEZ53iKg@mail.gmail.com>
	<20141105100056.152fd532@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Juerg Haefliger <juergh@gmail.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141105100056.152fd532@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 5 Nov 2014 14:50:41 +0100 Juerg Haefliger <juergh@gmail.com> wrote:
> The cpufreq code does nested down_read_trylocks and only the first one succeeds:
>drivers/cpufreq/cpufreq.c:
>store
>  down_read_trylock(cpufreq_rwsem)  <- succeeds
>  store_scaling_governor
>    cpufreq_get_policy
>      cpufreq_cpu_get
>        down_read_trylock(cpufreq_rwsem)  <-- fails

On a related note: I think this patch/issue may be the cause of the
-rt CPU frequency scaling bug I reported a couple of months ago.
http://comments.gmane.org/gmane.linux.rt.user/12472

I'm currently using the performance governor by default as a
workaround; thanks to JackWinter for packaging in the ArchAudio repos.

Cheers, -Harry

-- 

http://www.openavproductions.com
