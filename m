From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/10] ARM patch series for -rt15
Date: Sat, 16 Dec 2006 12:38:29 +0100
Message-ID: <1166269110.29505.251.camel@localhost.localdomain>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:47957 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753629AbWLPLee (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Dec 2006 06:34:34 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20061215223658.009035000@metis.extern.pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2006-12-15 at 23:36 +0100, Robert Schwebel wrote:
> Thomas,
> 
> this is our current series to make -rt work on ARM, currently based on
> 2.6.19-rt15. The clockevent patches are already merged in 2.6.20-rc1 via

How are the clock event patches merged ? Clock events are not in
2.6.20-rc1

> I'm looking forward to your comments.

General notes:

Please take care of 80 char width and stray whitespace in struct
initializers.

	tglx
