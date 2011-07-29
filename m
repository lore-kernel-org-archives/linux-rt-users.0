From: "N, Mugunthan V" <mugunthanvnm@ti.com>
Subject: RE: Poor cycletest results for rt6
Date: Fri, 29 Jul 2011 17:16:55 +0530
Message-ID: <45EE9921DD12714AB1D7B7B9D2FE208B0230256D4D3F@dbde03.ent.ti.com>
References: <4E329515.7080803@i-tech.si>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Hinko Kocevar <hinko.kocevar@i-tech.si>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab1G2LrD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 07:47:03 -0400
In-Reply-To: <4E329515.7080803@i-tech.si>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I've build linux-3.0-rt6 for AM3517 and run the cyclic test with the 
following commands

./hackbench -P -l -1 -g 10  &
./cyclictest -t1 -p80 -n -h 400

The test results are poot with the max latency of 5231

---
Regards,
Mugunthan V N.
