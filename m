From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: scheduler idea ... any thoughts
Date: Thu, 8 Nov 2012 21:39:20 +0100
Message-ID: <CAF-VNaotHj4SinWsd0EsvqMiuEpHqDXimVL0w7hup_6AB8Ow5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61899 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631Ab2KHUjW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2012 15:39:22 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so1802581eek.19
        for <linux-rt-users@vger.kernel.org>; Thu, 08 Nov 2012 12:39:20 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have been looking at the linux scheduler ( mostly to understand it
... ) and fiddling with sched_mc and assymetric packing.

I had the thought of using packing in a scheduler domain to bias rt to
one end and regular tasks to the other. Possibly using using
overcommit on userland .....

If packing on scheduler domains is working properly it wouldn't be too hard.

An other option would be to bias userland to the higher numbered
scheduling groups, and keep interrupts and timers on the lower one.

 Do you think it would be worh a shot ?

 / regards, Lars Segerlund.
