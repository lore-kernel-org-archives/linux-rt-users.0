From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: Analyze sched_switch ftrace data with vcd viewer
Date: Sun, 14 Jun 2009 00:57:19 +0900
Message-ID: <49b7c2350906130857m196bc4bfvca8c5b766d172273@mail.gmail.com>
References: <4A281971.1040406@home.nl>
	 <49b7c2350906112312o1ca2aefeq658e6e645021c63f@mail.gmail.com>
	 <4A326BE3.40202@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Herman ten Brugge <hermantenbrugge@home.nl>,
	linux-rt-users@vger.kernel.org
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:65419 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbZFMP5Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 13 Jun 2009 11:57:16 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1925847ywb.1
        for <linux-rt-users@vger.kernel.org>; Sat, 13 Jun 2009 08:57:19 -0700 (PDT)
In-Reply-To: <4A326BE3.40202@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 12, 2009 at 11:53 PM, Carsten Emde<Carsten.Emde@osadl.org> =
wrote:
> Dear GeunSik Lim,
>
>> [..]
>> But I can not show normal result using "#> gtkware trace.vcd" comman=
d.
>> * screenshot :
>> http://blogfiles5.naver.net/data43/2009/6/12/228/gtkwave-vcd-2009060=
9.1503-invain.png
>
> The Quick HOWTO on our download page says:
> To select a particular data channel within gtkwave, select sched_swit=
ch in
> the top left window and drag and drop the label of the requested chan=
nel
> from the bottom left window labeled "Signals" to the drop area at the=
 left
> side of the main wave display area (also labeled "Signals").
Thank you for your explanation.
Now is normal.
>
> Please do so. I have every confidence that it will work.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Carsten.
>



--=20
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
