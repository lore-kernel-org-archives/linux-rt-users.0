From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -v2 0/7] New RT Task Balancing -v2
Date: Tue, 23 Oct 2007 10:39:55 +0200
Message-ID: <20071023083955.GA15887@elte.hu>
References: <20071023025900.927578809@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Paul Jackson <pj@sgi.com>,
	Gregory Haskins <ghaskins@novell.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:46562 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbXJWIkJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2007 04:40:09 -0400
Content-Disposition: inline
In-Reply-To: <20071023025900.927578809@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

>   Changes since V1:
>     Updated to git tree 55b70a0300b873c0ec7ea6e33752af56f41250ce
> 
>     Various clean ups suggested by Gregory Haskins, Dmitry Adamushko,
>     and Peter Zijlstra.

ok, i like this new approach - nice work! I'd suggest we test it in -rt 
for some time and then merge it into v2.6.25?

	Ingo
