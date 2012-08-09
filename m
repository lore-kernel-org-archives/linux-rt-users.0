From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: imx25: maximum latency increased on some tests
Date: Thu, 09 Aug 2012 12:46:50 +0200
Message-ID: <5023951A.5060804@osadl.org>
References: <5023901E.5090009@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Alessandro Biasci <a.biasci@evidence.eu.com>
To: Claudio Scordino <claudio@evidence.eu.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:37163 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757398Ab2HIKxO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Aug 2012 06:53:14 -0400
In-Reply-To: <5023901E.5090009@evidence.eu.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Claudio,

> [..]
> Please, find below the results that we have obtained.
> [..]
> Do you have any idea about the possible reason of this behavior ?
> $ signaltest -l 10000 -t 4
Please specify the priority of the test task, e.g. -p99, since it runs 
with default non-RT priority, otherwise.

	-Carsten.
