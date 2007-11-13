From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: cyclic test results on 8 way (2.6.23.1-rt7 through 2.6.23.1-rt11)
Date: Tue, 13 Nov 2007 09:20:15 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711130918180.8512@gandalf.stny.rr.com>
References: <200711072334.40216.dvhltc@us.ibm.com> <4732CF27.BA47.005A.0@novell.com>
 <1985e0f60711130530x5a6ac4fy14763da579e7414@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>,
	Darren Hart <dvhltc@us.ibm.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:36742 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbXKMOW6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2007 09:22:58 -0500
In-Reply-To: <1985e0f60711130530x5a6ac4fy14763da579e7414@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Tue, 13 Nov 2007, Jaswinder Singh wrote:

> Hello Greg and Darren,
>
> If possible, can you please also add processor ID/number in your
> cyclictest and run more tasks (say 40, 60 or 80 tasks) then we have
> good picture like how many processes are running in which processor
> and how they switching between processors.
>
> And can we force processes to run on specific processor or core.
>

Cyclic test isn't really about testing RT balancing. Even though it does
have an effect. For that type of test you want my rt-migrate-test.c
http://rostedt.homelinux.com/rt/rt-migrate-test.c
or Gregory's (when he fixes it ;-)
http://rt.wiki.kernel.org/index.php/Preemption_Test

-- Steve
