From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.0.14-rt31
Date: Fri, 13 Jan 2012 18:51:48 -0500
Message-ID: <1326498708.7642.128.camel@gandalf.stny.rr.com>
References: <1324525237.5916.114.camel@gandalf.stny.rr.com>
	 <1326376484.7642.65.camel@gandalf.stny.rr.com>
	 <201201121757.25467.tim.sander@hbm.com>
	 <201201131042.08323.tim.sander@hbm.com>
	 <CAOEEKGXUJC9Mmu7azKSvQNkoB3Z_aLPTCDWABOE5WpHRKR=YNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Tim Sander <tim.sander@hbm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Bernardo Barros <bernardobarros2@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:37221 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab2AMXvv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jan 2012 18:51:51 -0500
In-Reply-To: <CAOEEKGXUJC9Mmu7azKSvQNkoB3Z_aLPTCDWABOE5WpHRKR=YNg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-01-13 at 10:45 -0800, Bernardo Barros wrote:
> Will 3.0-rt continue to receive bugfixes in parallel with 3.2-rt? Will
> it be a LTS kernel as 3.0 is?


Yes, I will still be maintaining it.

But as with mainline stable, there's some rules I follow. I do not add
any patch that is not yet in 3.2-rt (or whatever is the latest rt),
Linux mainline, or Linux stable. A patch must be in one of the above
before I add it.

With the exception if the patch only pertains to fix a bug in 3.0-rt and
that code no longer exists in 3.2-rt.

-- Steve


