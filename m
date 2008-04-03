From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: Real time USB2Serial devices and behaivor
Date: Thu, 03 Apr 2008 02:24:30 -0400
Message-ID: <1207203870.12035.1.camel__44553.8826905706$1207205307$gmane$org@perihelion>
References: <20080326152559.GA17164@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:42211 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756260AbYDCGk0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Apr 2008 02:40:26 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JhJ7M-0000or-Cl
	for linux-rt-users@vger.kernel.org; Thu, 03 Apr 2008 06:40:12 +0000
Received: from boston.jonmasters.org ([74.92.29.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Apr 2008 06:40:02 +0000
Received: from jonathan by boston.jonmasters.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Apr 2008 06:40:02 +0000
In-Reply-To: <20080326152559.GA17164@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 2008-03-26 at 08:25 -0700, mark gross wrote:

> BTW Why does the PL2303 have a 1KB buffer for incoming data?

Personally, RT or not, I really like to avoid using those PL230X parts.
They're everywhere, this is true, but also quite horrible sometimes.

Jon.



