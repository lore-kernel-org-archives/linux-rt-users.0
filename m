From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 10:08:25 -0400
Message-ID: <1284559705.5701.128.camel@gandalf.stny.rr.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	 <201009141317.13439@zigzag.lvk.cs.msu.su>
	 <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com>
	 <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com>
	 <4C8F7AB90200005A00071A8F@soto.provo.novell.com>
	 <4C8FF2B6.2090205@us.ibm.com>  <4C906608.8080906@enseirb-matmeca.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:35714 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab0IOOI1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 10:08:27 -0400
In-Reply-To: <4C906608.8080906@enseirb-matmeca.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-09-15 at 08:22 +0200, Patrice Kadionik wrote:
> Le 15/09/2010 00:09, Nivedita Singhvi a =E9crit :

> Hi Nivedita;
> > I would go further and say people need to stop using the terms
> > "hard" and "soft". There isn't a binary yes/no answer to the real-t=
ime
> > requirements spectrum.
> >
> I don't agree with that.
> We are all OK to say that the application or the process to control=20
> fixes the timing constraints to the overall HW/SW system.
>=20
> If the application can NEVER miss an event or a deadline because it w=
ill=20
> be catastrophic, we MUST use a hard RTOS.

And you also need to have a hard RT HW, which x86 is far from that. If
you have a system that can cause a catastrophic disaster on failure, yo=
u
better not be running it on a normal x86 processor.

Hence, if you don't have a proven RT HW system, you don't need to worry
about the software either.


> If the application supports to miss (from time to time) an event or a=
=20
> deadline without catastrophic consequence, we can use a soft RTOS (or=
 a=20
> hard RTOS if we want).
> Not thinking hard nor soft realtime can have dramatic consequences.
>=20
> Until now, PREEMPT-RT is a nice solution as soft RTOS and offers no=20
> guaranty on an very big latency appeared in a particular case. Thinki=
ng=20
> that PREEMPT-RT is a hard RTOS is false.

Again, it depends on what you think hard is. If a failure wont kill
people but you will lose a million dollars, PREEMPT-RT may be good
enough. (although, if you lose a million dollars, you may still be
killed ;-)


> > Applications can have varying response time requirements, from
> > microseconds to milliseconds to seconds to minutes as Greg says abo=
ve.
> >
> > Applications might have differing penalties for missed deadlines:
> >  * nuclear reactor explodes
> >  * I lose a trade and it costs me money
> >  * I get a slightly different stock price quoted to me
> >  * Justin Bieber sounds a little hoarse
> >
> > If you're discussing Linux real-time, chances are your application
> > does not fall in the first one. Typically a very custom engineered
> > solution (hardware and software) is used for those who have rather
> > severe constraints.
> >
> > The concept of "hard" as being mathematically/logically provable
> > in terms of specs and code examination is nice, but not very practi=
cal.
> > As other people have pointed out frequently, given any system, it's
> > possible to break its guaranteed deadlines (catastrophic hw failure=
,
> > etc.
> You're right.
> In case of possible HW failure, HW design has HW redundancies.
>=20
> This discussion is very interesting but as I said in my first respons=
e,=20
> it will be the troll for many years...

Here's what I've come up with (and presented this in Brazil last year).

True hard real time is mathematically proven software that has all know=
n
worse case scenarios defined.

True soft real time allows for a missed deadline (as long as it is not
the norm), and the system does not fail.

PREEMPT-RT is neither of the above. What I call PREEMPT-RT is a hard
real time design. That is, we design PREEMPT-RT to be a hard real time
system but we do not mathematically prove that it is (too big to ever d=
o
that).

But if we find a situation that a worse case scenario exists that is
over a threshold for the given hardware, we consider it a bug and it
must be fixed. A soft real time system does not consider that a bug.

So is PREEMPT-RT hard real time? No.
Is it soft real time? No.

It is in between. The design goal of PREEMPT-RT is to be hard real time=
,
but we will never prove that it is. Hence, when it comes to non life
threatening things but things that are very important (may lose lots of
money, but no one dies), PREEMPT-RT may very well be the product of
choice.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
