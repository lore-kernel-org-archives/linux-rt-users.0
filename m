From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: Re: Preempt RT on ARM (some simple compile patches attached)
Date: Tue, 3 Mar 2009 15:19:46 +0100
Message-ID: <200903031519.47659.tim01@vlsi.informatik.tu-darmstadt.de>
References: <200903021824.43495.tim01@vlsi.informatik.tu-darmstadt.de> <20090303001525.GA16807@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx500.hrz.tu-darmstadt.de ([130.83.156.225]:50792 "EHLO
	lnx500.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752322AbZCCOT5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Mar 2009 09:19:57 -0500
Received: from mailserver3.hrz.tu-darmstadt.de (lnx504.hrz.tu-darmstadt.de [130.83.156.233])
	by lnx500.hrz.tu-darmstadt.de (8.13.8/8.13.8/HRZ/PMX) with ESMTP id n23EJp08013318
	for <linux-rt-users@vger.kernel.org>; Tue, 3 Mar 2009 15:19:52 +0100
	(envelope-from tim01@vlsi.informatik.tu-darmstadt.de)
Received: from [213.157.9.102] (helo=IP-213157009102.dialin.heagmedianet.de)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tim01@vlsi.informatik.tu-darmstadt.de>)
	id 1LeVTL-0004Y6-R4
	for linux-rt-users@vger.kernel.org; Tue, 03 Mar 2009 15:19:51 +0100
In-Reply-To: <20090303001525.GA16807@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

Thanks for your reply Uwe.
> You should check the warnings you get.  There are several telling you:
> 	warning: unsupported argument to '__builtin_return_address
Ok, i missed these.
There are some more strange warnings:
"/tmp/ccGVkFZn.s:610: rdhi, rdlo and rm must all be different"
are these harmful too?

> You can find the patches in my git repo, too.  Either at
>
> 	git://git.pengutronix.de/git/ukl/linux-2.6.git rt-master
>
> or in the topgit controlled patches in the same repo with t/rt-master
> being the topmost patch.
I pulled your tree before since i found a message in the archive saying you 
where working on it. But i was a bit disappointed since i didn't pulled the 
rt-master branch. However tracing is still not working, but you already said 
there are some patches missing.

I am currently a little lost in all these git trees, but if someone gives me a 
hint i might give it a try.

Regards
Tim

-- 
''=~('(?{'.('._@@[~'^'^-)./^').'"'.('}@@~-]@_^__'^'))-^~<.;;-}').',$/})')
