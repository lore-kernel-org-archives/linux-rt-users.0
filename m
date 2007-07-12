From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.22.1-rt1
Date: Thu, 12 Jul 2007 18:01:39 +0200
Message-ID: <20070712160139.GB8252@elte.hu>
References: <20070712121355.GA10949@elte.hu> <200707121645.46206.mgd@technosis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Michael Gerdau <mgd@technosis.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:58027 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757283AbXGLQBr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 12:01:47 -0400
Content-Disposition: inline
In-Reply-To: <200707121645.46206.mgd@technosis.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Michael Gerdau <mgd@technosis.de> wrote:

> [sorry Ingo for the dublicated post]

[ sorry for the duplicated reply :) ]

> > to build a 2.6.22.1-rt1 tree, the following patches should be appli=
ed:
> > =A0
> > =A0 =A0http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.22.1.tar.b=
z2
> > =A0 =A0http://redhat.com/~mingo/realtime-preempt/patch-2.6.22.1-rt1
>=20
> I get a compile error on my x86_64 dualcore sytem.

could you check it builds fine with -rt2?

	Ingo
