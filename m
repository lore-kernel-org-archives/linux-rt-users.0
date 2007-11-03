From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: 2.6.23.1-rt5 (was 2.6.23-rt1 trouble)
Date: Sat, 03 Nov 2007 19:22:18 +0100
Message-ID: <472CBC5A.5080104@googlemail.com>
References: <1192154640.15992.10.camel@localhost.localdomain>          <38542.213.58.131.130.1192445349.squirrel@www.rncbc.org> <471648B8.1030007@rncbc.org> <47234EA1.4050006@rncbc.org> <Pine.LNX.4.58.0710271203170.28617@gandalf.stny.rr.com> <47239A37.8000401@rncbc.org> <472781E3.7010103@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:14691 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988AbXKCSWX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 Nov 2007 14:22:23 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1068687mue
        for <linux-rt-users@vger.kernel.org>; Sat, 03 Nov 2007 11:22:22 -0700 (PDT)
In-Reply-To: <472781E3.7010103@rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

>> Steven Rostedt wrote:
>>> When things start to freeze, could you capture the output of a sysrq-t.
>>>

Hi ,

I have also the same problem on my SMP box[1] ( i686 ), random hard freeze I can just hard reset the box.

I'm not able to capture any output :/ keyboard does not work , netconsole does not have any output when freeze occurs,
nor I have any 'BUG:' , 'Oops:' or the like messages in any logs.
The only thing I noticed is :

...

Clocksource tsc unstable (delta = 4686944957 ns)
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^ <-- may be some sort data corruption :/

...

as latest kernel message before most freeze. 

Booting with different clocksource does not make any difference.

I do not use nvidia , in fact I don't use any external kernel module on that box.

Anyway it seems to work fine on non-SMP also my laptops does not have that problem with the same kernel.

If needed I can post the config but I tested a lot different configs with the same result.

Is there any rt-git tree I can test ?


Regards,

Gabriel


[1] http://194.231.229.228/lara/lara.html
    http://194.231.229.228/lara/lara.lspci
