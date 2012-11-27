From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: am33xx beaglebone mainline status?
Date: Tue, 27 Nov 2012 13:58:05 +0100
Message-ID: <20121127125805.GB31484@netboy.at.omicron.at>
References: <201211270941.52055.tim01@iss.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk,
	linux-rt-users@vger.kernel.org
To: Tim Sander <tim01@iss.tu-darmstadt.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41885 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab2K0M6Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Nov 2012 07:58:16 -0500
Content-Disposition: inline
In-Reply-To: <201211270941.52055.tim01@iss.tu-darmstadt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 27, 2012 at 09:41:51AM +0100, Tim Sander wrote:
> Hi
> 
> I have been trying to get the 3.7-rc6 kernel to compile for a beaglebone board 
> with device tree but it seems there are still bits missing. Especially it 
> seems as if the sd card reader and network is not working properly?

The CPSW network driver is working in net-next, and so it will be
working in v3.8. Don't know about SD, since I only boot with a ramfs.

HTH,
Richard
