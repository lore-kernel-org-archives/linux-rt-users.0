From: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 08:22:00 +0200
Message-ID: <4C906608.8080906@enseirb-matmeca.fr>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <201009141317.13439@zigzag.lvk.cs.msu.su> <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com> <4C8F7AB90200005A00071A8F@soto.provo.novell.com> <4C8FF2B6.2090205@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plan.enseirb.fr ([147.210.18.60]:35019 "EHLO plan.enseirb.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809Ab0IOGWH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 02:22:07 -0400
Received: from localhost (mx [147.210.18.15])
	by plan.enseirb.fr (8.13.8/8.13.8) with ESMTP id o8F6KXKG024138
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 08:20:33 +0200 (MEST)
Received: from plan.enseirb.fr ([147.210.18.60])
	by localhost (tan.enseirb.fr [147.210.18.15]) (amavisd-new, port 10041)
	with LMTP id RXRbxPbtdVEH for <linux-rt-users@vger.kernel.org>;
	Wed, 15 Sep 2010 08:20:59 +0200 (MEST)
Received: from [192.168.0.1] (lns-bzn-43-82-249-190-231.adsl.proxad.net [82.249.190.231])
	(authenticated bits=0)
	from identified as kadionik
	by plan.enseirb.fr (8.13.8/8.13.8) with ESMTP id o8F6KTYK024136
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 08:20:30 +0200 (MEST)
In-Reply-To: <4C8FF2B6.2090205@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Le 15/09/2010 00:09, Nivedita Singhvi a =E9crit :
> On 09/14/2010 10:38 AM, Gregory Haskins wrote:
>
>>> No.  Preempt rt it's not hard realtime.
>>
>> This is not technically correct, but a common misconception. "Hard"=20
>> vs "Soft" is a property of the _application_, not the os/platform=20
>> itself, and it's based on how tolerant a given application is to=20
>> missed deadlines.
>>
>> "Hard" might be something like professional lossless audio, nuclear=20
>> fuel-rod control, bomb-squad robotics, tele-medicine, etc, where the=
=20
>> result of a missed deadline can have a serious/unacceptable negative=
=20
>> impact (death, injury, SLA failure, etc).  "Soft" might be telecom=20
>> audio, high-frequency financial trading, etc, where misses (crappy=20
>> audio quality, missed market opportunity, etc) are certainly not=20
>> desired, but can technically be gracefully recovered from.
>>
>> Any given platform (os and hardware combo) will have quantifiable=20
>> performance/latency characteristics.  If those characteristics excee=
d=20
>> the requirements of your application, they it would generally work t=
o=20
>> run a "hard rt" application on that platform.  If those=20
>> characteristics<=3D your app, it probably will not meet your deadlin=
es=20
>> and therefore, a hard-rt app will fail.
>>
>> Consider a fictious nuclear fuel rod control applications with=20
>> requirements for a period of 20s, 500ms dutycycle, and with +- 1s=20
>> jitter tolerance.  Failure means reactor meltdown (this is=20
>> hard-realtime) yet preempt-rt could certainly handle this.  Heck,=20
>> mainline linux could probably handle this.  On the other hand, if=20
>> anyone out there plans on doing fuel-rod control with software,=20
>> please tell me so I can leave the continent. ;)  But the point is,=20
>> it's a hard-realtime application and it can be done even with=20
>> preempt-rt.  As you scale the applicaiton's requirements tighter and=
=20
>> tighter, you will eventually find the limits of the platform to whic=
h=20
>> it is no longer acceptable to run the application.  On modern x86=20
>> desktops, these limits are in the order of 10us-150us.
>>
>> The biggest challenge is _proving_ that a given platform actually=20
>> possesses the desired performance characteristics.  This is=20
>> especially difficult with preempt-rt given that its based on a=20
>> general purpose OS (linux) and a large one that that.  Smaller, more=
=20
>> RT specific os designs may be easier to prove every path has a=20
>> maximum latency of "X".  That said, there are very few products out=20
>> there that could probably fit that description and most will have=20
>> trouble proving beyond a shadow of doubt.  In addition, the=20
>> preempt-rt community is very responsive and treats every latency=20
>> source as a "bug" to be fixed/improved.
>>
>> So bottom line, if in doubt, I suggest you give preempt-rt a try. =20
>> Linux in general boasts probably the broadest support profile of any=
=20
>> platform out there.  In addition, it's configuration is so finely=20
>> grained that you can probably scale it back to a lean, mean,=20
>> low-latency environment that will do what you need for perhaps all=20
>> but the most stringent requirements.  Where it wouldn't work, perhap=
s=20
>> only dedicated hardware may help anyway.
>
>
Hi Nivedita;
> I would go further and say people need to stop using the terms
> "hard" and "soft". There isn't a binary yes/no answer to the real-tim=
e
> requirements spectrum.
>
I don't agree with that.
We are all OK to say that the application or the process to control=20
fixes the timing constraints to the overall HW/SW system.

If the application can NEVER miss an event or a deadline because it wil=
l=20
be catastrophic, we MUST use a hard RTOS.
If the application supports to miss (from time to time) an event or a=20
deadline without catastrophic consequence, we can use a soft RTOS (or a=
=20
hard RTOS if we want).
Not thinking hard nor soft realtime can have dramatic consequences.

Until now, PREEMPT-RT is a nice solution as soft RTOS and offers no=20
guaranty on an very big latency appeared in a particular case. Thinking=
=20
that PREEMPT-RT is a hard RTOS is false.
> Applications can have varying response time requirements, from
> microseconds to milliseconds to seconds to minutes as Greg says above=
=2E
>
> Applications might have differing penalties for missed deadlines:
>  * nuclear reactor explodes
>  * I lose a trade and it costs me money
>  * I get a slightly different stock price quoted to me
>  * Justin Bieber sounds a little hoarse
>
> If you're discussing Linux real-time, chances are your application
> does not fall in the first one. Typically a very custom engineered
> solution (hardware and software) is used for those who have rather
> severe constraints.
>
> The concept of "hard" as being mathematically/logically provable
> in terms of specs and code examination is nice, but not very practica=
l.
> As other people have pointed out frequently, given any system, it's
> possible to break its guaranteed deadlines (catastrophic hw failure,
> etc.
You're right.
In case of possible HW failure, HW design has HW redundancies.

This discussion is very interesting but as I said in my first response,=
=20
it will be the troll for many years...

Cheers;

Patrice
>
> The real-time Linux patchset (CONFIG_PREEMPT_RT) provides real-time
> support in Linux. As you might expect from a general-purpose OS
> providing real-time, it's providing increased determinism and better
> control over your system (most significantly, your kernel tasks).
>
> A more preemptive kernel and system with better time granularity
> provides better real-time response compared to a standard kernel.
>
> It's important to note that we're not providing guarantees. Latency
> response time expectations are really based on empirical evidence,
> testing with common hw/sw/configurations and debugging issues when
> an issue is reported.
>
> Seriously, the terms "hard" and "soft" really only serve to either
> confuse or have little value (other than "custom" and "non-custom").
>
> thanks,
> Nivedita
>
>
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
+ Patrice Kadionik             http://www.enseirb-matmeca.fr/~kadionik =
+
+ IMS Laboratory               http://www.ims-bordeaux.fr/             =
+
+ ENSEIRB-MATMECA              http://www.enseirb-matmeca.fr           =
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
