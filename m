From: DIXLOR <dixlor@gmail.com>
Subject: PTRACE_TRACEME doesn't work: function not implemented
Date: Mon, 22 Sep 2014 17:27:37 +0400
Message-ID: <542023C9.5020105@gmail.com>
Reply-To: dixlor@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:56645 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbaIVN1s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Sep 2014 09:27:48 -0400
Received: by mail-lb0-f169.google.com with SMTP id b12so6784375lbj.14
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Sep 2014 06:27:46 -0700 (PDT)
Received: from [192.168.1.2] (ppp83-237-41-233.pppoe.mtu-net.ru. [83.237.41.233])
        by mx.google.com with ESMTPSA id b8sm3781129lbp.16.2014.09.22.06.27.45
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2014 06:27:45 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

kernel 3.14 + patch-3.14.12-rt9.patch.gz

# strace  anything

strace: test_ptrace_setoptions_for_all: PTRACE_TRACEME strace: 
test_ptrace_setoptions_for_all: PTRACE_TRACEME doesn't work: function not 
implemented
