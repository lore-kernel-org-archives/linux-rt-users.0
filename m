From: Julian Fuchs <julian@fuchs.cc>
Subject: Problem with interrupt handler
Date: Mon, 25 Jan 2010 18:16:08 +0100
Message-ID: <e97c14da1001250916u9b20444k2bdb550211aca1ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f173.google.com ([209.85.223.173]:51222 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220Ab0AYRQN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2010 12:16:13 -0500
Received: by iwn3 with SMTP id 3so1056011iwn.19
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2010 09:16:13 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

being aware of the risk to bother some people here I would
nevertheless really appreciate your help with the following issue:

Is there any difference in the request_irq() function call in
comparison to the one in the normal kernel?

I'm trying to run

request_irq(irq, interrupt_handler, IRQF_SHARED | IRQF_DISABLED |
IRQF_NODELAY, MODULE_IDENT, &stage)

on 2.6.31.6-rt19 but it doesn't call interrupt_handler() when an
interrupt is received.

In the plain kernel 2.6.31 it works with this call:

request_irq(irq, interrupt_handler, IRQF_SHARED | IRQF_DISABLED,
MODULE_IDENT, &stage)

Do you have hints to literature / tutorials / code I should look at?

I would really appreciate any kind of help,

thanks,

Julian
