From: "MA QING A" <Qing.a.Ma@alcatel-sbell.com.cn>
Subject: RE: 2.6.25.4-rt2
Date: Tue, 20 May 2008 12:59:19 +0800
Message-ID: <630E9048ECEBBB4798CE33255209FE7306483561@CNSHGSMBS02.ad4.ad.alcatel.com>
References: <1211237032.14697.76.camel@localhost.localdomain><1211239147.198
	45.42.camel@localhost>  
	<Pine.LNX.4.58.0805191936120.4125@gandalf.stny.rr.com><630E9048ECEBBB4798CE
	33255209FE730648317D@CNSHGSMBS02.ad4.ad.alcatel.com>
	<Pine.LNX.4.58.0805200030120.9319@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kasper Sandberg" <lkml@metanurb.dk>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"RT" <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759367AbYETFAS@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.58.0805200030120.9319@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thanks very much for your explanation
At the very beginning I thought the Hackbench was a latency tools, so I=
 was very surprised to see such result.

But there's another question. When I choose the Complete Preemption -Re=
al Time  configuration, it's recommended to choose Timer Frequency --->=
 1000Mhz to improve the cpu performance, does it mean cpu will cost muc=
h more during the thread context switch? Or I should choose 100Mhz in o=
rder to decrease the thread context switch and get a better performance=
?=20
Which one should I choose? Or any useful tools can tell me the differen=
ces.

Any opinion appreciated
Thanks


Really Thanks again

-----Original Message-----
=46rom: Steven Rostedt [mailto:rostedt@goodmis.org]=20
Sent: 2008=C4=EA5=D4=C220=C8=D5 12:37
To: MA QING A
Cc: Kasper Sandberg; LKML; RT; Ingo Molnar; Thomas Gleixner
Subject: RE: 2.6.25.4-rt2




On Tue, 20 May 2008, MA QING A wrote:

> Forgive me to ask a stupid question.
> Why using the 24 mainline kernel, the time is less than using the
> rt-patched kernel?
>

The test I used is a performance test, not a latency test. An RTOS
(Real-time Operating System) will sacrifice performance to achieve
determinism (low latencies). Several key features to an RT system usual=
ly
come with a performance cost.

A non RT system will perform 99% of the time faster than an RTOS. But a=
ll
it takes is that one time to miss a deadline to make an RT system crash=
=2E
An RTOS may be slightly slower, but it will not have those outliers tha=
t a
normal desktop system would have.

So getting back to your question.  Hackbench runs a bunch of stuff and
times how long it took to do so. It stresses the system quite a bit. Th=
e
lower the number the better. Given that hackbench is not checking for
latency, but only shear perforance, it is expected that hackbench will =
run
better on a non RT system.

Now, a test like cyclictest that measures latencies will show the benef=
its
of realtime.  The kernel with the RT patch can measure 65 microsecond
latencies for response times even while running hackbench. The vanilla
kernel would measure a few milliseconds response times running the same
test.

-- Steve
