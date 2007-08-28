Return-Path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:57013 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751274AbXH1HEc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 Aug 2007 03:04:32 -0400
Date: Tue, 28 Aug 2007 09:04:01 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
Message-ID: <20070828070401.GT23573@pengutronix.de>
References: <664539.31533.qm@web36101.mail.mud.yahoo.com> <Pine.LNX.4.63.0708270954340.8578@pcgl.dsa-ac.de> <46D28A9F.1050008@osadl.org> <Pine.LNX.4.63.0708271155420.8578@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0708271155420.8578@pcgl.dsa-ac.de>
Subject: Re: How to talk to DAQ Hardware?
Sender: linux-rt-users-owner@vger.kernel.org
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: Carsten Emde <Carsten.Emde@osadl.org>, Calin Culianu <cculianu@yahoo.com>, Daniel Walker <dwalker@mvista.com>, linux-rt-users@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Aug 27, 2007 at 12:02:24PM +0200, Guennadi Liakhovetski wrote:
> As long as your non-realtime tasks are allowed to take locks, that also
> prevent real-time tasks from preempting them, and as long as you haven't
> proved that all those locks in all your non-realtime sources can never
> under any circumstances last longer than your pre-defined limit, it is not
> a hard-realtime OS.

Yes, but that's only true for locks shared between rt and non-rt
threads. You surely have to design an interface between high and low
priority parts of an RT system following certain rules, but that's the
same with all hard realtime systems.

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
