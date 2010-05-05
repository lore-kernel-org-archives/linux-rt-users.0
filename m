From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Changing real time priority of interrupt handler thread
Date: Wed, 05 May 2010 11:37:14 -0700
Message-ID: <4BE1BADA.3040902@us.ibm.com>
References: <20100505130845.GA9118@rivendell>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Raphael Hertzog <raphael@ouaza.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:43170 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab0EEShb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 May 2010 14:37:31 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o45IZqox015744
	for <linux-rt-users@vger.kernel.org>; Wed, 5 May 2010 12:35:52 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id o45IbJNS238876
	for <linux-rt-users@vger.kernel.org>; Wed, 5 May 2010 12:37:22 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o45IbFwX022277
	for <linux-rt-users@vger.kernel.org>; Wed, 5 May 2010 12:37:15 -0600
In-Reply-To: <20100505130845.GA9118@rivendell>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Raphael Hertzog wrote:

> In case it was not clear, I want to run the IRQ handler of the serial
> ports at a higher priority than the other ones (like network, disk,
> etc.) to avoid buffer overruns.

Have you tried using the rtctl utility and the /etc/rtgroups file?


thanks,
Nivedita

