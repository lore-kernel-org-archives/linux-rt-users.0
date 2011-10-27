From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: Latency problem
Date: Thu, 27 Oct 2011 23:15:35 +0200
Message-ID: <4EA9C9F7.9090902@osadl.org>
References: <CAE_Gge02PZyZ93wSyH8uSJAQ6wdZRqG-L-qumV23g4Tam7BUmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:36101 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab1J0Vjc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Oct 2011 17:39:32 -0400
In-Reply-To: <CAE_Gge02PZyZ93wSyH8uSJAQ6wdZRqG-L-qumV23g4Tam7BUmQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Rapha=EBl,

> [..]
>> root@USBnux:/home/xaf/RT/rt-tests# ./hwlatdetect --threshold=3D1 --r=
eport=3D/home/xaf/hwlat_report
>> hwlatdetect:  test duration 120 seconds
>>    parameters:
>>         Latency threshold: 1us
>>
>>         Sample window:     1000000us
>>         Sample width:      500000us
>>      Non-sampling period:  500000us
>>         Output File:       /home/xaf/hwlat_report
>> Starting test
>> test finished
>> Max Latency: 38136us
>> Samples recorded: 45
>> Samples exceeding threshold: 45
>> sample data written to /home/xaf/hwlat_report
>
> and the content of the hwlat_report file :
>
>> 1319575592.0802426354	19061
>> 1319575707.0402420761	19036
> [..]
> I really have no idea from where the problem could be. And I need you=
r
> lights to help me.
The hwlatdetect application detects system management interrupts (SMIs)=
=2E=20
Such interrupts are installed by the BIOS and are used to manage variou=
s=20
things such as battery management, overheat protection and emulation of=
=20
legacy devices (e.g. IDE, PS/2 etc.). You may try to check your BIOS=20
settings and disable all these or similar features. Then run hwlatdetec=
t=20
again. If it still reports SMIs, the next thing to do depends on the=20
promises that you got when you bought the board:

1. It was advertised as an industrial PC to be used in a control system=
s=20
and to run a real-time operating system:
Return the board to the manufacturer along with the printed output of=20
hwlatdetect and ask for a fix or your money back.

2. It is a standard server PC board without any promises as to its=20
suitability in a real-time system:
There probably is nothing you can do. Try to send the output of=20
hwlatdetect to the BIOS manufacturer and nicely ask for a fixed BIOS,=20
but I am not very optimistic that you will get one.

Hope this helps,
	-Carsten.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
