From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RFC on fixing mutex spinning on owner
Date: Thu, 17 Mar 2016 08:08:30 -0400
Message-ID: <20160317080830.0855148d@grimm.local.home>
References: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com>
	<20160316233530.GA8731@kroah.com>
	<CAD=GYpZVGwfk8Y8WTQpdgdm5qgxjsi_gVrnOswuWitEbhaWPbw@mail.gmail.com>
	<20160316221751.71816309@grimm.local.home>
	<CAD=GYpbFRP5W2aNLpUoDtuK8Ebn+ki9JDGkBMS45nKVkc2wdSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <greg@kroah.com>,
	linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Joel Fernandes <agnel.joel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]:34089 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932879AbcCQMIe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 08:08:34 -0400
In-Reply-To: <CAD=GYpbFRP5W2aNLpUoDtuK8Ebn+ki9JDGkBMS45nKVkc2wdSQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 16 Mar 2016 22:35:21 -0700
Joel Fernandes <agnel.joel@gmail.com> wrote:


> Also, since we are on the topic of preemptoff tracer, I posted a patch
> [1] few days ago fixing another issue, if it looks Ok to you could you
> pick it up? I had CC'd you on it.
> 
> [1] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1099561.html

Yeah I saw that. I've been busy debugging work code. In other words,
doing my day job ;-)  I'm hoping to spend today working on mainline
again.

Thanks,

-- Steve
