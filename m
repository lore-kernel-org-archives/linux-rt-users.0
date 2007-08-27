From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: How to talk to DAQ Hardware?
Date: Mon, 27 Aug 2007 11:53:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0708271149500.8578@pcgl.dsa-ac.de>
References: <664539.31533.qm@web36101.mail.mud.yahoo.com>
 <Pine.LNX.4.63.0708270954340.8578@pcgl.dsa-ac.de>
 <1188205922.29859.53.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Calin Culianu <cculianu@yahoo.com>,
	Daniel Walker <dwalker@mvista.com>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:49193 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbXH0JxQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Aug 2007 05:53:16 -0400
In-Reply-To: <1188205922.29859.53.camel@sx.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 27 Aug 2007, Sven-Thorsten Dietrich wrote:

> Therefore, it is inappropriate to qualify an operating system as hard or
> soft RT without deadline context.

It is. An OS is not hard real-time (capable) if it cannot guarantee you 
with 100% certainty to meet ANY hard dead-line.

There is a philosophical side of this question, whether _any_ OS can 
guaratee that, but we don't want to discuss it here.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
