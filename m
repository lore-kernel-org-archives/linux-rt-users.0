From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Using patch-3.2-rt10, kernel won't compile with
 CONFIG_PREEMPT_RT_FULL=y
Date: Thu, 11 Oct 2012 22:20:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210112217520.2779@ionos>
References: <CAOARjkOT0ZndTxyvAq-Yj8QN6EJ5JnodGcfHq4XooHNPKRadXQ@mail.gmail.com> <CAP=VYLpUWqF5nztH-ZyC4v+GNYi997vVcZdJ_zpptmOJh4jYpA@mail.gmail.com> <CAOARjkM49dJaDT3x9uLZpqGSFD174MeN6ayp_7CWAxsRUJxTOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1874724239-1349986822=:2779"
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-15?Q?Andr=E9_Bachmann?= <andrebachmann.dd@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51605 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431Ab2JKUUZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2012 16:20:25 -0400
In-Reply-To: <CAOARjkM49dJaDT3x9uLZpqGSFD174MeN6ayp_7CWAxsRUJxTOw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1874724239-1349986822=:2779
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 11 Oct 2012, André Bachmann wrote:
> 2012/10/11 Paul Gortmaker <paul.gortmaker@windriver.com>:
> 
> Well I must be completely blind to miss this. Thank you! Now the
> kernel compiles successfully.
> But now the question arises: Why I don't get this error when not using
> "CONFIG_PREEMPT_RT_FULL=y"?

You have to look at the preprocessor output. It's probably covered up
by some magic macro expansion.

Thanks,

	tglx
--8323328-1874724239-1349986822=:2779--
