From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] New stable 3.0-rt-rebase branch at
 git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
Date: Tue, 24 Jan 2012 16:46:48 -0500
Message-ID: <1327441608.22710.35.camel@gandalf.stny.rr.com>
References: <1327423516.22710.31.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Clark Williams <clark@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:44237 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab2AXVqu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jan 2012 16:46:50 -0500
In-Reply-To: <1327423516.22710.31.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-01-24 at 11:45 -0500, Steven Rostedt wrote:

> $ git tag | grep -- -rt
> v3.0.10-rt27
> v3.0.10-rt27-rebase
> v3.0.11-rt28
> v3.0.11-rt28-rebase
> v3.0.12-rt29
> v3.0.12-rt29-rebase
> v3.0.12-rt30
> v3.0.12-rt30-rebase
> v3.0.14-rt31
> v3.0.14-rt31-rebase
> v3.0.14-rt32
> v3.0.14-rt32-rebase
> v3.0.17-rt33
> v3.0.17-rt33-rebase
> v3.0.9-rt25
> v3.0.9-rt26
> 

As I found out by testing what was pushed and not seeing what I expected
and going crazy in the mean time, I've discovered (thanks to the guys on
Freenode #git) that tags of commits that are not associated to any
branch (like these are) will not be pulled with a normal "git fetch" or
"git remote update".


You need to do a "git fetch --tags" to get the tags for the rebases that
are no long part of the v3.0-rt-rebase branch.

-- Steve


