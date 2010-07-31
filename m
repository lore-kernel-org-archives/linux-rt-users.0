From: Reza Roboubi <reza@earthdetails.com>
Subject: disable address translation (virtual/physical)
Date: Sat, 31 Jul 2010 07:19:04 -0700
Message-ID: <AANLkTimfPqKxXvU=xhxaRXdnWU7q7YR2kXQuL+Uk9GB9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38647 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab0GaOTI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 31 Jul 2010 10:19:08 -0400
Received: by wwj40 with SMTP id 40so2457376wwj.1
        for <linux-rt-users@vger.kernel.org>; Sat, 31 Jul 2010 07:19:05 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Can we turn off address translation overheads (let's say with
something like SCHED_FIFO?)  That's really all I want, as opposed to
RT interrupt handling.

It seems like linux-rt doesn't do this.  What would be the best (or
easiest) way to do it?
<OFF-TOPIC>  possibly without abandoning my Ubuntu box! </OFF-TOPIC>

Thanks a great deal.

Reza.
