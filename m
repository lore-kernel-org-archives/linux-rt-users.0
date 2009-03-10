From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: rt application question with rs232 communication
Date: Tue, 10 Mar 2009 08:44:32 -0400
Message-ID: <f96d234e0903100544p5bc17143l8916aefd49d78562@mail.gmail.com>
References: <f96d234e0903091434xafaedcamc68023ebce5c7799@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:56902 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbZCJMoe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Mar 2009 08:44:34 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2202077rvb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2009 05:44:32 -0700 (PDT)
In-Reply-To: <f96d234e0903091434xafaedcamc68023ebce5c7799@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clarification, I don't have the RT patch applied, just CONFIG_PREEMPT
from Linus's kernel.  Reviewing my notes from several years ago, I ran
into a similar issue and the RT patch fixed it, so now to figure out
the best way to get a recent RT patched ARM kernel ...

Cliff

On Mon, Mar 9, 2009 at 5:34 PM, Cliff Brake <cliff.brake@gmail.com> wro=
te:
> Hello,
>
> I have an application where I do the following:
>
> - PXA270 CPU
> - communicating over serial ports on 40ms intervals
> - communication scheme is very simple in that the linux system sends =
a
> packet every 40ms and expects a response back within the 40ms window
> - currently using 2.6.27 with CONFIG_PREEMPT
>
> If I set the application comm thread to real time priority, the
> sending works very well. =A0There is very little jitter in the 40ms s=
end
> timing. =A0However, it seems that the system has trouble receiving th=
e
> response in a timely fashion. =A0I often observe that it takes at lea=
st
> 10ms for the application to receive the response data after the data
> has appeared on the rs232 bus. =A0Is the RT patch something that woul=
d
> help speed up the serial receive response time, or is there something
> else going on that I am missing? =A0The system is fairly busy with
> graphical processing, but the sending is always right on schedule.
>
> It seems that interrupts may be involved with this problem as when
> sending, the send data is smaller than the FIFO size, and is probably
> put into the fifo during the write, where with the read, an interrupt
> needs to fire, etc. =A0Does all the kernel code that handles the seri=
al
> data automatically run at the calling application's RT priority, or i=
s
> there additional work required to make everything that touches the
> data RT?
>
> I'm also trying to figure out how well RT will work for CAN
> communications. =A0Once again we have the same problem -- a RT user
> space application needs to send and receive data with strict timing.
> Which, I can make a RT thread in user space run well (toggle a gpio
> with very little jitter), how does this translate to all the kernel
> components involved in the socketcan stack (networking, etc) that nee=
d
> to touch the data?
>
> Thanks,
> Cliff
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Cliff Brake
> http://bec-systems.com
>



--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Cliff Brake
http://bec-systems.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
