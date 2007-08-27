From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: How to talk to DAQ Hardware?
Date: Mon, 27 Aug 2007 12:02:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0708271155420.8578@pcgl.dsa-ac.de>
References: <664539.31533.qm@web36101.mail.mud.yahoo.com>
 <Pine.LNX.4.63.0708270954340.8578@pcgl.dsa-ac.de> <46D28A9F.1050008@osadl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Calin Culianu <cculianu@yahoo.com>,
	Daniel Walker <dwalker@mvista.com>,
	linux-rt-users@vger.kernel.org
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:49310 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbXH0KC2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Aug 2007 06:02:28 -0400
In-Reply-To: <46D28A9F.1050008@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 27 Aug 2007, Carsten Emde wrote:

> I don't know what exactly "soft real-time" is, and I don't think there is an
> exact definition of it. The term "hard real-time", however, is well defined.
> It is the same as "real-time". It means that a system never ever exceeds a
> previously defined maximum latency.

As long as your non-realtime tasks are allowed to take locks, that also 
prevent real-time tasks from preempting them, and as long as you haven't 
proved that all those locks in all your non-realtime sources can never 
under any circumstances last longer than your pre-defined limit, it is not 
a hard-realtime OS.

This doesn't mean I don't like rt-opreempt:-) One just has to understand 
clearly its features and limitations.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
