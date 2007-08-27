From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: How to talk to DAQ Hardware?
Date: Mon, 27 Aug 2007 13:09:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0708271308020.8578@pcgl.dsa-ac.de>
References: <664539.31533.qm@web36101.mail.mud.yahoo.com>
 <Pine.LNX.4.63.0708270954340.8578@pcgl.dsa-ac.de>  <46D28A9F.1050008@osadl.org>
  <Pine.LNX.4.63.0708271155420.8578@pcgl.dsa-ac.de>
 <1188212251.21706.45.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carsten Emde <Carsten.Emde@osadl.org>,
	Calin Culianu <cculianu@yahoo.com>,
	Daniel Walker <dwalker@mvista.com>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:50016 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbXH0LKC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Aug 2007 07:10:02 -0400
In-Reply-To: <1188212251.21706.45.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 27 Aug 2007, Sven-Thorsten Dietrich wrote:

> On Mon, 2007-08-27 at 12:02 +0200, Guennadi Liakhovetski wrote:
> > 
> > As long as your non-realtime tasks are allowed to take locks, that also 
>                                ^^^^^
> > prevent real-time tasks from preempting them, and as long as you haven't 
> > proved that all those locks in all your non-realtime sources can never 
> > under any circumstances last longer than your pre-defined limit, it is not 
> > a hard-realtime OS.
> 
> So you're talking about a property of the application !!!

Wrong emphasis. Here's what is meant:

> > As long as your non-realtime tasks are allowed to take locks, that also 
                                       ^^^^^^^^^^^
> > prevent real-time tasks from preempting them, and as long as you haven't 

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
