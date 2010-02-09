From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: Converting a device driver for real time kernel
Date: Tue, 09 Feb 2010 12:24:35 +0100
Message-ID: <4B7145F3.6040200@osadl.org>
References: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: RT-Users <linux-rt-users@vger.kernel.org>
To: "Leggo, Adam (UK)" <Adam.Leggo2@baesystems.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:51007 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911Ab0BILbn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2010 06:31:43 -0500
In-Reply-To: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Adam,

> [..]
> I have gone back to the supplier and they are not interested in
> developing a real time version of the driver.
I wouldn't ask the supplier to provide a "real time version of the
driver". I would ask them to provide a correctly written Linux driver
that works on a current kernel version and can be submitted to Greg KH's
driver project. And I would ask the supplier to contribute to the
project and collaborate with Greg to make the driver ready for mainline.
If it still crashes under PREEMPT_RT, then the driver is simply buggy -
it just happens that the bugs do not show up or show up less frequently
on the standard mainline kernel.

	Carsten.
