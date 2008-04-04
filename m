From: "Nelson Castillo" <nelsoneci@gmail.com>
Subject: Re: RT_PREEMPT and Serial Port
Date: Fri, 4 Apr 2008 10:42:05 -0500
Message-ID: <2accc2ff0804040842v1435fb5cq36df8c38d98bac3c@mail.gmail.com>
References: <20080404075753.GB28260@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "=?ISO-8859-1?Q?Mauricio_A._Araya_L=F3pez?=" <maray@inf.utfsm.cl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.180]:33459 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250AbYDDPmJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Apr 2008 11:42:09 -0400
Received: by ik-out-1112.google.com with SMTP id c28so87789ika.5
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Apr 2008 08:42:07 -0700 (PDT)
In-Reply-To: <20080404075753.GB28260@alumnos.inf.utfsm.cl>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 4, 2008 at 2:57 AM, Mauricio A. Araya L=F3pez
<maray@inf.utfsm.cl> wrote:
> Hi all,
>
>  I've been searching on the web (and in the rt-wiki) for the current
>  status of the real-time support for devices. For instance
>  the serial port, CAN Bus, etc.

Hi Mauricio.

I had a nice experience with a RS485 bus (half-duplex). The ideal setup
is to use automatic RTS control. I tried using manual control of this
signal with and without PREEMPT_RT. With PREEMPT_RT I
managed to receive the response of the device in the bus.
Without the patch I would miss the response
(even if it took as much as a few milliseconds).

I don't know about specific support in drivers, but I had a good experi=
ence
with this patch and a serial device.

Regards,
Nelson.-

--=20
http://arhuaco.org
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
