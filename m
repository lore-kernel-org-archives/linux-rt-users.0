From: Peter Williams <pwil3058@bigpond.net.au>
Subject: Possible error in 2.6.23-rc2-rt1 series
Date: Mon, 06 Aug 2007 11:29:54 +1000
Message-ID: <46B67992.1080503@bigpond.net.au>
References: <4695E5BB0200005A0002763E@mcclure.wal.novell.com> <20070712130958.GB17494@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, jim.houston@ccur.com,
	joe.korty@ccur.com, rostedt@goodmis.org, tglx@linutronix.de,
	dwalker@mvista.com, David Bahi <DBahi@novell.com>,
	Moiz Kohari <MKohari@novell.com>,
	Sven Dietrich <SDietrich@novell.com>, dsaxena@plexity.net,
	williams@redhat.com, abogani@texware.it,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qsrv01ps.mx.bigpond.com ([144.140.82.181]:18752 "EHLO
	qsrv01ps.mx.bigpond.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbXHFDzI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Aug 2007 23:55:08 -0400
In-Reply-To: <20070712130958.GB17494@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I've just been reviewing these patches and have spotted a possible
error in the file arch/ia64/kernel/time.c in that the scope of the
#ifdef on CONFIG_TIME_INTERPOLATION seems to have grown quite a lot
since 2.2.23-rc1-rt7.  It used to chop out one if statement and now it
chops out half the file.

Is it correct?
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
