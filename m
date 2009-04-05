From: Remy Bohmer <linux@bohmer.net>
Subject: Re: System deadlock on 2.6.24-rt20 (-rt27 panics on
	locking-api-selftests)
Date: Sun, 5 Apr 2009 21:00:39 +0200
Message-ID: <3efb10970904051200g4c725badp6d05092b70dd56a2@mail.gmail.com>
References: <3efb10970904030502q1068731fl5b92f93d5341b43e@mail.gmail.com>
	 <alpine.LFD.2.00.0904051257470.747@localhost.localdomain>
	 <3efb10970904051139ue3802b1ib33487418188e4bc@mail.gmail.com>
	 <alpine.LFD.2.00.0904052046030.747@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753443AbZDETBF@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0904052046030.747@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Thomas,

2009/4/5 Thomas Gleixner <tglx@linutronix.de>:
> On Sun, 5 Apr 2009, Remy Bohmer wrote:
>> > What happens if you disable the self tests ?
>>
>> The system boots and seems to run properly. We did not yet test for a
>> longer period of time, but the first looks are that the hangups we had
>> are gone now. But it would be good for the peace of mind if the
>> locking-selftest was working properly.
>
> Patches are welcome. :)
>
> Seriously, I'm not going to look into that as my limited capacity is
> focussed on 2.6.29-rt.

As it should be... :-)
I was not asking you to fix it, my apologies if you read it that way.
It is not that important to me, just a nice-to-have.


Kind Regards,

Remy
