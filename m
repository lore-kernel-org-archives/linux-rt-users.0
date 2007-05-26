From: Alessio Igor Bogani <abogani@texware.it>
Subject: 2.6.22
Date: Sat, 26 May 2007 09:23:51 +0200
Message-ID: <1180164231.5067.30.camel@godzilla>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:46017 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397AbXEZHX4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 26 May 2007 03:23:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by hermes.xcon.it (Postfix) with ESMTP id 2C1A360811E
	for <linux-rt-users@vger.kernel.org>; Sat, 26 May 2007 09:23:54 +0200 (CEST)
Received: from hermes.xcon.it ([127.0.0.1])
	by localhost (hermes.xcon.it [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sa6p8MnmVQAC for <linux-rt-users@vger.kernel.org>;
	Sat, 26 May 2007 09:23:53 +0200 (CEST)
Received: from [192.168.0.4] (host-84-222-57-139.cust-adsl.tiscali.it [84.222.57.139])
	(Authenticated sender: aib@texware.it)
	by hermes.xcon.it (Postfix) with ESMTP id 7C4EB60811A
	for <linux-rt-users@vger.kernel.org>; Sat, 26 May 2007 09:23:53 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I'm trying to adapt patch-2.6.21-rt7 for 2.6.22.

Now i can compile this but it start only without ide support.

When i boot with a kernel which have ide support system freeze on
ide_generic_init() function.

Do you have any suggestions? How can deeply investigate? Which tools are
available to help in this situation?

Thanks,
Alessio
