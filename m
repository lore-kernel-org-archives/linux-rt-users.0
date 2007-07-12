From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to 2.6.22
	available
Date: Thu, 12 Jul 2007 07:14:03 +0200
Message-ID: <1184217243.12353.205.camel@chaos>
References: <469544710200005A000275CC@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, jim.houston@ccur.com, joe.korty@ccur.com,
	dwalker@mvista.com, David Bahi <DBahi@novell.com>,
	Moiz Kohari <MKohari@novell.com>,
	Sven Dietrich <SDietrich@novell.com>, dsaxena@plexity.net,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:59609 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751310AbXGLFOH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 01:14:07 -0400
In-Reply-To: <469544710200005A000275CC@mcclure.wal.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-07-11 at 20:58 -0400, Gregory Haskins wrote:
> 	Note also that we find that the resulting kernel does not boot on some
> T60p thinkpads without "acpi=off".  We are still investigating the root
> cause here.

Try "nohpet" for now. I'm investigating it on the -hrt side as well.

	tglx
