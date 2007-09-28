From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Network hangs when rt-preempt patch is applied
Date: Fri, 28 Sep 2007 07:49:49 -0700
Message-ID: <1190990989.17385.0.camel@imap.mvista.com>
References: <200709281213.34994.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:46161 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638AbXI1Oz7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Sep 2007 10:55:59 -0400
In-Reply-To: <200709281213.34994.jbe@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-09-28 at 12:13 +0200, Juergen Beisert wrote:
> Hi,
> 
> I'm trying to find out if this is an MPC5200B related driver problem or
> RT-Preempt related one: Under some network (nmap, nc) load the network dies on
> my target.
> 
> Target (PowerPC) runs 2.6.23-rc8 plus patch-2.6.23-rc8-rt1.
> 
> Sometimes it survives the nmap, but mostly it dies immediately. Here it was
> successfull in the first nmap run, but dies on the second one:
> 

Which networking driver are you using?

Daniel
