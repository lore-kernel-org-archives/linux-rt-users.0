From: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Subject: CONFIG_NO_HZ_FULL in x86 (32bit)?
Date: Fri, 11 Oct 2013 08:32:50 +0000
Message-ID: <F9467A784CC48947B1D879F07370839E1E0364DC@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:58426 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab3JKIc6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 04:32:58 -0400
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 8BD2415800A8
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Oct 2013 10:32:55 +0200 (CEST)
Received: from vsgw11.fe.internet.bosch.com (vsgw11.fe.internet.bosch.com [10.4.98.11])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 6CC41A404F8
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Oct 2013 10:32:55 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by IMSVA (Postfix) with SMTP id 6B0C2982CB
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Oct 2013 10:32:55 +0200 (CEST)
Received: from fe20093s.ecn.etasgroup.com (unknown [10.103.1.64])
	by vsgw11.fe.internet.bosch.com (Postfix) with ESMTP id 896739834D
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Oct 2013 10:32:51 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I found out that with the RT_PREEMPT patch for kernel 3.10 there is the cool feature rcu_nocbs (offload RCU callback processing) available which allows to free cores to run single real time user space applications on it.
This feature depends on CONFIG_NO_HZ_FULL, however this is not available for x86 (32 bit).
My question is now: Is there a way to get the rcu_nocbs running together with NO_HZ_FULL on a 32bit x86?

Thanks for any feedback

Best regards

Mathias

