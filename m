From: Joel Fernandes <agnel.joel@gmail.com>
Subject: Question on clock drift with NO_HZ_FULL vs NO_HZ_IDLE
Date: Sun, 23 Feb 2014 01:20:53 -0600
Message-ID: <CAD=GYpaGnS=1A7z6AhtJ9KGH68NY4C5rGRXgfePm33he6s6YOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:64010 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaBWHUy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Feb 2014 02:20:54 -0500
Received: by mail-oa0-f43.google.com with SMTP id i7so2841639oag.2
        for <linux-rt-users@vger.kernel.org>; Sat, 22 Feb 2014 23:20:53 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
After reading documentation, I follow that NO_HZ_FULL turns off the
scheduling-clock interrupt on all except the boot CPU, where as
NO_HZ_IDLE turns it off on all idle CPUs.

I understand the period scheduling-clock interrupt is required to
compensate for hardware oscillator drift. I believe that's why
NO_HZ_FULL keeps it ON on atleast one CPU. That way the drift is
compensated for.

But, with NO_HZ_IDLE, all CPUs turn off interrupt during idle. Then
how is the drift accounted for?

CC'ing Paul as well for any guidance, thanks :)

Regards,
-Joel
