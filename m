From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: RT is freezing
Date: Mon, 05 Jan 2015 20:47:26 -0200
Message-ID: <54AB147E.9060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:49126 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbbAEWrb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Jan 2015 17:47:31 -0500
Received: by mail-vc0-f170.google.com with SMTP id hy4so8770003vcb.29
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Jan 2015 14:47:30 -0800 (PST)
Received: from [192.168.0.13] ([201.53.181.238])
        by mx.google.com with ESMTPSA id ut11sm16123253vdb.4.2015.01.05.14.47.29
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2015 14:47:30 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everybody

I compiled the 3.14.25-rt22, but my system freezes when I start Unity 
and some programs like Chrome or Thunderbird. The problem happens only 
when PREEMPT_RT_FULL=y. No log is generated. I would like to find the 
root of this problem, but I don't know how. Do you have any suggestion?

Best regard,
Gustavo Bittencourt
