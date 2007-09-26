From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Date: Wed, 26 Sep 2007 15:44:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>
References: <1190345162.620000.305760830507.qpush@thor>
 <Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com> <46FAB56E.8080509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:37584 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbXIZTpQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 15:45:16 -0400
In-Reply-To: <46FAB56E.8080509@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Wed, 26 Sep 2007, Sergei Shtylyov wrote:

> Hello.
>
> Steven Rostedt wrote:
> > Tony,
>
> > I'm about to release a new -rt patch based on -rc8. This patch series
> > blew up totally in trying to get it applied. I'm leaving it out, so after
> > I release the next series, could you update these patches.
>
>     No wonder here: the -rt patch already has much of this code since around
> 2.6.21.  They have been submitted by me, mostly... and this patchset is
> against the Linus' tree.

That would explain it ;-)

I was searching the linux-rt-users mailing list for any patches, and
pulled in any that looked legit. These happen to in that mailing list too.

-- Steve
