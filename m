From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [PATCH -rt] mm: protect activate_mm() by
 preempt_[disable|enable]_rt()
Date: Wed, 16 May 2012 09:38:02 +0800
Message-ID: <20120516013802.GA8829@zhy>
References: <1337061236-1766-1-git-send-email-yong.zhang0@gmail.com>
 <20120515213619.GA8880@joshcartwright.net>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Josh Cartwright <joshc@linux.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36572 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611Ab2EPBiN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 21:38:13 -0400
Content-Disposition: inline
In-Reply-To: <20120515213619.GA8880@joshcartwright.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 15, 2012 at 05:36:19PM -0400, Josh Cartwright wrote:
> Frank Rowand posted a very similar fix in December of last year that
> we've been carrying to fix the same issue:
> 
>    http://permalink.gmane.org/gmane.linux.kernel/1229806
> 
> It looks like there was some deliberation as to whether or not it should
> be pulled into stable-rt.  Perhaps its time to revisit this discussion?

Yeah, thanks for pointing it out, I didn't know there is discussion about
it.

Thanks again,
Yong
