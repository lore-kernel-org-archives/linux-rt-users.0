From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to 2.6.22
	available
Date: Thu, 12 Jul 2007 14:07:38 +0200
Message-ID: <20070712120738.GA9985@elte.hu>
References: <469544710200005A000275CC@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, jim.houston@ccur.com, joe.korty@ccur.com,
	dwalker@mvista.com, David Bahi <DBahi@novell.com>,
	Moiz Kohari <MKohari@novell.com>,
	Sven Dietrich <SDietrich@novell.com>, dsaxena@plexity.net,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>,
	Alessio Igor Bogani <abogani@texware.it>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:37760 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932648AbXGLMIr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 08:08:47 -0400
Content-Disposition: inline
In-Reply-To: <469544710200005A000275CC@mcclure.wal.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Gregory Haskins <ghaskins@novell.com> wrote:

> Hi Ingo, Thomas, and the greater linux-rt community,
>   
> 	I just wanted to let you guys know that our team has a port of 
> the 21.5-rt20 patch for the 2.6.22 kernel available. [...]

great! We had the upstream -rt port to .22 in the works too, it was just 
held up by the hpet breakage - which Thomas managed to fix earlier 
today. I've released the 2.6.22.1-rt1 patch to the usual place:

    http://redhat.com/~mingo/realtime-preempt/

I took a quick look at the delta between .22.1-rt1 and your rt1 merge, 
and the delta patch is quite large and i saw no obvious fixes to pick 
up. Could you please filter out any fixes that you might have in your 
tree that you think should be applied, and send it to us as a delta 
against .22.1-rt1? Alessio, could you please also do the same and check 
for any diffs that should be applied? Thanks!

(And, as Daniel suggested, in the future, could you _please_ use a 
different naming scheme instead of using up the upstream -rt namespace.)

	Ingo
