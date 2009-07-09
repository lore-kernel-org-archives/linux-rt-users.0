From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: Problem with hwlat detector in smp_processor_id()
Date: Thu, 09 Jul 2009 10:36:37 -0400
Message-ID: <1247150197.5512.13.camel@localhost.localdomain>
References: <4A55D53A.6040108@psysteme.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Wolfgang Steinwender <wolfgang@psysteme.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dallas.jonmasters.org ([72.29.103.172]:37755 "EHLO
	dallas.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761336AbZGIOgd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jul 2009 10:36:33 -0400
In-Reply-To: <4A55D53A.6040108@psysteme.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2009-07-09 at 13:32 +0200, Wolfgang Steinwender wrote:

> e = ring_buffer_consume(ring_buffer, smp_processor_id(), NULL);
> 
> I'm wondering, because the seems to run at least for some people.
> Can it be a problem with my kernel?

Indeed. Can you post some more information - the config file as an
attachment, along with the specifics of what you recompiled?

Jon.


