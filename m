From: "$rik@nth " <srikanth007m@gmail.com>
Subject: [RT-Tests] pmqtest on ARM
Date: Mon, 25 Jan 2016 17:31:50 +0530
Message-ID: <CANKSX+G0tePQNFw8uH+RYrFEKanTsHmiqSzd1y5aGq1gwms17Q@mail.gmail.com>
Reply-To: srikanth007m@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36720 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbcAYMBw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2016 07:01:52 -0500
Received: by mail-lb0-f181.google.com with SMTP id oh2so72640635lbb.3
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2016 04:01:51 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I am having dragonboard 410c with Android kernel. Tried successfully
cross compile rt-tests for ARM using cross tool-chain.

pmqtest is showing error "could not open POSIX message queue #1"

Do i need to compile rt-tests with any additional/specific flags
inorder to work on ARM platform as well? Request someone to share
pointers to unblock my debugging.

-- 
Thanks & Regards,
M.Srikanth Kumar.
