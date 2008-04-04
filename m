From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: Linux 11-minute mode (RTC update)
Date: Fri, 04 Apr 2008 16:20:17 -0400
Message-ID: <y0mlk3tnzi6.fsf@ton.toronto.redhat.com>
References: <47F5E194.5040409@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60461 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760900AbYDDUVS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Apr 2008 16:21:18 -0400
In-Reply-To: <47F5E194.5040409@free.fr> (John Sigler's message of "Fri, 04 Apr 2008 10:06:44 +0200")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

John Sigler <linux.kernel@free.fr> writes:

>[...]
> I run Linux kernel 2.6.22.1-rt9 and ntpd 4.2.4p0

The bug you're describing appear to have been created & fixed
last year by commits 82644459 and 298a5df4.

- FChE
