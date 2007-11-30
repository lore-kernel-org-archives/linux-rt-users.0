From: Dominique Michel <dominique.michel@citycable.ch>
Subject: Re: Priorities of IRQ handlers
Date: Fri, 30 Nov 2007 12:26:32 +0100
Message-ID: <20071130122632.604adc6f@citycable.ch>
References: <474AE6C7.4090204@free.fr>
	<Pine.LNX.4.58.0711271125130.16899@gandalf.stny.rr.com>
	<474D4B76.8080001@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.alinto.citycable.ch ([85.218.0.111]:42400 "HELO
	citycable.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756446AbXK3LaF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Nov 2007 06:30:05 -0500
In-Reply-To: <474D4B76.8080001@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Le Wed, 28 Nov 2007 12:05:26 +0100,
John Sigler <linux.kernel@free.fr> a =C3=A9crit :


> > Perhaps look at one of the startup scripts, and add the chrt
> > command there.
>=20
> Which startup scripts?

You can look at the rtirq package: http://www.rncbc.org/jack/

Most of (all?) the multimedia linux distribution include it.

Cheers,
Dominique
