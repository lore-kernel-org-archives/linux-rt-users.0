From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] mm: protect activate_mm() by
 preempt_[disable|enable]_rt()
Date: Tue, 15 May 2012 21:56:50 -0400
Message-ID: <1337133410.6724.25.camel@gandalf.stny.rr.com>
References: <1337061236-1766-1-git-send-email-yong.zhang0@gmail.com>
	 <20120515213619.GA8880@joshcartwright.net> <20120516013802.GA8829@zhy>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Josh Cartwright <joshc@linux.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:5661 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757223Ab2EPB4w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 21:56:52 -0400
In-Reply-To: <20120516013802.GA8829@zhy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-05-16 at 09:38 +0800, Yong Zhang wrote:
> On Tue, May 15, 2012 at 05:36:19PM -0400, Josh Cartwright wrote:
> > Frank Rowand posted a very similar fix in December of last year that
> > we've been carrying to fix the same issue:
> > 
> >    http://permalink.gmane.org/gmane.linux.kernel/1229806
> > 
> > It looks like there was some deliberation as to whether or not it should
> > be pulled into stable-rt.  Perhaps its time to revisit this discussion?
> 
> Yeah, thanks for pointing it out, I didn't know there is discussion about
> it.
> 

I believe we can go with Yong's patch. I don't think the #ifdef is
necessary. Just do the preempt_disable_rt().

-- Steve


