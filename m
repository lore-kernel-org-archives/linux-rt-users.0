From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ RT PATCH] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 13:02:58 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808291300580.17917@gandalf.stny.rr.com>
References: <20080829154237.1196.66825.stgit@dev.haskins.net> <20080829095729.0966d38e@extreme>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, gregory.haskins@gmail.com
To: Stephen Hemminger <shemminger@vyatta.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:60417 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566AbYH2RDA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Aug 2008 13:03:00 -0400
In-Reply-To: <20080829095729.0966d38e@extreme>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


/me adds "RT" to subject.

On Fri, 29 Aug 2008, Stephen Hemminger wrote:
> 
> I have mixed feelings about this. The point of this primitive was for
> cases where write contention was rare and writers only did small updates.
> So what you did was fix the primitive for cases where it is being misused.
> Do you have a real example where this is a problem? If so then the
> user of seqlock should be fixed, rather than fixing seqlock.
> 


I think there's some confusion here, because of the changes to raw. The 
raw_seqlock_t and mainline seqlock_t has no issue, and should not be 
touched.

What Gregory is solving is an issue in -rt where we let write seqlocks be 
preempted.  Thus this causes issues with determinism. This is a special 
case for -rt, and -rt only. It should not affect mainline in anyway.

Sorry for the noise.

-- Steve

