From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Date: Wed, 26 Sep 2007 21:58:33 +0200
Message-ID: <1190836713.23376.41.camel@chaos>
References: <1190345162.620000.305760830507.qpush@thor>
	 <Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
	 <46FAB56E.8080509@ru.mvista.com>
	 <Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:38543 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752037AbXIZT6g (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 15:58:36 -0400
In-Reply-To: <Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-09-26 at 15:44 -0400, Steven Rostedt wrote:
> >     No wonder here: the -rt patch already has much of this code since around
> > 2.6.21.  They have been submitted by me, mostly... and this patchset is
> > against the Linus' tree.
> 
> That would explain it ;-)
> 
> I was searching the linux-rt-users mailing list for any patches, and
> pulled in any that looked legit. These happen to in that mailing list too.

I'll sort that out along with the other hrt updates.

	tglx
