From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH -rt] CONFIG_PARAVIRT and CONFIG_MCOUNT don't play well
	together
Date: Fri, 22 Jun 2007 08:30:22 -0700
Message-ID: <20070622153021.GR3723@sequoia.sous-sol.org>
References: <20070622080634.GP3723@sequoia.sous-sol.org> <1182516222.5493.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:33379 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757282AbXFVPaa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2007 11:30:30 -0400
Content-Disposition: inline
In-Reply-To: <1182516222.5493.33.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
> Chris, thanks a hell of a lot for looking into this!!!
> 
> -rt doesn't do much with paravirt, but since both -rt and lguest are two
> things I love to play with, it was really bothering me that they were
> not getting along.

It was bugging me too, now if only I had noticed the compiler warnings ;-)
