From: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 15:56:38 +0200
Message-ID: <4C90D096.7070301@enseirb-matmeca.fr>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <201009141317.13439@zigzag.lvk.cs.msu.su> <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com> <4C8F7AB90200005A00071A8F@soto.provo.novell.com> <4C8FF2B6.2090205@us.ibm.com> <4C906608.8080906@enseirb-matmeca.fr> <4C90CF71.2050205@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plan.enseirb.fr ([147.210.18.60]:38958 "EHLO plan.enseirb.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab0ION4y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 09:56:54 -0400
In-Reply-To: <4C90CF71.2050205@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Le 15/09/2010 15:51, Nivedita Singhvi a =E9crit :
> Patrice Kadionik wrote:
>
>
>> Hi Nivedita;
>>> I would go further and say people need to stop using the terms
>>> "hard" and "soft". There isn't a binary yes/no answer to the real-t=
ime
>>> requirements spectrum.
>>>
>> I don't agree with that.
>> We are all OK to say that the application or the process to control=20
>> fixes the timing constraints to the overall HW/SW system.
>>
>> If the application can NEVER miss an event or a deadline because it=20
>> will be catastrophic, we MUST use a hard RTOS.
>> If the application supports to miss (from time to time) an event or =
a=20
>> deadline without catastrophic consequence, we can use a soft RTOS (o=
r=20
>> a hard RTOS if we want).
>
> No, not really. The consequences may not be catastrophic, but people
> still want performance, latency, determinism, etc. For the majority
> of applications out there, this is true.  And they have specific
> requirements. So they _do_ need to ask, specifically, "can your OS
> do this?".
>
>
>> Not thinking hard nor soft realtime can have dramatic consequences.
>
> I think you missed my point. That's sort of exactly what I'm saying:
oops,

Sorry. I've misunderstood.

Cheers,

Patrice
>
> That customers/users need to think *VERY CAREFULLY* about their
> _specific_ requirements.
>
> i.e., it is never enough to ask "Is it a hard RTOS or soft"?
>
> If you have any specific requirements, the question needs to be:
>
> "can it do xxx in yyy when running zzz in ppp" etc.
>
> Followed by a whole heap of actual testing.
>
> i.e., the answer you get to the first question provides little
> value if you don't know how it is being defined, or worse, it's
> silently being defined differently than what you define it to be.
>
>
>> Until now, PREEMPT-RT is a nice solution as soft RTOS and offers no=20
>> guaranty on an very big latency appeared in a particular case.=20
>> Thinking that PREEMPT-RT is a hard RTOS is false.
>
> I'm not sure what this means, because most people I know are
> not making any kind of specific claims about PREEMPT_RT.
>
> thanks,
> Nivedita
>


--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------=
+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" =
+
+----------------------------------------------------------------------=
+
+ Patrice Kadionik             http://www.enseirb.fr/~kadionik         =
+
+ IMS Laboratory               http://www.ims-bordeaux.fr/             =
+
+ ENSEIRB                      http://www.enseirb.fr                   =
+
+ PO BOX 99                    fax   : +33 5.56.37.20.23               =
+
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               =
+
+ FRANCE                       mailto:patrice.kadionik@ims-bordeaux.fr =
+
+----------------------------------------------------------------------=
+

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
