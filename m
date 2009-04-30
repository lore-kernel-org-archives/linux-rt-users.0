From: Sujit Karataparambil <sjt.kar@gmail.com>
Subject: Re: Ethernet communication from real time thread
Date: Thu, 30 Apr 2009 14:59:11 +0530
Message-ID: <921ca19c0904300229g47889c67yedd3aa4acb73b20d@mail.gmail.com>
References: <20308172.1241074857487.JavaMail.ngmail@webmail19.ha2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "M. Koehrer" <mathias_koehrer@arcor.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:43457 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbZD3J3M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2009 05:29:12 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1292173wfd.4
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2009 02:29:11 -0700 (PDT)
In-Reply-To: <20308172.1241074857487.JavaMail.ngmail@webmail19.ha2.local>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 think there are few questions you will have to answer before you end u=
p with
an solution.

1. Is Xenomai is Configured to take care of Multicore Hard real time
Computation? Since
  you say that the Thread is running in Processor 3. How is Xenomai
Configured in case
  of the Multicore Solution
2. What are these hard real time computations in this particular thread=
?
3. How is Xenomai Taking care of this thread?
4. RTNET is running the UDP Part of Thread or Does not fork in Xenomai.

On Thu, Apr 30, 2009 at 12:30 PM, M. Koehrer <mathias_koehrer@arcor.de>=
 wrote:
> Hi all,
>
> I have an application which is (so far) running using Xenomai and Rtn=
et.
> I am about to evaluate this using the rt_preemption patch (V2.6.29.1-=
rt9).
> It works quite smoothly, however I have some questions on the priorit=
ies that are used for
> Ethernet, UDP/IP based network communication.
> I have one separate NIC in my (Intel QuadCore) PC, that is used for a=
 point-to-point connection
> with an embedded device. Communication is done via UDP.
> I have now a user thread (RT prio: 80) to do some computation and als=
o the communication with
> the embedded device. This thread is the only running on core 3.
>
> My questions are now:
> A call of send() in my user space application to transmit a UDP messa=
ge
> ends up in the network stack of Linux.
> Which real time priority will be used in the network stack?
> Is it the priority of the user space thread that is calling send()?
> Or is it the priority of the kernel thread [sirq-net-tx/3]?
>
> On the receive side (calling recv()):
> Which threads are relevant here?
> IRQ-XX for the NIC's irq thread, [sirq-net-rx/3] or also the user spa=
ce thread that is calling recv()?
>
> Thanks for all feedback on that basic question!
>
> Best regards
>
> Mathias
>
>
> --
> Mathias Koehrer
> mathias_koehrer@arcor.de
>
>
> Arcor.de Gaming Area - kostenfrei daddeln bis der Arzt kommt!
> Jetzt checken und aus =FCber 80 Spielen w=E4hlen!
> http://www.arcor.de/footer-gaming/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
-- Sujit K M
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
