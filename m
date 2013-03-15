From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: System freeze while sending data via tcp with 3.6.11-rt30
 kernel
Date: Fri, 15 Mar 2013 22:44:53 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303152236550.22263@ionos>
References: <CAKQvxgXUDJ=o-dvoGg+cVJpNHw_yCBL+0BTv_QZqPv7QZ7WNUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1950233863-1363383772=:22263"
Cc: linux-rt-users@vger.kernel.org
To: Heiko Schumann <heiko.sirona@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59901 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab3COVoz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Mar 2013 17:44:55 -0400
In-Reply-To: <CAKQvxgXUDJ=o-dvoGg+cVJpNHw_yCBL+0BTv_QZqPv7QZ7WNUg@mail.gmail.com>
Content-ID: <alpine.LFD.2.02.1303152243320.22263@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1950233863-1363383772=:22263
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LFD.2.02.1303152243321.22263@ionos>

On Fri, 15 Mar 2013, Heiko Schumann wrote:
> i´ve a 3.6.11-rt30 kernel on a QorIQ P2020 Processor.
> Everything works fine, but when i start my application, which sends
> data via tcp socket with a rate of ~840 Mbits to an another computer,
> the QorIQ P2020 freezes within three minutes.
> The application is started with SCHED_OTHER scheduling algorithm the
> standard priority. The system freeze occurs until i start the
> application with the SCHED_FIFO algorithm and a priority higher then
> 50. With this option everything runs stable, but this option
> isn´t suitable for the later system.

Is this a stock 3.6.11-rt30 or do you have any magic vendor patches
applied?

Thanks,

	tglx
--8323328-1950233863-1363383772=:22263--
