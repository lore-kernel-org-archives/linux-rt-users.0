From: "N, Mugunthan V" <mugunthanvnm@ti.com>
Subject: RE: Poor cycletest results for rt6
Date: Fri, 29 Jul 2011 17:14:00 +0530
Message-ID: <45EE9921DD12714AB1D7B7B9D2FE208B0230256D4D3E@dbde03.ent.ti.com>
References: <4E329515.7080803@i-tech.si>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Hinko Kocevar <hinko.kocevar@i-tech.si>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49888 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754147Ab1G2LoH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 07:44:07 -0400
In-Reply-To: <4E329515.7080803@i-tech.si>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I've build linux-3.0-rt6 for AM3517 and run the cyclic test with the following commands

./hackbench -P -l -1 -g 10  &
./cyclictest -t1 -p80 -n -h 400
---
Regards,
Mugunthan V N. 
