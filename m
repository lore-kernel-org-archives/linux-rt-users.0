From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: linux-3.6.11-rt30 smoke test on ARM
Date: Mon, 11 Mar 2013 18:34:24 +0100
Message-ID: <20130311173424.GB22286@linutronix.de>
References: <51396143.5060108@am.sony.com>
 <51396306.6090902@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36589 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab3CKReZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Mar 2013 13:34:25 -0400
Content-Disposition: inline
In-Reply-To: <51396306.6090902@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Frank Rowand | 2013-03-07 20:03:18 [-0800]:

>panda boot often fails due to a usb timeout, while sending a command on
>behalf of the smsc95xx ethernet driver.
>
>This patch is a temporary hack to force a retry when the timeout occurs.

It looks like you overrun the chip for some reason. Can you reproduce it
on mainline? They added a few delayes on register read() it might do the
trick.

Sebastian
