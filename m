From: DIXLOR <dixlor@gmail.com>
Subject: rt-tests-0.93: VERSION mistake
Date: Fri, 14 Aug 2015 04:00:26 +0300
Message-ID: <55CD3DAA.5020601@gmail.com>
Reply-To: dixlor@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:34052 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbbHNBAa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Aug 2015 21:00:30 -0400
Received: by labd1 with SMTP id d1so35724023lab.1
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Aug 2015 18:00:29 -0700 (PDT)
Received: from [192.168.1.2] (ppp83-237-161-29.pppoe.mtu-net.ru. [83.237.161.29])
        by smtp.googlemail.com with ESMTPSA id d9sm1006702lah.40.2015.08.13.18.00.28
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 18:00:28 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In /src/rt-migrate-test/rt-migrate-test.c

#define VERSION_STRING 0.3

#  ./rt-migrate-test -h

rt-migrate-test 0.30
...

Version 3/10 ?  :)
