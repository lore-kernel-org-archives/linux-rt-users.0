From: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 15:58:10 +0200
Message-ID: <4C8F7F72.1080206@enseirb-matmeca.fr>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <201009141317.13439@zigzag.lvk.cs.msu.su> <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F67A6.1030409@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plan.enseirb.fr ([147.210.18.60]:35132 "EHLO plan.enseirb.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776Ab0INN6l (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 09:58:41 -0400
Received: from localhost (mx [147.210.18.15])
	by plan.enseirb.fr (8.13.8/8.13.8) with ESMTP id o8EDv94R005247
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 15:57:09 +0200 (MEST)
Received: from plan.enseirb.fr ([147.210.18.60])
	by localhost (tan.enseirb.fr [147.210.18.15]) (amavisd-new, port 10041)
	with LMTP id FmJnu-wSHhSK for <linux-rt-users@vger.kernel.org>;
	Tue, 14 Sep 2010 15:57:34 +0200 (MEST)
Received: from [147.210.18.209] (pythagore [147.210.18.209])
	(authenticated bits=0)
	from identified as kadionik
	by plan.enseirb.fr (8.13.8/8.13.8) with ESMTP id o8EDulP9005213
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 15:57:08 +0200 (MEST)
In-Reply-To: <4C8F67A6.1030409@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Le 14/09/2010 14:16, Armin Steinhoff a =E9crit :
>  Robert Schwebel wrote:
>> On Tue, Sep 14, 2010 at 11:24:21AM +0200, Raz wrote:
>>> anyone can say preempt rt is hard real time?
>> Hard realtime has something to do with how you define "missing the
>> deadline". If somebody cuts the cable of your roboter controller in =
the
>> factory hall, the system misses the deadline. So it is all about
>> probabilities: hard realtime systems have a very, very low probabili=
ty
>> of missing the deadline. However, in real life systems, it is>  0%.
>>
>> So yes, if you talk about real world, it is hard realtime.
>>
> Hm, and what do think about that statement from FSMLabs:
>
> "Linux =93PREEMPT=94 real-time is a continuing experiment aimed at au=
dio
> and video playing with unreliable results and a detrimental affect on
> =93enterprise=94 performance"
Hello,

"soft realtime vs hard realtime" will be the troll in the embedded=20
community for the next years after the "with or without MMU" troll...


Patrice
>
> --Armin
>
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
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
+ Patrice Kadionikhttp://www.enseirb.fr/~kadionik          +
+ IMS Laboratoryhttp://www.ims-bordeaux.fr/              +
+ ENSEIRBhttp://www.enseirb.fr                    +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               =
+
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               =
+
+ FRANCEmailto:patrice.kadionik@ims-bordeaux.fr  +
+----------------------------------------------------------------------=
+

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
