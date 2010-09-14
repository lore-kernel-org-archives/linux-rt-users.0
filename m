From: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 17:42:48 +0200
Message-ID: <4C8F97F8.8080405@enseirb-matmeca.fr>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <201009141317.13439@zigzag.lvk.cs.msu.su> <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plan.enseirb.fr ([147.210.18.60]:37784 "EHLO plan.enseirb.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab0INPnS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 11:43:18 -0400
Received: from localhost (mx [147.210.18.15])
	by plan.enseirb.fr (8.13.8/8.13.8) with ESMTP id o8EFfl4Y007269
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 17:41:47 +0200 (MEST)
Received: from plan.enseirb.fr ([147.210.18.60])
	by localhost (tan.enseirb.fr [147.210.18.15]) (amavisd-new, port 10041)
	with LMTP id 44e-W-Xl2j+y for <linux-rt-users@vger.kernel.org>;
	Tue, 14 Sep 2010 17:42:12 +0200 (MEST)
Received: from [147.210.11.104] (relais.ixl.fr [147.210.188.1])
	(authenticated bits=0)
	from identified as kadionik
	by plan.enseirb.fr (8.13.8/8.13.8) with ESMTP id o8EFfSOc007267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 17:41:45 +0200 (MEST)
In-Reply-To: <4C8F8500.5070002@theptrgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Le 14/09/2010 16:21, Jeff Angielski a =E9crit :
> On 09/14/2010 05:44 AM, Robert Schwebel wrote:
>> On Tue, Sep 14, 2010 at 11:24:21AM +0200, Raz wrote:
>>> anyone can say preempt rt is hard real time?
>>
>> Hard realtime has something to do with how you define "missing the
>> deadline". If somebody cuts the cable of your roboter controller in =
the
>> factory hall, the system misses the deadline. So it is all about
>> probabilities: hard realtime systems have a very, very low probabili=
ty
>> of missing the deadline. However, in real life systems, it is>  0%.
>>
>> So yes, if you talk about real world, it is hard realtime.
>
> No.  Preempt rt it's not hard realtime.
Hi Jeff,

I agree with you.
Saying just realtime makes confusion because people often think hard=20
realtime in this case. They can also have surprises with they use a sof=
t=20
realtime OS in this case.
>
> But most people/companies who think they need hard realtime really=20
> don't.  They can live with soft realtime and have a really low=20
> probability of missing deadlines and having long latencies.  For thes=
e=20
> people, the preempt rt is adequate.
Yes. The reflexion to have is: I need realtime. Does my process to=20
control need hard realtime requirements or just soft realtime is enough=
?=20
Can my process to control support to miss some events sometime or not?

Patrice

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
