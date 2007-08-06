From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt 9/9] seqlocks: use PICK_FUNCTION
Date: Mon, 6 Aug 2007 09:21:53 +0200
Message-ID: <20070806072153.GH5359@elte.hu>
References: <20070730024534.369897977@mvista.com> <20070730024721.274774887@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:56122 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757531AbXHFHV7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Aug 2007 03:21:59 -0400
Content-Disposition: inline
In-Reply-To: <20070730024721.274774887@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Replace the old PICK_OP style macros with PICK_FUNCTION. Although, 
> seqlocks has some alien code, which I also replaced as can be seen 
> from the line count below.

ok, i very much like the cleanup effects here, could you resend your 
latest version of this (with Peter's suggested cleanup) against -rc2-rt2 
so that i can apply it?

	Ingo
