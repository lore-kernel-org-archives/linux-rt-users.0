From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: generating 100% load for cyclictest ?
Date: Thu, 11 Jan 2007 16:15:12 +0100
Message-ID: <45A65480.6050708@imc-berlin.de>
References: <45A65009.8070902@imc-berlin.de> <20070111151027.GS29495@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2686 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbXAKPPO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jan 2007 10:15:14 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20070111151027.GS29495@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Robert,

>> How is this load created? Any recommendations?
> 
> At least these should generate significant load:
> 
> - hackbench
> - while true; do find /; done
> - calibrator (for cache load)

Thanks.

And of course all running at the same time?

--
Steven
