From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: Which version of preempt_realtime to use?
Date: Mon, 19 Jan 2009 14:51:35 +0100
Message-ID: <49748567.30201@osadl.org>
References: <1232366467.31686.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: esn@terma.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:56795 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbZASPKA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Jan 2009 10:10:00 -0500
In-Reply-To: <1232366467.31686.10.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Esben,

> I am going to suggest that we use preempt_realtime for a _real_ project
> (i.e. costumers will depend on it). We will run on standeard x86 (maybe
> x86_64) hardware and will only need serial interfaces for realtime
> purposes. Security is not an issue. Which version of preempt_realtime
> should I pick?
The latest and greatest *and* most stable version is 2.6.24.7-rt26. As
far as I know (but maybe others know better), there are no unresolved
issues with this "Latest Stable". The kernel release 2.6.24 may not
contain sufficient architecture support for PPC and ARM, but the large
majority of x86 based processors and chipsets is well supported.

Please report, if anything does not work as expected.

	--Carsten.
