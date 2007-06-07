From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Someone can explain me this error?
Date: Thu, 07 Jun 2007 10:01:36 +0200
Message-ID: <1181203296.4404.277.camel@chaos>
References: <1181201730.13830.8.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:55906 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751468AbXFGIBk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2007 04:01:40 -0400
In-Reply-To: <1181201730.13830.8.camel@godzilla.tecnorama.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-06-07 at 09:35 +0200, Alessio Igor Bogani wrote:
> Hi,
>=20
> I'm trying to compile 2.6.22 kernel with patch-2.6.21.3-rt9.

I have no idea, why you insist to run the 2.6.21 patch on 2.6.22-rc.=20

> I have this error but i don't understand what type of error it is.
> Someone can explain me this error? Or suggest me how can resolve it?
> What mean "error: expected declaration specifiers or =E2=80=98...=E2=80=
=99 before
> =E2=80=98mmu_gathers=E2=80=99" ?

There is no way to tell, what you did to make the patches apply on
2.6.22, what it breaks any why. And I really do not care.=20

We are going to move to 2.6.22 once we have sorted out some urgent
problems in 2.6.21-rt.

	tglx
