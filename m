From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Poor UDP performance using 2.6.21-rc5-rt5
Date: Mon, 2 Apr 2007 09:21:11 +0200
Message-ID: <20070402072111.GA21356@elte.hu>
References: <461004CE.1030009@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Dave Sperry <dave_sperry@ieee.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:44336 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370AbXDBHVT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Apr 2007 03:21:19 -0400
Content-Disposition: inline
In-Reply-To: <461004CE.1030009@ieee.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Dave Sperry <dave_sperry@ieee.org> wrote:

> I have a dual core Opteron machine that exhibits poor UDP performance 
> (RT consumes more than 2X cpu) with the 2.6.21-rc5-rt5 as compared to 
> 2.6.21-rc5. Top shows the IRQ handler consuming a lot of CPU.

update: even with acpi_pm clocksource on vanilla i can reproduce similar 
overhead using netperf.

	Ingo
