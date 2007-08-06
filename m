From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Possible error in 2.6.23-rc2-rt1 series
Date: Mon, 6 Aug 2007 07:42:40 +0200
Message-ID: <20070806054240.GA16815@elte.hu>
References: <4695E5BB0200005A0002763E@mcclure.wal.novell.com> <20070712130958.GB17494@elte.hu> <46B67992.1080503@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gregory Haskins <ghaskins@novell.com>, jim.houston@ccur.com,
	joe.korty@ccur.com, rostedt@goodmis.org, tglx@linutronix.de,
	dwalker@mvista.com, David Bahi <DBahi@novell.com>,
	Moiz Kohari <MKohari@novell.com>,
	Sven Dietrich <SDietrich@novell.com>, dsaxena@plexity.net,
	williams@redhat.com, abogani@texware.it,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Peter Williams <pwil3058@bigpond.net.au>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:44163 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbXHFFnj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Aug 2007 01:43:39 -0400
Content-Disposition: inline
In-Reply-To: <46B67992.1080503@bigpond.net.au>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> I've just been reviewing these patches and have spotted a possible 
> error in the file arch/ia64/kernel/time.c in that the scope of the
> #ifdef on CONFIG_TIME_INTERPOLATION seems to have grown quite a lot
> since 2.2.23-rc1-rt7.  It used to chop out one if statement and now it 
> chops out half the file.

i have not got much feedback about the ia64 -rt code. Does it even 
compile? The above thing could be a merge artifact - TIME_INTERPOLATION 
has been removed from upstream recently.

	Ingo
