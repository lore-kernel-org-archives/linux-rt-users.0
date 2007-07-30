From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt 2/9] Dont allow non-threaded softirqs and threaded
	hardirqs
Date: Mon, 30 Jul 2007 11:23:31 +0200
Message-ID: <20070730092331.GB25640@elte.hu>
References: <20070730024534.369897977@mvista.com> <20070730024718.890110769@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:33058 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932157AbXG3JXr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 05:23:47 -0400
Content-Disposition: inline
In-Reply-To: <20070730024718.890110769@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> I think this was sent before, and it did cause problems before. Would 
> there be *any* reason to have non-threaded softirqs but threaded 
> hardirqs. I can see lots of issues with that.

please elaborate in precise terms: what issues can you see?

	Ingo
