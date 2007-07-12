From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to 2.6.22
	available
Date: Thu, 12 Jul 2007 07:10:21 -0400
Message-ID: <4695D3DD0200005A00027621@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <jim.houston@ccur.com>, <joe.korty@ccur.com>, <dwalker@mvista.com>,
	"David Bahi" <DBahi@novell.com>,
	"Moiz Kohari" <MKohari@novell.com>,
	"Sven Dietrich" <SDietrich@novell.com>, <dsaxena@plexity.net>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: <mingo@elte.hu>, <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:32118 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932369AbXGLLKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 07:10:32 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-07-12 at 00:58 +0000, Gregory Haskins wrote:
> Hi Ingo, Thomas, and the greater linux-rt community,
>   
> 	I just wanted to let you guys know that our team has a port of the
> 21.5-rt20 patch for the 2.6.22 kernel available.  

Ok, we have incorporated some of the feedback from you guys and made a
new drop: rt2

Changes:

*) split into series

*) split the rt patch into two sections.  The first is .21.5-rt19 after
it applies to 2.6.22 minus the rejects.  The second patch is the
resolution of those rejects + our fixes (sorry, dont have this broken
down finer grained yet) (Thanks to Daniel for this suggestion)

*) We rolled Alessio's fix for duplication of div64 into the rt patch

*) We added Alessio's fix for percpu to the series

Notably missing:

*) We are still at rt19.  We will push rt20 in shortly, and rt21 as
available.

You can find the patch here:
ftp://ftp.novell.com/dev/patches-2.6.22-rt2.tar.gz

Thanks for the feedback, guys!

Regards,
-Greg
