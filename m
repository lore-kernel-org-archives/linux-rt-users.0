From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RT Linux support on 2.6.37
Date: Wed, 19 Jan 2011 22:33:34 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302484742DF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34038 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab1ASRDk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Jan 2011 12:03:40 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0JH3bFR003633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Jan 2011 11:03:39 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p0JH3aRS006882
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Jan 2011 22:33:36 +0530 (IST)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello RT developers,

Can anyone confirm if the next realtime kernel will
indeed be based on 2.6.37 as mentioned here:

https://www.osadl.org/Single-View.111+M528d085a4d0.0.html

We are planning to use RT on an ARM Cortex-A8 based SoC
and would like to use a RT kernel as close as possible
to the mainline so we can work on getting the SoC supported
in the mainline as well without too much rework.

Will be happy to help test whatever development is ongoing.

Thanks,
Sekhar
