From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Thu, 5 Mar 2015 07:01:12 -0600
Message-ID: <20150305130111.GB668@unpythonic.net>
References: <3671201425478878@web10j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: mikhail.avkhimenia@emlid.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rrcs-76-79-27-186.west.biz.rr.com ([76.79.27.186]:50356 "EHLO
	rrcs-76-79-27-186.west.biz.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754607AbbCENai (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Mar 2015 08:30:38 -0500
Content-Disposition: inline
In-Reply-To: <3671201425478878@web10j.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It occurs to me that you could adjust the priority of IRQs (by sudo
chrt).  With cyclictest running at priority 49, adjust each irq down
from 50 to 48 in turn and see if you get your hang.  Once you have a
specific irq, perhaps that will in turn point toward an actual cause.

Jeff
