From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.23.1-rt9 (and others)
Date: Wed, 07 Nov 2007 20:41:06 +0000
Message-ID: <473222E2.8030007@gmx.net>
References: <1194413959.8827.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:48628 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750821AbXKGToZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2007 14:44:25 -0500
In-Reply-To: <1194413959.8827.66.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven Rostedt wrote:
>
> Currently, what we do to test RT latencies is to run Thomas Gleixner's
> cyclictest
> (http://git.kernel.org/?p=linux/kernel/git/tglx/rt-tests.git;a=summary)
> as well as hackbench, to see what the maximum latencies we get are.
>   

hallo, can please someone suggest for how long time you are running
cyclictest?
if i run it for about 3 min. i get a feeling that the values will not
change anymore, so is there any recommended time for how long to run it?

another thing i do not know is, if i run cyclictest for lets say 3
minutes, than stop ('ctrl+c') and than start again, i get often
different values. so is it recommended to run it more times and than to
pick up the best/worst cases.

i have done some tests already with rt7,8 and 10 but i am not sure if
the tests make any sense - thats why i would really appreciate some
answers on the both questions.

cheers,
doc
