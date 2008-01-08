From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Tue, 8 Jan 2008 21:40:39 +0100
Message-ID: <20080108204039.GF3177@pengutronix.de>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <4783A7A6.6030808@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:36205 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751844AbYAHUkm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Jan 2008 15:40:42 -0500
Content-Disposition: inline
In-Reply-To: <4783A7A6.6030808@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jan 08, 2008 at 05:41:10PM +0100, Wolfgang Grandegger wrote:
> You are obviously using a 2.6.23.1 with private patches for MPC5200 as
> there is no FEC driver or no clock event support in that version.

Oops, sure, I should have noted. The patches are part of the -6 release
of the BSP:

http://www.pengutronix.de/oselas/bsp/phytec/download/phyCORE-MPC5200B-tiny/

> The _official_ 2.6.24-rc5 finally builds fine and works for my
> Icecube-Eval-Board :-). Yes, it would make sense to add board support
> for the phyCORE-MPC5200B-tiny for that version.

Sure, we'll do soon.

> > Can you elaborate which load you are using?
> 
> "while ls; do ls; done" in a telnet window, "ping -f <host-ip>" and the
> cache calibrator.

We need some well defined default loads for this kind of machines. I'll
post a proposal when we've collected our current ideas.

> Some time in the past I also measured much better values and likely
> there is a problem with the official version.

Yup. We are in the process of setting up an autobuilder for the
phyCORE-MPC5200B. It will hopefully soon find latency regressions in a
more systematic way.

Robert
-- 
 Robert Schwebel              |  http://www.pengutronix.de
 OSADL Testlab @ Pengutronix  |  http://www.osadl.org
