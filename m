From: Remy Bohmer <linux@bohmer.net>
Subject: Re: System deadlock on 2.6.24-rt20
Date: Fri, 3 Apr 2009 12:38:23 +0200
Message-ID: <3efb10970904030338h6ff7256ehf6ecd8032f9933d7@mail.gmail.com>
References: <3efb10970904030248t39a13176led25b9dc7ff9383c@mail.gmail.com>
	 <alpine.LFD.2.00.0904031226500.12916@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:44029 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763410AbZDCKi0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Apr 2009 06:38:26 -0400
In-Reply-To: <alpine.LFD.2.00.0904031226500.12916@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Thomas,

>> Does anybody recognise these backtraces? And if so, is there a fix for
>> it already?
>
> http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.24.7-rt27.bz2

Thanks, for the quick response.
I was already starting integrating -rt27, but I could not predict if
that would solve this problem.
I am happy you confirmed that.

Thanks!

Kind Regards,

Remy
