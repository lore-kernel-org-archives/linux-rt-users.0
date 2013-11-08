From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: UDP jitter
Date: Fri, 08 Nov 2013 13:22:19 +0100
Message-ID: <527CD77B.3050303@steinhoff.de>
References: <20130429222238.2b440d8c@sanja.asnn.org> <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org> <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at> <20131106125709.2e091182@sth491dt.servo.net> <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de> <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at> <20131107103325.65938975@sanja.asnn.org> <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de> <527CB16D.3040909@meduna.org> <20131108113250.2abdb8b7@sth491dt.servo.net> <alpine.DEB.2.02.1311081230580.23353@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stanislav Meduna <stano@meduna.org>,
	eg Engleder Gerhard <eg@keba.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53428 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab3KHMWc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 07:22:32 -0500
In-Reply-To: <alpine.DEB.2.02.1311081230580.23353@ionos.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner wrote:
> On Fri, 8 Nov 2013, Neboj=C3=85=C2=A1a =C3=84=E2=80=A0osi=C3=84=E2=80=
=A1 wrote:
>> I have to repeat that the code in question worked in my case, which =
is
>> very specific, and that reason for discussing it is to try to come t=
o a
>> proper solution to this problem.
>> And yes, I do believe that, even if behaviour is documented, it is s=
till
>> a problem and can be dealt with in a better way.
> I have to repeat what the real problem is:

It's also not possible to solve problems of the x86 based hardware by
kernel patches :)

Is the problem a mirage created by "SMI" ?
Running EtherCAT stable with SMI based delays of ~200-400 us is just an
illusion ...

--Armin

>
>  You are not understanding at all how networking, queueing, traffic
>  control and other advanced concepts are working. You are not even
>  trying it.
>
>  You just insist that your view of the problem is correct and there
>  must be a magic technical solution to it.
>
> Again, there is no technical solution to cure ignorance.
>
> Thanks,
>
> 	tglx
>
>
>
>
>
>
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
