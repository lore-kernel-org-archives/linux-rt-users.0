From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Poor UDP performance using 2.6.21-rc5-rt5
Date: Mon, 2 Apr 2007 16:23:58 +0200
Message-ID: <20070402142358.GA32103@elte.hu>
References: <040220071409.15202.46110E98000A743600003B622205886172979D9D0A9F9C0E0B@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Sperry <dave_sperry@ieee.org>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: "dave_sperry@ieee.org" <dasperry@comcast.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:37375 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965489AbXDBOYG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Apr 2007 10:24:06 -0400
Content-Disposition: inline
In-Reply-To: <040220071409.15202.46110E98000A743600003B622205886172979D9D0A9F9C0E0B@comcast.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* dave_sperry@ieee.org <dasperry@comcast.net> wrote:

> Thanks for all the input Ingo, Here's a list of all the permutations 
> I've tried:

one thing i noticed is that cyclesoak interferes with the netperf 
workload. This is quite surprising. 'top' and 'vmstat' output is 
reliable on -rt, and the overhead goes down if i stop cyclesoak.

	Ingo
