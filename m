From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Mysterious delay (interrupt?)
Date: Mon, 25 Jun 2007 08:01:46 -0400
Message-ID: <1182772906.5493.153.camel@localhost.localdomain>
References: <20070625095538.6b642a7b.szilard.pasztor@evosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?P=E1sztor_Szil=E1rd?= <szilard.pasztor@evosoft.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:46210 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbXFYMBu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jun 2007 08:01:50 -0400
In-Reply-To: <20070625095538.6b642a7b.szilard.pasztor@evosoft.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi P=E1sztor,

Not sure if it would help you trace this down further but have you trie=
d
running your load with the Latency Tracer configured in? The Latency
Tracer will generate its own over head latency but might track the
problem down further.


On Mon, 2007-06-25 at 09:55 +0200, P=E1sztor Szil=E1rd wrote:
> Hi,
>=20
>   I'm using the RT patch for a project where I have to communicate ov=
er
> ethernet and 8 serial ports (via a pci multi-interface card). I must =
gain CPU
> time for a while in every millisecond which is my periodic cycle time=
=2E

Is the thread that needs to gain CPU time dependent on the accessing of
the serial and ethernet ports?

>   Most things seem ok, but for some strange reason, 2-3 ms latencies =
show up
> rarely about once out of 200000 cycle runs or so when the machine is =
under
> load, mostly of interrupts.

Can you post the code to your program somewhere, and also show us
exactly where you see the latency?

>   It took a while for me to track it down but finally found that this=
 latency
> is not related to a slower part of my cycle, but is caused indirectly=
 by an
> ioctl() call in the cycle with TIOCMGET read command on the serial po=
rts that
> translates to a driver-dependent get_mctrl call inside the kernel. If=
 the call
> is in, the delay shows up elsewhere every time, spread across the cyc=
le (found
> that with extensive timestamping) so I'm thinking of some interrupt k=
icking in
> a while after the ioctl() call. Commenting the call out eliminates th=
e problem
> completely, but it unfortunately eliminates the functionality of my c=
ode as
> well since things depend on the line states so I cannot spare the rea=
d of the
> modem status register.

The only real thing that happens in get_mctrl that I see is a wake_up.
So if something is sleeping on an ioctl TIOCMWAIT, it will wake up and
run.  Do you have something that does this?  Your latency that you are
seeing, might just be another thread taking up the CPU.

>=20
> I'm currently using 2.6.19-rt15 but this problem shows up with every =
kernel
> and patch version I've tried (starting from 2.6.16 to 2.6.20) and I'm=
 not
> really able to test newer versions currently because the server is un=
der heavy

Your personal server or are you talking about the server to download th=
e
patch?

> use. However, I suspect that this problem is not an easy sight to com=
e by and
> probably still persists. Of course my task is running with the highes=
t
> real-time priority. The lower level serial driver that is in use is
> drivers/serial/8250.c.

As I said, check your application. I think there's another thread you
may have that is competing with the thread you are timing.

>=20
>   I'm afraid I don't have a deep enough insight to track it down any =
further,
> so I thought I'd try if this description rings a bell with more knowl=
edgeable
> persons.
>=20
> Any help would be greatly appreciated.

-- Steve
