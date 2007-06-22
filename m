From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt] CONFIG_PARAVIRT and CONFIG_MCOUNT don't play well
	together
Date: Fri, 22 Jun 2007 17:32:32 +0200
Message-ID: <20070622153232.GA31848@elte.hu>
References: <20070622080634.GP3723@sequoia.sous-sol.org> <20070622083330.GB19382@elte.hu> <20070622152915.GQ3723@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:38034 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757142AbXFVPcq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2007 11:32:46 -0400
Content-Disposition: inline
In-Reply-To: <20070622152915.GQ3723@sequoia.sous-sol.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Chris Wright <chrisw@sous-sol.org> wrote:

> > thanks! I ran into this before and asked for the fastcalls to not be 
> > removed from upstream paravirt.c but to no avail it seems. It does 
> > no harm to anyone to keep the 'fastcall' declarations and 
> > definitions for places where _actual assembly code_ depends on the 
> > calling convention. Could someone please send this upstream-wards 
> > too?
> 
> Yes, I agree, it's actually documenting the subtlety of the calling 
> convention, not just noise in the source.  The upstream patch is 
> different, I'll sort one out.

great!

	Ingo
