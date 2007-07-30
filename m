From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt 5/9] net: fix mis-merge in qdisc_restart
Date: Mon, 30 Jul 2007 11:30:13 +0200
Message-ID: <20070730093013.GE25640@elte.hu>
References: <20070730024534.369897977@mvista.com> <20070730024720.116454959@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:36284 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935419AbXG3JaY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 05:30:24 -0400
Content-Disposition: inline
In-Reply-To: <20070730024720.116454959@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> This mismerge caused my networking to malfunction. The interface would 
> come up, but no traffic would make it in/out ..

your patch only affects the !CONFIG_PREEMPT_RT case, so with that 
qualification indeed that happened, and i've applied your fix.

	Ingo
