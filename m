From: mgross <640e9920@gmail.com>
Subject: Re: RT_PREEMPT and Serial Port
Date: Sat, 12 Apr 2008 13:08:37 -0700
Message-ID: <20080412200837.GA6223@mgross-t43>
References: <20080404075753.GB28260@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Mauricio =?utf-8?Q?A=2E_Araya_L=EF=BF=BDpez?= <maray@inf.utfsm.cl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:59673 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449AbYDLUIn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Apr 2008 16:08:43 -0400
Received: by an-out-0708.google.com with SMTP id d31so246098and.103
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Apr 2008 13:08:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080404075753.GB28260@alumnos.inf.utfsm.cl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 04, 2008 at 03:57:53AM -0400, Mauricio A. Araya L=EF=BF=BDp=
ez wrote:
> Hi all,
>=20
> I've been searching on the web (and in the rt-wiki) for the current
> status of the real-time support for devices. For instance
> the serial port, CAN Bus, etc.
>=20
> I am doing some experiments to check if RT_PREEMPT could be an option=
 to
> a control system that is using RTAI nowadays.
>=20
> If not, maybe it is a good thing to develop myself, so if anyone can
> comment anything about this, it will be very helpfull to start.

I was just doing this and fell into a tangent looking at USB2Serial
issues with RT applications.

=46WIW I was able to get +/- 30usec jitter from a serial port experimen=
t
where I programmed a PIC to push 5 bytes over the serial line every
20ms.  I had a blocking read from a FIFO pthread that would wake up
and call gettimeofday, which I used to measure the jitter.  It was
very impressive.  I'm pretty confident that *if* you use a hardware
serial port (no-USB) you will be able to implement effective PID
controls with a real time pthread program running on a RT-preempt
kernel.=20

um on common desktop PC hardware like what I used anyway.

--mgross


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
