From: Ingo Molnar <mingo@elte.hu>
Subject: Re: PROFILE_NMI kernel config symbol
Date: Mon, 6 Aug 2007 13:11:50 +0200
Message-ID: <20070806111150.GB29370@elte.hu>
References: <46B1D26E.2010508@free.fr> <46B6E166.6090507@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51566 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbXHFLL4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Aug 2007 07:11:56 -0400
Content-Disposition: inline
In-Reply-To: <46B6E166.6090507@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* John Sigler <linux.kernel@free.fr> wrote:

> John Sigler wrote:
> 
> >The -rt patch includes the following update:
> >
> >Index: linux/arch/i386/oprofile/Kconfig
> >===================================================================
> >--- linux.orig/arch/i386/oprofile/Kconfig
> >+++ linux/arch/i386/oprofile/Kconfig
> >@@ -15,3 +15,6 @@ config OPROFILE
> >
> >       If unsure, say N.
> >
> >+config PROFILE_NMI
> >+    bool
> >+    default y
> >
> >
> >What is the purpose of the PROFILE_NMI config symbol?
> >(It does not seem to be used anywhere else in the -rt patch.)
> 
> Should I provide a patch removing this configuration option?

indeed it's a leftover - i've zapped it.

	Ingo
