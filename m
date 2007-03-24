From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 00/11] Autotool support for IBM RT Cases
Date: Sat, 24 Mar 2007 13:10:45 +0100
Message-ID: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45095 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752203AbXCXMQt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:16:49 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Darren,

Here is a first raw cut for autotool support for your rt testcases. It
is against the version on your website. The series survives a basic
distcheck.

Known issues & discussion points:

- test programs which use pthread_mutexattr_setprotocol and
  pthread_mutexattr_setrobust_np could not be tested (debian unstable
  does not have a recent enough glibc)

- due to the above, I assume the tests in question will have a similar
  quantity of warnings, so I see if I can get access to a box which is
  recent enough to do the rest of the fixes.

- a sane version number and contact mail address should be added to
  configure.ac; I've just taken our template here, please adjust
  according to your needs.

Robert
--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
