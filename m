From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt] CONFIG_PARAVIRT and CONFIG_MCOUNT don't play well
	together
Date: Fri, 22 Jun 2007 17:39:28 +0200
Message-ID: <20070622153928.GA2030@elte.hu>
References: <20070622080634.GP3723@sequoia.sous-sol.org> <1182516222.5493.33.camel@localhost.localdomain> <20070622153021.GR3723@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:51408 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756735AbXFVPjm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2007 11:39:42 -0400
Content-Disposition: inline
In-Reply-To: <20070622153021.GR3723@sequoia.sous-sol.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Chris Wright <chrisw@sous-sol.org> wrote:

> * Steven Rostedt (rostedt@goodmis.org) wrote:
> > Chris, thanks a hell of a lot for looking into this!!!
> > 
> > -rt doesn't do much with paravirt, but since both -rt and lguest are two
> > things I love to play with, it was really bothering me that they were
> > not getting along.
> 
> It was bugging me too, now if only I had noticed the compiler warnings 
> ;-)

if only those compiler warnings werent drowning in 1000 other compiler 
warnings? :-/

	Ingo
