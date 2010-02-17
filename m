From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: LTTng0.158 Linux-2629-RT kernel BUG: sleeping
	function called from invalid context at kernel/rtmutex.c:685
Date: Wed, 17 Feb 2010 16:06:28 +0530
Message-ID: <f5a7b3811002170236i6c560eadp2de7deb10082db4f@mail.gmail.com>
References: <f5a7b3811002160717y65b4577buf53e5784c71575c3@mail.gmail.com>
	<1266337450.24271.140.camel@gandalf.stny.rr.com>
	<alpine.LFD.2.00.1002161727570.2811@localhost.localdomain>
	<20100216164744.GA25115@Krystal>
	<alpine.LFD.2.00.1002161757050.2811@localhost.localdomain>
	<20100216170540.GA28039@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, ltt-dev@lists.casi.polymtl.ca,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Return-path: <ltt-dev-bounces@lists.casi.polymtl.ca>
In-Reply-To: <20100216170540.GA28039@Krystal>
List-Unsubscribe: <http://lists.casi.polymtl.ca/cgi-bin/mailman/options/ltt-dev>,
	<mailto:ltt-dev-request@lists.casi.polymtl.ca?subject=unsubscribe>
List-Archive: <http://lists.casi.polymtl.ca/pipermail/ltt-dev>
List-Post: <mailto:ltt-dev@lists.casi.polymtl.ca>
List-Help: <mailto:ltt-dev-request@lists.casi.polymtl.ca?subject=help>
List-Subscribe: <http://lists.casi.polymtl.ca/cgi-bin/mailman/listinfo/ltt-dev>,
	<mailto:ltt-dev-request@lists.casi.polymtl.ca?subject=subscribe>
Errors-To: ltt-dev-bounces@lists.casi.polymtl.ca
List-Id: linux-rt-users.vger.kernel.org

Hi,

On Tue, Feb 16, 2010 at 10:35 PM, Mathieu Desnoyers
<compudj@krystal.dyndns.org> wrote:
> * Thomas Gleixner (tglx@linutronix.de) wrote:
>> On Tue, 16 Feb 2010, Mathieu Desnoyers wrote:
>> > > The function is called from an IPI. That's a LTTNG problem, not a RT=
 one.

yes. it's seems be a LTTng0.158 problem.
I have tested with below combinations.

2.6.29                        ->no issues
2.6.29+LTTng0.100      ->no issues
2.6.29+LTTng0.158     ->no issues

2.6.29-RT                   ->no issues
2.6.29-RT+LTTng0.100 ->no issues
2.6.29-RT+LTTng0.158 ->BUG reported.

>> >
>> > I use del_timer in IPI to delete lttng per-cpu timers on all CPUs. I
>> > have to do this because timers created with add_timer_on are documented
>> > to be incompatible with del_timer_sync():
>> >
>> > =A0* Synchronization rules: Callers must prevent restarting of the tim=
er,
>> > =A0* otherwise this function is meaningless. It must not be called from
>> > =A0* interrupt contexts. The caller must not hold locks which would pr=
event
>> > =A0* completion of the timer's handler. The timer's handler must not c=
all
>> > =A0* add_timer_on(). Upon exit the timer is not queued and the handler=
 is
>> > =A0* not running on any CPU.
>>
>> Errm. The documentation says:
>>
>> =A0 =A0 =A0 "The timer's handler must not call add_timer_on()."
>>
>> It's not talking about a timer which was initialized with
>> add_timer_on().
>>
>> =A0And your per cpu timer handlers have no requirement to call
>> add_timer_on() simply because add/mod_timer() is requeueing the timer
>> on the same cpu on which the handler runs.
>>
>> So the IPI is just a solution for a non existing problem.
>
> Oh, right. Thanks for the explanation. I'll look into moving LTTng to a
> saner del_timer_sync() scheme to delete the timers.

Could you give more info regarding, what kind of changes we can work on.
let me also work around on it.

Best regards,
Naresh Kamboju

>
> Thanks,
>
> Mathieu
>
>>
>> Thanks,
>>
>> =A0 =A0 =A0 tglx
>>
>
> --
> Mathieu Desnoyers
> OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F =A0BA06 3F25 A8FE 3BAE =
9A68
