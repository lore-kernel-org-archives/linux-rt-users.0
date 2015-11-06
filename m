From: Claudio Scordino <claudio@evidence.eu.com>
Subject: PREEMPT_RT kernel for Xilinx Zynq
Date: Fri, 6 Nov 2015 12:38:18 +0100
Message-ID: <563C912A.6020301@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34608 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161192AbbKFLiZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Nov 2015 06:38:25 -0500
Received: by wikq8 with SMTP id q8so28487854wik.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Nov 2015 03:38:24 -0800 (PST)
Received: from [192.168.10.115] (host83-110-static.58-79-b.business.telecomitalia.it. [79.58.110.83])
        by smtp.gmail.com with ESMTPSA id e63sm2624499wma.7.2015.11.06.03.38.23
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2015 03:38:24 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

For anybody interested,

here I've put a RT kernel for the Xilinx Zynq platform:

         git clone https://github.com/claudioscordino/linux-xlnx.git -b 
preempt_rt

         make ARCH=arm xilinx_zynq_preempt_defconfig

Best regards,

                 Claudio

