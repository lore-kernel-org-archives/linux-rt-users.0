From: Esben Nielsen <esn@terma.com>
Subject: Which version of preempt_realtime to use?
Date: Mon, 19 Jan 2009 13:01:07 +0100
Message-ID: <1232366467.31686.10.camel@localhost.localdomain>
Reply-To: esn@terma.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from asgaard.lystrup.terma.com ([193.163.1.112]:40860 "EHLO
	asgaard.terma.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758751AbZASML5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Jan 2009 07:11:57 -0500
Received: from exch-fe.terma.com (localhost.localdomain [127.0.0.1])
	by asgaard.terma.com (8.13.5/8.12.8) with ESMTP id n0JC658p032764
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Jan 2009 13:06:08 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey,

I am going to suggest that we use preempt_realtime for a _real_ project
(i.e. costumers will depend on it). We will run on standeard x86 (maybe
x86_64) hardware and will only need serial interfaces for realtime
perposes. Security is not an issue. Which version of preempt_realtime
should I pick?

Esben
