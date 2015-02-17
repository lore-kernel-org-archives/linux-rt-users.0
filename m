From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Problem with driver on preempt-rt linux
Date: Tue, 17 Feb 2015 10:52:54 +0100
Message-ID: <20150217095254.GE26177@linutronix.de>
References: <BAY181-W466E944454AFF96EB6B11FC4FF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: =?utf-8?B?546L5oyv5YW0?= <myazheng@hotmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42970 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933129AbbBQJw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 04:52:56 -0500
Content-Disposition: inline
In-Reply-To: <BAY181-W466E944454AFF96EB6B11FC4FF0@phx.gbl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* =E7=8E=8B=E6=8C=AF=E5=85=B4 | 2014-07-24 11:56:22 [+0000]:

>Hi,everyone!
>   I have a problem in testing the driver of my PCI-7841 card on preem=
pt_rt linux. The driver is provided by the producer of the card.It runs=
 well on regular linux.However, when I run it with preempt_rt linux ker=
nel,although it's installed with no problem,the data of the can ports r=
eceive always have some errors.It just can't rightly receive the datas =
I transmit.Is it a driver problem?But I thought driver on preempt-rt li=
nux should be the same with the regular one.

If the driver has been written properly in terms of locking and API the=
n
there should be no problem after re-compiling. There is however a
sja1000 driver in kernel, I suggest you try that one.

>    Looking forward to the reply.Thanks.             		 	   		  N=E5=AB=
=A5=E5=8F=89=E9=9D=A3=E7=AC=A1y=EE=8C=B7=E6=B0=8Ab=E7=9E=82=EE=83=91=E5=
=8D=83v=E8=B1=9D?)=E8=97=93{.n?+=E5=A3=8F=EE=9A=8F{=E7=A2=91=E9=83=9Cz?=
"=E7=82=9F^n=E5=99=90=E2=96=A0=EE=9B=A0?=1A=E4=BE=82h=E6=AB=92=E7=92=80=
?&=E2=85=A7=1E=E7=93=BD=E7=8F=B4=E9=96=94?=03(=EE=85=A2=E6=AE=A0=E5=A8=B8=
=EE=95=90"=E6=BF=9F=1A?=1Bm??=E9=A3=A6=E8=B5=87z=E7=BD=90=E6=9E=88=E5=B8=
=BCf=EF=BC=82=E7=A9=90=E6=AE=98=EE=9D=84=E5=9D=A2

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
