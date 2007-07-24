From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 00/15] fixes for rt-test build system
Date: Tue, 24 Jul 2007 11:25:17 +0200
Message-ID: <20070724092517.390730736@metis.extern.pengutronix.de>
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45919 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761871AbXGXKGu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 06:06:50 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Darren,

This is a patch queue which fixes up the remaining issues with your
recently released rt-test packet. The focus of this series was on

- fixing all GNUmakefile.am files do do the right thing; there have been
  bogus Makefiles which somehow leaked into your tree

- fix 'make dist-check', which should be your preferred distribution
  tarball building mechanism in the future. Please don't do that
  manually, as the autotools make sure you don't forget half of the
  files if you use their mechanism :-)

Robert
--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
