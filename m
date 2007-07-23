From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt] temporary WARN_ON removal
Date: Mon, 23 Jul 2007 21:55:48 +0200
Message-ID: <20070723195548.GA10445@elte.hu>
References: <1185124961.2573.14.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:41157 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761974AbXGWTzw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 15:55:52 -0400
Content-Disposition: inline
In-Reply-To: <1185124961.2573.14.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> These two WARN_ON calls send my system into a boot hang. They trigger 
> over and over , some examples below.

hm, could you try to figure out why they trigger on your box and not on 
anyone else's box? By disabling them we might be papering over a 
potential problem.

	Ingo
