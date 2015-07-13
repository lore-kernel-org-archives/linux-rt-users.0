From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference on 3.18.13-rt10
Date: Mon, 13 Jul 2015 10:58:49 +0200
Message-ID: <55A37DC9.6050604@linutronix.de>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com> <alpine.DEB.2.11.1507091605410.5134@nanos> <c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com> <20150710132318.GA27402@linutronix.de> <e1b9f04b95504df78cab1eb4e6946238@FE-MBX1012.de.bosch.com> <55A36EF0.7020404@linutronix.de> <15fcff88e0b4417aba7fd635a98b1ad0@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52634 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbGMI6v (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2015 04:58:51 -0400
In-Reply-To: <15fcff88e0b4417aba7fd635a98b1ad0@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/13/2015 10:56 AM, Koehrer Mathias (ETAS/ESW5) wrote:
>> Was this with or without the ctor patch I mentioned?
> I was still without the reverted patch.

In that case I ignore this report unless you manage (or not) to
reproduce it without the patch.

> 
> Mathias
> 
Sebastian
