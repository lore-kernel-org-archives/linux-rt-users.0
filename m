From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] create /proc/all-interrupts
Date: Thu, 26 Jul 2007 11:56:56 -0700
Message-ID: <46A8EE78.4040702@zytor.com>
References: <20070726180522.GA1486@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, tglx@linutronix.de, sdietrich@novell.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	jason.baietto@ccur.com
To: Joe Korty <joe.korty@ccur.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45371 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934213AbXGZS6Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 14:58:24 -0400
In-Reply-To: <20070726180522.GA1486@tsunami.ccur.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Joe Korty wrote:
> Create /proc/all-interrupts for some architectures.
> 
> Create a version of /proc/interrupts that displays _every_
> IRQ vector, not just those that someone thought might be
> interesting, and add an entry in the commentary column
> for those vectors which lacked such a comment.
> 
> Rationale: /proc/interrupts is not truly useful unless it
> displays every IRQ vector, not just those somebody thought
> would be interesting.  For example, since /proc/interrupts
> does not display the rescheduling interrupt, the occurance
> of rescheduling interrupt floods ends up affecting
> latencies, yet without an entry in /proc/interrupts, it
> is difficult to discern why latencies are being affected.
> 
> Rather than modify /proc/interrupts, this patch creates
> a new version of /proc/interrupts, on the off-chance
> that adding new lines to /proc/interrupts, and appending
> new fields to the end of old lines, might break some
> longstanding script.  However, these kinds of changes
> traditionally do not affect scripts, so it might be
> reasonable to fold /proc/all-interrupts back into
> /proc/interrupts.

I think that would be the right thing to do.  We have added things to
/proc/interrupts in the past.

	-hpa
