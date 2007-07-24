From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RT-PATCH] v2.6.23-rc1-rt0 Add missing header in sch_generic.c
Date: Tue, 24 Jul 2007 21:11:45 +0200
Message-ID: <20070724191145.GB13268@elte.hu>
References: <200707242103.41880.hjk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: =?iso-8859-1?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:45576 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbXGXTLv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 15:11:51 -0400
Content-Disposition: inline
In-Reply-To: <200707242103.41880.hjk@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Hans-J=FCrgen Koch <hjk@linutronix.de> wrote:

> v2.6.23-rc1-rt0 adds an msleep(1) in net/sched/sch_generic.c without=20
> including the neceessary header. This patches fixes it.
>=20
> Signed-off-by: Hans J. Koch <hjk@linutronix.de>

thanks, applied.

	Ingo
