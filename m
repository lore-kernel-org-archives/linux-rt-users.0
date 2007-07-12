From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to 2.6.22
	available
Date: Thu, 12 Jul 2007 06:17:43 -0400
Message-ID: <4695C7870200005A0002760F@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <jim.houston@ccur.com>, <joe.korty@ccur.com>, <mingo@elte.hu>,
	<dwalker@mvista.com>, "David Bahi" <DBahi@novell.com>,
	"Moiz Kohari" <MKohari@novell.com>,
	"Sven Dietrich" <SDietrich@novell.com>, <dsaxena@plexity.net>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:29889 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751673AbXGLKRy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 06:17:54 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-07-12 at 07:14 +0200, Thomas Gleixner wrote:
> On Wed, 2007-07-11 at 20:58 -0400, Gregory Haskins wrote:
> > 	Note also that we find that the resulting kernel does not boot on some
> > T60p thinkpads without "acpi=off".  We are still investigating the root
> > cause here.
> 
> Try "nohpet" for now. I'm investigating it on the -hrt side as well.
> 

Ah, good to know others are looking at it.

On a different front, I see .21.6-rt21 came out in the last 24 hours.
Were there any fixes that went in between rt20-21 here, or was it simply
a forward port?  If fixes, could you possibly share them to save me the
effort of working it out myself?  I will then push the next version of
the 22-based forward port to rt21 today.

Regards,
-Greg
