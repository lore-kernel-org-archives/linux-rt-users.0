From: Ove Karlsen <ove.karlsen@paradoxuncreated.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Mon, 29 Oct 2012 21:39:49 +0100
Message-ID: <508EE995.3030109@paradoxuncreated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: tglx@linutronix.de, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.54]:48121 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224Ab2J2U4Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Oct 2012 16:56:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hiya, I am switching email-client currently, so excuse a bit of chaos.

I am reading=20
https://rt.wiki.kernel.org/index.php/Frequently_Asked_Questions#What_so=
rt_of_real-time_performance_should_I_expect.3F

I think it sounds really interesting that you have 10-30uS latencies=20
back in 2007. The concept sounds thorough and tried then. So I shouldn`=
t=20
expect any big SMI messing things up, on my core2duo right?

I think I really wanna get this to work. No solutions? :)

I am reading more here:

https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch

"Works ok, but frequency scaling has to be turned off for decent=20
results. A task run at 1 kHz repetition rate with low load was found to=
=20
be t-distributed with 4 degrees of freedom, with 1% value 0.9842 ms, 99=
%=20
value 1.0103 ms (ideal realtime performance would get exactly 1 ms for=20
both values), with the frequency governor set to "performance"."

Quite low. So he has got it running with low jitter, on a core 2 quad.

SMI sounds not much of a problem then. I want this guys. Altough as sai=
d=20
I am buying a computer, particulary for low-jitter, we can always try=20
and make this work on my older box in the mean time.

Remember the prob is with threadirqs on mainline aswell. Could it be=20
some clockproblem? A task for the thirsty bughunter, and patch-glory to=
=20
mainline.

--=20
=46red v=E6re med deg / Peace Be with You,
Ove Karlsen
http://www.paradoxuncreated.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
