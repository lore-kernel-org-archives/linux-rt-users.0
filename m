From: "Stepina, Alina" <Alina.Stepina@emc.com>
Subject: Cgroups: RT-Scheduler
Date: Mon, 29 Jul 2013 02:33:32 -0400
Message-ID: <9BD9A5CBDB7AA84C904151C4DB793B73FDD165B2@MX18A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]:33053 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751440Ab3G2Gds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Jul 2013 02:33:48 -0400
Received: from hop04-l1d11-si02.isus.emc.com (HOP04-L1D11-SI02.isus.emc.com [10.254.111.55])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id r6T6Xkbb011248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Jul 2013 02:33:46 -0400
Received: from mailhub.lss.emc.com (mailhubhoprd04.lss.emc.com [10.254.222.226]) by hop04-l1d11-si02.isus.emc.com (RSA Interceptor) for <linux-rt-users@vger.kernel.org>; Mon, 29 Jul 2013 02:33:34 -0400
Received: from mxhub32.corp.emc.com (mxhub32.corp.emc.com [128.222.70.172])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id r6T6XY4f019081
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Jul 2013 02:33:34 -0400
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi folks,
I'm working with cgroup now, and I can't understand RT mechanism's destination. What is the real case for RT scheduler in cgroup? In what cases should I restrict RT-threads? As far as I understand, a RT-thread has highest priority in system, and what the reason to give ability to make TS-thread higher priority? If someone has such experience please share it.


Regards,
Alina Stepina
